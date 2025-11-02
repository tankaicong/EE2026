`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2025 04:45:31
// Design Name: 
// Module Name: generate_bram_overlay
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


module generate_bram_overlay(
    input clk,                      // 100MHz clk
    input clk25,                    // 25MHz clk
    input en,                       // Enable overlay generation
    input [59:0] x,                 // x input for all 6 boxes (10 bits)
    input [53:0] y,                 // y input for all 6 boxes (9 bits)
    input [9:0] frame_x,            // current x coord in frame (0..639) from VGA
    input [9:0] frame_y,            // current y coord in frame (0..479) from VGA
    input [2:0] front_idx,          // which movable box is foreground (draw on top when overlapping)
    output reg to_write,                // HIGH for write to VGA, LOW for no write
    output [3:0] image_pixel        // BRAM color output (encoded, decode in Top.v)
);
    /* Takes in X and Y coordinate for movable boxes in order:
    Gaussian, Median, Erode 1, Erode 2, Dilate 1, Dilate 2
    Outputs to_write signal HIGH when any overlay pixel is to be drawn
    and the corresponding BRAM pixel data address for that overlay
    en is used to turn on/off the overlay */
    // Access BRAM
    reg [17:0] overlay_addr;
    Single_Port_Buffer single_buffer(
        .clk(clk25),
        .addr(overlay_addr),
        .dout(image_pixel)
    );

    // Localparams for pixels
    localparam integer NUM = 23;        // Number of things to generate
    localparam integer NUM_ACTL = 29;   // + 6 moving, just to store address of moving parts
    localparam integer ATTRS = 5;       // Number of attributes per thing
    localparam integer lookup [0 : (NUM_ACTL * ATTRS) - 1] = {
        // X, Y, x-size, y-size, bram_offset            // Index, desc, start-end row in csv, start addr, num rows (= numpixels), next addr (start + rows)
        // 128, 348, 12, 12, 0,           // 0 Red square, 1-12, 0, 144, 144
        // 128, 363, 12, 12, 144,         // 1 Green square, 13-24, 144, 144, 288
        // 128, 378, 12, 12, 288,         // 2 Blue square, 25-36, 288, 144, 432
        //  33, 330, 81, 12, 432,         // 3 Text "Threshold", 37-48, 432, 972, 1404
        //  39, 401, 71, 12, 1404,        // 4 Text "Raw Feed", 49-77, 1404, 1044, 2448
        //  33, 435, 47, 34, 2448,        // 5 Text "Camera", 78-111, 2256, 1598, 3854
        // 120, 410, 112, 18, 3854,       // 6  Text "Preprocessing", 112-129, 3854, 2016, 5870
        // 105, 435, 148, 1, 5870,        // 7 Blue horizontal preprocessing, 130, 5870, 148, 6018
        // 105, 468, 148, 1, 5870,        // 8 Blue horizontal preprocessing, (no additional)
        // 105, 436,  1, 32, 6018,        // 9 Blue vertical preprocessing, 131-162, 6018, 32, 6050
        // 251, 436,  1, 32, 6018,        // 10 Red vertical preprocessing, (no additional)
        // 262, 410, 105, 18, 6050,       // 11 Text "Thresholding" 163-180, 6050, 1890, 7940
        // 278, 435, 72,  34, 7940,       // 12 Text "BITMAP" + square, 181-214, 7940, 2448, 10388
        // 410, 410, 95, 18, 10388,       // 13 Text "Morphology", 215-232, 10388, 1710, 12098
        // 558, 400, 77, 30, 12948,       // 14 Text "Operations", 216-245, 12948, 2310, 15258
        // 558, 435, 72, 34, 15258,       // 15 Text "UFDS"  + square, 246-279, 15258, 2448, 17706
        // 320, 330, 196, 18, 17706,      // 16 Text "Image Processing Blocks", 280-297, 17706, 3528, 21234
        // 320, 352, 72, 34, 21234,       // 17 Text "Gaussian" + square, 298-331, 21234, 2448, 23682
        // 394, 352, 72, 34, 23682,       // 18 Text "Median" + square, 332-365, 23682, 2448, 26130      NOTE: ONLY USING BRAM ADDR
        // 468, 352, 40, 34, 26130,       // 19 Text "Erode 1" + square, 366-399, 26130, 1360, 27490     NOTE: ONLY USING BRAM ADDR
        // 510, 352, 40, 34, 26130,       // 20 Text "Erode 2" + square, reuse                           NOTE: ONLY USING BRAM ADDR
        // 552, 352, 40, 34, 27490,       // 21 Text "Dilate 1" + square, 400-433, 27490, 1360, 28850    NOTE: ONLY USING BRAM ADDR
        // 594, 352, 40, 34, 27490        // 22 Text "Dilate 2" + square, reuse                          NOTE: ONLY USING BRAM ADDR
        128, 348, 12, 12, 0,            // 0 Red square
        128, 363, 12, 12, 144,          // 1 Green square
        128, 378, 12, 12, 288,          // 2 Blue square
        33, 330, 81, 12, 432,           // 3 Text "Threshold"
        39, 401, 36, 29, 1404,          // 4 Text "Raw Feed"
        33, 435, 47, 34, 2448,          // 5 Text "Camera"
        124, 410, 112, 18, 4046,        // 6 Text "Preprocessing"
        80, 448, 25, 8, 6062,           // 7 Yellow arrow
        253, 448, 25, 8, 6062,          // 8 Yellow arrow
        350, 448, 25, 8, 6062,          // 9 Yellow arrow
        539, 448, 25, 8, 6062,          // 10 Yellow arrow
        106, 451, 146, 2, 6262,         // 11 Yellow short rectangle
        376, 451, 162, 2, 6262,         // 12 Yellow long rectangle
        85, 435, 15, 12, 6585,          // 13 Eye 1
        258, 435, 15, 12, 6585,         // 14 Eye 2
        355, 435, 15, 12, 6585,         // 15 Eye 3
        544, 435, 15, 12, 6585,         // 16 Eye 4
        262, 410, 105, 18, 6766,        // 17 Text "Thresholding"
        278, 435, 72, 34, 8656,         // 18 Text "BITMAP" + square
        410, 410, 95, 18, 11104,        // 19 Text "Morphology"
        558, 401, 77, 29, 12814,        // 20 Text "Object Detection"
        564, 435, 66, 34, 15047,        // 21 Text "UFDS"  + square
        320, 330, 196, 18, 17291,       // 22 Text "Image Processing Blocks"
        320, 352, 72, 34, 20819,        // 23 Text "Gaussian" + square
        394, 352, 72, 34, 23267,        // 24 Text "Median" + square
        468, 352, 40, 34, 25715,        // 25 Text "Erode 1" + square
        510, 352, 40, 34, 25715,        // 26 Text "Erode 2" + square
        552, 352, 40, 34, 27075,        // 27 Text "Dilate 1" + square
        594, 352, 40, 34, 27075         // 28 Text "Dilate 2" + square
    };

    wire [0 : (NUM - 1)] gen;
    wire [0 : (NUM - 1)] gen_1;
    genvar gi;
    generate
        for (gi = 0; gi < NUM; gi = gi + 1) begin : GEN_OVERLAYS
            assign gen[gi] = (frame_x >= (lookup[gi*ATTRS]) && frame_x <= (lookup[gi*ATTRS] + lookup[gi*ATTRS + 2])) && (frame_y >= lookup[gi*ATTRS + 1] && frame_y < (lookup[gi*ATTRS + 1] + lookup[gi*ATTRS + 3]));
            assign gen_1[gi] = (frame_x > (lookup[gi*ATTRS]) && frame_x <= (lookup[gi*ATTRS] + lookup[gi*ATTRS + 2])) && (frame_y >= lookup[gi*ATTRS + 1] && frame_y < (lookup[gi*ATTRS + 1] + lookup[gi*ATTRS + 3]));
        end
    endgenerate

    wire gauss_sq, gauss_sq_1;
    wire med_sq, med_sq_1;
    wire erode_1_sq, erode_1_sq_1;
    wire erode_2_sq, erode_2_sq_1;
    wire dilate_1_sq, dilate_1_sq_1;
    wire dilate_2_sq, dilate_2_sq_1;

    assign gauss_sq = (frame_x >= gauss_x && frame_x <= (gauss_x + lookup[(NUM_ACTL - 6)*ATTRS + 2])) && (frame_y >= gauss_y && frame_y < (gauss_y + lookup[(NUM_ACTL - 6)*ATTRS + 3]));
    assign gauss_sq_1 = (frame_x > gauss_x && frame_x <= (gauss_x + lookup[(NUM_ACTL - 6)*ATTRS + 2])) && (frame_y >= gauss_y && frame_y < (gauss_y + lookup[(NUM_ACTL - 6)*ATTRS + 3]));
    assign med_sq = (frame_x >= med_x && frame_x <= (med_x + lookup[(NUM_ACTL - 5)*ATTRS + 2])) && (frame_y >= med_y && frame_y < (med_y + lookup[(NUM_ACTL - 5)*ATTRS + 3]));
    assign med_sq_1 = (frame_x > med_x && frame_x <= (med_x + lookup[(NUM_ACTL - 5)*ATTRS + 2])) && (frame_y >= med_y && frame_y < (med_y + lookup[(NUM_ACTL - 5)*ATTRS + 3]));
    assign erode_1_sq = (frame_x >= erode_1_x && frame_x <= (erode_1_x + lookup[(NUM_ACTL - 4)*ATTRS + 2])) && (frame_y >= erode_1_y && frame_y < (erode_1_y + lookup[(NUM_ACTL - 4)*ATTRS + 3]));
    assign erode_1_sq_1 = (frame_x > erode_1_x && frame_x <= (erode_1_x + lookup[(NUM_ACTL - 4)*ATTRS + 2])) && (frame_y >= erode_1_y && frame_y < (erode_1_y + lookup[(NUM_ACTL - 4)*ATTRS + 3]));
    assign erode_2_sq = (frame_x >= erode_2_x && frame_x <= (erode_2_x + lookup[(NUM_ACTL - 3)*ATTRS + 2])) && (frame_y >= erode_2_y && frame_y < (erode_2_y + lookup[(NUM_ACTL - 3)*ATTRS + 3]));
    assign erode_2_sq_1 = (frame_x > erode_2_x && frame_x <= (erode_2_x + lookup[(NUM_ACTL - 3)*ATTRS + 2])) && (frame_y >= erode_2_y && frame_y < (erode_2_y + lookup[(NUM_ACTL - 3)*ATTRS + 3]));
    assign dilate_1_sq = (frame_x >= dilate_1_x && frame_x <= (dilate_1_x + lookup[(NUM_ACTL - 2)*ATTRS + 2])) && (frame_y >= dilate_1_y && frame_y < (dilate_1_y + lookup[(NUM_ACTL - 2)*ATTRS + 3]));
    assign dilate_1_sq_1 = (frame_x > dilate_1_x && frame_x <= (dilate_1_x + lookup[(NUM_ACTL - 2)*ATTRS + 2])) && (frame_y >= dilate_1_y && frame_y < (dilate_1_y + lookup[(NUM_ACTL - 2)*ATTRS + 3]));
    assign dilate_2_sq = (frame_x >= dilate_2_x && frame_x <= (dilate_2_x + lookup[(NUM_ACTL - 1)*ATTRS + 2])) && (frame_y >= dilate_2_y && frame_y < (dilate_2_y + lookup[(NUM_ACTL - 1)*ATTRS + 3]));
    assign dilate_2_sq_1 = (frame_x > dilate_2_x && frame_x <= (dilate_2_x + lookup[(NUM_ACTL - 1)*ATTRS + 2])) && (frame_y >= dilate_2_y && frame_y < (dilate_2_y + lookup[(NUM_ACTL - 1)*ATTRS + 3]));

    reg [9:0] gauss_x, med_x, erode_1_x, erode_2_x, dilate_1_x, dilate_2_x;
    reg [8:0] gauss_y, med_y, erode_1_y, erode_2_y, dilate_1_y, dilate_2_y;
    
    always @ (posedge clk) begin
        dilate_2_x <= x[59:50];
        dilate_1_x <= x[49:40];
        erode_2_x <= x[39:30];
        erode_1_x<= x[29:20];
        med_x <= x[19:10];
        gauss_x <= x[9:0];

        dilate_2_y <= y[53:45];
        dilate_1_y <= y[44:36];
        erode_2_y <= y[35:27];
        erode_1_y <= y[26:18];
        med_y <= y[17:9];
        gauss_y <= y[8:0];
    end

    integer i;
    reg [2:0] sel; // 0:gauss 1:median 2:erode1 3:erode2 4:dilate1 5:dilate2 7:none
    always @ (*) begin
        // Default: resolve static elements (non-overlapping)
        for (i = 0; i < NUM; i = i + 1) begin
            if (gen[i]) begin
                overlay_addr = ((frame_y - lookup[i*ATTRS + 1]) * lookup[i*ATTRS + 2]) + (frame_x - lookup[i*ATTRS]) + lookup[i*ATTRS + 4];
            end
        end

        // Resolve movable boxes with foreground priority for clicked one
        sel = 3'd7; // none
        // Is the foreground box under the pixel?
        if      ((front_idx == 3'd0) && gauss_sq)      sel = 3'd0;
        else if ((front_idx == 3'd1) && med_sq)        sel = 3'd1;
        else if ((front_idx == 3'd2) && erode_1_sq)    sel = 3'd2;
        else if ((front_idx == 3'd3) && erode_2_sq)    sel = 3'd3;
        else if ((front_idx == 3'd4) && dilate_1_sq)   sel = 3'd4;
        else if ((front_idx == 3'd5) && dilate_2_sq)   sel = 3'd5;
        // Otherwise fall back to fixed z-order
        else if (gauss_sq)      sel = 3'd0;
        else if (med_sq)        sel = 3'd1;
        else if (erode_1_sq)    sel = 3'd2;
        else if (erode_2_sq)    sel = 3'd3;
        else if (dilate_1_sq)   sel = 3'd4;
        else if (dilate_2_sq)   sel = 3'd5;

        case (sel)
            3'd0: overlay_addr = ((frame_y - gauss_y) * lookup[(NUM_ACTL - 6)*ATTRS + 2]) + (frame_x - gauss_x) + lookup[(NUM_ACTL - 6)*ATTRS + 4];
            3'd1: overlay_addr = ((frame_y - med_y) * lookup[(NUM_ACTL - 5)*ATTRS + 2]) + (frame_x - med_x) + lookup[(NUM_ACTL - 5)*ATTRS + 4];
            3'd2: overlay_addr = ((frame_y - erode_1_y) * lookup[(NUM_ACTL - 4)*ATTRS + 2]) + (frame_x - erode_1_x) + lookup[(NUM_ACTL - 4)*ATTRS + 4];
            3'd3: overlay_addr = ((frame_y - erode_2_y) * lookup[(NUM_ACTL - 3)*ATTRS + 2]) + (frame_x - erode_2_x) + lookup[(NUM_ACTL - 3)*ATTRS + 4];
            3'd4: overlay_addr = ((frame_y - dilate_1_y) * lookup[(NUM_ACTL - 2)*ATTRS + 2]) + (frame_x - dilate_1_x) + lookup[(NUM_ACTL - 2)*ATTRS + 4];
            3'd5: overlay_addr = ((frame_y - dilate_2_y) * lookup[(NUM_ACTL - 1)*ATTRS + 2]) + (frame_x - dilate_2_x) + lookup[(NUM_ACTL - 1)*ATTRS + 4];
            default: /* keep last overlay_addr from static elements */ ;
        endcase
    end

    // to_write goes high when overlay enabled and current x/y count is within range
    wire to_write_int;
    assign to_write_int = en ? ((|gen) || gauss_sq || med_sq || erode_1_sq || erode_2_sq || dilate_1_sq || dilate_2_sq) : 1'b0;

    always @ (posedge clk25) begin
        to_write <= to_write_int;
    end
endmodule
