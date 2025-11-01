module generate_overlay(
    input clk,              // 100MHz clk
    input en,               // Enable overlay generation
    input [59:0] x,         // x input for all 6 boxes
    input [53:0] y,         // y input for all 6 boxes
    input [9:0] frame_x,     // current x coord in frame (0..639) from VGA
    input [9:0] frame_y,     // current y coord in frame (0..479) from VGA
    output to_write,        // HIGH for write to VGA, LOW for no write
    output image_pixel      // BRAM color output (encoded, decode in Top.v)
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
    localparam integer NUM = 17;        // Number of things to generate
    localparam integer NUM_ACTL = 23;   // + 6 moving, just to store address of moving parts
    localparam integer ATTRS = 5;       // Number of attributes per thing
    localparam integer lookup [0 : (NUM_ACTL * ATTRS) - 1] = {
        // X, Y, x-size, y-size, bram_offset            // Index, desc, start-end row in csv, start addr, num rows (= numpixels), next addr (start + rows)
        111, 348, 12, 12, 0,           // 0 Red square, 0, 144, 144
        111, 363, 12, 12, 144,         // 1 Green square, 144, 144, 288
        111, 378, 12, 12, 288,         // 2 Blue square, 288, 144, 432
         13, 330, 81, 12, 432,         // 3 Text "Threshold", 432, 972, 1404
         12, 410, 71, 12, 1404,        // 4 Text "Raw Feed", 49-60, 1404, 852, 2256
         11, 435, 72, 34, 2256,        // 5 Text "Camera", 61-94, 2256, 2448, 4704
        124, 410, 112, 18, 4704,       // 6  Text "Preprocessing", 95-112, 4686, 2016, 6720
        104, 435, 148, 1, 6720,        // 7 Blue horizontal preprocessing, 113, 6720, 148, 6868
        104, 468, 148, 1, 6720,        // 8 Blue horizontal preprocessing, (no additional)
        104, 436,  1, 32, 6868,        // 9 Blue vertical preprocessing, 114-145, 6868, 32, 6900
        251, 436,  1, 32, 6868,        // 10 Red vertical preprocessing, (no additional)
        268, 410, 105, 18, 6900,       // 11 Text "Thresholding" 146-163, 6900, 1890, 8790
        285, 435, 72,  34, 8790,       // 12 Text "BITMAP" + square, 164-197, 8790, 2448, 11238
        416, 410, 95, 18, 11238,       // 13 Text "Morphology", 198-215, 11238, 1710, 12948
        558, 400, 77, 30, 12948,       // 14 Text "Operations", 216-245, 12948, 2310, 15258
        558, 435, 72, 34, 15258,       // 15 Text "UFDS"  + square, 246-279, 15258, 2448, 17706
        320, 330, 196, 18, 17706,      // 16 Text "Image Processing Blocks", 280-297, 17706, 3528, 21234
        320, 352, 72, 34, 21234,       // 17 Text "Gaussian" + square, 298-331, 21234, 2448, 23682
        394, 352, 72, 34, 23682,       // 18 Text "Median" + square, 332-365, 23682, 2448, 26130      NOTE: ONLY USING BRAM ADDR
        468, 352, 40, 34, 26130,       // 19 Text "Erode 1" + square, 366-399, 26130, 1360, 27490     NOTE: ONLY USING BRAM ADDR
        510, 352, 40, 34, 26130,       // 20 Text "Erode 2" + square, reuse                           NOTE: ONLY USING BRAM ADDR
        552, 352, 40, 34, 27490,       // 21 Text "Dilate 1" + square, 400-433, 27490, 1360, 28850    NOTE: ONLY USING BRAM ADDR
        594, 352, 40, 34, 27490        // 22 Text "Dilate 2" + square, reuse                          NOTE: ONLY USING BRAM ADDR
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

    assign gauss_sq = (frame_x >= gauss_x && frame_x <= (gauss_x + 10'd72)) && (frame_y >= gauss_y && frame_y < (gauss_y + 10'd34));
    assign gauss_sq_1 = (frame_x > gauss_x && frame_x <= (gauss_x + 10'd72)) && (frame_y >= gauss_y && frame_y < (gauss_y + 10'd34));
    assign med_sq = (frame_x >= med_x && frame_x <= (med_x + 10'd72)) && (frame_y >= med_y && frame_y < (med_y + 10'd34));
    assign med_sq_1 = (frame_x > med_x && frame_x <= (med_x + 10'd72)) && (frame_y >= med_y && frame_y < (med_y + 10'd34));
    assign erode_1_sq = (frame_x >= erode_1_x && frame_x <= (erode_1_x + 10'd40)) && (frame_y >= erode_1_y && frame_y < (erode_1_y + 10'd34));
    assign erode_1_sq_1 = (frame_x > erode_1_x && frame_x <= (erode_1_x + 10'd40)) && (frame_y >= erode_1_y && frame_y < (erode_1_y + 10'd34));
    assign erode_2_sq = (frame_x >= erode_2_x && frame_x <= (erode_2_x + 10'd40)) && (frame_y >= erode_2_y && frame_y < (erode_2_y + 10'd34));
    assign erode_2_sq_1 = (frame_x > erode_2_x && frame_x <= (erode_2_x + 10'd40)) && (frame_y >= erode_2_y && frame_y < (erode_2_y + 10'd34));
    assign dilate_1_sq = (frame_x >= dilate_1_x && frame_x <= (dilate_1_x + 10'd40)) && (frame_y >= dilate_1_y && frame_y < (dilate_1_y + 10'd34));
    assign dilate_1_sq_1 = (frame_x > dilate_1_x && frame_x <= (dilate_1_x + 10'd40)) && (frame_y >= dilate_1_y && frame_y < (dilate_1_y + 10'd34));
    assign dilate_2_sq = (frame_x >= dilate_2_x && frame_x <= (dilate_2_x + 10'd40)) && (frame_y >= dilate_2_y && frame_y < (dilate_2_y + 10'd34));
    assign dilate_2_sq_1 = (frame_x > dilate_2_x && frame_x <= (dilate_2_x + 10'd40)) && (frame_y >= dilate_2_y && frame_y < (dilate_2_y + 10'd34));

    reg [9:0] gauss_x, gauss_y, med_x, med_y,
            erode_1_x, erode_1_y, erode_2_x, erode_2_y,
            dilate_1_x, dilate_1_y, dilate_2_x, dilate_2_y;
    
    always @ (posedge clk) begin
        gauss_x <= x[59:50];
        med_x <= x[49:40];
        erode_1_x <= x[39:30];
        erode_2_x <= x[29:20];
        dilate_1_x <= x[19:10];
        dilate_2_x <= x[9:0];
        gauss_y <= y[53:45];
        med_y <= y[44:36];
        erode_1_y <= y[35:27];
        erode_2_y <= y[26:18];
        dilate_1_y <= y[17:9];
        dilate_2_y <= y[8:0];
    end

    integer i;
    always @ (*) begin
        for (i = 0; i < NUM; i = i + 1) begin
            if (gen[i]) begin
                overlay_addr = ((frame_y - lookup[i*ATTRS + 1]) * lookup[i*ATTRS + 2]) + (frame_x - lookup[i*ATTRS]) + lookup[i*ATTRS + 4];
            end
        end
        if (gauss_sq) begin
            overlay_addr = ((frame_y - gauss_y) * 10'd72) + (frame_x - gauss_x) + lookup[17*ATTRS + 4];
        end
        else if (med_sq) begin
            overlay_addr = ((frame_y - med_y) * 10'd72) + (frame_x - med_x) + lookup[18*ATTRS + 4];
        end
        else if (erode_1_sq) begin
            overlay_addr = ((frame_y - erode_1_y) * 10'd40) + (frame_x - erode_1_x) + lookup[19*ATTRS + 4];
        end
        else if (erode_2_sq) begin
            overlay_addr = ((frame_y - erode_2_y) * 10'd40) + (frame_x - erode_2_x) + lookup[20*ATTRS + 4];
        end
        else if (dilate_1_sq) begin
            overlay_addr = ((frame_y - dilate_1_y) * 10'd40) + (frame_x - dilate_1_x) + lookup[21*ATTRS + 4];
        end
        else if (dilate_2_sq) begin
            overlay_addr = ((frame_y - dilate_2_y) * 10'd40) + (frame_x - dilate_2_x) + lookup[22*ATTRS + 4];
        end
    end

    // to_write goes high when overlay enabled and current x/y count is within range
    assign to_write = en ? ((|gen) || gauss_sq || med_sq || erode_1_sq || erode_2_sq || dilate_1_sq || dilate_2_sq) : 1'b0;
endmodule