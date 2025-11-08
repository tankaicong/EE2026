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
    output reg [1:0] max_boxes_sel,       // 00=1, 01=2, 10=3, 11=4
    output reg         servo           // servo mode on/off
);

    // Colors
    localparam [11:0] BLACK   = 12'h000; // 0
    localparam [11:0] WHITE   = 12'hFFF; // 1
    localparam [11:0] RED     = 12'h00F; // 2
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
    localparam [11:0] BUMBLEBEE   = 12'h0CF; // 14

    // Boxes geometry (inclusive ranges)
    // Box 1: Return (30..62, 324..430)
    // Box 2: Sample+Find (65..218, 324..430)
    // Box 3: Union (221..321, 324..430)
    // Box 4: Build Components and states (324..413, 324..430)
    // Box 5: Filter (416..505, 324..430)
    // Box 6: Draw BB (505..594, 324..430)
    // Box 7: Next setting (594..630, 324..430)

    // Black and yellow arrow lines (inside only)
    wire gen_black = (
        // Official pixel count from Excel
        // ((px >= 36 && px <= 50) && (py >= 435 && py <= 446)) ||                                     // Black square for eye
        // ((px == 77 || px == 80) && (py >= 379 && py <= 441)) ||                                     // Leftmost vertical "ready" to "samples"
        // ((px == 203 || px == 206) && (py >= 379 && py <= 400)) ||                                   // Vertical sample neighbors to union
        // ((py == 401 || py == 404) && ((px >= 207 && px <= 213) || (px >= 227 && px <= 236))) ||     // Both sides of roots to union
        // ((py == 401 || py == 404) && ((px >= 307 && px <= 316))) ||                                 // Left of components to update stats
        // ((px >= 81 && px <= 313) && (py == 471 || py == 474)) ||                                    // Horizontal line from advance to ready
        // ((px >= 116 && px <= 339) && (py == 442 || py == 445)) ||                                   // Horizontal line from ready to advance
        // ((px == 366 || px == 369) && (py >= 424 && py <= 445)) ||                                   // Vertical line from update stats to advance
        // ((px >= 386 && px <= 399) && (py == 465 || py == 468)) ||                                   // Horizontal line from advance to filter
        // ((px == 400 || px == 403) && (py >= 405 && py <= 464)) ||                                   // Vertical line from advance to filter
        // ((px >= 484 && px <= 488) && (py == 401 || py == 404))                                      // Horizontal line from filter to bounding

        // Revised pixel count to fix off-by-one
        ((px >= 37 && px <= 50) && (py >= 435 && py <= 446)) ||                                     // Black square for eye
        ((px == 78 || px == 81) && (py >= 379 && py <= 441)) ||                                     // Leftmost vertical "ready" to "samples"
        ((px == 204 || px == 207) && (py >= 379 && py <= 400)) ||                                   // Vertical sample neighbors to union
        ((py == 401 || py == 404) && ((px >= 208 && px <= 214) || (px >= 228 && px <= 237))) ||     // Both sides of roots to union
        ((py == 401 || py == 404) && ((px >= 308 && px <= 317))) ||                                 // Left of components to update stats
        ((px >= 82 && px <= 314) && (py == 471 || py == 474)) ||                                    // Horizontal line from advance to ready
        ((px >= 117 && px <= 340) && (py == 442 || py == 445)) ||                                   // Horizontal line from ready to advance
        ((px == 367 || px == 370) && (py >= 424 && py <= 445)) ||                                   // Vertical line from update stats to advance
        ((px >= 387 && px <= 400) && (py == 465 || py == 468)) ||                                   // Horizontal line from advance to filter
        ((px == 401 || px == 404) && (py >= 405 && py <= 464)) ||                                   // Vertical line from advance to filter
        ((px >= 485 && px <= 489) && (py == 401 || py == 404))                                      // Horizontal line from filter to bounding
    );

    wire gen_yellow = (
        // Official pixel count from Excel
        // ((px >= 21 && px <= 30) && (py == 451 || py == 452)) ||                                     // Leftmost yellow line inside pink box

        // ((px == 78 || px == 79) && (py >= 379 && py <= 441)) ||                                     // Leftmost vertical "ready" to "samples"
        // ((px == 204 || px == 205) && (py >= 379 && py <= 400)) ||                                   // Vertical sample neighbors to union
        // ((py == 402 || py == 403) && ((px >= 207 && px <= 213) || (px >= 227 && px <= 236))) ||     // Both sides of roots to union
        // ((py == 402 || py == 403) && ((px >= 307 && px <= 316))) ||                                 // Left of components to update stats
        // ((px >= 81 && px <= 313) && (py == 472 || py == 473)) ||                                    // Horizontal line from advance to ready
        // ((px >= 116 && px <= 339) && (py == 443 || py == 444)) ||                                   // Horizontal line from ready to advance
        // ((px == 367 || px == 368) && (py >= 424 && py <= 445)) ||                                   // Vertical line from update stats to advance
        // ((px >= 386 && px <= 399) && (py == 466 || py == 467)) ||                                   // Horizontal line from advance to filter
        // ((px == 401 || px == 402) && (py >= 405 && py <= 464)) ||                                   // Vertical line from advance to filter
        // ((px >= 484 && px <= 488) && (py == 402 || py == 403))                                      // Horizontal line from filter to bounding

        // Revised pixel count to fix off-by-one
        ((px >= 22 && px <= 31) && (py == 451 || py == 452)) ||                                     // Leftmost yellow line inside pink box

        ((px == 79 || px == 80) && (py >= 379 && py <= 441)) ||                                     // Leftmost vertical "ready" to "samples"
        ((px == 205 || px == 206) && (py >= 379 && py <= 400)) ||                                   // Vertical sample neighbors to union
        ((py == 402 || py == 403) && ((px >= 208 && px <= 214) || (px >= 228 && px <= 237))) ||     // Both sides of roots to union
        ((py == 402 || py == 403) && ((px >= 308 && px <= 317))) ||                                 // Left of components to update stats
        ((px >= 82 && px <= 314) && (py == 472 || py == 473)) ||                                    // Horizontal line from advance to ready
        ((px >= 117 && px <= 340) && (py == 443 || py == 444)) ||                                   // Horizontal line from ready to advance
        ((px == 368 || px == 369) && (py >= 424 && py <= 445)) ||                                   // Vertical line from update stats to advance
        ((px >= 387 && px <= 400) && (py == 466 || py == 467)) ||                                   // Horizontal line from advance to filter
        ((px == 402 || px == 403) && (py >= 405 && py <= 464)) ||                                   // Vertical line from advance to filter
        ((px >= 485 && px <= 489) && (py == 402 || py == 403))                                      // Horizontal line from filter to bounding
    );

    wire gen_magenta = (
        (px >= 21 && px <= 31) && (py == 435 || py == 469) ||
        (px == 31 && (py >= 435 && py <= 469))
    );

    // X start, X end, Y start, Y end
    // localparam integer box1 [0:3] = {21, 31, 435, 468};
    // localparam integer box2 [0:3] = {63, 219, 324, 432};
    // localparam integer box3 [0:3] = {220, 324, 324, 432};
    // localparam integer box4 [0:3] = {325, 396, 324, 432};
    // localparam integer box5 [0:3] = {397, 494, 324, 432};
    // localparam integer box6 [0:3] = {495, 596, 324, 479};
    // localparam integer box7 [0:3] = {597, 639, 324, 479};
    // localparam integer box1 [0:3] = {21, 31, 435, 469};
    localparam integer box1 [0:3] = {21, 64, 324, 475};
    localparam integer box2 [0:3] = {63, 219, 324, 432};
    localparam integer box3 [0:3] = {220, 324, 324, 432};
    localparam integer box4 [0:3] = {325, 396, 324, 432};
    localparam integer box5 [0:3] = {397, 494, 324, 449};
    localparam integer box6 [0:3] = {495, 596, 324, 449};
    localparam integer box7 [0:3] = {597, 639, 324, 479};


    wire in_box1 = (px >= box1[0] + 2 && px <= box1[1] - 2 && py >= box1[2] + 2 && py <= box1[3] - 2);      // Pink left box
    wire in_box2 = (px >= box2[0] + 2 && px <= box2[1] - 2 && py >= box2[2] + 2 && py <= box2[3] - 2);      // Sample neighbors box
    wire in_box3 = (px >= box3[0] + 2 && px <= box3[1] - 2 && py >= box3[2] + 2 && py <= box3[3] - 2);      // Union box
    wire in_box4 = (px >= box4[0] + 2 && px <= box4[1] - 2 && py >= box4[2] + 2 && py <= box4[3] - 2);      // Update stats box
    wire in_box5 = (px >= box5[0] + 2 && px <= box5[1] - 2 && py >= box5[2] + 2 && py <= box5[3] - 2);      // Filter refine box
    wire in_box6 = (px >= box6[0] + 2 && px <= box6[1] - 2 && py >= box6[2] + 2 && py <= box6[3] - 2);      // Bounding box box
    wire in_servo = (px >= box7[0] + 2 && px <= box7[1] - 2 && py >= box7[2] + 2 && py <= box7[3] - 2);      // servo box

    wire mouse_in_box1 = (mouse_x >= box1[0] + 2 && mouse_x <= box1[1] - 2 && mouse_y >= box1[2] + 2 && mouse_y <= box1[3] - 2);
    wire mouse_in_box2 = (mouse_x >= box2[0] + 2 && mouse_x <= box2[1] - 2 && mouse_y >= box2[2] + 2 && mouse_y <= box2[3] - 2);
    wire mouse_in_box3 = (mouse_x >= box3[0] + 2 && mouse_x <= box3[1] - 2 && mouse_y >= box3[2] + 2 && mouse_y <= box3[3] - 2);
    wire mouse_in_box4 = (mouse_x >= box4[0] + 2 && mouse_x <= box4[1] - 2 && mouse_y >= box4[2] + 2 && mouse_y <= box4[3] - 2);
    wire mouse_in_box5 = (mouse_x >= box5[0] + 2 && mouse_x <= box5[1] - 2 && mouse_y >= box5[2] + 2 && mouse_y <= box5[3] - 2);
    wire mouse_in_box6 = (mouse_x >= box6[0] + 2 && mouse_x <= box6[1] - 2 && mouse_y >= box6[2] + 2 && mouse_y <= box6[3] - 2);
    wire mouse_in_servo = (mouse_x >= box7[0] + 2 && mouse_x <= box7[1] - 2 && mouse_y >= box7[2] + 2 && mouse_y <= box7[3] - 2);


    // Panel 4 controls geometry (Filter) under the tab row: place within y 440..470
    // Constrain slider and buttons to be inside the width of panel 4 (x 416..505)
    // Slider track: x 430..496, y 446..450; 4 ticks placed within that span
    // Stack buttons vertically: Area button above Proximity button

    // Slider ()
    // wire in_slider_track = (px >= 430 && px <= 496 && py >= 446 && py <= 450);
    // wire [9:0] tick_x0 = 436; // 4
    // wire [9:0] tick_x1 = 452; // 16
    // wire [9:0] tick_x2 = 468; // 32
    // wire [9:0] tick_x3 = 484; // 64
    // wire in_slider_track = (px >= 418 && px <= 483 && py >= 389 && py <= 392);
    // wire [9:0] tick_x0 = 426; // 4
    // wire [9:0] tick_x1 = 442; // 16
    // wire [9:0] tick_x2 = 458; // 32
    // wire [9:0] tick_x3 = 474; // 64

    // wire in_tick0 = (px == tick_x0) && in_slider_track;
    // wire in_tick1 = (px == tick_x1) && in_slider_track;
    // wire in_tick2 = (px == tick_x2) && in_slider_track;
    // wire in_tick3 = (px == tick_x3) && in_slider_track;

    // Stack buttons vertically within panel width
    localparam integer a_start_x = 526, a_start_y = 368, a_end_x = 565, a_end_y = 383;
    localparam integer p_start_x = 506, p_start_y = 386, p_end_x = 585, p_end_y = 407;
    wire in_btn_area = (px >= a_start_x && px <= a_end_x && py >= a_start_y && py <= a_end_y);
    wire in_btn_prox = (px >= p_start_x && px <= p_end_x && py >= p_start_y && py <= p_end_y);
    wire mouse_in_btn_area = (mouse_x >= a_start_x && mouse_x <= a_end_x && mouse_y >= a_start_y && mouse_y <= a_end_y);
    wire mouse_in_btn_prox = (mouse_x >= p_start_x && mouse_x <= p_end_x && mouse_y >= p_start_y && mouse_y <= p_end_y);

    // Panel 5 controls geometry (Draw BB): x 510..610, y 446..470 (four small buttons)
    // localparam integer btn1_x0 = 502, btn1_x1 = 521, btn1_y0 = 422, btn1_y1 = 441;
    // localparam integer btn2_x0 = 525, btn2_x1 = 544, btn2_y0 = 422, btn2_y1 = 441;
    // localparam integer btn3_x0 = 548, btn3_x1 = 567, btn3_y0 = 422, btn3_y1 = 441;
    // localparam integer btn4_x0 = 571, btn4_x1 = 590, btn4_y0 = 422, btn4_y1 = 441;
    localparam integer btn1_x0 = 503, btn1_x1 = 522, btn1_y0 = 422, btn1_y1 = 441;
    localparam integer btn2_x0 = 526, btn2_x1 = 545, btn2_y0 = 422, btn2_y1 = 441;
    localparam integer btn3_x0 = 549, btn3_x1 = 568, btn3_y0 = 422, btn3_y1 = 441;
    localparam integer btn4_x0 = 572, btn4_x1 = 591, btn4_y0 = 422, btn4_y1 = 441;

    wire in_btn_1 = (px >= btn1_x0 && px <= btn1_x1 && py >= btn1_y0 && py <= btn1_y1);
    wire in_btn_2 = (px >= btn2_x0 && px <= btn2_x1 && py >= btn2_y0 && py <= btn2_y1);
    wire in_btn_3 = (px >= btn3_x0 && px <= btn3_x1 && py >= btn3_y0 && py <= btn3_y1);
    wire in_btn_4 = (px >= btn4_x0 && px <= btn4_x1 && py >= btn4_y0 && py <= btn4_y1);
    wire mouse_in_btn_1 = (mouse_x >= btn1_x0 && mouse_x <= btn1_x1 && mouse_y >= btn1_y0 && mouse_y <= btn1_y1);
    wire mouse_in_btn_2 = (mouse_x >= btn2_x0 && mouse_x <= btn2_x1 && mouse_y >= btn2_y0 && mouse_y <= btn2_y1);
    wire mouse_in_btn_3 = (mouse_x >= btn3_x0 && mouse_x <= btn3_x1 && mouse_y >= btn3_y0 && mouse_y <= btn3_y1);
    wire mouse_in_btn_4 = (mouse_x >= btn4_x0 && mouse_x <= btn4_x1 && mouse_y >= btn4_y0 && mouse_y <= btn4_y1);


    // Panel 4 controls for filtering
    // localparam integer btn04_x0 = 423, btn04_x1 = 447, btn04_y0 = 389, btn04_y1 = 413;
    // localparam integer btn16_x0 = 455, btn16_x1 = 479, btn16_y0 = 389, btn16_y1 = 413;
    // localparam integer btn32_x0 = 423, btn32_x1 = 447, btn32_y0 = 419, btn32_y1 = 443;
    // localparam integer btn64_x0 = 455, btn64_x1 = 479, btn64_y0 = 419, btn64_y1 = 443;
    localparam integer btn04_x0 = 424, btn04_x1 = 448, btn04_y0 = 388, btn04_y1 = 412;
    localparam integer btn16_x0 = 456, btn16_x1 = 480, btn16_y0 = 388, btn16_y1 = 412;
    localparam integer btn32_x0 = 424, btn32_x1 = 448, btn32_y0 = 418, btn32_y1 = 442;
    localparam integer btn64_x0 = 456, btn64_x1 = 480, btn64_y0 = 418, btn64_y1 = 442;

    wire btn04_1 = (px >= btn04_x0 && px <= btn04_x1 && py >= btn04_y0 && py <= btn04_y1);
    wire btn16_1 = (px >= btn16_x0 && px <= btn16_x1 && py >= btn16_y0 && py <= btn16_y1);
    wire btn32_1 = (px >= btn32_x0 && px <= btn32_x1 && py >= btn32_y0 && py <= btn32_y1);
    wire btn64_1 = (px >= btn64_x0 && px <= btn64_x1 && py >= btn64_y0 && py <= btn64_y1);
    wire mouse_in_btn04_1 = (mouse_x >= btn04_x0 && mouse_x <= btn04_x1 && mouse_y >= btn04_y0 && mouse_y <= btn04_y1);
    wire mouse_in_btn16_1 = (mouse_x >= btn16_x0 && mouse_x <= btn16_x1 && mouse_y >= btn16_y0 && mouse_y <= btn16_y1);
    wire mouse_in_btn32_1 = (mouse_x >= btn32_x0 && mouse_x <= btn32_x1 && mouse_y >= btn32_y0 && mouse_y <= btn32_y1);
    wire mouse_in_btn64_1 = (mouse_x >= btn64_x0 && mouse_x <= btn64_x1 && mouse_y >= btn64_y0 && mouse_y <= btn64_y1);

    // Latch clicks for tabs and settings
    always @(posedge clk) begin
        if (reset) begin
            tab_idx       <= 1;
            min_area_sel  <= 2'b00; // 4
            sort_by_prox  <= 1'b0;  // area
            max_boxes_sel <= 2'b11; // 4
            return_click  <= 1'b0;
        end else begin
            return_click <= 1'b0; // default pulse low
            if (settings_active && left_edge) begin
                if (mouse_in_box1) begin
                    return_click <= 1'b1;
                    tab_idx <= 0;
                end else if (mouse_in_box2) begin
                    tab_idx <= 1;
                end else if (mouse_in_box3) begin
                    tab_idx <= 2;
                end else if (mouse_in_box4) begin
                    tab_idx <= 3; // Build Components and states
                end else if (mouse_in_box5) begin
                    tab_idx <= 4; // Filter
                end else if (mouse_in_box6) begin
                    tab_idx <= 5; // Draw BB
                end

                // Panel 4 interactions (Filter) only when tab 4
                // if (tab_idx == 4) begin
                    // Click near ticks selects min area discrete levels
                    // if (mouse_x >= tick_x0-2 && mouse_x <= tick_x0+2 && mouse_y >= 444 && mouse_y <= 452) begin
                    //     min_area_sel <= 2'b00; // 4
                    // end else if (mouse_x >= tick_x1-2 && mouse_x <= tick_x1+2 && mouse_y >= 444 && mouse_y <= 452) begin
                    //     min_area_sel <= 2'b01; // 16
                    // end else if (mouse_x >= tick_x2-2 && mouse_x <= tick_x2+2 && mouse_y >= 444 && mouse_y <= 452) begin
                    //     min_area_sel <= 2'b10; // 32
                    // end else if (mouse_x >= tick_x3-2 && mouse_x <= tick_x3+2 && mouse_y >= 444 && mouse_y <= 452) begin
                    //     min_area_sel <= 2'b11; // 64
                    // // end
                    // Sort mode buttons
                if (mouse_in_btn_area) sort_by_prox <= 1'b0;
                if (mouse_in_btn_prox) sort_by_prox <= 1'b1;

                if (mouse_in_btn04_1) min_area_sel <= 2'b00; // 4
                else if (mouse_in_btn16_1) min_area_sel <= 2'b01; // 16
                else if (mouse_in_btn32_1) min_area_sel <= 2'b10; // 32
                else if (mouse_in_btn64_1) min_area_sel <= 2'b11; // 64
                // end

                // Panel 5 interactions (Draw BB) only when tab 5
                // if (tab_idx == 5) begin
                if (mouse_in_btn_1) max_boxes_sel <= 2'b00;
                else if (mouse_in_btn_2) max_boxes_sel <= 2'b01;
                else if (mouse_in_btn_3) max_boxes_sel <= 2'b10;
                else if (mouse_in_btn_4) max_boxes_sel <= 2'b11;

                // end
                if (mouse_in_servo) begin
                    servo <= ~servo;
                end
            end
        end
    end

    // Precomputed border wires
    // Thickness 1 for pink box
    // wire border_box1 = ((px >= box1[0] && px <= box1[1] && (py == box1[2] || py == box1[3])) ||                                 // Leftmost (pink box) horiz lines
    //                     ((px == box1[0] || px == box1[1]) && (py >= box1[2] + 1 && py <= box1[3] - 1)));                        // vertical lines
    // Thickness 2 for all the rest
    wire border_box1 = ((px >= box1[0] && px <= box1[1] && ((py >= box1[2] && py <= box1[2] + 2) || (py >= box1[3] && py <= box1[3] + 2))) ||             // Horizontals
                        (py >= (box1[2] + 2) && py <= box1[3] && ((px >= box1[0] && px <= box1[0] + 2) || (px >= (box1[1] - 2) && px <= box1[1]))));      // Verticals

    // wire border_box2 = ((px >= box2[0] && px <= box2[1] && (py >= box2[2] && py <= box2[2] + 2)) ||                       // Horizontal top
    //                     (px >= (box2[0] + 25) && px <= box2[1] && (py >= box2[3] && py <= box2[3] + 2)) ||                // Horizontal bottom due to cutout for READY
    //                     (py >= (box2[2] + 2) && py <= box2[3] && ((px >= box2[0] && px <= box2[0] + 2) || (px >= (box2[1] - 2) && px <= box2[1]))));     // Verticals
    
    wire border_box2 = ((px >= box2[0] && px <= box2[1] && ((py >= box2[2] && py <= box2[2] + 2) || (py >= box2[3] && py <= box2[3] + 2))) ||            // Horizontals
                        (py >= (box2[2] + 2) && py <= box2[3] && ((px >= box2[0] && px <= box2[0] + 2) || (px >= (box2[1] - 2) && px <= box2[1]))));     // Verticals

    wire border_box3 = ((px >= box3[0] && px <= box3[1] && ((py >= box3[2] && py <= box3[2] + 2) || (py >= box3[3] && py <= box3[3] + 2))) ||             // Horizontals
                        (py >= (box3[2] + 2) && py <= box3[3] && ((px >= box3[0] && px <= box3[0] + 2) || (px >= (box3[1] - 2) && px <= box3[1]))));      // Verticals

    wire border_box4 = ((px >= box4[0] && px <= box4[1] && ((py >= box4[2] && py <= box4[2] + 2) || (py >= box4[3] && py <= box4[3] + 2))) ||             // Horizontals
                        (py >= (box4[2] + 2) && py <= box4[3] && (px >= box4[0] && px <= box4[0] + 2)) ||                                            // Left vertical with cutout for slider
                        (py >= (box4[2] + 2) && py <= box4[3] && (px >= (box4[1] - 2) && px <= box4[1])));                                           // Right vertical

    wire border_box5 = ((px >= box5[0] && px <= box5[1] && ((py >= box5[2] && py <= box5[2] + 2) || (py >= box5[3] && py <= box5[3] + 2))) ||             // Horizontals
                        (py >= (box5[2] + 2) && py <= box5[3] && ((px >= box5[0] && px <= box5[0] + 2) || (px >= (box5[1] - 2) && px <= box5[1]))));      // Verticals

    wire border_box6 = ((px >= box6[0] && px <= box6[1] && ((py >= box6[2] && py <= box6[2] + 2) || (py >= box6[3] && py <= box6[3] + 2))) ||             // Horizontals
                        (py >= (box6[2] + 2) && py <= box6[3] && ((px >= box6[0] && px <= box6[0] + 2) || (px >= (box6[1] - 2) && px <= box6[1]))));      // Verticals

    wire border_box7 = ((px >= box7[0] && px <= box7[1] && ((py >= box7[2] && py <= box7[2] + 2) || (py >= box7[3] && py <= box7[3] + 2))) ||             // Horizontals
                        (py >= (box7[2] + 2) && py <= box7[3] && ((px >= box7[0] && px <= box7[0] + 2) || (px >= (box7[1] - 2) && px <= box7[1]))));      // Verticals

    // Panel 4 button borders (4 and 16 area), thickness 1
    // wire border_btn04_1 = ((px >= 423 + 1 && px <= 447 && ((py == 389) || (py == 413))) ||
    //                        (py >= 389 && py <= 413 && ((px == 423 + 1) || (px == 447))));
    // wire border_btn16_1 = ((px >= 455 + 1 && px <= 479 && ((py == 389) || (py == 413))) ||
    //                        (py >= 389 && py <= 413 && ((px == 455 + 1) || (px == 479))));
    wire border_btn04_1 = ((px >= btn04_x0 + 1 && px <= btn04_x1 && ((py == btn04_y0) || (py == btn04_y1))) ||
                           (py >= btn04_y0 && py <= btn04_y1 && ((px == btn04_x0 + 1) || (px == btn04_x1))));
    wire border_btn16_1 = ((px >= btn16_x0 + 1 && px <= btn16_x1 && ((py == btn16_y0) || (py == btn16_y1))) ||
                           (py >= btn16_y0 && py <= btn16_y1 && ((px == btn16_x0 + 1) || (px == btn16_x1))));
    // Panel 4 button borders (32 and 64 area), thickness 1
    // wire border_btn32_1 = ((px >= 423 + 1 && px <= 447 && ((py == 419) || (py == 443))) ||
    //                        (py >= 419 && py <= 443 && ((px == 423 + 1) || (px == 447))));
    // wire border_btn64_1 = ((px >= 455 + 1 && px <= 479 && ((py == 419) || (py == 443))) ||
    //                        (py >= 419 && py <= 443 && ((px == 455 + 1) || (px == 479))));
    wire border_btn32_1 = ((px >= btn32_x0 + 1 && px <= btn32_x1 && ((py == btn32_y0) || (py == btn32_y1))) ||
                           (py >= btn32_y0 && py <= btn32_y1 && ((px == btn32_x0 + 1) || (px == btn32_x1))));
    wire border_btn64_1 = ((px >= btn64_x0 + 1 && px <= btn64_x1 && ((py == btn64_y0) || (py == btn64_y1))) ||
                           (py >= btn64_y0 && py <= btn64_y1 && ((px == btn64_x0 + 1) || (px == btn64_x1))));

    // Panel 5 button borders (Area/Proximity), thickness 1
    // Border wires for stacked buttons
    wire border_btn_area = ((px >= 526 + 1 && px <= 565 && ((py == 368) || (py == 383))) ||
                            (py >= 368 && py <= 383 && ((px == 526 + 1) || (px == 565))));
    wire border_btn_prox = ((px >= 506 + 1 && px <= 585 && ((py == 386) || (py == 407))) ||
                            (py >= 386 && py <= 407 && ((px == 506 + 1) || (px == 585))));

    // Panel 5 max-box button borders, thickness 1
    wire border_btn_1 = ((px >= btn1_x0 + 1 && px <= btn1_x1 && ((py == btn1_y0) || (py == btn1_y1))) ||
                         (py >= btn1_y0 && py <= btn1_y1 && ((px == btn1_x0 + 1) || (px == btn1_x1))));
    wire border_btn_2 = ((px >= btn2_x0 + 1 && px <= btn2_x1 && ((py == btn2_y0) || (py == btn2_y1))) ||
                            (py >= btn2_y0 && py <= btn2_y1 && ((px == btn2_x0 + 1) || (px == btn2_x1))));
    wire border_btn_3 = ((px >= btn3_x0 + 1 && px <= btn3_x1 && ((py == btn3_y0) || (py == btn3_y1))) ||
                            (py >= btn3_y0 && py <= btn3_y1 && ((px == btn3_x0 + 1) || (px == btn3_x1))));
    wire border_btn_4 = ((px >= btn4_x0 + 1 && px <= btn4_x1 && ((py == btn4_y0) || (py == btn4_y1))) ||
                            (py >= btn4_y0 && py <= btn4_y1 && ((px == btn4_x0 + 1) || (px == btn4_x1))));

    // Combinational pixel generator
    always @(*) begin
        overlay_en  = 1'b0;
        overlay_rgb = 12'h000;
        if (!settings_active) begin
            // nothing
        end else begin
            // Separating lines at y = 322 (full width)
            // if ((py == 322)) begin
            //     overlay_en  = 1'b1; overlay_rgb = GREEN;
            // end
            // if ((py == 323)) begin
            //     overlay_en  = 1'b1; overlay_rgb = 12'h1A1;
            // end
            // if ((py == 324)) begin
            //     overlay_en  = 1'b1; overlay_rgb = 12'h181;
            // end
            // if ((py == 323) || (py == 321) || (py == 323) || (py == 395) || (py == 397)) begin
            //     overlay_en  = 1'b1; overlay_rgb = BORDERBLUE;
            // end
            // if ((py == 324) || (py == 320) || (py == 324) || (py == 394) || (py == 398)) begin
            //     overlay_en  = 1'b1; overlay_rgb = DARKBLUE;
            // end
            // Hover fill: fill interior with CYAN when mouse hovers
            if (mouse_in_box1 && in_box1) begin overlay_en=1; overlay_rgb=MAGENTA; end
            if (mouse_in_box2 && in_box2) begin overlay_en=1; overlay_rgb=OFFWHITE; end
            if (mouse_in_box3 && in_box3) begin overlay_en=1; overlay_rgb=OFFWHITE; end
            if (mouse_in_box4 && in_box4) begin overlay_en=1; overlay_rgb=OFFWHITE; end
            if (mouse_in_box5 && in_box5) begin overlay_en=1; overlay_rgb=OFFWHITE; end
            if (mouse_in_box6 && in_box6) begin overlay_en=1; overlay_rgb=OFFWHITE; end
            if (mouse_in_servo && in_servo) begin overlay_en=1; overlay_rgb=RED; end

            // Draw tab borders
            // if (border_box1) begin overlay_en=1; overlay_rgb=GREEN; end
            if (border_box1) begin
                overlay_en=1;
                if (tab_idx == 0) overlay_rgb=GREEN; else overlay_rgb=GREY;
            end
            if (border_box2) begin
                overlay_en = 1; 
                if (tab_idx == 1) overlay_rgb = GREEN; else overlay_rgb = GREY;
            end
            if (border_box3) begin
                overlay_en = 1; 
                if (tab_idx == 2) overlay_rgb = GREEN; else overlay_rgb = GREY;
            end
            if (border_box4) begin
                overlay_en = 1; 
                if (tab_idx == 3) overlay_rgb = GREEN; else overlay_rgb = GREY;
            end
            if (border_box5) begin
                overlay_en = 1; 
                if (tab_idx == 4) overlay_rgb = GREEN; else overlay_rgb = GREY;
            end
            if (border_box6) begin
                overlay_en = 1; 
                if (tab_idx == 5) overlay_rgb = GREEN; else overlay_rgb = GREY;
            end
            if (border_box7) begin overlay_en=1; if (servo) overlay_rgb = RED; else overlay_rgb=GREY; end

            if (gen_black) begin overlay_en=1; overlay_rgb=BLACK; end
            if (gen_yellow) begin overlay_en=1; overlay_rgb=YELLOW; end

            if (gen_magenta) begin overlay_en=1; overlay_rgb=MAGENTA; end

            // Panel indicator 9x9 squares inside boxes 2..6
            // Place near top-left inside each tab box
            // if (px >= 72 && px <= 80 && py >= 330 && py <= 338) begin overlay_en=1; overlay_rgb=CYAN; end      // Box2
            // if (px >= 228 && px <= 236 && py >= 330 && py <= 338) begin overlay_en=1; overlay_rgb=YELLOW; end  // Box3
            // if (px >= 331 && px <= 339 && py >= 330 && py <= 338) begin overlay_en=1; overlay_rgb=GREEN; end   // Box4
            // if (px >= 423 && px <= 431 && py >= 330 && py <= 338) begin overlay_en=1; overlay_rgb=MAGENTA; end // Box5
            // if (px >= 512 && px <= 520 && py >= 330 && py <= 338) begin overlay_en=1; overlay_rgb=BLUE; end    // Box6

            // Panel 4 details
            // if (tab_idx== 4) begin
                // slider track
                // if (in_slider_track) begin overlay_en=1; overlay_rgb=WHITE; end
                // if (in_tick0 || in_tick1 || in_tick2 || in_tick3) begin overlay_en=1; overlay_rgb=WHITE; end
                // // highlight selected tick with green column
                // // if ((min_area_sel==2'b00 && px==tick_x0 && py>=442 && py<=454) ||
                // //     (min_area_sel==2'b01 && px==tick_x1 && py>=442 && py<=454) ||
                // //     (min_area_sel==2'b10 && px==tick_x2 && py>=442 && py<=454) ||
                // //     (min_area_sel==2'b11 && px==tick_x3 && py>=442 && py<=454)) begin
                // if ((min_area_sel==2'b00 && px==tick_x0 && py>=387 && py<=394) ||
                //     (min_area_sel==2'b01 && px==tick_x1 && py>=387 && py<=394) ||
                //     (min_area_sel==2'b10 && px==tick_x2 && py>=387 && py<=394) ||
                //     (min_area_sel==2'b11 && px==tick_x3 && py>=387 && py<=394)) begin
                //     overlay_en=1; overlay_rgb=GREEN;
                // end
                // buttons
            if (btn04_1 && (mouse_in_btn04_1 || min_area_sel==2'b00)) begin overlay_en=1; overlay_rgb=BUMBLEBEE; end
            if (btn16_1 && (mouse_in_btn16_1 || min_area_sel==2'b01)) begin overlay_en=1; overlay_rgb=BUMBLEBEE; end
            if (btn32_1 && (mouse_in_btn32_1 || min_area_sel==2'b10)) begin overlay_en=1; overlay_rgb=BUMBLEBEE; end
            if (btn64_1 && (mouse_in_btn64_1 || min_area_sel==2'b11)) begin overlay_en=1; overlay_rgb=BUMBLEBEE; end
            // end

            // Panel 4 buttons
            if (border_btn04_1) begin
                overlay_en = 1;
                if (min_area_sel==2'b00) overlay_rgb = BUMBLEBEE; else overlay_rgb = GREY;
            end
            if (border_btn16_1) begin
                overlay_en = 1;
                if (min_area_sel==2'b01) overlay_rgb = BUMBLEBEE; else overlay_rgb = GREY;
            end
            if (border_btn32_1) begin
                overlay_en = 1;
                if (min_area_sel==2'b10) overlay_rgb = BUMBLEBEE; else overlay_rgb = GREY;
            end
            if (border_btn64_1) begin
                overlay_en = 1;
                if (min_area_sel==2'b11) overlay_rgb = BUMBLEBEE; else overlay_rgb = GREY;
            end

            // Panel 5 details
            // if (tab_idx == 5) begin
            if (in_btn_1 && (mouse_in_btn_1 || max_boxes_sel==2'b00)) begin overlay_en=1; overlay_rgb=BUMBLEBEE; end
            if (in_btn_2 && (mouse_in_btn_2 || max_boxes_sel==2'b01)) begin overlay_en=1; overlay_rgb=BUMBLEBEE; end
            if (in_btn_3 && (mouse_in_btn_3 || max_boxes_sel==2'b10)) begin overlay_en=1; overlay_rgb=BUMBLEBEE; end
            if (in_btn_4 && (mouse_in_btn_4 || max_boxes_sel==2'b11)) begin overlay_en=1; overlay_rgb=BUMBLEBEE; end
            if (in_btn_area && (mouse_in_btn_area || !sort_by_prox)) begin overlay_en=1; overlay_rgb=BUMBLEBEE; end
            if (in_btn_prox && (mouse_in_btn_prox || sort_by_prox)) begin overlay_en=1; overlay_rgb=BUMBLEBEE; end
            // end
            if (border_btn_1) begin
                overlay_en = 1;
                if (max_boxes_sel==2'b00) overlay_rgb = BUMBLEBEE; else overlay_rgb = GREY;
            end
            if (border_btn_2) begin
                overlay_en = 1;
                if (max_boxes_sel==2'b01) overlay_rgb = BUMBLEBEE; else overlay_rgb = GREY;
            end
            if (border_btn_3) begin
                overlay_en = 1;
                if (max_boxes_sel==2'b10) overlay_rgb = BUMBLEBEE; else overlay_rgb = GREY;
            end
            if (border_btn_4) begin
                overlay_en = 1;
                if (max_boxes_sel==2'b11) overlay_rgb = BUMBLEBEE; else overlay_rgb = GREY;
            end
            if (border_btn_area) begin
                overlay_en = 1;
                if (sort_by_prox) overlay_rgb = GREY; else overlay_rgb = BUMBLEBEE;
            end
            if (border_btn_prox) begin
                overlay_en = 1;
                if (sort_by_prox) overlay_rgb = BUMBLEBEE; else overlay_rgb = GREY;
            end
            // end
            if (in_servo && servo) begin overlay_en=1; overlay_rgb=RED; end

        end
    end

endmodule
