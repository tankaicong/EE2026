`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Threshold UI + Pixel Classifier (RGB/HSV with FSM)
//
// What this module does now
// - Draws 3 reusable sliders and 2 color boxes (min/max) as before.
// - Owns an internal 4-state FSM to manage mode switching and one-shot conversions:
//     ST_RGB     -> sliders/edit are RGB, threshold in RGB.
//     ST_TO_HSV  -> perform RGB->HSV endpoint conversion (one shot), UI already shows HSV.
//     ST_HSV     -> sliders/edit are HSV, threshold in HSV with hue wrap support.
//     ST_TO_RGB  -> perform HSV->RGB endpoint conversion (one shot), UI already shows RGB.
// - Takes a live RGB444 pixel and outputs a 1/0 classification based on current mode and ranges.
//
// Sliders (0..15 values only; UI rendering refined later):
// - RGB mode: R/G/B sliders clamp and do not cross. Selected segment colored; out-of-range grey.
// - HSV mode: H/S/V sliders control hue/sat/value ranges.
//     Hue supports wrap-around selection: if h_min <= h_max -> select inside [min..max];
//     if h_min > h_max -> select outside, i.e., [min..15] U [0..max]. S/V do not cross.
// - The 2 boxes show the min endpoint (left) and max endpoint (right). In HSV mode, boxes are
//   HSV endpoints converted to RGB for display so the color preview matches perception.
//
// Thresholding (internal now; Top only reads the boolean):
// - RGB mode: compare rgb_pixel_in.{R,G,B} against [min..max] per channel.
// - HSV mode: convert rgb_pixel_in -> HSV (4-bit each, adapted integer math),
//   then compare H using wrap logic and S, V within [min..max].
//   Reference idea adapted from WPILib thresholding guidance:
//   https://docs.wpilib.org/en/stable/docs/software/vision-processing/wpilibpi/image-thresholding.html
// - RGB<->HSV endpoint conversions happen only during the transitional states to keep UI coherent.
//
// Math notes (detailed, variables and integer approximations)
//  Based on rapidtables reference (adapted and quantized for 16 steps of hue).
//   https://www.rapidtables.com/convert/color/rgb-to-hsv.html
// Channels and formats
// - RGB444 packed as {B[11:8], G[7:4], R[3:0]}. Each channel is 4-bit unsigned (0..15).
// - HSV uses Q4 (4-bit) per component: H in 16 bins around the color wheel, S 0..15, V 0..15.
//
// RGB -> HSV (quantized)
// Inputs: r,g,b (4-bit). Aux: maxc = max(r,g,b), minc = min(r,g,b), delta = maxc-minc.
// Outputs: h_q (0..15), s_q (0..15), v_q (0..15).
// - v_q = maxc (value is the dominant channel).
// - s_q = delta (saturation approximated by chroma; avoids division by V).
// - h_q (hue bin): choose sector by dominant channel, then use signed difference t between the
//   two non-dominant channels to pick a coarse position inside the 6 main sectors.
//   We compare shifted magnitudes (t<<1 vs delta, t<<2 vs 3*delta) to decide among 3 interior
//   bin positions per sector (roughly at 20°, 60°, 100° inside that sector). No division is used.
//   The mapping wraps around at 0/15 to keep hue circular.
//
// HSV -> RGB (quantized)
// Inputs: h (0..15), s (0..15), v (0..15).
// Aux: C = (s*v)>>4 (chroma), m = v - C, sec = floor((h*6)/16) in {0..5} (we compute using *6 and bit-slice).
// Start from base (m,m,m). Then add/subtract C on the two channels dictated by sec (standard 6-sector model):
//  sec=0: R=v; G=m+C; B=m
//  sec=1: G=v; R=v-C; B=m
//  sec=2: G=v; B=m+C; R=m
//  sec=3: B=v; G=v-C; R=m
//  sec=4: B=v; R=m+C; G=m
//  sec=5: R=v; B=v-C; G=m
// This is used for endpoint conversion (FSM) and the preview boxes/gradient (with S=V=15 approximation).
//
// Hue wrap selection logic
// - When h_min <= h_max: selected if h in [h_min..h_max].
// - When h_min > h_max: selection wraps across 15->0; selected if h >= h_min OR h <= h_max.
//   S/V (and RGB channel ranges) are always non-wrapping (min<=max enforced by UI).
//////////////////////////////////////////////////////////////////////////////////
module threshold_subsection (
    input  wire        clk25,
    input  wire        vga_reset,
    // Accept VGA coordinates so the overlay draws correctly when used with BRAM-backed
    // overlays. frame_x is 10 bits (0..639), frame_y is 10 bits (0..479).
    input  wire [9:0]  px_src,         // 0..639 (VGA X)
    input  wire [9:0]  py_src,         // 0..479 (VGA Y)
    input  wire [9:0]  mouse_x_px,     // synchronized mouse X in VGA coords
    input  wire [8:0]  mouse_y_px,     // synchronized mouse Y in VGA coords
    input  wire        left_click,     // level (synchronized)
    input  wire        left_click_edge,// 1-cycle edge pulse (synchronized)
    input wire        left_click_fall, // 1-cycle falling edge pulse (synchronized)
    input  wire        enable,         // module only active when enable asserted (e.g. in S_GAME_AUTO_MODE)
    // BRAM pixel input at mouse location (sampled externally / provided by Top)
    input wire [11:0] bram_pixel_out,
    input wire [11:0] mouse_color_bram,
    // Live pixel to classify (RGB444: {B[11:8], G[7:4], R[3:0]})
    input  wire [11:0] rgb_pixel_in,
    // Range outputs: 4-bit per channel (0..15)
    output reg  [3:0]  start_red_val,     // 0..15
    output reg  [3:0]  end_red_val,        
    output reg  [3:0]  start_green_val,      
    output reg  [3:0]  end_green_val,        
    output reg  [3:0]  start_blue_val,
    output reg  [3:0]  end_blue_val,
    // HSV outputs (0..15 per channel)
    // output reg  [3:0]  start_h_val,
    // output reg  [3:0]  end_h_val,
    // output reg  [3:0]  start_s_val,
    // output reg  [3:0]  end_s_val,
    // output reg  [3:0]  start_v_val,
    // output reg  [3:0]  end_v_val,
    // Mode flag: 1 = HSV mode, 0 = RGB mode
    // output reg         mode_is_hsv,
    // 1 = pixel passes current threshold; 0 = filtered out
    output reg         threshold_pixel,
    output wire [11:0] section_pixel,   // overlay pixel
    output wire        section_active   // overlay active flag
);
    // // Range outputs: 4-bit per channel (0..15)
    // reg  [3:0]  start_red_val;     // 0..15
    // reg  [3:0]  end_red_val;      
    // reg  [3:0]  start_green_val;      
    // reg  [3:0]  end_green_val;        
    // reg  [3:0]  start_blue_val;
    // reg  [3:0]  end_blue_val;
    // // HSV outputs (0..15 per channel)
    // reg  [3:0]  start_h_val;
    // reg  [3:0]  end_h_val;
    // reg  [3:0]  start_s_val;
    // reg  [3:0]  end_s_val;
    // reg  [3:0]  start_v_val;
    // reg  [3:0]  end_v_val;
    // ---------------- Geometry constants ----------------
    // Horizontal slider layout (three sliders): X range and Y rows
    localparam SLIDE_X0          = 145;
    localparam SLIDER_WIDTH      = 160;
    localparam SLIDE_X1          = SLIDE_X0 + SLIDER_WIDTH;
    localparam SLIDER_THICKNESS_Y= 4;
    localparam SLIDER0_Y         = 9'd352;
    localparam SLIDER1_Y         = 9'd367;
    localparam SLIDER2_Y         = 9'd382;
    // Legacy knob box extent (used for hit-tests); arrows replace boxes visually
    localparam KNOB_SIZE_HEIGHT  = 12; // knob (arrow) nominal height in pixels
    localparam KNOB_SIZE_WIDTH   = 6;  // legacy half-width for selection hit-test
    localparam integer SLIDER_STEP = 10; // 16 bins * 10px per bin = 160px track
    // Arrow geometry (visual rendering only). Hit-tests still use compact bounding boxes.
    localparam ARROW_W           = 10; // total width of arrow shape (pixels)
    localparam ARROW_H           = 12; // total height of arrow shape (pixels)

    // Color boxes
    localparam BOX_WIDTH_HEIGHT  = 42;
    localparam BOX_START_LEFT_X  = 33;
    localparam BOX_START_LEFT_Y  = 9'd348;

    // Eyedropper display rectangle
    localparam EYE_X   = 10'd230;
    localparam EYE_Y   = 9'd330;
    localparam EYE_W   = 10'd50;
    localparam EYE_H   = 9'd15;
    // Eyedropper toggle square
    localparam EYE_TOG_X = 10'd290;
    localparam EYE_TOG_Y = 9'd330;
    localparam EYE_TOG_W = 10'd15;
    localparam EYE_TOG_H = 9'd15;

    // Mode toggle buttons
    // localparam MODE_TOG_W = 10'd32;
    // localparam MODE_TOG_H = 9'd15;
    // localparam RGB_TOG_X  = 10'd150;
    // localparam RGB_TOG_Y  = 9'd330;
    // localparam HSV_TOG_X  = 10'd190;
    // localparam HSV_TOG_Y  = 9'd330;

    // Eyedropper vertical marker lines
    localparam EYEDROPPER_LINE_HEIGHT = 10;
    localparam EYEDROPPER_LINE_WIDTH  = 2;

    // ---------------- Colours ----------------
    // Simple 12-bit colors for UI elements
    localparam GREEN      = 12'h1C1;
    localparam RED        = 12'h00F;
    localparam BLUE       = 12'hF00;
    localparam CLR_WHITE  = 12'hFFF;
    localparam CLR_BLACK  = 12'h000;
    localparam CLR_GREY   = 12'h888;
    localparam CLR_PICK   = 12'hFB0; // highlight colour for dragged knob

    // ---------------- Range registers ----------------
    reg [3:0] red_min, red_max;
    reg [3:0] green_min, green_max;
    reg [3:0] blue_min, blue_max;
    // reg [3:0] h_min, h_max;
    // reg [3:0] s_min, s_max;
    // reg [3:0] v_min, v_max;

    // ---------------- Dragging state ----------------
    reg dragging;
    reg left_q;
    reg [21:0] drag_rel_cnt;
    localparam DRAG_RELEASE_TH = 22'd1000000; 
    reg dragging_r_min, dragging_r_max;
    reg dragging_g_min, dragging_g_max;
    reg dragging_b_min, dragging_b_max;
    reg eyedropper_enabled;
    reg [11:0] picked_color;

    // knob X positions derived from 4-bit values (0..15 -> positions along track)
    // Active sliders follow mode: RGB uses R,G,B; HSV uses H,S,V.
    wire [3:0] slider0_min = 
    // mode_is_hsv ? h_min   : 
    red_min;
    wire [3:0] slider0_max = 
    // mode_is_hsv ? h_max   : 
    red_max;
    wire [3:0] slider1_min = 
    // mode_is_hsv ? s_min   : 
    green_min;
    wire [3:0] slider1_max = 
    // mode_is_hsv ? s_max   : 
    green_max;
    wire [3:0] slider2_min = 
    // mode_is_hsv ? v_min   : 
    blue_min;
    wire [3:0] slider2_max = 
    // mode_is_hsv ? v_max   : 
    blue_max;

    // Center knobs/markers within each 10px bin so value 15 reaches the final cell visually
    wire [9:0] knob_r_min_x = SLIDE_X0 + (slider0_min * SLIDER_STEP) + (SLIDER_STEP>>1);
    wire [9:0] knob_r_max_x = SLIDE_X0 + (slider0_max * SLIDER_STEP) + (SLIDER_STEP>>1);
    wire [9:0] knob_g_min_x = SLIDE_X0 + (slider1_min * SLIDER_STEP) + (SLIDER_STEP>>1);
    wire [9:0] knob_g_max_x = SLIDE_X0 + (slider1_max * SLIDER_STEP) + (SLIDER_STEP>>1);
    wire [9:0] knob_b_min_x = SLIDE_X0 + (slider2_min * SLIDER_STEP) + (SLIDER_STEP>>1);
    wire [9:0] knob_b_max_x = SLIDE_X0 + (slider2_max * SLIDER_STEP) + (SLIDER_STEP>>1);
    wire [9:0] eye_red_pos_x   = SLIDE_X0 + (picked_color[3:0]   * SLIDER_STEP) + (SLIDER_STEP>>1);
    wire [9:0] eye_blue_pos_x  = SLIDE_X0 + (picked_color[7:4]   * SLIDER_STEP) + (SLIDER_STEP>>1);
    wire [9:0] eye_green_pos_x = SLIDE_X0 + (picked_color[11:8]  * SLIDER_STEP) + (SLIDER_STEP>>1);

    // display positions for knobs — when min==max, offset the two knobs left/right so
    // the user can select them separately (they form a side-by-side 10x10 visual block).
    wire [9:0] knob_r_min_x_disp = (slider0_min == slider0_max) ? (knob_r_min_x - (KNOB_SIZE_WIDTH)) : knob_r_min_x;
    wire [9:0] knob_r_max_x_disp = (slider0_min == slider0_max) ? (knob_r_max_x + (KNOB_SIZE_WIDTH)) : knob_r_max_x;
    wire [9:0] knob_g_min_x_disp = (slider1_min == slider1_max) ? (knob_g_min_x - (KNOB_SIZE_WIDTH)) : knob_g_min_x;
    wire [9:0] knob_g_max_x_disp = (slider1_min == slider1_max) ? (knob_g_max_x + (KNOB_SIZE_WIDTH)) : knob_g_max_x;
    wire [9:0] knob_b_min_x_disp = (slider2_min == slider2_max) ? (knob_b_min_x - (KNOB_SIZE_WIDTH)) : knob_b_min_x;
    wire [9:0] knob_b_max_x_disp = (slider2_min == slider2_max) ? (knob_b_max_x + (KNOB_SIZE_WIDTH)) : knob_b_max_x;

    // Mouse X -> 0..15 bin (no division). Ladder of comparisons at 10px steps
    reg [3:0] mouse_val_bin;
    always @(*) begin
        if (mouse_x_px <= SLIDE_X0) mouse_val_bin = 4'd0;
        else if (mouse_x_px < SLIDE_X0 + 1*SLIDER_STEP) mouse_val_bin = 4'd0;
        else if (mouse_x_px < SLIDE_X0 + 2*SLIDER_STEP) mouse_val_bin = 4'd1;
        else if (mouse_x_px < SLIDE_X0 + 3*SLIDER_STEP) mouse_val_bin = 4'd2;
        else if (mouse_x_px < SLIDE_X0 + 4*SLIDER_STEP) mouse_val_bin = 4'd3;
        else if (mouse_x_px < SLIDE_X0 + 5*SLIDER_STEP) mouse_val_bin = 4'd4;
        else if (mouse_x_px < SLIDE_X0 + 6*SLIDER_STEP) mouse_val_bin = 4'd5;
        else if (mouse_x_px < SLIDE_X0 + 7*SLIDER_STEP) mouse_val_bin = 4'd6;
        else if (mouse_x_px < SLIDE_X0 + 8*SLIDER_STEP) mouse_val_bin = 4'd7;
        else if (mouse_x_px < SLIDE_X0 + 9*SLIDER_STEP) mouse_val_bin = 4'd8;
        else if (mouse_x_px < SLIDE_X0 +10*SLIDER_STEP) mouse_val_bin = 4'd9;
        else if (mouse_x_px < SLIDE_X0 +11*SLIDER_STEP) mouse_val_bin = 4'd10;
        else if (mouse_x_px < SLIDE_X0 +12*SLIDER_STEP) mouse_val_bin = 4'd11;
        else if (mouse_x_px < SLIDE_X0 +13*SLIDER_STEP) mouse_val_bin = 4'd12;
        else if (mouse_x_px < SLIDE_X0 +14*SLIDER_STEP) mouse_val_bin = 4'd13;
        else if (mouse_x_px < SLIDE_X0 +15*SLIDER_STEP) mouse_val_bin = 4'd14;
        else mouse_val_bin = 4'd15;
    end

    // --- RGB->HSV endpoint conversion (approx, integer, no div) ---
    // Helper wires for converting a single RGB444 color to HSV Q4 (H 0..15 (0=red ~5=green ~10=blue), S 0..15, V 0..15)
    // Implemented as a task-like comb block for use in procedural always blocks.
    // Since Verilog tasks are not allowed per constraints, inline the logic where needed.

    // Shared temporaries for endpoint conversion (FSM transitions)
    // reg [3:0] r, g, b;                 // input RGB components (Q4)
    // reg [3:0] maxc, minc, delta;       // max/min and chroma (Q4)
    // reg signed [5:0] t;                // signed difference between non-dominant channels
    // reg [3:0] h_q, s_q, v_q;           // computed HSV components (Q4)
    // reg [4:0] C1,m1; reg [4:0] R1,G1,B1; reg [6:0] H61; reg [2:0] sec1; // upper endpoint HSV->RGB
    // reg [4:0] C0,m0; reg [4:0] R0,G0,B0; reg [6:0] H60; reg [2:0] sec0; // lower endpoint HSV->RGB

    // Temporaries for gradient rendering on hue track (HSV mode)
    // reg [3:0] hue_px_bin;              // which hue bin the current px_src lies in
    // reg [11:0] hue_grad_color;         // raw gradient color for that bin
    // reg [11:0] hue_out_color;          // gradient after selection highlighting
    // reg        hue_sel;                // selection membership flag for that bin
    // reg [4:0] Cg, mg; reg [6:0] Hmul; reg [2:0] secg; reg [4:0] Rg,Gg,Bg; // gradient HSV->RGB temps

    // Temporaries for arrow rendering (triangle fills)
    reg [9:0] x_left, x_right;         // arrow bounding box left/right
    reg [3:0] diff_y;                  // vertical distance from arrow centerline
    reg [9:0] dx, dx_inv;              // horizontal distance used for triangle edge test

    // Temporaries for box previews (HSV endpoints -> RGB)
    // reg [4:0] C0p, m0p; reg [6:0] H0p; reg [2:0] S0p; reg [4:0] R0p,G0p,B0p;
    // reg [4:0] C1p, m1p; reg [6:0] H1p; reg [2:0] S1p; reg [4:0] R1p,G1p,B1p;

    // Temporaries for live pixel RGB->HSV conversion used in thresholding
    // reg [3:0] pr_t, pg_t, pb_t;        // pixel RGB
    // reg [3:0] pmax_t, pmin_t, pdelta_t;// pixel max/min/delta
    // reg signed [5:0] pt_t;             // signed diff for hue computation
    // reg [3:0] ph_t, ps_t, pv_t;        // pixel HSV

    // 4-state FSM for mode and one-shot conversions
    // localparam [1:0] ST_RGB    = 2'b00;
    // localparam [1:0] ST_TO_HSV = 2'b01;
    // localparam [1:0] ST_HSV    = 2'b10;
    // localparam [1:0] ST_TO_RGB = 2'b11;
    // reg [1:0] state;

    // ---------------- Main sequential block: reset, drag (cv_settings style), FSM conversions ----------------
    // Unified dragging: capture handle on left_click_edge, stick until left_click held low long enough.
    reg [2:0] drag_idx; // declare here for synthesis grouping
    always @(posedge clk25) begin
        if (vga_reset) begin
            red_min<=4'd0; red_max<=4'd15; green_min<=4'd0; green_max<=4'd15; blue_min<=4'd0; blue_max<=4'd15;
            // h_min<=4'd0; h_max<=4'd15; s_min<=4'd0; s_max<=4'd15; v_min<=4'd0; v_max<=4'd15;
            dragging<=1'b0; drag_rel_cnt<=22'd0; drag_idx<=3'd0;
            dragging_r_min<=0; dragging_r_max<=0; dragging_g_min<=0; dragging_g_max<=0; dragging_b_min<=0; dragging_b_max<=0;
            eyedropper_enabled<=1'b0; picked_color<=12'h000;
            // state<=ST_RGB; mode_is_hsv<=1'b0;
            start_red_val<=4'd0; end_red_val<=4'd15; start_green_val<=4'd0; end_green_val<=4'd15; start_blue_val<=4'd0; end_blue_val<=4'd15;
            // start_h_val<=4'd0; end_h_val<=4'd15; start_s_val<=4'd0; end_s_val<=4'd15; start_v_val<=4'd0; end_v_val<=4'd15;
        end else begin
            // Mode & eyedropper controls when enabled
            if (enable) begin
                // If click landed in the toggle square, flip enable
                if (left_click_edge && (mouse_x_px >= EYE_TOG_X) && (mouse_x_px < (EYE_TOG_X + EYE_TOG_W)) &&
                    (mouse_y_px >= EYE_TOG_Y) && (mouse_y_px < (EYE_TOG_Y + EYE_TOG_H))) begin
                    eyedropper_enabled <= ~eyedropper_enabled;
                end
                // // Mode toggle buttons: mutually exclusive -> trigger FSM transitions
                // else if (left_click_edge && (mouse_x_px >= RGB_TOG_X) && (mouse_x_px < (RGB_TOG_X + MODE_TOG_W)) &&
                //                 (mouse_y_px >= RGB_TOG_Y) && (mouse_y_px < (RGB_TOG_Y + MODE_TOG_H))) begin
                //     // Request switch to RGB pipeline
                //     if (state == ST_HSV) state <= ST_TO_RGB; else state <= ST_RGB;
                // end
                // else if (left_click_edge && (mouse_x_px >= HSV_TOG_X) && (mouse_x_px < (HSV_TOG_X + MODE_TOG_W)) &&
                //                 (mouse_y_px >= HSV_TOG_Y) && (mouse_y_px < (HSV_TOG_Y + MODE_TOG_H))) begin
                //     // Request switch to HSV pipeline
                //     if (state == ST_RGB) state <= ST_TO_HSV; else state <= ST_HSV;
                // end

                // Eyedropper: single-sample then auto-disable. Capture only on click edge not on toggle square.
                if (eyedropper_enabled && left_click_edge &&
                   !( (mouse_x_px >= EYE_TOG_X) && (mouse_x_px < (EYE_TOG_X + EYE_TOG_W)) &&
                      (mouse_y_px >= EYE_TOG_Y) && (mouse_y_px < (EYE_TOG_Y + EYE_TOG_H)) )) begin
                    picked_color <= mouse_color_bram;
                    eyedropper_enabled <= 1'b0;
                end
            end
            // Reflect UI mode from FSM (transitional states already show target UI)
            // mode_is_hsv <= (state == ST_HSV) || (state == ST_TO_HSV);

            // Drag start (edge) only if enabled & not already dragging
            // Block starting a drag while eyedropper awaiting click
            if (enable && left_click_edge && !dragging && !eyedropper_enabled) begin
                if ((mouse_x_px >= (knob_r_min_x_disp-(KNOB_SIZE_WIDTH>>1))) && (mouse_x_px < (knob_r_min_x_disp+(KNOB_SIZE_WIDTH>>1))) && (mouse_y_px >= (SLIDER0_Y-(KNOB_SIZE_HEIGHT>>1))) && (mouse_y_px < (SLIDER0_Y+(KNOB_SIZE_HEIGHT>>1)))) begin dragging<=1'b1; drag_idx<=3'd0; end
                else if ((mouse_x_px >= (knob_r_max_x_disp-(KNOB_SIZE_WIDTH>>1))) && (mouse_x_px < (knob_r_max_x_disp+(KNOB_SIZE_WIDTH>>1))) && (mouse_y_px >= (SLIDER0_Y-(KNOB_SIZE_HEIGHT>>1))) && (mouse_y_px < (SLIDER0_Y+(KNOB_SIZE_HEIGHT>>1)))) begin dragging<=1'b1; drag_idx<=3'd1; end
                else if ((mouse_x_px >= (knob_g_min_x_disp-(KNOB_SIZE_WIDTH>>1))) && (mouse_x_px < (knob_g_min_x_disp+(KNOB_SIZE_WIDTH>>1))) && (mouse_y_px >= (SLIDER1_Y-(KNOB_SIZE_HEIGHT>>1))) && (mouse_y_px < (SLIDER1_Y+(KNOB_SIZE_HEIGHT>>1)))) begin dragging<=1'b1; drag_idx<=3'd2; end
                else if ((mouse_x_px >= (knob_g_max_x_disp-(KNOB_SIZE_WIDTH>>1))) && (mouse_x_px < (knob_g_max_x_disp+(KNOB_SIZE_WIDTH>>1))) && (mouse_y_px >= (SLIDER1_Y-(KNOB_SIZE_HEIGHT>>1))) && (mouse_y_px < (SLIDER1_Y+(KNOB_SIZE_HEIGHT>>1)))) begin dragging<=1'b1; drag_idx<=3'd3; end
                else if ((mouse_x_px >= (knob_b_min_x_disp-(KNOB_SIZE_WIDTH>>1))) && (mouse_x_px < (knob_b_min_x_disp+(KNOB_SIZE_WIDTH>>1))) && (mouse_y_px >= (SLIDER2_Y-(KNOB_SIZE_HEIGHT>>1))) && (mouse_y_px < (SLIDER2_Y+(KNOB_SIZE_HEIGHT>>1)))) begin dragging<=1'b1; drag_idx<=3'd4; end
                else if ((mouse_x_px >= (knob_b_max_x_disp-(KNOB_SIZE_WIDTH>>1))) && (mouse_x_px < (knob_b_max_x_disp+(KNOB_SIZE_WIDTH>>1))) && (mouse_y_px >= (SLIDER2_Y-(KNOB_SIZE_HEIGHT>>1))) && (mouse_y_px < (SLIDER2_Y+(KNOB_SIZE_HEIGHT>>1)))) begin dragging<=1'b1; drag_idx<=3'd5; end
                drag_rel_cnt<=22'd0;
            end

            // Release filter (sustained low) while dragging
            if (dragging) begin
                if (left_click) drag_rel_cnt<=22'd0; else if (drag_rel_cnt<DRAG_RELEASE_TH) drag_rel_cnt<=drag_rel_cnt+1'b1; else begin dragging<=1'b0; end
            end

            // Highlight flags
            dragging_r_min <= dragging && (drag_idx==3'd0);
            dragging_r_max <= dragging && (drag_idx==3'd1);
            dragging_g_min <= dragging && (drag_idx==3'd2);
            dragging_g_max <= dragging && (drag_idx==3'd3);
            dragging_b_min <= dragging && (drag_idx==3'd4);
            dragging_b_max <= dragging && (drag_idx==3'd5);

            // Drag update logic (single case)
            if (dragging) begin
                case (drag_idx)
                    3'd0: begin // red/hue min
                        if (mouse_x_px < SLIDE_X0) begin 
                            // if (mode_is_hsv) h_min<=4'd0; else 
                            red_min<=4'd0; 
                            end
                        else if (mouse_x_px > SLIDE_X1) begin 
                            // if (mode_is_hsv) h_min<=4'd15; else 
                            red_min<=red_max; 
                            end
                        else begin 
                            // if (mode_is_hsv) h_min<=mouse_val_bin; else 
                            if (mouse_val_bin>red_max) red_min<=red_max; else red_min<=mouse_val_bin; 
                        end
                    end
                    3'd1: begin // red/hue max
                        if (mouse_x_px < SLIDE_X0) begin 
                            // if (mode_is_hsv) h_max<=4'd0; else 
                            red_max<=red_min; 
                            end
                        else if (mouse_x_px > SLIDE_X1) begin 
                            // if (mode_is_hsv) h_max<=4'd15; else 
                            red_max<=4'd15; 
                            end
                        else begin 
                            // if (mode_is_hsv) h_max<=mouse_val_bin; else 
                            if (mouse_val_bin<red_min) red_max<=red_min; else red_max<=mouse_val_bin; 
                            end
                    end
                    3'd2: begin // green/sat min
                        if (mouse_x_px < SLIDE_X0) begin 
                            // if (mode_is_hsv) s_min<=4'd0; else 
                            green_min<=4'd0; 
                            end
                        else if (mouse_x_px > SLIDE_X1) begin 
                            // if (mode_is_hsv) s_min<=s_max; else 
                            green_min<=green_max; 
                            end
                        else begin 
                            // if (mode_is_hsv) begin if (mouse_val_bin>s_max) s_min<=s_max; else s_min<=mouse_val_bin; end else 
                            if (mouse_val_bin>green_max) green_min<=green_max; else green_min<=mouse_val_bin; 
                            end
                    end
                    3'd3: begin // green/sat max
                        if (mouse_x_px < SLIDE_X0) begin 
                            // if (mode_is_hsv) s_max<=s_min; else 
                            green_max<=green_min;
                            end
                        else if (mouse_x_px > SLIDE_X1) begin 
                            // if (mode_is_hsv) s_max<=4'd15; else 
                            green_max<=4'd15; 
                            end
                        else begin 
                            // if (mode_is_hsv) begin if (mouse_val_bin<s_min) s_max<=s_min; else s_max<=mouse_val_bin; end else 
                            if (mouse_val_bin<green_min) green_max<=green_min; else green_max<=mouse_val_bin; 
                            end
                    end
                    3'd4: begin // blue/value min
                        if (mouse_x_px < SLIDE_X0) begin 
                            // if (mode_is_hsv) v_min<=4'd0; else 
                            blue_min<=4'd0; 
                            end
                        else if (mouse_x_px > SLIDE_X1) begin 
                            // if (mode_is_hsv) v_min<=v_max; else 
                            blue_min<=blue_max; 
                            end
                        else begin 
                            // if (mode_is_hsv) begin if (mouse_val_bin>v_max) v_min<=v_max; else v_min<=mouse_val_bin; end else 
                            if (mouse_val_bin>blue_max) blue_min<=blue_max; else blue_min<=mouse_val_bin; 
                            end
                    end
                    3'd5: begin // blue/value max
                        if (mouse_x_px < SLIDE_X0) begin 
                            // if (mode_is_hsv) v_max<=4'd0; else 
                            blue_max<=4'd0;
                            end
                        else if (mouse_x_px > SLIDE_X1) begin 
                            // if (mode_is_hsv) v_max<=4'd15; else 
                            blue_max<=4'd15; 
                            end
                        else begin 
                            // if (mode_is_hsv) begin if (mouse_val_bin<v_min) v_max<=v_min; else v_max<=mouse_val_bin; end else 
                            if (mouse_val_bin<blue_min) blue_max<=blue_min; else blue_max<=mouse_val_bin; 
                            end
                    end
                    default: ;
                endcase
            end

            // One-shot transitional conversions
            // if (enable) begin
            //     if (state==ST_TO_HSV) begin
            //     // Lower endpoint RGB->HSV
            //     r = red_min; g = green_min; b = blue_min;
            //     maxc = (r>=g && r>=b) ? r : (g>=b ? g : b);
            //     minc = (r<=g && r<=b) ? r : (g<=b ? g : b);
            //     delta = maxc - minc;
            //     v_q = maxc;
            //     s_q = delta;
            //     if (delta == 0) h_q = 4'd0; else begin
            //         if (maxc == r) begin
            //             t = $signed({2'b00,g}) - $signed({2'b00,b});
            //             if (t >= 0)
            //                 h_q = ( (t<<<2) >= (3*delta) ) ? 4'd5 : ( (t<<<1) >= delta ? 4'd3 : 4'd1 );
            //             else
            //                 h_q = 4'd15 - ( ((-t)<<<2) >= (3*delta) ? 4'd1 : ( ((-t)<<<1) >= delta ? 4'd3 : 4'd5 ) );
            //         end else if (maxc == g) begin
            //             t = $signed({2'b00,b}) - $signed({2'b00,r});
            //             if (t >= 0)
            //                 h_q = 4'd5 + ( (t<<<2) >= (3*delta) ? 4'd5 : ( (t<<<1) >= delta ? 4'd3 : 4'd1 ) );
            //             else
            //                 h_q = 4'd5 - ( ((-t)<<<2) >= (3*delta) ? 4'd1 : ( ((-t)<<<1) >= delta ? 4'd3 : 4'd5 ) );
            //         end else begin
            //             t = $signed({2'b00,r}) - $signed({2'b00,g});
            //             if (t >= 0)
            //                 h_q = 4'd10 + ( ((t<<<2) >= (3*delta)) ? 4'd5 : ( (t<<<1) >= delta ? 4'd3 : 4'd1 ) );
            //             else
            //                 h_q = 4'd10 - ( ((-t)<<<2) >= (3*delta) ? 4'd1 : ( ((-t)<<<1) >= delta ? 4'd3 : 4'd5 ) );
            //         end
            //     end
            //         h_min <= h_q; s_min <= s_q; v_min <= v_q;

            //     // Upper endpoint RGB->HSV
            //     r = red_max; g = green_max; b = blue_max;
            //     maxc = (r>=g && r>=b) ? r : (g>=b ? g : b);
            //     minc = (r<=g && r<=b) ? r : (g<=b ? g : b);
            //     delta = maxc - minc;
            //     v_q = maxc;
            //     s_q = delta;
            //     if (delta == 0) h_q = 4'd0; else begin
            //         if (maxc == r) begin
            //             t = $signed({2'b00,g}) - $signed({2'b00,b});
            //             if (t >= 0)
            //                 h_q = ( (t<<<2) >= (3*delta) ) ? 4'd5 : ( (t<<<1) >= delta ? 4'd3 : 4'd1 );
            //             else
            //                 h_q = 4'd15 - ( ((-t)<<<2) >= (3*delta) ? 4'd1 : ( ((-t)<<<1) >= delta ? 4'd3 : 4'd5 ) );
            //         end else if (maxc == g) begin
            //             t = $signed({2'b00,b}) - $signed({2'b00,r});
            //             if (t >= 0)
            //                 h_q = 4'd5 + ( (t<<<2) >= (3*delta) ? 4'd5 : ( (t<<<1) >= delta ? 4'd3 : 4'd1 ) );
            //             else
            //                 h_q = 4'd5 - ( ((-t)<<<2) >= (3*delta) ? 4'd1 : ( ((-t)<<<1) >= delta ? 4'd3 : 4'd5 ) );
            //         end else begin
            //             t = $signed({2'b00,r}) - $signed({2'b00,g});
            //             if (t >= 0)
            //                 h_q = 4'd10 + ( ((t<<<2) >= (3*delta)) ? 4'd5 : ( (t<<<1) >= delta ? 4'd3 : 4'd1 ) );
            //             else
            //                 h_q = 4'd10 - ( ((-t)<<<2) >= (3*delta) ? 4'd1 : ( ((-t)<<<1) >= delta ? 4'd3 : 4'd5 ) );
            //         end
            //     end
            //         h_max <= h_q; s_max <= s_q; v_max <= v_q;
            //         state <= ST_HSV;
            //     end else if (state==ST_TO_RGB) begin
            //     // Lower endpoint HSV->RGB
            //     C0 = (s_min * v_min) >> 4; m0 = v_min - C0; H60 = {3'b000,h_min} * 6; sec0 = H60[6:4];
            //     R0 = m0; G0 = m0; B0 = m0;
            //     case (sec0)
            //         3'd0: begin R0 = v_min; G0 = m0 + C0; end
            //         3'd1: begin G0 = v_min; R0 = v_min - C0; end
            //         3'd2: begin G0 = v_min; B0 = m0 + C0; end
            //         3'd3: begin B0 = v_min; G0 = v_min - C0; end
            //         3'd4: begin B0 = v_min; R0 = m0 + C0; end
            //         default: begin R0 = v_min; B0 = v_min - C0; end
            //     endcase
            //         red_min <= R0[3:0]; green_min <= G0[3:0]; blue_min <= B0[3:0];
            //     // Upper endpoint HSV->RGB

            //     C1 = (s_max * v_max) >> 4; m1 = v_max - C1; H61 = {3'b000,h_max} * 6; sec1 = H61[6:4];
            //     R1 = m1; G1 = m1; B1 = m1;
            //     case (sec1)
            //         3'd0: begin R1 = v_max; G1 = m1 + C1; end
            //         3'd1: begin G1 = v_max; R1 = v_max - C1; end
            //         3'd2: begin G1 = v_max; B1 = m1 + C1; end
            //         3'd3: begin B1 = v_max; G1 = v_max - C1; end
            //         3'd4: begin B1 = v_max; R1 = m1 + C1; end
            //         default: begin R1 = v_max; B1 = v_max - C1; end
            //     endcase
            //         red_max <= R1[3:0]; green_max <= G1[3:0]; blue_max <= B1[3:0];
            //         state <= ST_RGB;
            //     end
            // end

            // Mirror ranges to outputs every cycle
            start_red_val<=red_min; end_red_val<=red_max; start_green_val<=green_min; end_green_val<=green_max; start_blue_val<=blue_min; end_blue_val<=blue_max;
            // start_h_val<=h_min; end_h_val<=h_max; start_s_val<=s_min; end_s_val<=s_max; start_v_val<=v_min; end_v_val<=v_max;
        end
    end

    // ---------------- Combinational UI rendering ----------------
    // Draws: slider tracks (hue gradient on top slider in HSV mode), selection ranges, eyedropper
    // markers, arrow-shaped slider handles, min/max preview boxes, and mode/eyedropper toggles.
    reg [11:0] pixel_out;
    reg        pixel_active;

    // UI rendering
    always @(*) begin
                    // clamp to ensure max >= min (mouse_val_bin already quantized 0..15)
    pixel_active = 1'b0;
    pixel_out    = 12'h000;

        if (!enable)   ; // quick exit when disabled
        // 1. Track base / hue gradient (slider0). In HSV mode draw 16-step hue gradient with selection highlight.
        else if ((py_src >= (SLIDER0_Y - 2)) && (py_src <= (SLIDER0_Y + SLIDER_THICKNESS_Y + 2)) &&
                 (px_src >= SLIDE_X0) && (px_src <= SLIDE_X1)) begin
            pixel_active = 1'b1;
            // if (mode_is_hsv) begin
            //     // Map px_src to hue bin (0..15) without division (ladder of comparisons)
            //     if (px_src <= SLIDE_X0) hue_px_bin = 4'd0;
            //     else if (px_src < SLIDE_X0 + 1*SLIDER_STEP) hue_px_bin = 4'd0;
            //     else if (px_src < SLIDE_X0 + 2*SLIDER_STEP) hue_px_bin = 4'd1;
            //     else if (px_src < SLIDE_X0 + 3*SLIDER_STEP) hue_px_bin = 4'd2;
            //     else if (px_src < SLIDE_X0 + 4*SLIDER_STEP) hue_px_bin = 4'd3;
            //     else if (px_src < SLIDE_X0 + 5*SLIDER_STEP) hue_px_bin = 4'd4;
            //     else if (px_src < SLIDE_X0 + 6*SLIDER_STEP) hue_px_bin = 4'd5;
            //     else if (px_src < SLIDE_X0 + 7*SLIDER_STEP) hue_px_bin = 4'd6;
            //     else if (px_src < SLIDE_X0 + 8*SLIDER_STEP) hue_px_bin = 4'd7;
            //     else if (px_src < SLIDE_X0 + 9*SLIDER_STEP) hue_px_bin = 4'd8;
            //     else if (px_src < SLIDE_X0 +10*SLIDER_STEP) hue_px_bin = 4'd9;
            //     else if (px_src < SLIDE_X0 +11*SLIDER_STEP) hue_px_bin = 4'd10;
            //     else if (px_src < SLIDE_X0 +12*SLIDER_STEP) hue_px_bin = 4'd11;
            //     else if (px_src < SLIDE_X0 +13*SLIDER_STEP) hue_px_bin = 4'd12;
            //     else if (px_src < SLIDE_X0 +14*SLIDER_STEP) hue_px_bin = 4'd13;
            //     else if (px_src < SLIDE_X0 +15*SLIDER_STEP) hue_px_bin = 4'd14;
            //     else hue_px_bin = 4'd15;
            //     // Build gradient colour via simplified HSV->RGB (S=15,V=15 -> C=14,m=1)
            //     Cg = 5'd14; mg = 5'd1; Hmul = {3'b000,hue_px_bin} * 7'd6; secg = Hmul[6:4];
            //     Rg = mg; Gg = mg; Bg = mg;
            //     case (secg)
            //         3'd0: begin Rg = 5'd15; Gg = mg + Cg; end // red->yellow
            //         3'd1: begin Gg = 5'd15; Rg = 5'd15 - Cg; end // yellow->green
            //         3'd2: begin Gg = 5'd15; Bg = mg + Cg; end // green->cyan
            //         3'd3: begin Bg = 5'd15; Gg = 5'd15 - Cg; end // cyan->blue
            //         3'd4: begin Bg = 5'd15; Rg = mg + Cg; end // blue->magenta
            //         default: begin Rg = 5'd15; Bg = 5'd15 - Cg; end // magenta->red
            //     endcase
            //     hue_grad_color = {Bg[3:0], Gg[3:0], Rg[3:0]};
            //     // Determine selection vs non-selection (wrap logic)
            //     if (h_min <= h_max) hue_sel = (hue_px_bin >= h_min) && (hue_px_bin <= h_max); else hue_sel = (hue_px_bin >= h_min) || (hue_px_bin <= h_max);
            //     // Highlight: selected region uses full gradient; non-selected darkened.
            //     hue_out_color = hue_sel ? hue_grad_color : (hue_grad_color & 12'h333);
            //     pixel_out = hue_out_color;
            // end else begin
                // RGB mode: fallback grey track
                pixel_out = CLR_GREY;
            // end
        end
        else if ((py_src >= (SLIDER1_Y - 2)) && (py_src <= (SLIDER1_Y + SLIDER_THICKNESS_Y + 2)) &&
                 (px_src >= SLIDE_X0) && (px_src <= SLIDE_X1)) begin
            pixel_active = 1'b1;
            pixel_out    = CLR_GREY;
        end
        else if ((py_src >= (SLIDER2_Y - 2)) && (py_src <= (SLIDER2_Y + SLIDER_THICKNESS_Y + 2)) &&
                 (px_src >= SLIDE_X0) && (px_src <= SLIDE_X1)) begin
            pixel_active = 1'b1;
            pixel_out    = CLR_GREY;
        end

        // 2. Coloured ranges by bin (ensure last cell reachable). HSV: slider1/2 white; slider0 gradient only.
        if (//!mode_is_hsv && 
        (py_src >= (SLIDER0_Y - 2)) && (py_src <= (SLIDER0_Y + SLIDER_THICKNESS_Y + 2))) begin
            if ((px_src >= (SLIDE_X0 + slider0_min*SLIDER_STEP)) && (px_src < (SLIDE_X0 + (slider0_max+1)*SLIDER_STEP))) begin
                pixel_active = 1'b1; pixel_out = RED; end
        end
        if ((py_src >= (SLIDER1_Y - 2)) && (py_src <= (SLIDER1_Y + SLIDER_THICKNESS_Y + 2))) begin
            if ((px_src >= (SLIDE_X0 + slider1_min*SLIDER_STEP)) && (px_src < (SLIDE_X0 + (slider1_max+1)*SLIDER_STEP))) begin
                pixel_active = 1'b1; pixel_out = 
                // mode_is_hsv ? CLR_WHITE : 
                GREEN; end
        end
        if ((py_src >= (SLIDER2_Y - 2)) && (py_src <= (SLIDER2_Y + SLIDER_THICKNESS_Y + 2))) begin
            if ((px_src >= (SLIDE_X0 + slider2_min*SLIDER_STEP)) && (px_src < (SLIDE_X0 + (slider2_max+1)*SLIDER_STEP))) begin
                pixel_active = 1'b1; pixel_out = 
                // mode_is_hsv ? CLR_WHITE : 
                BLUE; end
        end

        // Eyedropper black lines
        if ((py_src >= SLIDER0_Y - 2) && (py_src <= (SLIDER0_Y + EYEDROPPER_LINE_HEIGHT)) &&
            (px_src >= eye_red_pos_x) && (px_src <= eye_red_pos_x + EYEDROPPER_LINE_WIDTH)) begin
            pixel_active = 1'b1;
            pixel_out = picked_color;
        end
        else if ((py_src >= SLIDER1_Y - 2) && (py_src <= (SLIDER1_Y + EYEDROPPER_LINE_HEIGHT)) &&
            (px_src >= eye_green_pos_x) && (px_src <= eye_green_pos_x + EYEDROPPER_LINE_WIDTH)) begin
            pixel_active = 1'b1;
            pixel_out = picked_color;
        end
        else if ((py_src >= SLIDER2_Y - 2) && (py_src <= (SLIDER2_Y + EYEDROPPER_LINE_HEIGHT)) &&
            (px_src >= eye_blue_pos_x) && (px_src <= eye_blue_pos_x + EYEDROPPER_LINE_WIDTH)) begin
            pixel_active = 1'b1;
            pixel_out = picked_color;
        end

        // slider arrows (triangles). We approximate filled triangles without division using diff_y<<1 comparisons.
        // Use bounding box for drag hit-tests (sequential logic) but draw triangle here.
        // begin
            // Slider 0 (Hue or Red)
            x_left  = knob_r_min_x_disp - (ARROW_W>>1);
            x_right = knob_r_min_x_disp + (ARROW_W>>1);
            if ((px_src >= x_left) && (px_src < x_right) && (py_src >= (SLIDER0_Y - (ARROW_H>>1))) && (py_src < (SLIDER0_Y + (ARROW_H>>1)))) begin
                diff_y = (py_src >= SLIDER0_Y) ? (py_src - SLIDER0_Y) : (SLIDER0_Y - py_src);
                dx_inv = x_right - px_src; // left-pointing arrow for MIN
                if ((diff_y<<1) <= dx_inv) begin
                    pixel_active = 1'b1;
                    pixel_out = dragging_r_min ? CLR_PICK : CLR_WHITE;
                end
            end
            x_left  = knob_r_max_x_disp - (ARROW_W>>1);
            x_right = knob_r_max_x_disp + (ARROW_W>>1);
            if ((px_src >= x_left) && (px_src < x_right) && (py_src >= (SLIDER0_Y - (ARROW_H>>1))) && (py_src < (SLIDER0_Y + (ARROW_H>>1)))) begin
                diff_y = (py_src >= SLIDER0_Y) ? (py_src - SLIDER0_Y) : (SLIDER0_Y - py_src);
                dx = px_src - x_left; // right-pointing arrow for MAX
                if ((diff_y<<1) <= dx) begin
                    pixel_active = 1'b1;
                    pixel_out = dragging_r_max ? CLR_PICK : CLR_WHITE;
                end
            end
            // Slider 1 (S or Green)
            x_left  = knob_g_min_x_disp - (ARROW_W>>1);
            x_right = knob_g_min_x_disp + (ARROW_W>>1);
            if ((px_src >= x_left) && (px_src < x_right) && (py_src >= (SLIDER1_Y - (ARROW_H>>1))) && (py_src < (SLIDER1_Y + (ARROW_H>>1)))) begin
                diff_y = (py_src >= SLIDER1_Y) ? (py_src - SLIDER1_Y) : (SLIDER1_Y - py_src);
                dx_inv = x_right - px_src; // left-pointing for MIN
                if ((diff_y<<1) <= dx_inv) begin
                    pixel_active = 1'b1; pixel_out = dragging_g_min ? CLR_PICK : CLR_WHITE; end
            end
            x_left  = knob_g_max_x_disp - (ARROW_W>>1);
            x_right = knob_g_max_x_disp + (ARROW_W>>1);
            if ((px_src >= x_left) && (px_src < x_right) && (py_src >= (SLIDER1_Y - (ARROW_H>>1))) && (py_src < (SLIDER1_Y + (ARROW_H>>1)))) begin
                diff_y = (py_src >= SLIDER1_Y) ? (py_src - SLIDER1_Y) : (SLIDER1_Y - py_src);
                dx = px_src - x_left; // right-pointing for MAX
                if ((diff_y<<1) <= dx) begin
                    pixel_active = 1'b1; pixel_out = dragging_g_max ? CLR_PICK : CLR_WHITE; end
            end
            // Slider 2 (V or Blue)
            x_left  = knob_b_min_x_disp - (ARROW_W>>1);
            x_right = knob_b_min_x_disp + (ARROW_W>>1);
            if ((px_src >= x_left) && (px_src < x_right) && (py_src >= (SLIDER2_Y - (ARROW_H>>1))) && (py_src < (SLIDER2_Y + (ARROW_H>>1)))) begin
                diff_y = (py_src >= SLIDER2_Y) ? (py_src - SLIDER2_Y) : (SLIDER2_Y - py_src);
                dx_inv = x_right - px_src; // left-pointing for MIN
                if ((diff_y<<1) <= dx_inv) begin
                    pixel_active = 1'b1; pixel_out = dragging_b_min ? CLR_PICK : CLR_WHITE; end
            end
            x_left  = knob_b_max_x_disp - (ARROW_W>>1);
            x_right = knob_b_max_x_disp + (ARROW_W>>1);
            if ((px_src >= x_left) && (px_src < x_right) && (py_src >= (SLIDER2_Y - (ARROW_H>>1))) && (py_src < (SLIDER2_Y + (ARROW_H>>1)))) begin
                diff_y = (py_src >= SLIDER2_Y) ? (py_src - SLIDER2_Y) : (SLIDER2_Y - py_src);
                dx = px_src - x_left; // right-pointing for MAX
                if ((diff_y<<1) <= dx) begin
                    pixel_active = 1'b1; pixel_out = dragging_b_max ? CLR_PICK : CLR_WHITE; end
            end
        // end

        // display color boxes
        // Left Box
        if ((px_src > BOX_START_LEFT_X) && (px_src < (BOX_START_LEFT_X + BOX_WIDTH_HEIGHT)) && 
        (py_src >= BOX_START_LEFT_Y) && (py_src < (BOX_START_LEFT_Y + BOX_WIDTH_HEIGHT))) begin
            // red box
            pixel_active = 1'b1;
            // Inline HSV->RGB preview (coarse) for lower endpoint when in HSV mode (no function calls)
            // if (mode_is_hsv) begin
            //     C0p = (s_min * v_min) >> 4; m0p = v_min - C0p; H0p = {3'b000,h_min} * 6; S0p = H0p[6:4];
            //     R0p = m0p; G0p = m0p; B0p = m0p;
            //     case (S0p)
            //         3'd0: begin R0p = v_min; G0p = m0p + C0p; end
            //         3'd1: begin G0p = v_min; R0p = v_min - C0p; end
            //         3'd2: begin G0p = v_min; B0p = m0p + C0p; end
            //         3'd3: begin B0p = v_min; G0p = v_min - C0p; end
            //         3'd4: begin B0p = v_min; R0p = m0p + C0p; end
            //         default: begin R0p = v_min; B0p = v_min - C0p; end
            //     endcase
            //     pixel_out = {B0p[3:0], G0p[3:0], R0p[3:0]};
            // end else 
            pixel_out = {blue_min, green_min, red_min};
        end
        // right box
        else if ((px_src >= (BOX_START_LEFT_X + BOX_WIDTH_HEIGHT + 5)) && (px_src < (BOX_START_LEFT_X + 2 *  BOX_WIDTH_HEIGHT + 5)) && (py_src >= BOX_START_LEFT_Y) && (py_src < (BOX_START_LEFT_Y + BOX_WIDTH_HEIGHT))) begin
            pixel_active = 1'b1;
            // Inline HSV->RGB preview for upper endpoint (uses h_max,s_max,v_max)
            // if (mode_is_hsv) begin
            //     C1p = (s_max * v_max) >> 4; m1p = v_max - C1p; H1p = {3'b000,h_max} * 6; S1p = H1p[6:4];
            //     R1p = m1p; G1p = m1p; B1p = m1p;
            //     case (S1p)
            //         3'd0: begin R1p = v_max; G1p = m1p + C1p; end
            //         3'd1: begin G1p = v_max; R1p = v_max - C1p; end
            //         3'd2: begin G1p = v_max; B1p = m1p + C1p; end
            //         3'd3: begin B1p = v_max; G1p = v_max - C1p; end
            //         3'd4: begin B1p = v_max; R1p = m1p + C1p; end
            //         default: begin R1p = v_max; B1p = v_max - C1p; end
            //     endcase
            //     pixel_out = {B1p[3:0], G1p[3:0], R1p[3:0]};
            // end else 
            pixel_out = {blue_max, green_max, red_max};
        end

        // <---- Eyedropper display rectangle (shows sampled colour) ----->
        else if ((px_src >= EYE_X) && (px_src < (EYE_X + EYE_W)) && (py_src >= EYE_Y) && (py_src < (EYE_Y + EYE_H))) begin
            pixel_active = 1'b1;
            pixel_out = picked_color;
        end

        // Eyedropper toggle square
        else if ((px_src >= EYE_TOG_X) && (px_src < (EYE_TOG_X + EYE_TOG_W)) && (py_src >= EYE_TOG_Y) && (py_src < (EYE_TOG_Y + EYE_TOG_H))) begin
            pixel_active = 1'b1;
            // visible feedback when enabled
            pixel_out = eyedropper_enabled ? CLR_GREY : CLR_WHITE;
        end
        // // Mode toggle rectangles (outline fill)
        // else if ((px_src >= RGB_TOG_X) && (px_src < (RGB_TOG_X + MODE_TOG_W)) && (py_src >= RGB_TOG_Y) && (py_src < (RGB_TOG_Y + MODE_TOG_H))) begin
        //     pixel_active = 1'b1;
        //     pixel_out = (mode_is_hsv == 1'b0) ? CLR_BLACK : CLR_GREY;
        // end
        // else if ((px_src >= HSV_TOG_X) && (px_src < (HSV_TOG_X + MODE_TOG_W)) && (py_src >= HSV_TOG_Y) && (py_src < (HSV_TOG_Y + MODE_TOG_H))) begin
        //     pixel_active = 1'b1;
        //     pixel_out = (mode_is_hsv == 1'b1) ? CLR_BLACK : CLR_GREY;
        // end
    end      

    assign section_pixel = pixel_out;
    assign section_active = pixel_active;
    // reg hue_pass, sat_pass, val_pass; // local pass flags (1-cycle wires)
    reg rpass, gpass, bpass;
    // --- Pixel classification output (internal thresholding) ---
    // RGB444 input is {B[11:8], G[7:4], R[3:0]}
    // In HSV mode, convert to HSV Q4 and apply wrap-aware comparisons.
    always @(*) begin
            // if ((state == ST_HSV) || (state == ST_TO_HSV)) begin
            //     // Convert rgb_pixel_in to HSV (4-bit)
            //     pr_t = rgb_pixel_in[3:0];
            //     pg_t = rgb_pixel_in[11:8];
            //     pb_t = rgb_pixel_in[7:4];
            //     pmax_t = (pr_t>=pg_t && pr_t>=pb_t) ? pr_t : (pg_t>=pb_t ? pg_t : pb_t);
            //     pmin_t = (pr_t<=pg_t && pr_t<=pb_t) ? pr_t : (pg_t<=pb_t ? pg_t : pb_t);
            //     pdelta_t = pmax_t - pmin_t;
            //     pv_t = pmax_t; // value
            //     ps_t = pdelta_t; // saturation approx
            //     if (pdelta_t == 4'd0) begin
            //         ph_t = 4'd0;
            //     end else begin
            //         if (pmax_t == pr_t) begin
            //             pt_t = $signed({2'b00,pg_t}) - $signed({2'b00,pb_t});
            //             if (pt_t >= 0) begin
            //                 ph_t = ( (pt_t<<<2) >= (3*pdelta_t) ) ? 4'd5 :
            //                        ( (pt_t<<<1) >= (pdelta_t) )   ? 4'd3 : 4'd1;
            //             end else begin
            //                 ph_t = 4'd15 - ( ((-pt_t)<<<2) >= (3*pdelta_t) ? 4'd1 : (((-pt_t)<<<1) >= pdelta_t ? 4'd3 : 4'd5) );
            //             end
            //         end else if (pmax_t == pg_t) begin
            //             pt_t = $signed({2'b00,pb_t}) - $signed({2'b00,pr_t});
            //             if (pt_t >= 0) begin
            //                 ph_t = 4'd5 + ( (pt_t<<<2) >= (3*pdelta_t) ? 4'd5 : ( (pt_t<<<1) >= pdelta_t ? 4'd3 : 4'd1 ) );
            //             end else begin
            //                 ph_t = 4'd5 - ( ((-pt_t)<<<2) >= (3*pdelta_t) ? 4'd1 : (((-pt_t)<<<1) >= pdelta_t ? 4'd3 : 4'd5) );
            //             end
            //         end else begin
            //             pt_t = $signed({2'b00,pr_t}) - $signed({2'b00,pg_t});
            //             if (pt_t >= 0) begin
            //                 ph_t = 4'd10 + ( (pt_t<<<2) >= (3*pdelta_t) ? 4'd5 : ( (pt_t<<<1) >= pdelta_t ? 4'd3 : 4'd1 ) );
            //             end else begin
            //                 ph_t = 4'd10 - ( ((-pt_t)<<<2) >= (3*pdelta_t) ? 4'd1 : (((-pt_t)<<<1) >= pdelta_t ? 4'd3 : 4'd5) );
            //             end
            //         end
            //     end

                // Apply thresholds with hue wrap logic
                // Hue selected if inside range when not wrapped; or outside center when wrapped
                // S/V are standard (min<=max enforced by UI).
            //     if (h_min <= h_max) hue_pass = (ph_t >= h_min) && (ph_t <= h_max);
            //     else                hue_pass = (ph_t >= h_min) || (ph_t <= h_max);
            //     sat_pass = (ps_t >= s_min) && (ps_t <= s_max);
            //     val_pass = (pv_t >= v_min) && (pv_t <= v_max);
            //     threshold_pixel = hue_pass && sat_pass && val_pass;
            // end else begin
                // RGB mode thresholding
                rpass = (rgb_pixel_in[3:0]   >= red_min)   && (rgb_pixel_in[3:0]   <= red_max);
                gpass = (rgb_pixel_in[11:8]  >= green_min) && (rgb_pixel_in[11:8]  <= green_max);
                bpass = (rgb_pixel_in[7:4]   >= blue_min)  && (rgb_pixel_in[7:4]   <= blue_max);
                threshold_pixel = rpass && gpass && bpass;
            // end
    end

endmodule