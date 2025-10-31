`timescale 1ns / 1ps

// Display Settings UI (mouse sensitivity + crosshair color)
// - Self-contained page shown when 'active' is 1
// - Handles mouse interactions: slider drag and color box selection
// - Draws a simple panel, slider, knob, and 7 color boxes as an overlay
// - Exposes chosen mouse_sensitivity (0..255) and crosshair_color_sel (0..6)
// - All coordinates are in VGA (640x480): px (x:0..639), py (y:0..479)

module user_settings_ui (
    input  wire        clk,            // clk25 domain
    input  wire        reset,          // sync reset (vga_reset)
    input  wire        active,         // show UI when 1

    // Per-pixel coords for overlay drawing (VGA 0..639/0..479)
    input  wire [9:0]  px,
    input  wire [9:0]  py,

    // Mouse (VGA, synchronized) and buttons
    input  wire [9:0]  mouse_x,
    input  wire [8:0]  mouse_y,
    input  wire        left,
    input  wire        left_edge,

    // Outputs
    output reg         overlay_en,
    output reg [11:0]  overlay_rgb,
    output reg [7:0]   mouse_sensitivity,
    output reg [2:0]   crosshair_color_sel
);

    // Panel placement (scaled to VGA)
    localparam integer PANEL_X      = 100;
    localparam integer PANEL_Y      = 100;
    localparam integer PANEL_W      = 320;
    localparam integer PANEL_H      = 240;

    // Slider geometry
    localparam integer SLIDER_X_START = (120) + 20;              // 60*2 + 20
    localparam integer SLIDER_X_END   = (120) + (280) - 20;      // 60*2 + 140*2 - 20
    localparam integer SLIDER_Y_POS   = 210;                     // 105*2
    localparam integer SLIDER_HEIGHT  = 12;
    localparam integer KNOB_SIZE      = 16;

    // Color boxes strip
    localparam integer COLOR_BOX_X        = 120;                 // 60*2
    localparam integer COLOR_BOX_Y        = 260;                 // 130*2
    localparam integer COLOR_BOX_WIDTH    = 280;                 // 140*2
    localparam integer COLOR_BOX_HEIGHT   = 70;                  // 35*2
    localparam integer COLOR_BOX_SIZE     = 24;                  // 12*2
    localparam integer COLOR_BOX_SPACING  = 30;                  // 15*2
    localparam integer COLOR_BOX_START_X  = COLOR_BOX_X + 40;    // +20*2
    localparam integer COLOR_MINOR_BOX_Y  = COLOR_BOX_Y + 20;    // +10*2

    // Colors (RGB444)
    localparam [11:0] WHITE   = 12'hFFF;
    localparam [11:0] BLACK   = 12'h000;
    localparam [11:0] GREY    = 12'h888;
    localparam [11:0] YELLOW  = 12'h0FF;
    localparam [11:0] GREEN   = 12'h0F0;
    localparam [11:0] RED     = 12'h00F;
    localparam [11:0] BLUE    = 12'hF00;
    localparam [11:0] CYAN    = 12'hFF0;
    localparam [11:0] MAGENTA = 12'hF0F;

    // State
    reg dragging;

    // Derived
    wire [9:0] knob_x = SLIDER_X_START + ((mouse_sensitivity * (SLIDER_X_END - SLIDER_X_START)) >> 8);

    // Mouse hit tests
    wire on_slider = (mouse_x >= SLIDER_X_START && mouse_x <= SLIDER_X_END &&
                      mouse_y >= (SLIDER_Y_POS - 3) && mouse_y <= (SLIDER_Y_POS + SLIDER_HEIGHT + 3));
    wire on_knob   = (mouse_x >= knob_x - (KNOB_SIZE>>1) && mouse_x <= knob_x + (KNOB_SIZE>>1) &&
                      mouse_y >= (SLIDER_Y_POS - 2) && mouse_y <= (SLIDER_Y_POS + SLIDER_HEIGHT + 2));

    // Color box X positions
    wire [9:0] c0x = COLOR_BOX_START_X + (0 * COLOR_BOX_SPACING);
    wire [9:0] c1x = COLOR_BOX_START_X + (1 * COLOR_BOX_SPACING);
    wire [9:0] c2x = COLOR_BOX_START_X + (2 * COLOR_BOX_SPACING);
    wire [9:0] c3x = COLOR_BOX_START_X + (3 * COLOR_BOX_SPACING);
    wire [9:0] c4x = COLOR_BOX_START_X + (4 * COLOR_BOX_SPACING);
    wire [9:0] c5x = COLOR_BOX_START_X + (5 * COLOR_BOX_SPACING);
    wire [9:0] c6x = COLOR_BOX_START_X + (6 * COLOR_BOX_SPACING);

    // Hover flags (mouse)
    wire hov0 = (mouse_x >= c0x && mouse_x <= c0x + COLOR_BOX_SIZE && mouse_y >= COLOR_MINOR_BOX_Y && mouse_y <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE);
    wire hov1 = (mouse_x >= c1x && mouse_x <= c1x + COLOR_BOX_SIZE && mouse_y >= COLOR_MINOR_BOX_Y && mouse_y <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE);
    wire hov2 = (mouse_x >= c2x && mouse_x <= c2x + COLOR_BOX_SIZE && mouse_y >= COLOR_MINOR_BOX_Y && mouse_y <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE);
    wire hov3 = (mouse_x >= c3x && mouse_x <= c3x + COLOR_BOX_SIZE && mouse_y >= COLOR_MINOR_BOX_Y && mouse_y <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE);
    wire hov4 = (mouse_x >= c4x && mouse_x <= c4x + COLOR_BOX_SIZE && mouse_y >= COLOR_MINOR_BOX_Y && mouse_y <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE);
    wire hov5 = (mouse_x >= c5x && mouse_x <= c5x + COLOR_BOX_SIZE && mouse_y >= COLOR_MINOR_BOX_Y && mouse_y <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE);
    wire hov6 = (mouse_x >= c6x && mouse_x <= c6x + COLOR_BOX_SIZE && mouse_y >= COLOR_MINOR_BOX_Y && mouse_y <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE);

    // Interactions
    always @(posedge clk) begin
        if (reset) begin
            dragging <= 1'b0;
            mouse_sensitivity <= 8'd128;
            crosshair_color_sel <= 3'd0; // default White
        end else if (active) begin
            // Slider drag
            if (!dragging && left && on_slider) begin
                dragging <= 1'b1;
            end
            if (dragging) begin
                if (!left) begin
                    dragging <= 1'b0;
                end else begin
                    if (mouse_x <= SLIDER_X_START) mouse_sensitivity <= 8'd0;
                    else if (mouse_x >= SLIDER_X_END) mouse_sensitivity <= 8'd255;
                    else mouse_sensitivity <= ((mouse_x - SLIDER_X_START) * 8'd256) / (SLIDER_X_END - SLIDER_X_START);
                end
            end

            // Color selection (on click edge)
            if (left_edge) begin
                if (hov0) crosshair_color_sel <= 3'd0;
                else if (hov1) crosshair_color_sel <= 3'd1;
                else if (hov2) crosshair_color_sel <= 3'd2;
                else if (hov3) crosshair_color_sel <= 3'd3;
                else if (hov4) crosshair_color_sel <= 3'd4;
                else if (hov5) crosshair_color_sel <= 3'd5;
                else if (hov6) crosshair_color_sel <= 3'd6;
            end
        end
    end

    // Drawing helpers
    wire in_panel_fill   = (px >= PANEL_X+1) && (px < (PANEL_X + PANEL_W - 1)) && (py >= PANEL_Y+1) && (py < (PANEL_Y + PANEL_H - 1));
    wire in_panel_border = ((py == PANEL_Y) || (py == (PANEL_Y + PANEL_H - 1))) ? ((px >= PANEL_X) && (px < (PANEL_X + PANEL_W))) :
                           ((px == PANEL_X) || (px == (PANEL_X + PANEL_W - 1))) ? ((py >= PANEL_Y) && (py < (PANEL_Y + PANEL_H))) : 1'b0;

    // Slider drawing
    wire in_slider_track = (px >= SLIDER_X_START && px <= SLIDER_X_END && py >= SLIDER_Y_POS && py < (SLIDER_Y_POS + SLIDER_HEIGHT));
    wire in_slider_knob  = (px >= (knob_x - (KNOB_SIZE>>1)) && px <= (knob_x + (KNOB_SIZE>>1)) &&
                            py >= (SLIDER_Y_POS - 2) && py <= (SLIDER_Y_POS + SLIDER_HEIGHT + 2));

    // Color box content and border (for each of 7 boxes)
    wire c0_fill = (px >= c0x + 1 && px <= c0x + COLOR_BOX_SIZE - 1 && py >= COLOR_MINOR_BOX_Y + 1 && py <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE - 1);
    wire c1_fill = (px >= c1x + 1 && px <= c1x + COLOR_BOX_SIZE - 1 && py >= COLOR_MINOR_BOX_Y + 1 && py <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE - 1);
    wire c2_fill = (px >= c2x + 1 && px <= c2x + COLOR_BOX_SIZE - 1 && py >= COLOR_MINOR_BOX_Y + 1 && py <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE - 1);
    wire c3_fill = (px >= c3x + 1 && px <= c3x + COLOR_BOX_SIZE - 1 && py >= COLOR_MINOR_BOX_Y + 1 && py <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE - 1);
    wire c4_fill = (px >= c4x + 1 && px <= c4x + COLOR_BOX_SIZE - 1 && py >= COLOR_MINOR_BOX_Y + 1 && py <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE - 1);
    wire c5_fill = (px >= c5x + 1 && px <= c5x + COLOR_BOX_SIZE - 1 && py >= COLOR_MINOR_BOX_Y + 1 && py <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE - 1);
    wire c6_fill = (px >= c6x + 1 && px <= c6x + COLOR_BOX_SIZE - 1 && py >= COLOR_MINOR_BOX_Y + 1 && py <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE - 1);

    wire c0_brd = ((px == c0x || px == c0x + COLOR_BOX_SIZE) && (py >= COLOR_MINOR_BOX_Y && py <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE)) ||
                  ((py == COLOR_MINOR_BOX_Y || py == COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE) && (px >= c0x && px <= c0x + COLOR_BOX_SIZE));
    wire c1_brd = ((px == c1x || px == c1x + COLOR_BOX_SIZE) && (py >= COLOR_MINOR_BOX_Y && py <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE)) ||
                  ((py == COLOR_MINOR_BOX_Y || py == COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE) && (px >= c1x && px <= c1x + COLOR_BOX_SIZE));
    wire c2_brd = ((px == c2x || px == c2x + COLOR_BOX_SIZE) && (py >= COLOR_MINOR_BOX_Y && py <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE)) ||
                  ((py == COLOR_MINOR_BOX_Y || py == COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE) && (px >= c2x && px <= c2x + COLOR_BOX_SIZE));
    wire c3_brd = ((px == c3x || px == c3x + COLOR_BOX_SIZE) && (py >= COLOR_MINOR_BOX_Y && py <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE)) ||
                  ((py == COLOR_MINOR_BOX_Y || py == COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE) && (px >= c3x && px <= c3x + COLOR_BOX_SIZE));
    wire c4_brd = ((px == c4x || px == c4x + COLOR_BOX_SIZE) && (py >= COLOR_MINOR_BOX_Y && py <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE)) ||
                  ((py == COLOR_MINOR_BOX_Y || py == COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE) && (px >= c4x && px <= c4x + COLOR_BOX_SIZE));
    wire c5_brd = ((px == c5x || px == c5x + COLOR_BOX_SIZE) && (py >= COLOR_MINOR_BOX_Y && py <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE)) ||
                  ((py == COLOR_MINOR_BOX_Y || py == COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE) && (px >= c5x && px <= c5x + COLOR_BOX_SIZE));
    wire c6_brd = ((px == c6x || px == c6x + COLOR_BOX_SIZE) && (py >= COLOR_MINOR_BOX_Y && py <= COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE)) ||
                  ((py == COLOR_MINOR_BOX_Y || py == COLOR_MINOR_BOX_Y + COLOR_BOX_SIZE) && (px >= c6x && px <= c6x + COLOR_BOX_SIZE));

    // Color selection for fills
    wire [11:0] col0 = WHITE;
    wire [11:0] col1 = RED;
    wire [11:0] col2 = GREEN;
    wire [11:0] col3 = BLUE;
    wire [11:0] col4 = YELLOW;
    wire [11:0] col5 = CYAN;
    wire [11:0] col6 = MAGENTA;

    // Border color based on active/hover
    wire [11:0] brd0 = (crosshair_color_sel == 3'd0) ? WHITE : (hov0 ? YELLOW : GREY);
    wire [11:0] brd1 = (crosshair_color_sel == 3'd1) ? WHITE : (hov1 ? YELLOW : GREY);
    wire [11:0] brd2 = (crosshair_color_sel == 3'd2) ? WHITE : (hov2 ? YELLOW : GREY);
    wire [11:0] brd3 = (crosshair_color_sel == 3'd3) ? WHITE : (hov3 ? YELLOW : GREY);
    wire [11:0] brd4 = (crosshair_color_sel == 3'd4) ? WHITE : (hov4 ? YELLOW : GREY);
    wire [11:0] brd5 = (crosshair_color_sel == 3'd5) ? WHITE : (hov5 ? YELLOW : GREY);
    wire [11:0] brd6 = (crosshair_color_sel == 3'd6) ? WHITE : (hov6 ? YELLOW : GREY);

    // Final overlay mux
    always @(*) begin
        overlay_en  = 1'b0;
        overlay_rgb = 12'h000;
        if (active) begin
            // Panel back and border
            if (in_panel_fill)   begin overlay_en = 1'b1; overlay_rgb = WHITE; end
            else if (in_panel_border) begin overlay_en = 1'b1; overlay_rgb = BLACK; end

            // Slider track/knob
            if (in_slider_track) begin overlay_en = 1'b1; overlay_rgb = GREEN; end
            if (in_slider_knob)  begin overlay_en = 1'b1; overlay_rgb = (dragging ? GREY : (on_knob ? YELLOW : BLACK)); end

            // Color boxes (border first, then fill overrides)
            if (c0_brd) begin overlay_en = 1'b1; overlay_rgb = brd0; end
            else if (c1_brd) begin overlay_en = 1'b1; overlay_rgb = brd1; end
            else if (c2_brd) begin overlay_en = 1'b1; overlay_rgb = brd2; end
            else if (c3_brd) begin overlay_en = 1'b1; overlay_rgb = brd3; end
            else if (c4_brd) begin overlay_en = 1'b1; overlay_rgb = brd4; end
            else if (c5_brd) begin overlay_en = 1'b1; overlay_rgb = brd5; end
            else if (c6_brd) begin overlay_en = 1'b1; overlay_rgb = brd6; end

            if (c0_fill) begin overlay_en = 1'b1; overlay_rgb = col0; end
            else if (c1_fill) begin overlay_en = 1'b1; overlay_rgb = col1; end
            else if (c2_fill) begin overlay_en = 1'b1; overlay_rgb = col2; end
            else if (c3_fill) begin overlay_en = 1'b1; overlay_rgb = col3; end
            else if (c4_fill) begin overlay_en = 1'b1; overlay_rgb = col4; end
            else if (c5_fill) begin overlay_en = 1'b1; overlay_rgb = col5; end
            else if (c6_fill) begin overlay_en = 1'b1; overlay_rgb = col6; end
        end
    end

endmodule
