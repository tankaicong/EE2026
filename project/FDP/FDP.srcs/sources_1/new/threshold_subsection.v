`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// This module allows users to threshold bitmap images based on RGB or HSV ranges.
// 2 buttons. One to turn on HSV mode, one to turn on RGB mode. 
// Toggling one will untoggle the other (use the same logic as the changeview.v toggling of 4 buttons.)
//
// Then, thresholding follows the mode that is turned on. 
// In RGB mode, rgb_pixel_out is taken in, user use slider to change RGB_THRESHOLD values, then outputs this threshold values to top.v then threshold_pixel_rgb will be 1 or 0
//
// In HSV mode, we mux the thresholding pipeline, such that within threshold_subsection, 
// it is RGB pixel out -> convert to HSV_pixel -> use HSV thresholdings that are actually now in HSV values -> send to top.v the min and max H, S, V values. 
// threshold_pixel_rgb then uses these min and max H S V values to get 1 or 0
//
// For the convertion from RGB to HSV, do it within threshold_subsection.
//
// Sliders:
//      RGB mode: R, G, B sliders set channel min/max independently (0..15).
//      HSV mode: H, S, V sliders set intuitive ranges (0..15) where:
//      H is sector index 0..15 (0=red.. ~5=green .. ~10=blue).
//      S and V ranges are 0..15 (more saturated, brighter).
//      Implementation: In HSV mode, the three sliders update HSV min/max.
//      Those are converted to RGB min/max internally and exported out to Top so thresholding stays in RGB.
//
// Box colors:
//      Left box shows the lower endpoint; right box the upper endpoint.
//      In HSV mode, those endpoints are converted to RGB for display, so the colors are visually consistent regardless of mode.
//
// Toggling behavior:
//      RGB → HSV: We compute HSV endpoints from the current RGB endpoints, so sliders start in the “right” place. Large boxes keep the same colors.
//      HSV → RGB: Sliders return to RGB sliders; exported RGB outputs just mirror the RGB regs. Large boxes keep the same colors.
//
// RGB to HSV math
// Based on https://www.rapidtables.com/convert/color/rgb-to-hsv.html
// V = max(R,G,B)
// S = 0 if V=0 else (V - min(R,G,B)) / V (floor ((delta * 15) / MAX) for 4-bit S)
// H 0 to 15 derived via ratio = floor ((abs(diff) * 15) / delta)
//
//////////////////////////////////////////////////////////////////////////////////


`timescale 1ns / 1ps
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
    input  wire        enable,         // module only active when enable asserted (e.g. in S_GAME_AUTO_MODE)
    // BRAM pixel input at mouse location (sampled externally / provided by Top)
    input wire [11:0] bram_pixel_out,
    input wire [11:0] mouse_color_bram,
    // Range outputs: 4-bit per channel (0..15)
    output reg  [3:0]  start_red_val,     // 0..15
    output reg  [3:0]  end_red_val,        
    output reg  [3:0]  start_green_val,      
    output reg  [3:0]  end_green_val,        
    output reg  [3:0]  start_blue_val,
    output reg  [3:0]  end_blue_val,
    // HSV outputs (0..15 per channel)
    output reg  [3:0]  start_h_val,
    output reg  [3:0]  end_h_val,
    output reg  [3:0]  start_s_val,
    output reg  [3:0]  end_s_val,
    output reg  [3:0]  start_v_val,
    output reg  [3:0]  end_v_val,
    // Mode flag: 1 = HSV mode, 0 = RGB mode
    output reg         mode_is_hsv,
    output wire [11:0] section_pixel,  // 12-bit (RGB444) pixel to overlay when module asserts active
    output wire        section_active  // 1 if this module wants to drive pixel
);

    // Slider geometry (user requested)
    // First slider: x = 138 (left edge of track), y = 268
    localparam SLIDE_X0       = 145; // 138
    localparam SLIDER_WIDTH  = 160;          // track length in pixels (160)
    localparam SLIDE_X1       = SLIDE_X0 + SLIDER_WIDTH; // slider track end
    localparam SLIDER_THICKNESS_Y = 4;           // thickness (height) of the track (4)
    // localparam SLIDER_GAP_Y   = 15;           // vertical gap between sliders (comment out)
    // Slider Y positions (VGA coordinates) so they line up with the BRAM-backed overlay
    localparam SLIDER0_Y      = 9'd352;
    localparam SLIDER1_Y      = 9'd367;
    localparam SLIDER2_Y      = 9'd382;
    localparam KNOB_SIZE_HEIGHT = 12; // 12
    localparam KNOB_SIZE_WIDTH = 6; // 6


    // Line to demarcate eyedropper section
    localparam EYEDROPPER_LINE_HEIGHT = 12;
    localparam EYEDROPPER_LINE_WIDTH = 2;


    // Color boxes to display lower and higher end of thresholds
    localparam BOX_WIDTH_HEIGHT = 42; //
    localparam BOX_START_LEFT_X = 33; // 13
    localparam BOX_START_LEFT_Y = 9'd348; // VGA Y coordinate for color boxes

    // Eyedropper display color rectangle and toggle square geometry (VGA coords)
    localparam EYE_X = 10'd230; // eyedropper color display box left
    localparam EYE_Y = 9'd330;
    localparam EYE_W = 10'd50;
    localparam EYE_H = 9'd15;

    // Eyedropper (actual) background square
    localparam EYE_TOG_X = 10'd290; // small square to toggle eyedropper mode
    localparam EYE_TOG_Y = 9'd330;
    localparam EYE_TOG_W = 10'd15;
    localparam EYE_TOG_H = 9'd15;

    // Mode toggle buttons: RGB / HSV (mutually exclusive)
    localparam MODE_TOG_W = 10'd32;
    localparam MODE_TOG_H = 9'd15;
    localparam RGB_TOG_X  = 10'd150;
    localparam RGB_TOG_Y  = 9'd330;
    localparam HSV_TOG_X  = 10'd190;
    localparam HSV_TOG_Y  = 9'd330;


    // Colors (12-bit RGB444)
    localparam GREEN = 12'h1C1;
    localparam RED   = 12'h00F;
    localparam BLUE  = 12'hF00;

    // Common draw colours
    localparam CLR_WHITE  = 12'hFFF;
    localparam CLR_BLACK  = 12'h000;
    localparam CLR_GREY   = 12'h888;
    localparam CLR_CYAN = 12'hFF0;

    // Helper functions
    // slider active detection helper (horizontal track)
    function is_on_track;
        input [9:0] x;
        input [9:0] y;
        input [9:0] ty;
        begin
            is_on_track = (x >= SLIDE_X0 && x <= SLIDE_X1 && (y >= (ty - 2) && y <= (ty + SLIDER_THICKNESS_Y + 2)));
        end
    endfunction

    // knob hit test
    function is_on_knob;
        input [9:0] x;
        input [9:0] y;
        input [9:0] kx;
        input [9:0] ky;
        begin
            // Use separate knob width/height (centered at kx,ky)
            is_on_knob = (x >= (kx - (KNOB_SIZE_WIDTH>>1)) && x <= (kx + (KNOB_SIZE_WIDTH>>1)) &&
                          y >= (ky - (KNOB_SIZE_HEIGHT>>1)) && y <= (ky + (KNOB_SIZE_HEIGHT>>1)));
        end
    endfunction

    // slider values and dragging state (range sliders: min/max per channel, 0..15)
    reg [3:0] red_min,  red_max;
    reg [3:0] green_min, green_max;
    reg [3:0] blue_min, blue_max;
    // HSV ranges (internal)
    reg [3:0] h_min, h_max;
    reg [3:0] s_min, s_max;
    reg [3:0] v_min, v_max;
    reg dragging_r_min, dragging_r_max;
    reg dragging_g_min, dragging_g_max;
    reg dragging_b_min, dragging_b_max;

    // Eyedropper state and picked color
    reg eyedropper_enabled;
    reg [11:0] picked_color;


    // knob X positions derived from 4-bit values (0..15 -> positions along track)
    // Active sliders follow mode: RGB uses R,G,B; HSV uses H,S,V.
    wire [3:0] slider0_min = mode_is_hsv ? h_min   : red_min;
    wire [3:0] slider0_max = mode_is_hsv ? h_max   : red_max;
    wire [3:0] slider1_min = mode_is_hsv ? s_min   : green_min;
    wire [3:0] slider1_max = mode_is_hsv ? s_max   : green_max;
    wire [3:0] slider2_min = mode_is_hsv ? v_min   : blue_min;
    wire [3:0] slider2_max = mode_is_hsv ? v_max   : blue_max;

    wire [9:0] knob_r_min_x = SLIDE_X0 + ((slider0_min * SLIDER_WIDTH) / 15);
    wire [9:0] knob_r_max_x = SLIDE_X0 + ((slider0_max * SLIDER_WIDTH) / 15);
    wire [9:0] knob_g_min_x = SLIDE_X0 + ((slider1_min * SLIDER_WIDTH) / 15);
    wire [9:0] knob_g_max_x = SLIDE_X0 + ((slider1_max * SLIDER_WIDTH) / 15);
    wire [9:0] knob_b_min_x = SLIDE_X0 + ((slider2_min * SLIDER_WIDTH) / 15);
    wire [9:0] knob_b_max_x = SLIDE_X0 + ((slider2_max * SLIDER_WIDTH) / 15);
    wire [9:0] eye_red_pos_x = SLIDE_X0 + ((picked_color[3:0] * SLIDER_WIDTH) / 15);
    wire [9:0] eye_blue_pos_x = SLIDE_X0 + ((picked_color[7:4] * SLIDER_WIDTH) / 15);
    wire [9:0] eye_green_pos_x = SLIDE_X0 + ((picked_color[11:8] * SLIDER_WIDTH) / 15);

    // display positions for knobs — when min==max, offset the two knobs left/right so
    // the user can select them separately (they form a side-by-side 10x10 visual block).
    wire [9:0] knob_r_min_x_disp = (red_min == red_max) ? (knob_r_min_x - (KNOB_SIZE_WIDTH >> 1)) : knob_r_min_x;
    wire [9:0] knob_r_max_x_disp = (red_min == red_max) ? (knob_r_max_x + (KNOB_SIZE_WIDTH >> 1)) : knob_r_max_x;
    wire [9:0] knob_g_min_x_disp = (green_min == green_max) ? (knob_g_min_x - (KNOB_SIZE_WIDTH >> 1)) : knob_g_min_x;
    wire [9:0] knob_g_max_x_disp = (green_min == green_max) ? (knob_g_max_x + (KNOB_SIZE_WIDTH >> 1)) : knob_g_max_x;
    wire [9:0] knob_b_min_x_disp = (blue_min == blue_max) ? (knob_b_min_x - (KNOB_SIZE_WIDTH >> 1)) : knob_b_min_x;
    wire [9:0] knob_b_max_x_disp = (blue_min == blue_max) ? (knob_b_max_x + (KNOB_SIZE_WIDTH >> 1)) : knob_b_max_x;

    // small temp for scaling math
    reg [15:0] tmp_calc;

    // --- RGB->HSV endpoint conversion (approx, integer, no div) ---
    // Helper wires for converting a single RGB444 color to HSV Q4 (H 0..15 (0=red ~5=green ~10=blue), S 0..15, V 0..15)
    // Implemented as a task-like comb block for use in procedural always blocks.
    // Since Verilog tasks are not allowed per constraints, inline the logic where needed.

    reg [3:0] r, g, b;
    reg [3:0] maxc, minc, delta;
    reg signed [5:0] t;
    reg [3:0] h_q, s_q, v_q;

    // initialize on reset
    always @(posedge clk25) begin
        if (vga_reset) begin
            red_min   <= 4'd0;
            red_max   <= 4'd15;
            green_min <= 4'd0;
            green_max <= 4'd15;
            blue_min  <= 4'd0;
            blue_max  <= 4'd15;
            // HSV defaults mirror full range
            h_min     <= 4'd0;
            h_max     <= 4'd15;
            s_min     <= 4'd0;
            s_max     <= 4'd15;
            v_min     <= 4'd0;
            v_max     <= 4'd15;
            dragging_r_min <= 1'b0; dragging_r_max <= 1'b0;
            dragging_g_min <= 1'b0; dragging_g_max <= 1'b0;
            dragging_b_min <= 1'b0; dragging_b_max <= 1'b0;
            // mirror into outputs
            start_red_val  <= 4'd0; end_red_val  <= 4'd15;
            start_green_val<= 4'd0; end_green_val<= 4'd15;
            start_blue_val <= 4'd0; end_blue_val <= 4'd15;
            start_h_val    <= 4'd0; end_h_val    <= 4'd15;
            start_s_val    <= 4'd0; end_s_val    <= 4'd15;
            start_v_val    <= 4'd0; end_v_val    <= 4'd15;
            mode_is_hsv    <= 1'b0; // default RGB mode
        end
        else if (enable) begin
            // ---------- RED range interaction ----------
            // If no other slider is active, this click may start red dragging.
            if (!left_click) begin
                dragging_r_min <= 1'b0;
                dragging_r_max <= 1'b0;
                dragging_g_min <= 1'b0;
                dragging_g_max <= 1'b0;
                dragging_b_min <= 1'b0;
                dragging_b_max <= 1'b0;
            // initiatize left click drag on red min knob
            end
            else begin 
                if (left_click && !dragging_r_max && !dragging_g_min && !dragging_g_max && !dragging_b_min && !dragging_b_max && is_on_knob(mouse_x_px, mouse_y_px, knob_r_min_x_disp, SLIDER0_Y)) begin
                    dragging_r_min <= 1'b1;
                end
                else if (left_click && !dragging_r_min && !dragging_g_min && !dragging_g_max && !dragging_b_min && !dragging_b_max && is_on_knob(mouse_x_px, mouse_y_px, knob_r_max_x_disp, SLIDER0_Y)) begin
                    dragging_r_max <= 1'b1;
                end
                else if (left_click && !dragging_r_min && !dragging_r_max && !dragging_g_max && !dragging_b_min && !dragging_b_max && is_on_knob(mouse_x_px, mouse_y_px, knob_g_min_x_disp, SLIDER1_Y)) begin
                    dragging_g_min <= 1'b1;
                end
                else if (left_click && !dragging_r_min && !dragging_r_max && !dragging_g_min && !dragging_b_min && !dragging_b_max && is_on_knob(mouse_x_px, mouse_y_px, knob_g_max_x_disp, SLIDER1_Y)) begin
                    dragging_g_max <= 1'b1;
                end
                else if(left_click && !dragging_r_min && !dragging_r_max && !dragging_g_min && !dragging_g_max && !dragging_b_max && is_on_knob(mouse_x_px, mouse_y_px, knob_b_min_x_disp, SLIDER2_Y)) begin
                    dragging_b_min <= 1'b1;
                end
                else if(left_click && !dragging_r_min && !dragging_r_max && !dragging_g_min && !dragging_g_max && !dragging_b_min && is_on_knob(mouse_x_px, mouse_y_px, knob_b_max_x_disp, SLIDER2_Y)) begin
                    dragging_b_max <= 1'b1;
                end
            end

            if (dragging_r_min) begin
                if (mouse_x_px < SLIDE_X0) begin
                    if (mode_is_hsv) h_min <= 4'd0; else red_min <= 4'd0;
                end
                else if (mouse_x_px > SLIDE_X1) begin 
                    if (mode_is_hsv) h_min <= h_max; else red_min <= red_max;
                end
                else begin
                    // temporary calc to perform multiply and divide
                    tmp_calc = ((mouse_x_px - SLIDE_X0) * 15) / SLIDER_WIDTH;
                    if (mode_is_hsv) begin
                        if (tmp_calc[3:0] > h_max) h_min <= h_max; else h_min <= tmp_calc[3:0];
                    end
                    else begin
                        if (tmp_calc[3:0] > red_max) red_min <= red_max; else red_min <= tmp_calc[3:0];
                    end
                end
                // ensure min <= max
                // if (red_min > red_max) red_min <= red_max;
            end
            else if (dragging_r_max) begin
                if (mouse_x_px < SLIDE_X0) begin 
                    if (mode_is_hsv) h_max <= h_min; else red_max <= red_min;
                end
                else if (mouse_x_px > SLIDE_X1) begin 
                    if (mode_is_hsv) h_max <= 4'd15; else red_max <= 4'd15;
                end
                else begin
                    tmp_calc = ((mouse_x_px - SLIDE_X0) * 15) / SLIDER_WIDTH;
                    if (mode_is_hsv) begin
                        if (tmp_calc[3:0] < h_min) h_max <= h_min; else h_max <= tmp_calc[3:0];
                    end else begin
                        if (tmp_calc[3:0] < red_min) red_max <= red_min; else red_max <= tmp_calc[3:0];
                    end
                end
                // if (red_max < red_min) red_max <= red_min;
            end
            else if (dragging_g_min) begin
                if (mouse_x_px < SLIDE_X0) begin
                    if (mode_is_hsv) s_min <= 4'd0; else green_min <= 4'd0;
                end
                else if (mouse_x_px > SLIDE_X1) begin 
                    if (mode_is_hsv) s_min <= s_max; else green_min <= green_max;
                end
                else begin
                    tmp_calc = ((mouse_x_px - SLIDE_X0) * 15) / SLIDER_WIDTH;
                    if (mode_is_hsv) begin
                        if (tmp_calc[3:0] > s_max) s_min <= s_max; else s_min <= tmp_calc[3:0];
                    end else begin
                        if (tmp_calc[3:0] > green_max) green_min <= green_max; else green_min <= tmp_calc[3:0];
                    end
                end
            end
            else if (dragging_g_max) begin
                if (mouse_x_px < SLIDE_X0) begin 
                    if (mode_is_hsv) s_max <= s_min; else green_max <= green_min;
                end else if (mouse_x_px > SLIDE_X1) begin
                    if (mode_is_hsv) s_max <= 4'd15; else green_max <= 4'd15;
                end
                else begin
                    tmp_calc = ((mouse_x_px - SLIDE_X0) * 15) / SLIDER_WIDTH;
                    if (mode_is_hsv) begin
                        if (tmp_calc[3:0] < s_min) s_max <= s_min; else s_max <= tmp_calc[3:0];
                    end else begin
                        if (tmp_calc[3:0] < green_min) green_max <= green_min; else green_max <= tmp_calc[3:0];
                    end
                end
            end
            else if (dragging_b_min) begin
                if (mouse_x_px < SLIDE_X0) begin
                    if (mode_is_hsv) v_min <= 4'd0; else blue_min <= 4'd0;
                end else if (mouse_x_px > SLIDE_X1) begin 
                    if (mode_is_hsv) v_min <= v_max; else blue_min <= blue_max;
                end
                else begin
                    tmp_calc = ((mouse_x_px - SLIDE_X0) * 15) / SLIDER_WIDTH;
                    if (mode_is_hsv) begin
                        if (tmp_calc[3:0] > v_max) v_min <= v_max; else v_min <= tmp_calc[3:0];
                    end else begin
                        if (tmp_calc[3:0] > blue_max) blue_min <= blue_max; else blue_min <= tmp_calc[3:0];
                    end
                end
            end
            else if (dragging_b_max) begin
                // mouse_x_px is in pixel coords — convert to 0..15 slider value
                if (mouse_x_px < SLIDE_X0) begin
                    if (mode_is_hsv) v_max <= 4'd0; else blue_max <= 4'd0;
                end else if (mouse_x_px > SLIDE_X1) begin
                    if (mode_is_hsv) v_max <= 4'd15; else blue_max <= 4'd15;
                end else begin
                    tmp_calc = ((mouse_x_px - SLIDE_X0) * 15) / SLIDER_WIDTH;
                    // clamp to ensure max >= min
                    if (mode_is_hsv) begin
                        if (tmp_calc[3:0] < v_min) v_max <= v_min; else v_max <= tmp_calc[3:0];
                    end else begin
                        if (tmp_calc[3:0] < blue_min) blue_max <= blue_min; else blue_max <= tmp_calc[3:0];
                    end
                end
            end

            // always mirror internal ranges to the outputs so Top.v or backend can read
            start_red_val  <= red_min;  
            end_red_val    <= red_max;
            start_green_val<= green_min;
            end_green_val  <= green_max;
            start_blue_val <= blue_min; 
            end_blue_val   <= blue_max;
            start_h_val    <= h_min;  end_h_val <= h_max;
            start_s_val    <= s_min;  end_s_val <= s_max;
            start_v_val    <= v_min;  end_v_val <= v_max;
        end


    // Eyedropper toggle and sampling: toggle with click inside small square; when enabled,
    // sample the provided BRAM pixel on any left_click_edge (except when toggling the square)
        if (vga_reset) begin
            eyedropper_enabled <= 1'b0;
            picked_color <= 12'h000;
        end
        else begin
            if (left_click_edge) begin
                // If click landed in the toggle square, flip enable
                if ((mouse_x_px >= EYE_TOG_X) && (mouse_x_px < (EYE_TOG_X + EYE_TOG_W)) &&
                    (mouse_y_px >= EYE_TOG_Y) && (mouse_y_px < (EYE_TOG_Y + EYE_TOG_H))) begin
                    eyedropper_enabled <= ~eyedropper_enabled;
                end
                // Mode toggle buttons: mutually exclusive
                else if ((mouse_x_px >= RGB_TOG_X) && (mouse_x_px < (RGB_TOG_X + MODE_TOG_W)) &&
                             (mouse_y_px >= RGB_TOG_Y) && (mouse_y_px < (RGB_TOG_Y + MODE_TOG_H))) begin
                    // Switch to RGB mode and compute RGB endpoints from HSV so boxes keep colors
                    mode_is_hsv <= 1'b0;
                end
                // No change needed; boxes already use RGB registers
                else if ((mouse_x_px >= HSV_TOG_X) && (mouse_x_px < (HSV_TOG_X + MODE_TOG_W)) &&
                             (mouse_y_px >= HSV_TOG_Y) && (mouse_y_px < (HSV_TOG_Y + MODE_TOG_H))) begin
                    // Switch to HSV mode; compute initial HSV from current RGB endpoints
                    mode_is_hsv <= 1'b1;
                    // Convert lower RGB endpoint to HSV
                    // begin : RGBMIN_TO_HSV
           
                    r = red_min; g = green_min; b = blue_min;
                    // max/min
                    maxc = (r>=g && r>=b) ? r : (g>=b ? g : b);
                    minc = (r<=g && r<=b) ? r : (g<=b ? g : b);
                    delta = maxc - minc;
                    v_q = maxc;
                    s_q = delta; // approximate saturation as chroma
                    if (delta == 4'd0) begin
                        h_q = 4'd0;
                    end
                    else begin
                        if (maxc == r) begin
                            t = $signed({2'b00,g}) - $signed({2'b00,b});
                            // map around red: 0..5 forward (towards green) or 15..11 (towards blue)
                            if (t >= 0) begin
                                // approximate 0..5 by thresholding t vs delta fractions
                                h_q = ( (t<<<2) >= (3*delta) ) ? 4'd5 :
                                        ( (t<<<1) >= (delta) )   ? 4'd3 :
                                        ( t >= 0 )               ? 4'd1 : 4'd0;
                            end
                            else begin
                                // negative t -> towards 15
                                h_q = 4'd15 - ( ((-t)<<<2) >= (3*delta) ? 4'd1 : (((-t)<<<1) >= delta ? 4'd3 : 4'd5) );
                            end
                        end
                        else if (maxc == g) begin
                            t = $signed({2'b00,b}) - $signed({2'b00,r});
                            if (t >= 0) begin
                                h_q = 4'd5 + ( (t<<<2) >= (3*delta) ? 4'd5 : ( (t<<<1) >= delta ? 4'd3 : 4'd1 ) );
                            end
                            else begin
                                h_q = 4'd5 - ( ((-t)<<<2) >= (3*delta) ? 4'd1 : (((-t)<<<1) >= delta ? 4'd3 : 4'd5) );
                            end
                        end
                        else begin // max = b
                            t = $signed({2'b00,r}) - $signed({2'b00,g});
                            if (t >= 0) begin
                                h_q = 4'd10 + ( (t<<<2) >= (3*delta) ? 4'd5 : ( (t<<<1) >= delta ? 4'd3 : 4'd1 ) );
                            end
                            else begin
                                h_q = 4'd10 - ( ((-t)<<<2) >= (3*delta) ? 4'd1 : (((-t)<<<1) >= delta ? 4'd3 : 4'd5) );
                            end
                        end
                    end
                    h_min <= h_q; s_min <= s_q; v_min <= v_q;
                    // Convert upper RGB endpoint to HSV
                    // begin : RGBMAX_TO_HSV
                    r = red_max; g = green_max; b = blue_max;
                    maxc = (r>=g && r>=b) ? r : (g>=b ? g : b);
                    minc = (r<=g && r<=b) ? r : (g<=b ? g : b);
                    delta = maxc - minc;
                    v_q = maxc;
                    s_q = delta;
                    if (delta == 4'd0) begin
                        h_q = 4'd0;
                    end 
                    else begin
                        if (maxc == r) begin
                            t = $signed({2'b00,g}) - $signed({2'b00,b});
                            if (t >= 0) begin
                                h_q = ( (t<<<2) >= (3*delta) ) ? 4'd5 :
                                        ( (t<<<1) >= (delta) )   ? 4'd3 : 4'd1;
                            end else begin
                                h_q = 4'd15 - ( ((-t)<<<2) >= (3*delta) ? 4'd1 : (((-t)<<<1) >= delta ? 4'd3 : 4'd5) );
                            end
                        end else if (maxc == g) begin
                            t = $signed({2'b00,b}) - $signed({2'b00,r});
                            if (t >= 0) begin
                                h_q = 4'd5 + ( (t<<<2) >= (3*delta) ? 4'd5 : ( (t<<<1) >= delta ? 4'd3 : 4'd1 ) );
                            end else begin
                                h_q = 4'd5 - ( ((-t)<<<2) >= (3*delta) ? 4'd1 : (((-t)<<<1) >= delta ? 4'd3 : 4'd5) );
                            end
                        end else begin
                            t = $signed({2'b00,r}) - $signed({2'b00,g});
                            if (t >= 0) begin
                                h_q = 4'd10 + ( (t<<<2) >= (3*delta) ? 4'd5 : ( (t<<<1) >= delta ? 4'd3 : 4'd1 ) );
                            end else begin
                                h_q = 4'd10 - ( ((-t)<<<2) >= (3*delta) ? 4'd1 : (((-t)<<<1) >= delta ? 4'd3 : 4'd5) );
                            end
                        end
                    end
                    h_max <= h_q; s_max <= s_q; v_max <= v_q;
                end
            end
            else begin
                // capture color of bram pixel at mouse location if eyedropper enabled
                if (eyedropper_enabled) begin
                    picked_color <= mouse_color_bram;
                end
            end
        end
    end

    // Display hover color design
    reg [11:0] pixel_out;
    reg        pixel_active;

    // Approximate HSV->RGB conversion for box colors when in HSV mode
    // Uses coarse 6-sector mapping and fixed-point products via shifts.
    wire [3:0] box0_h = h_min, box0_s = s_min, box0_v = v_min;
    wire [3:0] box1_h = h_max, box1_s = s_max, box1_v = v_max;
    function [11:0] hsv_to_rgb444;
        input [3:0] H4; input [3:0] S4; input [3:0] V4;
        reg [6:0] H6; // 0..95 approx (scaled 0..6*16)
        reg [2:0] sector;
        reg [4:0] C, m; // up to 30 okay
        reg [4:0] Rp,Gp,Bp;
        begin
            H6 = H4 * 6; // 0..90
            sector = H6[6:4]; // top bits ~ 0..5
            C = (S4 * V4) >> 4; // approx (S*V)/16
            m = V4 - C;
            // Simple mapping without fractional within sector: choose endpoints
            case (sector)
                3'd0: begin Rp = V4; Gp = m + C; Bp = m; end       // R->Y
                3'd1: begin Rp = m + C; Gp = V4; Bp = m; end       // Y->G
                3'd2: begin Rp = m; Gp = V4; Bp = m + C; end       // G->C
                3'd3: begin Rp = m; Gp = m + C; Bp = V4; end       // C->B
                3'd4: begin Rp = m + C; Gp = m; Bp = V4; end       // B->M
                default: begin Rp = V4; Gp = m; Bp = m + C; end    // M->R
            endcase
            hsv_to_rgb444 = {Gp[3:0], Bp[3:0], Rp[3:0]}; // Note project uses {B,G,R} ordering in some places; here boxes expect {B,G,R}
        end
    endfunction

    always @(*) begin
        // default: not active (let other overlays draw)
        pixel_active = 1'b0;
        pixel_out = 12'h000;

        if (!enable) ;   // quick exit when disabled
        // 1. Grey track base (lowest priority)
        else if (is_on_track(px_src, py_src, SLIDER0_Y)) begin
            pixel_active = 1'b1;
            pixel_out    = CLR_GREY;
        end
        else if (is_on_track(px_src, py_src, SLIDER1_Y)) begin
            pixel_active = 1'b1;
            pixel_out    = CLR_GREY;
        end
        else if (is_on_track(px_src, py_src, SLIDER2_Y)) begin
            pixel_active = 1'b1;
            pixel_out    = CLR_GREY;
        end

        // 2. Coloured range
        if ((py_src >= (SLIDER0_Y - 2)) && (py_src <= (SLIDER0_Y + SLIDER_THICKNESS_Y + 2)) &&
            (px_src >= knob_r_min_x_disp) && (px_src <= knob_r_max_x_disp)) begin
            pixel_active = 1'b1;
            pixel_out    = RED;
        end
        if ((py_src >= (SLIDER1_Y - 2)) && (py_src <= (SLIDER1_Y + SLIDER_THICKNESS_Y + 2)) &&
            (px_src >= knob_g_min_x_disp) && (px_src <= knob_g_max_x_disp)) begin
            pixel_active = 1'b1;
            pixel_out    = GREEN;
        end
        if ((py_src >= (SLIDER2_Y - 2)) && (py_src <= (SLIDER2_Y + SLIDER_THICKNESS_Y + 2)) &&
            (px_src >= knob_b_min_x_disp) && (px_src <= knob_b_max_x_disp)) begin
            pixel_active = 1'b1;
            pixel_out    = BLUE;
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

        // slider knobs
        if (is_on_knob(px_src, py_src, knob_r_min_x_disp, SLIDER0_Y)) begin
            pixel_active = 1'b1;
            pixel_out = dragging_r_min ? 12'hFB0 : CLR_WHITE;
        end
        else if (is_on_knob(px_src, py_src, knob_r_max_x_disp, SLIDER0_Y)) begin
            pixel_active = 1'b1;
            pixel_out = dragging_r_max ? 12'hFB0 : CLR_WHITE;
        end
        else if (is_on_knob(px_src, py_src, knob_g_min_x_disp, SLIDER1_Y)) begin
            pixel_active = 1'b1;
            pixel_out = dragging_g_min ? 12'hFB0 : CLR_WHITE;
        end
        else if (is_on_knob(px_src, py_src, knob_g_max_x_disp, SLIDER1_Y)) begin
            pixel_active = 1'b1;
            pixel_out = dragging_g_max ? 12'hFB0 : CLR_WHITE;
        end
        else if (is_on_knob(px_src, py_src, knob_b_min_x_disp, SLIDER2_Y)) begin
            pixel_active = 1'b1;
            pixel_out = dragging_b_min ? 12'hFB0 : CLR_WHITE;
        end
        else if (is_on_knob(px_src, py_src, knob_b_max_x_disp, SLIDER2_Y)) begin
            pixel_active = 1'b1;
            pixel_out = dragging_b_max ? 12'hFB0 : CLR_WHITE;
        end

        // display color boxes
        // Left Box
        if ((px_src > BOX_START_LEFT_X) && (px_src < (BOX_START_LEFT_X + BOX_WIDTH_HEIGHT)) && 
        (py_src >= BOX_START_LEFT_Y) && (py_src < (BOX_START_LEFT_Y + BOX_WIDTH_HEIGHT))) begin
            // red box
            pixel_active = 1'b1;
            pixel_out = mode_is_hsv ? hsv_to_rgb444(box0_h, box0_s, box0_v) : {blue_min, green_min, red_min}; // lower threshold
        end
        // right box
        else if ((px_src >= (BOX_START_LEFT_X + BOX_WIDTH_HEIGHT + 5)) && (px_src < (BOX_START_LEFT_X + 2 *  BOX_WIDTH_HEIGHT + 5)) && (py_src >= BOX_START_LEFT_Y) && (py_src < (BOX_START_LEFT_Y + BOX_WIDTH_HEIGHT))) begin
            pixel_active = 1'b1;
            pixel_out = mode_is_hsv ? hsv_to_rgb444(box1_h, box1_s, box1_v) : {blue_max, green_max, red_max}; // upper threshold
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
        // Mode toggle rectangles (outline fill)
        else if ((px_src >= RGB_TOG_X) && (px_src < (RGB_TOG_X + MODE_TOG_W)) && (py_src >= RGB_TOG_Y) && (py_src < (RGB_TOG_Y + MODE_TOG_H))) begin
            pixel_active = 1'b1;
            pixel_out = (mode_is_hsv == 1'b0) ? CLR_BLACK : CLR_GREY;
        end
        else if ((px_src >= HSV_TOG_X) && (px_src < (HSV_TOG_X + MODE_TOG_W)) && (py_src >= HSV_TOG_Y) && (py_src < (HSV_TOG_Y + MODE_TOG_H))) begin
            pixel_active = 1'b1;
            pixel_out = (mode_is_hsv == 1'b1) ? CLR_BLACK : CLR_GREY;
        end
    end      

    assign section_pixel = pixel_out;
    assign section_active = pixel_active;

endmodule