`timescale 1ns/1ps

// UFDS Settings Overlay
// - Draws 5 segment tabs and a return button and next state button with fixed coordinates
// - Panel 4: min-area slider (4,16,32,64) and sort mode buttons (area/proximity)
// - Panel 5: max boxes buttons (1,2,3,4)
// - Maintains internal tab selection; exposes settings as stable outputs
// - Designed to mirror cv_settings overlay style (no loops/functions; simple FSM latching on clicks)
module ufds_settings_overlay (
    input wire clk,
    input wire reset,
    input wire settings_active,
    input wire [9:0] px,
    input wire [8:0] py,
    input wire [9:0] mouse_x,
    input wire [8:0] mouse_y,
    input wire left_edge,

    output reg  overlay_en,
    output reg [11:0] overlay_rgb,

    output reg return_click,

    // Settings
    output reg [2:0] tab_idx,          // 1..5
    output reg [1:0] min_area_sel,     // 00=4, 01=16, 10=32, 11=64
    output reg         sort_by_prox,     // 0=area, 1=proximity
    output reg [1:0] max_boxes_sel       // 00=1, 01=2, 10=3, 11=4
);

    // Colors
    localparam [11:0] BLACK   = 12'h000; // 0
    localparam [11:0] WHITE   = 12'hFFF; // 1
    localparam [11:0] RED     = 12'hF00; // 2
    localparam [11:0] GREEN   = 12'h1C1; // 3
    localparam [11:0] GREY    = 12'h888; 
    localparam [11:0] CYAN    = 12'hFF0; // 5
    localparam [11:0] MAGENTA = 12'hF0F; // 6
    localparam [11:0] YELLOW  = 12'h0FF; // 7
    localparam [11:0] DARKBLUE = 12'hB75; // 8
    localparam [11:0] BLUE    = 12'hECA; // 9
    localparam [11:0] LIGHTBLUE = 12'hEDB; // 10
    localparam [11:0] OFFWHITE  = 12'hBEE; // 11
    localparam [11:0] BORDERBLUE = 12'hC70; // 12
    localparam [11:0] BRIGHTBLUE = 12'hFB0; // 13
    localparam [11:0] BUMBLEBEE   = 12'hFC0; // 14

    // Boxes geometry (inclusive ranges)
    // Box 1: Return (30..62, 324..430)
    // Box 2: Sample+Find (65..218, 324..430)
    // Box 3: Union (221..321, 324..430)
    // Box 4: Build Components and states (324..413, 324..430)
    // Box 5: Filter (416..505, 324..430)
    // Box 6: Draw BB (505..594, 324..430)
    // Box 7: Next setting (594..630, 324..430)

    wire in_box1 = (px >= 10'd30  && px <= 10'd62  && py >= 9'd324 && py <= 9'd430);
    wire in_box2 = (px >= 10'd65  && px <= 10'd218 && py >= 9'd324 && py <= 9'd430);
    wire in_box3 = (px >= 10'd221 && px <= 10'd321 && py >= 9'd324 && py <= 9'd430);
    wire in_box4 = (px >= 10'd324 && px <= 10'd413 && py >= 9'd324 && py <= 9'd430);
    wire in_box5 = (px >= 10'd416 && px <= 10'd505 && py >= 9'd324 && py <= 9'd430);
    wire in_box6 = (px >= 10'd505 && px <= 10'd594 && py >= 9'd324 && py <= 9'd430);
    wire in_box7 = (px >= 10'd594 && px <= 10'd630 && py >= 9'd324 && py <= 9'd430);

    wire mouse_in_box1 = (mouse_x >= 10'd30  && mouse_x <= 10'd62  && mouse_y >= 9'd324 && mouse_y <= 9'd430);
    wire mouse_in_box2 = (mouse_x >= 10'd65  && mouse_x <= 10'd218 && mouse_y >= 9'd324 && mouse_y <= 9'd430);
    wire mouse_in_box3 = (mouse_x >= 10'd221 && mouse_x <= 10'd321 && mouse_y >= 9'd324 && mouse_y <= 9'd430);
    wire mouse_in_box4 = (mouse_x >= 10'd324 && mouse_x <= 10'd413 && mouse_y >= 9'd324 && mouse_y <= 9'd430);
    wire mouse_in_box5 = (mouse_x >= 10'd416 && mouse_x <= 10'd505 && mouse_y >= 9'd324 && mouse_y <= 9'd430);
    wire mouse_in_box6 = (mouse_x >= 10'd505 && mouse_x <= 10'd594 && mouse_y >= 9'd324 && mouse_y <= 9'd430);
    wire mouse_in_box7 = (mouse_x >= 10'd594 && mouse_x <= 10'd630 && mouse_y >= 9'd322 && mouse_y <= 9'd428);

    // Panel 4 controls geometry (Filter) under the tab row: place within y 440..470
    // Constrain slider and buttons to be inside the width of panel 4 (x 416..505)
    // Slider track: x 430..496, y 446..450; 4 ticks placed within that span
    // Stack buttons vertically: Area button above Proximity button
    wire in_slider_track = (px >= 10'd430 && px <= 10'd496 && py >= 9'd446 && py <= 9'd450);
    wire [9:0] tick_x0 = 10'd436; // 4
    wire [9:0] tick_x1 = 10'd452; // 16
    wire [9:0] tick_x2 = 10'd468; // 32
    wire [9:0] tick_x3 = 10'd484; // 64
    wire in_tick0 = (px == tick_x0) && in_slider_track;
    wire in_tick1 = (px == tick_x1) && in_slider_track;
    wire in_tick2 = (px == tick_x2) && in_slider_track;
    wire in_tick3 = (px == tick_x3) && in_slider_track;

    // Stack buttons vertically within panel width
    wire in_btn_area = (px >= 10'd430 && px <= 10'd480 && py >= 9'd446 && py <= 9'd456);
    wire in_btn_prox = (px >= 10'd430 && px <= 10'd480 && py >= 9'd458 && py <= 9'd468);
    wire mouse_in_btn_area = (mouse_x >= 10'd430 && mouse_x <= 10'd480 && mouse_y >= 9'd446 && mouse_y <= 9'd456);
    wire mouse_in_btn_prox = (mouse_x >= 10'd430 && mouse_x <= 10'd480 && mouse_y >= 9'd458 && mouse_y <= 9'd468);

    // Panel 5 controls geometry (Draw BB): x 510..610, y 446..470 (four small buttons)
    wire in_btn_1 = (px >= 10'd510 && px <= 10'd530 && py >= 9'd446 && py <= 9'd470);
    wire in_btn_2 = (px >= 10'd535 && px <= 10'd555 && py >= 9'd446 && py <= 9'd470);
    wire in_btn_3 = (px >= 10'd560 && px <= 10'd580 && py >= 9'd446 && py <= 9'd470);
    wire in_btn_4 = (px >= 10'd585 && px <= 10'd605 && py >= 9'd446 && py <= 9'd470);
    wire mouse_in_btn_1 = (mouse_x >= 10'd510 && mouse_x <= 10'd530 && mouse_y >= 9'd446 && mouse_y <= 9'd470);
    wire mouse_in_btn_2 = (mouse_x >= 10'd535 && mouse_x <= 10'd555 && mouse_y >= 9'd446 && mouse_y <= 9'd470);
    wire mouse_in_btn_3 = (mouse_x >= 10'd560 && mouse_x <= 10'd580 && mouse_y >= 9'd446 && mouse_y <= 9'd470);
    wire mouse_in_btn_4 = (mouse_x >= 10'd585 && mouse_x <= 10'd605 && mouse_y >= 9'd446 && mouse_y <= 9'd470);

    // Latch clicks for tabs and settings
    always @(posedge clk) begin
        if (reset) begin
            tab_idx       <= 3'd1;
            min_area_sel  <= 2'b00; // 4
            sort_by_prox  <= 1'b0;  // area
            max_boxes_sel <= 2'b11; // 4
            return_click  <= 1'b0;
        end else begin
            return_click <= 1'b0; // default pulse low
            if (settings_active && left_edge) begin
                if (mouse_in_box1) begin
                    return_click <= 1'b1;
                end else if (mouse_in_box2) begin
                    tab_idx <= 3'd1;
                end else if (mouse_in_box3) begin
                    tab_idx <= 3'd2;
                end else if (mouse_in_box4) begin
                    tab_idx <= 3'd3; // Build Components and states
                end else if (mouse_in_box5) begin
                    tab_idx <= 3'd4; // Filter
                end else if (mouse_in_box6) begin
                    tab_idx <= 3'd5; // Draw BB
                end

                // Panel 4 interactions (Filter) only when tab 4
                // if (tab_idx == 3'd4) begin
                    // Click near ticks selects min area discrete levels
                    if (mouse_x >= tick_x0-2 && mouse_x <= tick_x0+2 && mouse_y >= 9'd444 && mouse_y <= 9'd452) begin
                        min_area_sel <= 2'b00; // 4
                    end else if (mouse_x >= tick_x1-2 && mouse_x <= tick_x1+2 && mouse_y >= 9'd444 && mouse_y <= 9'd452) begin
                        min_area_sel <= 2'b01; // 16
                    end else if (mouse_x >= tick_x2-2 && mouse_x <= tick_x2+2 && mouse_y >= 9'd444 && mouse_y <= 9'd452) begin
                        min_area_sel <= 2'b10; // 32
                    end else if (mouse_x >= tick_x3-2 && mouse_x <= tick_x3+2 && mouse_y >= 9'd444 && mouse_y <= 9'd452) begin
                        min_area_sel <= 2'b11; // 64
                    // end
                    // Sort mode buttons
                    if (mouse_in_btn_area) sort_by_prox <= 1'b0;
                    if (mouse_in_btn_prox) sort_by_prox <= 1'b1;
                end

                // Panel 5 interactions (Draw BB) only when tab 5
                // if (tab_idx == 3'd5) begin
                    if (mouse_in_btn_1) max_boxes_sel <= 2'b00;
                    else if (mouse_in_btn_2) max_boxes_sel <= 2'b01;
                    else if (mouse_in_btn_3) max_boxes_sel <= 2'b10;
                    else if (mouse_in_btn_4) max_boxes_sel <= 2'b11;
                // end
            end
        end
    end

    // Precomputed border wires
    // Thickness 4 for tab boxes, 2 for small buttons
    wire border_box1 = ((px >= 10'd30 && px <= 10'd62 && (py >= 9'd324 && py < 9'd324 + 9'd4)) ||
                        (px >= 10'd30 && px <= 10'd62 && (py <= 9'd428 && py > 9'd428 - 9'd4)) ||
                        (py >= 9'd324 && py <= 9'd428 && (px >= 10'd30 && px < 10'd30 + 10'd4)) ||
                        (py >= 9'd324 && py <= 9'd428 && (px <= 10'd62 && px > 10'd62 - 10'd4)));
    wire border_box2 = ((px >= 10'd65 && px <= 10'd218 && (py >= 9'd324 && py < 9'd324 + 9'd4)) ||
                        (px >= 10'd65 && px <= 10'd218 && (py <= 9'd430 && py > 9'd430 - 9'd4)) ||
                        (py >= 9'd324 && py <= 9'd430 && (px >= 10'd65 && px < 10'd65 + 10'd4)) ||
                        (py >= 9'd324 && py <= 9'd430 && (px <= 10'd218 && px > 10'd218 - 10'd4)));
    wire border_box3 = ((px >= 10'd221 && px <= 10'd321 && (py >= 9'd324 && py < 9'd324 + 9'd4)) ||
                        (px >= 10'd221 && px <= 10'd321 && (py <= 9'd430 && py > 9'd430 - 9'd4)) ||
                        (py >= 9'd324 && py <= 9'd430 && (px >= 10'd221 && px < 10'd221 + 10'd4)) ||
                        (py >= 9'd324 && py <= 9'd430 && (px <= 10'd321 && px > 10'd321 - 10'd4)));
    wire border_box4 = ((px >= 10'd324 && px <= 10'd413 && (py >= 9'd324 && py < 9'd324 + 9'd4)) ||
                        (px >= 10'd324 && px <= 10'd413 && (py <= 9'd430 && py > 9'd430 - 9'd4)) ||
                        (py >= 9'd324 && py <= 9'd430 && (px >= 10'd324 && px < 10'd324 + 10'd4)) ||
                        (py >= 9'd324 && py <= 9'd430 && (px <= 10'd413 && px > 10'd413 - 10'd4)));
    wire border_box5 = ((px >= 10'd416 && px <= 10'd505 && (py >= 9'd324 && py < 9'd324 + 9'd4)) ||
                        (px >= 10'd416 && px <= 10'd505 && (py <= 9'd430 && py > 9'd430 - 9'd4)) ||
                        (py >= 9'd324 && py <= 9'd430 && (px >= 10'd416 && px < 10'd416 + 10'd4)) ||
                        (py >= 9'd324 && py <= 9'd430 && (px <= 10'd505 && px > 10'd505 - 10'd4)));
    wire border_box6 = ((px >= 10'd505 && px <= 10'd594 && (py >= 9'd324 && py < 9'd324 + 9'd4)) ||
                        (px >= 10'd505 && px <= 10'd594 && (py <= 9'd430 && py > 9'd430 - 9'd4)) ||
                        (py >= 9'd324 && py <= 9'd430 && (px >= 10'd505 && px < 10'd505 + 10'd4)) ||
                        (py >= 9'd324 && py <= 9'd430 && (px <= 10'd594 && px > 10'd594 - 10'd4)));
    wire border_box7 = ((px >= 10'd594 && px <= 10'd630 && (py >= 9'd324 && py < 9'd324 + 9'd4)) ||
                        (px >= 10'd594 && px <= 10'd630 && (py <= 9'd428 && py > 9'd428 - 9'd4)) ||
                        (py >= 9'd324 && py <= 9'd428 && (px >= 10'd594 && px < 10'd594 + 10'd4)) ||
                        (py >= 9'd324 && py <= 9'd428 && (px <= 10'd630 && px > 10'd630 - 10'd4)));

    // Panel 4 button borders (Area/Proximity), thickness 2
    // Border wires for stacked buttons
    wire border_btn_area = ((px >= 10'd430 && px <= 10'd480 && (py >= 9'd446 && py < 9'd446 + 9'd2)) ||
                            (px >= 10'd430 && px <= 10'd480 && (py <= 9'd456 && py > 9'd456 - 9'd2)) ||
                            (py >= 9'd446 && py <= 9'd456 && (px >= 10'd430 && px < 10'd430 + 10'd2)) ||
                            (py >= 9'd446 && py <= 9'd456 && (px <= 10'd480 && px > 10'd480 - 10'd2)));
    wire border_btn_prox = ((px >= 10'd430 && px <= 10'd480 && (py >= 9'd458 && py < 9'd458 + 9'd2)) ||
                            (px >= 10'd430 && px <= 10'd480 && (py <= 9'd468 && py > 9'd468 - 9'd2)) ||
                            (py >= 9'd458 && py <= 9'd468 && (px >= 10'd430 && px < 10'd430 + 10'd2)) ||
                            (py >= 9'd458 && py <= 9'd468 && (px <= 10'd480 && px > 10'd480 - 10'd2)));

    // Panel 5 max-box button borders, thickness 2
    wire border_btn_1 = ((px >= 10'd510 && px <= 10'd530 && (py >= 9'd446 && py < 9'd446 + 9'd2)) ||
                         (px >= 10'd510 && px <= 10'd530 && (py <= 9'd470 && py > 9'd470 - 9'd2)) ||
                         (py >= 9'd446 && py <= 9'd470 && (px >= 10'd510 && px < 10'd510 + 10'd2)) ||
                         (py >= 9'd446 && py <= 9'd470 && (px <= 10'd530 && px > 10'd530 - 10'd2)));
    wire border_btn_2 = ((px >= 10'd535 && px <= 10'd555 && (py >= 9'd446 && py < 9'd446 + 9'd2)) ||
                         (px >= 10'd535 && px <= 10'd555 && (py <= 9'd470 && py > 9'd470 - 9'd2)) ||
                         (py >= 9'd446 && py <= 9'd470 && (px >= 10'd535 && px < 10'd535 + 10'd2)) ||
                         (py >= 9'd446 && py <= 9'd470 && (px <= 10'd555 && px > 10'd555 - 10'd2)));
    wire border_btn_3 = ((px >= 10'd560 && px <= 10'd580 && (py >= 9'd446 && py < 9'd446 + 9'd2)) ||
                         (px >= 10'd560 && px <= 10'd580 && (py <= 9'd470 && py > 9'd470 - 9'd2)) ||
                         (py >= 9'd446 && py <= 9'd470 && (px >= 10'd560 && px < 10'd560 + 10'd2)) ||
                         (py >= 9'd446 && py <= 9'd470 && (px <= 10'd580 && px > 10'd580 - 10'd2)));
    wire border_btn_4 = ((px >= 10'd585 && px <= 10'd605 && (py >= 9'd446 && py < 9'd446 + 9'd2)) ||
                         (px >= 10'd585 && px <= 10'd605 && (py <= 9'd470 && py > 9'd470 - 9'd2)) ||
                         (py >= 9'd446 && py <= 9'd470 && (px >= 10'd585 && px < 10'd585 + 10'd2)) ||
                         (py >= 9'd446 && py <= 9'd470 && (px <= 10'd605 && px > 10'd605 - 10'd2)));

    // Combinational pixel generator
    always @(*) begin
        overlay_en  = 1'b0;
        overlay_rgb = 12'h000;
        if (!settings_active) begin
            // nothing
        end else begin
            // Separating lines at y = 322 (full width)
            if ((py == 9'd322)) begin
                overlay_en  = 1'b1; overlay_rgb = GREEN;
            end
            if ((py == 9'd323)) begin
                overlay_en  = 1'b1; overlay_rgb = 12'h1A1;
            end
            if ((py == 9'd324)) begin
                overlay_en  = 1'b1; overlay_rgb = 12'h181;
            end
            // if ((py == 9'd323) || (py == 9'd321) || (py == 9'd323) || (py == 9'd395) || (py == 9'd397)) begin
            //     overlay_en  = 1'b1; overlay_rgb = BORDERBLUE;
            // end
            // if ((py == 9'd324) || (py == 9'd320) || (py == 9'd324) || (py == 9'd394) || (py == 9'd398)) begin
            //     overlay_en  = 1'b1; overlay_rgb = DARKBLUE;
            // end
            // Hover fill: fill interior with CYAN when mouse hovers
            if (mouse_in_box1 && in_box1) begin overlay_en=1; overlay_rgb=MAGENTA; end
            if (mouse_in_box2 && in_box2) begin overlay_en=1; overlay_rgb=GREEN; end
            if (mouse_in_box3 && in_box3) begin overlay_en=1; overlay_rgb=GREEN; end
            if (mouse_in_box4 && in_box4) begin overlay_en=1; overlay_rgb=GREEN; end
            if (mouse_in_box5 && in_box5) begin overlay_en=1; overlay_rgb=GREEN; end
            if (mouse_in_box6 && in_box6) begin overlay_en=1; overlay_rgb=GREEN; end
            if (mouse_in_box7 && in_box7) begin overlay_en=1; overlay_rgb=(MAGENTA >> 1); end

            // Draw tab borders
            if (border_box1) begin overlay_en=1; overlay_rgb=GREEN; end
            if (border_box2) begin
                overlay_en = 1; 
                if (tab_idx == 3'd1) overlay_rgb = GREEN; else overlay_rgb = GREY;
            end
            if (border_box3) begin
                overlay_en = 1; 
                if (tab_idx == 3'd2) overlay_rgb = GREEN; else overlay_rgb = GREY;
            end
            if (border_box4) begin
                overlay_en = 1; 
                if (tab_idx == 3'd3) overlay_rgb = GREEN; else overlay_rgb = GREY;
            end
            if (border_box5) begin
                overlay_en = 1; 
                if (tab_idx == 3'd4) overlay_rgb = GREEN; else overlay_rgb = GREY;
            end
            if (border_box6) begin
                overlay_en = 1; 
                if (tab_idx == 3'd5) overlay_rgb = GREEN; else overlay_rgb = GREY;
            end
            if (border_box7) begin overlay_en=1; overlay_rgb=GREY; end

            // Panel indicator 9x9 squares inside boxes 2..6
            // Place near top-left inside each tab box
            // if (px >= 10'd72 && px <= 10'd80 && py >= 9'd330 && py <= 9'd338) begin overlay_en=1; overlay_rgb=CYAN; end      // Box2
            // if (px >= 10'd228 && px <= 10'd236 && py >= 9'd330 && py <= 9'd338) begin overlay_en=1; overlay_rgb=YELLOW; end  // Box3
            // if (px >= 10'd331 && px <= 10'd339 && py >= 9'd330 && py <= 9'd338) begin overlay_en=1; overlay_rgb=GREEN; end   // Box4
            // if (px >= 10'd423 && px <= 10'd431 && py >= 9'd330 && py <= 9'd338) begin overlay_en=1; overlay_rgb=MAGENTA; end // Box5
            // if (px >= 10'd512 && px <= 10'd520 && py >= 9'd330 && py <= 9'd338) begin overlay_en=1; overlay_rgb=BLUE; end    // Box6

            // Panel 4 details
            // if (tab_idx == 3'd4) begin
                // slider track
                if (in_slider_track) begin overlay_en=1; overlay_rgb=WHITE; end
                if (in_tick0 || in_tick1 || in_tick2 || in_tick3) begin overlay_en=1; overlay_rgb=WHITE; end
                // highlight selected tick with green column
                if ((min_area_sel==2'b00 && px==tick_x0 && py>=9'd442 && py<=9'd454) ||
                    (min_area_sel==2'b01 && px==tick_x1 && py>=9'd442 && py<=9'd454) ||
                    (min_area_sel==2'b10 && px==tick_x2 && py>=9'd442 && py<=9'd454) ||
                    (min_area_sel==2'b11 && px==tick_x3 && py>=9'd442 && py<=9'd454)) begin
                    overlay_en=1; overlay_rgb=GREEN;
                end
                // buttons
                if (border_btn_area) begin
                    overlay_en = 1;
                    if (sort_by_prox) overlay_rgb = GREY; else overlay_rgb = CYAN;
                end
                if (border_btn_prox) begin
                    overlay_en = 1;
                    if (sort_by_prox) overlay_rgb = CYAN; else overlay_rgb = GREY;
                end
            // end

            // Panel 5 details
            // if (tab_idx == 3'd5) begin
                if (border_btn_1) begin
                    overlay_en = 1;
                    if (max_boxes_sel==2'b00) overlay_rgb = GREEN; else overlay_rgb = GREY;
                end
                if (border_btn_2) begin
                    overlay_en = 1;
                    if (max_boxes_sel==2'b01) overlay_rgb = GREEN; else overlay_rgb = GREY;
                end
                if (border_btn_3) begin
                    overlay_en = 1;
                    if (max_boxes_sel==2'b10) overlay_rgb = GREEN; else overlay_rgb = GREY;
                end
                if (border_btn_4) begin
                    overlay_en = 1;
                    if (max_boxes_sel==2'b11) overlay_rgb = GREEN; else overlay_rgb = GREY;
                end
            // end
        end
    end

endmodule
