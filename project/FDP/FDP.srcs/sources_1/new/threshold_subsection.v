`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.10.2025 19:20:04
// Design Name: 
// Module Name: threshold_section
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
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


    // Colors (12-bit RGB444)
    localparam GREEN = 12'h0F0;
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
    reg dragging_r_min, dragging_r_max;
    reg dragging_g_min, dragging_g_max;
    reg dragging_b_min, dragging_b_max;

    // Eyedropper state and picked color
    reg eyedropper_enabled;
    reg [11:0] picked_color;


    // knob X positions derived from 4-bit values (0..15 -> positions along track)

    wire [9:0] knob_r_min_x = SLIDE_X0 + ((red_min * SLIDER_WIDTH) / 15);
    wire [9:0] knob_r_max_x = SLIDE_X0 + ((red_max * SLIDER_WIDTH) / 15);
    wire [9:0] knob_g_min_x = SLIDE_X0 + ((green_min* SLIDER_WIDTH) / 15);
    wire [9:0] knob_g_max_x = SLIDE_X0 + ((green_max* SLIDER_WIDTH) / 15);
    wire [9:0] knob_b_min_x = SLIDE_X0 + ((blue_min * SLIDER_WIDTH) / 15);
    wire [9:0] knob_b_max_x = SLIDE_X0 + ((blue_max * SLIDER_WIDTH) / 15);
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

    // initialize on reset
    always @(posedge clk25) begin
        if (vga_reset) begin
            red_min   <= 4'd0;
            red_max   <= 4'd15;
            green_min <= 4'd0;
            green_max <= 4'd15;
            blue_min  <= 4'd0;
            blue_max  <= 4'd15;
            dragging_r_min <= 1'b0; dragging_r_max <= 1'b0;
            dragging_g_min <= 1'b0; dragging_g_max <= 1'b0;
            dragging_b_min <= 1'b0; dragging_b_max <= 1'b0;
            // mirror into outputs
            start_red_val  <= 4'd0; end_red_val  <= 4'd15;
            start_green_val<= 4'd0; end_green_val<= 4'd15;
            start_blue_val <= 4'd0; end_blue_val <= 4'd15;
        end else if (enable) begin
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
            end else begin 
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
                    red_min <= 4'd0;
                end
                else if (mouse_x_px > SLIDE_X1) begin 
                    red_min <= red_max;
                end
                else begin
                    // temporary calc to perform multiply and divide
                    tmp_calc = ((mouse_x_px - SLIDE_X0) * 15) / SLIDER_WIDTH;
                    if (tmp_calc[3:0] > red_max)
                        red_min <= red_max;
                    else
                        red_min <= tmp_calc[3:0];
                end
                // ensure min <= max
                // if (red_min > red_max) red_min <= red_max;
            end else if (dragging_r_max) begin
                if (mouse_x_px < SLIDE_X0) begin 
                    red_max <= red_min;
                end
                else if (mouse_x_px > SLIDE_X1) begin 
                    red_max <= 4'd15;
                end
                else begin
                    tmp_calc = ((mouse_x_px - SLIDE_X0) * 15) / SLIDER_WIDTH;
                    if (tmp_calc[3:0] < red_min)
                        red_max <= red_min;
                    else
                        red_max <= tmp_calc[3:0];
                end
                // if (red_max < red_min) red_max <= red_min;
            end else if (dragging_g_min) begin
                if (mouse_x_px < SLIDE_X0) begin
                    green_min <= 4'd0;
                end
                else if (mouse_x_px > SLIDE_X1) begin 
                    green_min <= green_max;
                end
                else begin
                    tmp_calc = ((mouse_x_px - SLIDE_X0) * 15) / SLIDER_WIDTH;
                    if (tmp_calc[3:0] > green_max)
                        green_min <= green_max;
                    else
                        green_min <= tmp_calc[3:0];
                end
            end else if (dragging_g_max) begin
                if (mouse_x_px < SLIDE_X0) begin 
                    green_max <= green_min;
                end else if (mouse_x_px > SLIDE_X1) begin
                    green_max <= 4'd15;
                end
                else begin
                    tmp_calc = ((mouse_x_px - SLIDE_X0) * 15) / SLIDER_WIDTH;
                    if (tmp_calc[3:0] < green_min)
                        green_max <= green_min;
                    else
                        green_max <= tmp_calc[3:0];
                end
            end else if (dragging_b_min) begin
                if (mouse_x_px < SLIDE_X0) begin
                    blue_min <= 4'd0;
                end else if (mouse_x_px > SLIDE_X1) begin 
                    blue_min <= blue_max;
                end
                else begin
                    tmp_calc = ((mouse_x_px - SLIDE_X0) * 15) / SLIDER_WIDTH;
                    if (tmp_calc[3:0] > blue_max)
                        blue_min <= blue_max;
                    else
                        blue_min <= tmp_calc[3:0];
                end
            end else if (dragging_b_max) begin
                // mouse_x_px is in pixel coords — convert to 0..15 slider value
                if (mouse_x_px < SLIDE_X0) begin
                    blue_max <= 4'd0;
                end else if (mouse_x_px > SLIDE_X1) begin
                    blue_max <= 4'd15;
                end else begin
                    tmp_calc = ((mouse_x_px - SLIDE_X0) * 15) / SLIDER_WIDTH;
                    // clamp to ensure blue_max >= blue_min
                    if (tmp_calc[3:0] < blue_min)
                        blue_max <= blue_min;
                    else
                        blue_max <= tmp_calc[3:0];
                end
            end

            // always mirror internal ranges to the outputs so Top.v or backend can read
            start_red_val  <= red_min;  
            end_red_val  <= red_max;
            start_green_val<= green_min;
            end_green_val<= green_max;
            start_blue_val <= blue_min; 
            end_blue_val <= blue_max;
        end
    end

    // Eyedropper toggle and sampling: toggle with click inside small square; when enabled,
    // sample the provided BRAM pixel on any left_click_edge (except when toggling the square)
    always @(posedge clk25) begin
        if (vga_reset) begin
            eyedropper_enabled <= 1'b0;
            picked_color <= 12'h000;
        end else begin
            if (left_click_edge) begin
                // If click landed in the toggle square, flip enable
                if ((mouse_x_px >= EYE_TOG_X) && (mouse_x_px < (EYE_TOG_X + EYE_TOG_W)) &&
                    (mouse_y_px >= EYE_TOG_Y) && (mouse_y_px < (EYE_TOG_Y + EYE_TOG_H))) begin
                    eyedropper_enabled <= ~eyedropper_enabled;
                end else begin
                    // capture color of bram pixel at mouse location if eyedropper enabled
                    if (eyedropper_enabled) begin
                        picked_color <= mouse_color_bram;
                    end
                end
            end
        end
    end

    // Display hover color design
    reg [11:0] pixel_out;
    reg        pixel_active;

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
        end else if (is_on_knob(px_src, py_src, knob_r_max_x_disp, SLIDER0_Y)) begin
            pixel_active = 1'b1;
            pixel_out = dragging_r_max ? 12'hFB0 : CLR_WHITE;
        end else if (is_on_knob(px_src, py_src, knob_g_min_x_disp, SLIDER1_Y)) begin
            pixel_active = 1'b1;
            pixel_out = dragging_g_min ? 12'hFB0 : CLR_WHITE;
        end else if (is_on_knob(px_src, py_src, knob_g_max_x_disp, SLIDER1_Y)) begin
            pixel_active = 1'b1;
            pixel_out = dragging_g_max ? 12'hFB0 : CLR_WHITE;
        end else if (is_on_knob(px_src, py_src, knob_b_min_x_disp, SLIDER2_Y)) begin
            pixel_active = 1'b1;
            pixel_out = dragging_b_min ? 12'hFB0 : CLR_WHITE;
        end else if (is_on_knob(px_src, py_src, knob_b_max_x_disp, SLIDER2_Y)) begin
            pixel_active = 1'b1;
            pixel_out = dragging_b_max ? 12'hFB0 : CLR_WHITE;
        end

        // display color boxes
        // Left Box
        if ((px_src > BOX_START_LEFT_X) && (px_src < (BOX_START_LEFT_X + BOX_WIDTH_HEIGHT)) && 
        (py_src >= BOX_START_LEFT_Y) && (py_src < (BOX_START_LEFT_Y + BOX_WIDTH_HEIGHT))) begin
            // red box
            pixel_active = 1'b1;
            pixel_out = {blue_min, green_min, red_min}; // upper threshold
        end
        // right box
        else if ((px_src >= (BOX_START_LEFT_X + BOX_WIDTH_HEIGHT + 5)) && (px_src < (BOX_START_LEFT_X + 2 *  BOX_WIDTH_HEIGHT + 5)) && (py_src >= BOX_START_LEFT_Y) && (py_src < (BOX_START_LEFT_Y + BOX_WIDTH_HEIGHT))) begin
            pixel_active = 1'b1;
            pixel_out = {blue_max, green_max, red_max}; // lower threshold
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
    end      

    assign section_pixel = pixel_out;
    assign section_active = pixel_active;

endmodule