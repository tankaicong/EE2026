`timescale 1ns / 1ps

// CV settings overlay in VGA (640x480) coordinates
// Draws two drop zones (borders) and six filled boxes:
//  - Preprocessing: GAUSS, MEDIAN (cyan), size 72x34
//  - Morphology: ERODE, DILATE (magenta), size 40x34
// CAM box: Start at x = 30, width = 47 px
// Preprocessing drop box: Start at x = 105, width = 148px
// BITMAP box: Start at x = 278, width = 72 px
// Morphology drop box: Start at x = 375, width = 164px
// UFDS box: Start at x = 564, width = 66 px

module cv_settings_overlay (
    input  wire        clk,
    input  wire        reset,
    input  wire        settings_active,
    input  wire [9:0]  px,        // VGA x (0..639)
    input  wire [8:0]  py,        // VGA y (0..479)
    // Mouse (VGA coords) and click edge for hit-testing inside overlay
    input  wire [9:0]  mouse_x,
    input  wire [8:0]  mouse_y,
    input  wire        left_edge,

    // Box top-left positions in VGA coords (from drag/drop)
    input  wire [59:0] boxes_x,  // 6 x 10-bit
    input  wire [53:0] boxes_y,  // 6 x 9-bit

    // Index of the box to draw on top (foreground). 0..5; if out-of-range, default order applies.
    input  wire [2:0]  front_idx,

    // values from slider threshold settings
    input wire [3:0]  start_red_val, // 0..15
    input wire [3:0]  end_red_val,        
    input wire [3:0]  start_green_val,      
    input wire [3:0]  end_green_val,        
    input wire [3:0]  start_blue_val,
    input wire [3:0]  end_blue_val,

    // Outputs
    output reg         overlay_en,
    output reg [11:0]  overlay_rgb,
    // One-cycle click pulses when left_edge occurs inside these boxes (VGA coords)
    output wire        cam_box_click,
    output wire        bitmap_box_click,
    output wire        ufds_box_click,
    // Drop zones (overlay is the single source of truth)
    output wire [9:0]  pre_x_o,
    output wire [8:0]  pre_y_o,
    output wire [9:0]  pre_w_o,
    output wire [8:0]  pre_h_o,
    output wire [9:0]  morph_x_o,
    output wire [8:0]  morph_y_o,
    output wire [9:0]  morph_w_o,
    output wire [8:0]  morph_h_o,
    // Change-view selection outputs
    output wire [1:0]  final_out

);

    // Unpack for overlay drawing
    wire [9:0] x0 = boxes_x[9:0];
    wire [9:0] x1 = boxes_x[19:10];
    wire [9:0] x2 = boxes_x[29:20];
    wire [9:0] x3 = boxes_x[39:30];
    wire [9:0] x4 = boxes_x[49:40];
    wire [9:0] x5 = boxes_x[59:50];
    wire [8:0] y0 = boxes_y[8:0];
    wire [8:0] y1 = boxes_y[17:9];
    wire [8:0] y2 = boxes_y[26:18];
    wire [8:0] y3 = boxes_y[35:27];
    wire [8:0] y4 = boxes_y[44:36];
    wire [8:0] y5 = boxes_y[53:45];

    // Colors (BGR444)
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
  


    // Box sizes in VGA
    localparam [9:0] W_PRE = 10'd72;
    localparam [9:0] W_MOR = 10'd40;
    localparam [8:0] H_ALL = 9'd34;
    // Change-view toggle sizes and gap
    localparam [9:0] TOG_W = 10'd15;
    localparam [8:0] TOG_H = 9'd12;
    localparam [9:0] GAP_X = 10'd5;

    // Drop zones geometry
    localparam [9:0] PRE_X  = 10'd105;
    localparam [8:0] PRE_Y  = 9'd435;
    localparam [9:0] PRE_W  = 10'd148;
    localparam [8:0] PRE_H  = 9'd34;
    localparam [9:0] MORPH_X = 10'd375;
    localparam [8:0] MORPH_Y = 9'd435;
    localparam [9:0] MORPH_W = 10'd164;
    localparam [8:0] MORPH_H = 9'd34;

    // Export constants to Top/drag-drop
    assign pre_x_o   = PRE_X;
    assign pre_y_o   = PRE_Y;
    assign pre_w_o   = PRE_W;
    assign pre_h_o   = PRE_H;
    assign morph_x_o = MORPH_X;
    assign morph_y_o = MORPH_Y;
    assign morph_w_o = MORPH_W;
    assign morph_h_o = MORPH_H;

    // Drop zone borders (1px)
    wire in_pre_border;
    wire in_morph_border;
    assign in_pre_border   = ((py == PRE_Y) || (py == (PRE_Y + PRE_H - 1))) ? ((px >= PRE_X) && (px < (PRE_X + PRE_W))) :
                             ((px == PRE_X) || (px == (PRE_X + PRE_W - 1))) ? ((py >= PRE_Y) && (py < (PRE_Y + PRE_H))) : 1'b0;
    assign in_morph_border = ((py == MORPH_Y) || (py == (MORPH_Y + MORPH_H - 1))) ? ((px >= MORPH_X) && (px < (MORPH_X + MORPH_W))) :
                             ((px == MORPH_X) || (px == (MORPH_X + MORPH_W - 1))) ? ((py >= MORPH_Y) && (py < (MORPH_Y + MORPH_H))) : 1'b0;
    // Box interior checks
    wire in0 = (px >= x0) && (px < (x0 + W_PRE)) && (py >= y0) && (py < (y0 + H_ALL)); // GAUSS
    wire in1 = (px >= x1) && (px < (x1 + W_PRE)) && (py >= y1) && (py < (y1 + H_ALL)); // MEDIAN
    wire in2 = (px >= x2) && (px < (x2 + W_MOR)) && (py >= y2) && (py < (y2 + H_ALL)); // ERODE A
    wire in3 = (px >= x3) && (px < (x3 + W_MOR)) && (py >= y3) && (py < (y3 + H_ALL)); // ERODE B
    wire in4 = (px >= x4) && (px < (x4 + W_MOR)) && (py >= y4) && (py < (y4 + H_ALL)); // DILATE A
    wire in5 = (px >= x5) && (px < (x5 + W_MOR)) && (py >= y5) && (py < (y5 + H_ALL)); // DILATE B

    // Bottom row selection boxes (y = 435), custom widths
    localparam [8:0] ROW_Y  = 9'd435;
    localparam [9:0] CAM_X  = 10'd33;  localparam [9:0] CAM_W  = 10'd47;  localparam [8:0] CAM_Y  = ROW_Y;
    localparam [9:0] BMP_X  = 10'd278; localparam [9:0] BMP_W  = 10'd72;  localparam [8:0] BMP_Y  = ROW_Y;
    localparam [9:0] UFDS_X = 10'd564; localparam [9:0] UFDS_W = 10'd66;  localparam [8:0] UFDS_Y = ROW_Y;
    // Borders like drop zones, using per-box widths
    wire in_cam_border  = ((py == CAM_Y) || (py == (CAM_Y + H_ALL - 1))) ? ((px >= CAM_X) && (px < (CAM_X + CAM_W))) :
                     ((px == CAM_X) || (px == (CAM_X + CAM_W - 1))) ? ((py >= CAM_Y) && (py < (CAM_Y + H_ALL))) : 1'b0;
    wire in_bmp_border  = ((py == BMP_Y) || (py == (BMP_Y + H_ALL - 1))) ? ((px >= BMP_X) && (px < (BMP_X + BMP_W))) :
                     ((px == BMP_X) || (px == (BMP_X + BMP_W - 1))) ? ((py >= BMP_Y) && (py < (BMP_Y + H_ALL))) : 1'b0;
    wire in_ufds_border = ((py == UFDS_Y)|| (py == (UFDS_Y+ H_ALL - 1))) ? ((px >= UFDS_X) && (px < (UFDS_X+ UFDS_W))) :
                     ((px == UFDS_X)|| (px == (UFDS_X+ UFDS_W - 1))) ? ((py >= UFDS_Y) && (py < (UFDS_Y+ H_ALL))) : 1'b0;
    // In-rect checks for clicks (include border and interior)
    wire in_cam_rect    = (mouse_x >= CAM_X)   && (mouse_x < (CAM_X  + CAM_W))   && (mouse_y >= CAM_Y)  && (mouse_y < (CAM_Y  + H_ALL));
    wire in_bitmap_rect = (mouse_x >= BMP_X)   && (mouse_x < (BMP_X  + BMP_W))   && (mouse_y >= BMP_Y)  && (mouse_y < (BMP_Y  + H_ALL));
    wire in_ufds_rect   = (mouse_x >= UFDS_X)  && (mouse_x < (UFDS_X + UFDS_W))  && (mouse_y >= UFDS_Y) && (mouse_y < (UFDS_Y + H_ALL));

    // Change-view toggle positions (centered vertically in bottom-row height)
    localparam [8:0] TOG_Y  = ROW_Y;
    localparam [9:0] TOG0_X = CAM_X   + CAM_W   + GAP_X; // after CAM
    localparam [9:0] TOG1_X = PRE_X   + PRE_W   + GAP_X; // after PRE
    localparam [9:0] TOG2_X = BMP_X   + BMP_W   + GAP_X; // after BITMAP
    localparam [9:0] TOG3_X = MORPH_X + MORPH_W + GAP_X; // after MORPH

    // Toggle borders (1px)
    wire in_tog0_border = ((py == TOG_Y) || (py == (TOG_Y + TOG_H - 1))) ? ((px >= TOG0_X) && (px < (TOG0_X + TOG_W))) :
                          ((px == TOG0_X) || (px == (TOG0_X + TOG_W - 1))) ? ((py >= TOG_Y) && (py < (TOG_Y + TOG_H))) : 1'b0;
    wire in_tog1_border = ((py == TOG_Y) || (py == (TOG_Y + TOG_H - 1))) ? ((px >= TOG1_X) && (px < (TOG1_X + TOG_W))) :
                          ((px == TOG1_X) || (px == (TOG1_X + TOG_W - 1))) ? ((py >= TOG_Y) && (py < (TOG_Y + TOG_H))) : 1'b0;
    wire in_tog2_border = ((py == TOG_Y) || (py == (TOG_Y + TOG_H - 1))) ? ((px >= TOG2_X) && (px < (TOG2_X + TOG_W))) :
                          ((px == TOG2_X) || (px == (TOG2_X + TOG_W - 1))) ? ((py >= TOG_Y) && (py < (TOG_Y + TOG_H))) : 1'b0;
    wire in_tog3_border = ((py == TOG_Y) || (py == (TOG_Y + TOG_H - 1))) ? ((px >= TOG3_X) && (px < (TOG3_X + TOG_W))) :
                          ((px == TOG3_X) || (px == (TOG3_X + TOG_W - 1))) ? ((py >= TOG_Y) && (py < (TOG_Y + TOG_H))) : 1'b0;

    // Instantiate change-view controller
    wire [3:0] cv_flags;
    cv_settings_change_view u_cv_view (
        .clk(clk), .reset(reset), .settings_active(settings_active),
        .mouse_x(mouse_x), .mouse_y(mouse_y), .left_edge(left_edge),
        .x0(TOG0_X), .y0(TOG_Y), .w0(TOG_W), .h0(TOG_H),
        .x1(TOG1_X), .y1(TOG_Y), .w1(TOG_W), .h1(TOG_H),
        .x2(TOG2_X), .y2(TOG_Y), .w2(TOG_W), .h2(TOG_H),
        .x3(TOG3_X), .y3(TOG_Y), .w3(TOG_W), .h3(TOG_H),
        .toggled_flags(cv_flags),
        .final_out(final_out)
    );

    always @(*) begin
        overlay_en  = 1'b0;
        overlay_rgb = 12'h000;

        if (settings_active) begin
            // Separating lines at y = 322 and y = 396 (full width)
            if ((py == 9'd322) || (py == 9'd396)) begin
                overlay_en  = 1'b1; overlay_rgb = BRIGHTBLUE;
            end
            if ((py == 9'd323) || (py == 9'd321) || (py == 9'd323) || (py == 9'd395) || (py == 9'd397)) begin
                overlay_en  = 1'b1; overlay_rgb = BORDERBLUE;
            end
            if ((py == 9'd324) || (py == 9'd320) || (py == 9'd324) || (py == 9'd394) || (py == 9'd398)) begin
                overlay_en  = 1'b1; overlay_rgb = DARKBLUE;
            end


            // Upper vertical line from (313,322) to (313,395)
            if ((py >= 9'd322) && (py <= 9'd396) && (px == 10'd313)) begin
                overlay_en  = 1'b1; overlay_rgb = BRIGHTBLUE;
            end
            if ((py >= 9'd323) && (py <= 9'd394) && (px == 10'd312)) begin
                overlay_en  = 1'b1; overlay_rgb = BORDERBLUE;
            end
            if ((py >= 9'd324) && (py <= 9'd393) && (px == 10'd311)) begin
                overlay_en  = 1'b1; overlay_rgb = DARKBLUE;
            end
            if ((py >= 9'd323) && (py <= 9'd394) && (px == 10'd314)) begin
                overlay_en  = 1'b1; overlay_rgb = BORDERBLUE;
            end
            if ((py >= 9'd324) && (py <= 9'd393) && (px == 10'd315)) begin
                overlay_en  = 1'b1; overlay_rgb = DARKBLUE;
            end
            
            // // Vertical black lines downwards from (93,395), (262,395), (373,395), (548,395)
            // if (((py >= 9'd396 && py <= 9'd441) || py >= 470) && 
            //         (px == 10'd93 || px == 10'd262 || px == 10'd373 || px == 10'd548)) begin
            //     overlay_en  = 1'b1; overlay_rgb = BRIGHTBLUE;
            // end
            // if (((py >= 9'd397 && py <= 9'd441) || py >= 470) && 
            //         (px == 10'd92 || px == 10'd94 || px == 10'd261 || px == 10'd263 || px == 10'd372 || px == 10'd374 || px == 10'd547 ||  px == 10'd549)) begin
            //     overlay_en  = 1'b1; overlay_rgb = BORDERBLUE;
            // end
            // if (((py >= 9'd398 && py <= 9'd441) || py >= 470) && 
            //         (px == 10'd91 || px == 10'd95 || px == 10'd260 || px == 10'd264 || px == 10'd371 || px == 10'd375 || px == 10'd546 ||  px == 10'd550)) begin
            //     overlay_en  = 1'b1; overlay_rgb = DARKBLUE;
            // end

            // --- Rectangle at (33,348) size 89x42 with vertical bisector ---
            if ((py == 9'd348) || (py == (9'd348 + 9'd42 - 1))) begin
                if ((px >= 10'd33) && (px < (10'd33 + 10'd89))) begin
                    overlay_en = 1'b1; 
                    overlay_rgb = BLACK;
                end
            end
            if ((px == 10'd33) || (px == (10'd33 + 10'd89 - 1))) begin
                if ((py >= 9'd348) && (py < (9'd348 + 9'd42))) begin
                    overlay_en = 1'b1; overlay_rgb = BLACK;
                end
            end
            // Vertical bisecting line (floor(89/2) = 44 px from left)
            if ((px == (10'd33 + 10'd44)) && (py >= 9'd348) && (py < (9'd348 + 9'd42))) begin
                overlay_en = 1'b1; overlay_rgb = BLACK;
            end
            // Filled rectangles inside the left box
            if ((px >= 10'd33) && (px < (10'd33 + 10'd44)) &&          // 0…43 px wide
                (py >= 9'd348) && (py < (9'd348 + 9'd42))) begin        // full height
                overlay_en  = 1'b1;
                overlay_rgb = {start_blue_val, start_green_val, start_red_val};
            end
            if ((px >= (10'd33 + 10'd44 + 1'b1)) &&                     // 45…88 px wide
                (px < (10'd33 + 10'd89)) &&
                (py >= 9'd348) && (py < (9'd348 + 9'd42))) begin
                overlay_en  = 1'b1;
                overlay_rgb = {end_blue_val, end_green_val, end_red_val};
            end


            // Borders first (drop zones, bottom boxes, and change-view toggles)
            if (in_pre_border) begin
                overlay_en  = 1'b1; overlay_rgb = CYAN;
            end else if (in_morph_border) begin
                overlay_en  = 1'b1; overlay_rgb = MAGENTA;
            end else if (in_cam_border) begin
                overlay_en  = 1'b1; overlay_rgb = GREY;
            end else if (in_bmp_border) begin
                overlay_en  = 1'b1; overlay_rgb = GREY;
            end else if (in_ufds_border) begin
                overlay_en  = 1'b1; overlay_rgb = GREEN;
            end else if (in_tog0_border || in_tog1_border || in_tog2_border || in_tog3_border) begin
                overlay_en  = 1'b1; overlay_rgb = GREY;
            end

            // Do NOT fill movable boxes here anymore (GB/MF/EA/EB/DA/DB).
            // Their visuals are now drawn by the BRAM overlay layer in Top, with front_idx used for z-order.

            if (cv_flags[0] && (px >= TOG0_X) && (px < (TOG0_X + TOG_W)) && (py >= TOG_Y) && (py < (TOG_Y + TOG_H))) begin
                overlay_en = 1'b1; overlay_rgb = BLACK;
            end
            if (cv_flags[1] && (px >= TOG1_X) && (px < (TOG1_X + TOG_W)) && (py >= TOG_Y) && (py < (TOG_Y + TOG_H))) begin
                overlay_en = 1'b1; overlay_rgb = BLACK;
            end
            if (cv_flags[2] && (px >= TOG2_X) && (px < (TOG2_X + TOG_W)) && (py >= TOG_Y) && (py < (TOG_Y + TOG_H))) begin
                overlay_en = 1'b1; overlay_rgb = BLACK;
            end
            if (cv_flags[3] && (px >= TOG3_X) && (px < (TOG3_X + TOG_W)) && (py >= TOG_Y) && (py < (TOG_Y + TOG_H))) begin
                overlay_en = 1'b1; overlay_rgb = BLACK;
            end

            //        if ((front_idx == 3'd0 && in0) || (front_idx == 3'd1 && in1) || (front_idx == 3'd2 && in2)
            //     || (front_idx == 3'd3 && in3) || (front_idx == 3'd4 && in4) || (front_idx == 3'd5 && in5)) begin
            //     overlay_en  = 1'b1;
            //     case (front_idx)
            //         3'd0: overlay_rgb = BLACK;
            //         3'd1: overlay_rgb = CYAN;
            //         3'd2: overlay_rgb = MAGENTA;
            //         3'd3: overlay_rgb = GREY;
            //         3'd4: overlay_rgb = WHITE;
            //         3'd5: overlay_rgb = YELLOW;
            //         default: overlay_rgb = WHITE;
            //     endcase
            // end else begin
            //     // Otherwise, draw in default priority order skipping the front_idx
            //     if ((front_idx != 3'd0) && in0) begin overlay_en = 1'b1; overlay_rgb = BLACK; end
            //     else if ((front_idx != 3'd1) && in1) begin overlay_en = 1'b1; overlay_rgb = CYAN; end
            //     else if ((front_idx != 3'd2) && in2) begin overlay_en = 1'b1; overlay_rgb = MAGENTA; end
            //     else if ((front_idx != 3'd3) && in3) begin overlay_en = 1'b1; overlay_rgb = GREY; end
            //     else if ((front_idx != 3'd4) && in4) begin overlay_en = 1'b1; overlay_rgb = WHITE; end
            //     else if ((front_idx != 3'd5) && in5) begin overlay_en = 1'b1; overlay_rgb = YELLOW; end
            // end

            // // Draw toggled box fill last so it sits on top of everything
            // if (cv_flags[0] && (px >= TOG0_X) && (px < (TOG0_X + TOG_W)) && (py >= TOG_Y) && (py < (TOG_Y + TOG_H))) begin
            //     overlay_en = 1'b1; overlay_rgb = BLACK;
            // end
            // if (cv_flags[1] && (px >= TOG1_X) && (px < (TOG1_X + TOG_W)) && (py >= TOG_Y) && (py < (TOG_Y + TOG_H))) begin
            //     overlay_en = 1'b1; overlay_rgb = BLACK;
            // end
            // if (cv_flags[2] && (px >= TOG2_X) && (px < (TOG2_X + TOG_W)) && (py >= TOG_Y) && (py < (TOG_Y + TOG_H))) begin
            //     overlay_en = 1'b1; overlay_rgb = BLACK;
            // end
            // if (cv_flags[3] && (px >= TOG3_X) && (px < (TOG3_X + TOG_W)) && (py >= TOG_Y) && (py < (TOG_Y + TOG_H))) begin
            //     overlay_en = 1'b1; overlay_rgb = BLACK;
            // end
        end
    end

    // Click pulses exported to Top: generated from left_edge in VGA coords
    assign cam_box_click    = settings_active && left_edge && in_cam_rect;
    assign bitmap_box_click = settings_active && left_edge && in_bitmap_rect;
    assign ufds_box_click   = settings_active && left_edge && in_ufds_rect;

endmodule
