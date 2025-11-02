module letter_top (
    input clk,
    // input [59:0] x,
    // input [53:0] y,
    // input [15:0] sw,
    // input [18:0] gauss,
    // input [18:0] med,
    // input [18:0] erode_1,
    // input [18:0] erode_2,
    // input [18:0] dilate_1,
    // input [18:0] dilate_2,
    output vga_Hsync,
    output vga_Vsync,
    output [11:0] vga_RGB,    //4-bit red, 4-bit green, 4-bit blue
    // output [7:0] seg,
    // output [3:0] an,
    output reg [15:0] led
);
    // ----------- CLOCKS ----------- //
    // Generate 25 MHz (for VGA) and 24 MHz (for camera) clocks from 100 MHz input
    wire clk_status, clk25, clk24, clk50;
    display_clocks disp_clocks(
        .clk_in1(clk),
        .clk_out1(clk25),
        .clk_out2(clk24),
        .clk_out3(clk50),
        .reset(btnU),
        .locked(clk_status)
    );

    // reg [15:0] ss_output;
    // Seven_Seg ssd (
    //     .clk(clk),
    //     .num(ss_output),
    //     .dd(4'b0000),
    //     .seg(seg),
    //     .an(an)
    // );

    // ----------- VGA CONTROLLER ----------- //
    // Wire for BRAM address from VGA controller
    wire [16:0] frame_addr;             // logical 0..(306*240-1)
    wire [3:0] image_pixel;            // 12-bit RGB444 from BRAM
    reg [11:0] frame_pixel;            // RGB444 to VGA
    wire [9:0] frame_x;  // current x coord in frame (0..639)
    wire [9:0] frame_y;  // current y coord in frame (0..479)
    wire active_area;

    VGA_Controller vga(
        .clk25(clk25),
        .vga_red(vga_RGB[11:8]),
        .vga_green(vga_RGB[7:4]), 
        .vga_blue(vga_RGB[3:0]),
        .vga_hsync(vga_Hsync),
        .vga_vsync(vga_Vsync),
        .frame_addr(frame_addr),
        .frame_x(frame_x),
        .frame_y(frame_y),
        .frame_pixel(frame_pixel),
        .active_area(active_area)
    );
    // image_mem frame_buffer( 
    //     // .clka(ov7670_pclk),
    //     .clka(clk25),
    //     .wea(1'b0),
    //     .addra(18'b0),
    //     .dina(12'b0),          // write RGB444 (raw on we cycles, filtered on alt cycles)
    //     // .clkb(clk50),
    //     .clkb(clk25),
    //     // .clkb(clk),
    //     // .addrb(red_sq_addr),
    //     .addrb(overlay_addr),
    //     .doutb(image_pixel)   // read RGB444
    // );

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
        85, 435, 15, 12, 6586,          // 13 Eye 1
        258, 435, 15, 12, 6586,         // 14 Eye 2
        355, 435, 15, 12, 6586,         // 15 Eye 3
        544, 435, 15, 12, 6586,         // 16 Eye 4
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

    reg [9:0] gauss_x = 10'd320;
    reg [8:0] gauss_y = 9'd352;
    reg [9:0] med_x = 10'd394;
    reg [8:0] med_y = 9'd352;
    reg [9:0] erode_1_x = 10'd468;
    reg [8:0] erode_1_y = 9'd352;
    reg [9:0] erode_2_x = 10'd510;
    reg [8:0] erode_2_y = 9'd352;
    reg [9:0] dilate_1_x = 10'd552;
    reg [8:0] dilate_1_y = 9'd352;
    reg [9:0] dilate_2_x = 10'd594;
    reg [8:0] dilate_2_y = 9'd352;

    // reg [9:0] gauss_x, gauss_y, med_x, med_y,
    //           erode_1_x, erode_1_y, erode_2_x, erode_2_y,
    //           dilate_1_x, dilate_1_y, dilate_2_x, dilate_2_y;
    
    // always @ (posedge clk) begin
    //     // if (sw == 0) gauss_x <= 10'd320;
    //     // else gauss_x <= sw[9:0];
    //     gauss_x <= x[59:50];
    //     med_x <= x[49:40];
    //     erode_1_x <= x[39:30];
    //     erode_2_x <= x[29:20];
    //     dilate_1_x <= x[19:10];
    //     dilate_2_x <= x[9:0];
    //     gauss_y <= y[53:45];
    //     med_y <= y[44:36];
    //     erode_1_y <= y[35:27];
    //     erode_2_y <= y[26:18];
    //     dilate_1_y <= y[17:9];
    //     dilate_2_y <= y[8:0];
    // end

    integer i;
    always @ (*) begin
        for (i = 0; i < NUM; i = i + 1) begin
            if (gen[i]) begin
                overlay_addr = ((frame_y - lookup[i*ATTRS + 1]) * lookup[i*ATTRS + 2]) + (frame_x - lookup[i*ATTRS]) + lookup[i*ATTRS + 4];
            end
        end
        if (gauss_sq) begin
            overlay_addr = ((frame_y - gauss_y) * lookup[(NUM_ACTL - 6)*ATTRS + 2]) + (frame_x - gauss_x) + lookup[(NUM_ACTL - 6)*ATTRS + 4];
        end
        else if (med_sq) begin
            overlay_addr = ((frame_y - med_y) * lookup[(NUM_ACTL - 5)*ATTRS + 2]) + (frame_x - med_x) + lookup[(NUM_ACTL - 5)*ATTRS + 4];
        end
        else if (erode_1_sq) begin
            overlay_addr = ((frame_y - erode_1_y) * lookup[(NUM_ACTL - 4)*ATTRS + 2]) + (frame_x - erode_1_x) + lookup[(NUM_ACTL - 4)*ATTRS + 4];
        end
        else if (erode_2_sq) begin
            overlay_addr = ((frame_y - erode_2_y) * lookup[(NUM_ACTL - 3)*ATTRS + 2]) + (frame_x - erode_2_x) + lookup[(NUM_ACTL - 3)*ATTRS + 4];
        end
        else if (dilate_1_sq) begin
            overlay_addr = ((frame_y - dilate_1_y) * lookup[(NUM_ACTL - 2)*ATTRS + 2]) + (frame_x - dilate_1_x) + lookup[(NUM_ACTL - 2)*ATTRS + 4];
        end
        else if (dilate_2_sq) begin
            overlay_addr = ((frame_y - dilate_2_y) * lookup[(NUM_ACTL - 1)*ATTRS + 2]) + (frame_x - dilate_2_x) + lookup[(NUM_ACTL - 1)*ATTRS + 4];
        end
        // else begin
        //     overlay_addr = 18'd0;
        // end
    end
    // wire [17:0] overlay_addr = (frame_x >= 111 && frame_x <= (111 + 12) && frame_y >= 264 && frame_y < (264 + 12)) ?
    //     (frame_y - 264) * 12 + (frame_x - 111) : 18'd200;
    always @ (posedge clk25) begin
        // Global overlays (drawn last so they appear above other graphics)
        // if (frame_x == 0 || frame_x == 639 || frame_y == 0 || frame_y == 479) begin
        //     frame_pixel <= 12'hF00; // white border
        // end
        // else if (frame_x > 111 && frame_x <= (111 + 12) && frame_y >= 264 && frame_y < (264 + 12)) begin
        // else if (|gen_1) begin
        if (|gen_1 || gauss_sq_1 || med_sq_1 || erode_1_sq_1 || erode_2_sq_1 || dilate_1_sq_1 || dilate_2_sq_1) begin
            if (image_pixel == 4'h0) frame_pixel <= 12'h000;
            else if (image_pixel == 4'h1) frame_pixel <= 12'hFFF;
            else if (image_pixel == 4'h2) frame_pixel <= 12'h00F;
            else if (image_pixel == 4'h3) frame_pixel <= 12'h0F0;
            else if (image_pixel == 4'h4) frame_pixel <= 12'hF00;
            else if (image_pixel == 4'h5) frame_pixel <= 12'hFF0;
            else if (image_pixel == 4'h6) frame_pixel <= 12'hF0F;
            else if (image_pixel == 4'h7) frame_pixel <= 12'h0FF;
            else if (image_pixel == 4'h8) frame_pixel <= 12'h57B;
            else if (image_pixel == 4'h9) frame_pixel <= 12'hACE;
            else if (image_pixel == 4'hA) frame_pixel <= 12'hBDE;
            else if (image_pixel == 4'hB) frame_pixel <= 12'hEEB;
            // else if (image_pixel == 4'hC) frame_pixel <= 12'h555;
            // else if (image_pixel == 4'hD) frame_pixel <= 12'hDDD;
            // else if (image_pixel == 4'hE) frame_pixel <= 12'h777;
            else if (image_pixel == 4'hF) frame_pixel <= 12'h000;
        end
        else begin
            frame_pixel <= 12'h0FF;
        end
    end
endmodule