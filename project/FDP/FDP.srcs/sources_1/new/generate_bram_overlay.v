module generate_bram_overlay(
    input clk,                      // 100MHz clk
    input clk25,                    // 25MHz clk
    input en,                       // Enable overlay generation
    input [59:0] x,                 // x input for all 6 boxes (10 bits)
    input [53:0] y,                 // y input for all 6 boxes (9 bits)
    input [9:0] gauss_t_x,          // x coord of gaussian edu tab
    input [8:0] gauss_t_y,          // y coord of gaussian edu tab
    input [9:0] frame_x,            // current x coord in frame (0..639) from VGA
    input [9:0] frame_y,            // current y coord in frame (0..479) from VGA
    input [2:0] front_idx,          // which movable box is foreground (draw on top when overlapping)
    input [1:0] final_out,          // which view/eye is active (00 CAM, 01 PRE, 10 BITMAP, 11 MORPH)
    input ufds_settings_mode,       // UFDS settings mode active
    output to_write,                // HIGH for write to VGA, LOW for no write
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
    localparam integer NUM_usr = 25;        // Number of user things to generate
    localparam integer NUM_ufds = 63;       // Number of UFDS things to generate
    localparam integer NUM_ACTL = 94;       // (last index + 1) + 6 moving, just to store address of moving parts
    localparam integer ATTRS = 5;           // Number of attributes per thing
    localparam integer lookup [0 : (NUM_ACTL * ATTRS) - 1] = {
        // X, Y, x-size, y-size, bram_offset            // Index, desc, start-end row in csv, start addr, num rows (= numpixels), next addr (start + rows)
        // 128, 348, 12, 12, 0,            // 0 Red square
        // 128, 363, 12, 12, 144,          // 1 Green square
        // 128, 378, 12, 12, 288,          // 2 Blue square
        // 33, 330, 81, 12, 432,           // 3 Text "Threshold"
        // 39, 401, 36, 29, 1404,          // 4 Text "Raw Feed"
        // 40, 446, 34, 12, 2448,          // 5 Text "Camera"
        // 124, 410, 112, 18, 2856,        // 6 Text "Preprocessing"
        // 80, 448, 25, 8, 4872,           // 7 Yellow arrow
        // 253, 448, 25, 8, 4872,          // 8 Yellow arrow
        // 350, 448, 25, 8, 4872,          // 9 Yellow arrow
        // 539, 448, 25, 8, 4872,          // 10 Yellow arrow
        // 106, 451, 146, 2, 5072,         // 11 Yellow short rectangle
        // 376, 451, 162, 2, 5072,         // 12 Yellow long rectangle
        // 85, 435, 15, 12, 5396,          // 13 Eye 1 (default open)
        // 258, 435, 15, 12, 5576,         // 14 Eye 2 (default closed)
        // 355, 435, 15, 12, 5576,         // 15 Eye 3 (default closed)
        // 544, 435, 15, 12, 5576,         // 16 Eye 4 (default closed)
        // 262, 410, 105, 18, 5756,        // 17 Text "Thresholding"
        // 282, 446, 64, 12, 7646,         // 18 Text "BITMAP"
        // 410, 410, 95, 18, 8414,         // 19 Text "Morphology"
        // 558, 401, 77, 29, 10124,        // 20 Text "Object Detection"
        // 578, 446, 38, 12, 12357,        // 21 Text "UFDS"
        // 320, 330, 196, 18, 12813,       // 22 Text "Image Processing Blocks"
        // 362, 296, 281, 319, 16341,      // 23 Gaussian Edu tab

        // 322, 357, 68, 26, 105980,       // 24 Text "Gaussian" + square
        // 402, 357, 56, 26, 107748,       // 25 Text "Median" + square
        // 473, 364, 30, 9, 109204,        // 26 Text "Erode 1" + square
        // 364, 364, 30, 9, 109204,        // 27 Text "Erode 2" + square
        // 554, 364, 36, 9, 109474,        // 28 Text "Dilate 1" + square
        // 596, 364, 36, 9, 109474         // 29 Text "Dilate 2" + square
        128,  348, 12, 12, 0, 	    // 0 red square
        128,  363, 12, 12, 144, 	// 1 green square
        128,  378, 12, 12, 288, 	// 2 blue square
        289,  330, 15, 15, 432, 	// 3 eyedropper
        33,  330, 81, 12, 657, 	    // 4 threshold
        39,  401, 36, 29, 1629, 	// 5 raw feed
        40,  446, 34, 12, 2673, 	// 6 camera
        124,  410, 112, 18, 3081, 	// 7 preprocessing
        80,  448, 25, 8, 5097, 	    // 8 yellow arrow
        253,  448, 25, 8, 5097, 	// 9 yellow arrow 2
        350,  448, 25, 8, 5097, 	// 10 yellow arrow 3
        539,  448, 25, 8, 5097, 	// 11 yellow arrow 4
        106,  451, 146, 2, 5297, 	// 12 yellow rect short
        376,  451, 162, 2, 5297, 	// 13 yellow rect long
        85,  435, 15, 12, 5621, 	// 14 open eye
        258,  435, 15, 12, 5801, 	// 15 eye1
        355,  435, 15, 12, 5801, 	// 16 eye2
        544,  435, 15, 12, 5801, 	// 17 eye3
        262,  410, 105, 18, 5981, 	// 18 thresholding
        282,  446, 64, 12, 7871, 	// 19 bitmap
        410,  410, 95, 18, 8639, 	// 20 morphology
        558,  401, 77, 29, 10349, 	// 21 obj detection
        578,  446, 38, 12, 12582, 	// 22 ufds
        320,  330, 196, 18, 13038, 	// 23 image processing
        362,  296, 281, 27, 16566, 	// 24 gaussian edu tab

        33,  301, 52, 18, 24153, 	// 25 Object
        87,  301, 169, 12, 25089, 	// 26 Det Union Find
        258,  301, 60, 18, 27117, 	// 27 Disjoint
        320,  301, 26, 12, 28197, 	// 28 Set
        24,  379, 35, 12, 28509, 	// 29 Post
        24,  393, 36, 12, 28929, 	// 30 Feed
        36,  435, 15, 12, 5621, 	// 31 open eye 4
        32,  448, 25, 8, 5097, 	    // 32 yellow arrow 5
        62,  444, 49, 12, 29361, 	// 33 Ready
        77,  375, 4, 4, 29949, 	    // 34 Up→right
        69,  331, 146, 18, 29965, 	// 35 Sample neighbour
        100,  353, 83, 12, 32593, 	// 36 Findroots
        81,  372, 13, 10, 33589, 	// 37 small arrow
        105,  372, 13, 10, 33589, 	// 38 small arrow 1
        139,  372, 13, 10, 33589, 	// 39 small arrow 2
        164,  372, 13, 10, 33589, 	// 40 small arrow 3
        95,  371, 9, 12, 33719, 	// 41 L(eft)
        120,  371, 18, 12, 33827, 	// 42 U(p) L(eft)
        153,  371, 10, 12, 34043, 	// 43 U(p)
        178,  371, 21, 12, 34163, 	// 44 U(p) R(ight)
        102,  385, 88, 44, 34415, 	// 45 FR grid
        201,  375, 6, 4, 38287, 	// 46 right→down
        203,  401, 4, 4, 38311, 	// 47 down→right
        214,  398, 13, 10, 33589, 	// 48 small arrow 4
        249,  331, 44, 12, 38327, 	// 49 Union
        224,  346, 96, 17, 38855, 	// 50 Components
        244,  377, 55, 46, 40487, 	// 51 UC grid
        317,  398, 13, 10, 33589, 	// 52 small arrow 5
        332,  331, 55, 17, 43017, 	// 53 Update
        339,  351, 42, 12, 43952, 	// 54 Stats
        334,  377, 55, 46, 44456, 	// 55 US grid
        363,  446, 10, 13, 46986, 	// 56 down arrow 1
        337,  446, 10, 13, 46986, 	// 57 down arrow 2
        338,  442, 6, 4, 38287, 	// 58 right→down 2
        318,  460, 67, 12, 47116, 	// 59 Advance
        195,  458, 92, 12, 47920, 	// 60 Frame end =
        288,  458, 10, 12, 49024, 	// 61 0 (zero)
        120,  447, 36, 12, 49144, 	// 62 bit =
        157,  447, 10, 12, 49024, 	// 63 0 (zero) 2
        77,  471, 4, 4, 49576, 	    // 64 left→up
        74,  458, 10, 13, 49592, 	// 65 up arrow
        85,  396, 3, 12, 49722, 	// 66 1 (one)
        400,  465, 4, 4, 49758, 	// 67 right→up
        400,  401, 4, 4, 49774, 	// 68 up→right
        404,  398, 13, 10, 33589, 	// 69 small arrow 6
        425,  331, 42, 12, 49790, 	// 70 Filter
        432,  346, 29, 12, 50294, 	// 71 and
        421,  361, 50, 12, 50642, 	// 72 Refine
        528,  370, 36, 12, 51242, 	// 73 Area
        508,  388, 76, 18, 51674, 	// 74 Proximity
        409,  459, 92, 12, 47920, 	// 75 Frame end = 2
        503,  459, 3, 12, 49722, 	// 76 1 (one) 2
        489,  398, 13, 10, 33589, 	// 77 small arrow 7
        509,  331, 74, 18, 53042, 	// 78 Bounding
        531,  352, 30, 12, 54374, 	// 79 Box
        510,  423, 3, 18, 54734, 	// 80 num1
        528,  423, 13, 18, 54788, 	// 81 num2
        552,  423, 11, 18, 55022, 	// 82 num3
        574,  423, 15, 18, 55220, 	// 83 num4
        425,  390, 20, 23, 55490, 	// 84 big 4
        458,  391, 20, 21, 55950, 	// 85 big 16
        424,  421, 23, 21, 56370, 	// 86 big 36
        456,  421, 23, 21, 56853, 	// 87 big 64

        322,  357, 68, 26, 57336, 	// 88 gaussian
        402,  357, 56, 26, 59104, 	// 89 median
        473,  364, 30, 9, 60560, 	// 90 erode 1
        515,  364, 30, 9, 60560, 	// 91 erode 2
        554,  364, 36, 9, 60830, 	// 92 dilate 1
        596,  364, 36, 9, 60830 	// 93 dilate 2
    };

    // User settings wires
    wire [0 : (NUM_usr - 1)] gen;
    wire [0 : (NUM_usr - 1)] gen_1;
    genvar gi;
    generate
        for (gi = 0; gi < NUM_usr; gi = gi + 1) begin : GEN_OVERLAYS
            assign gen[gi] = (~ufds_settings_mode) && (frame_x >= (lookup[gi*ATTRS]) && frame_x <= (lookup[gi*ATTRS] + lookup[gi*ATTRS + 2])) && (frame_y >= lookup[gi*ATTRS + 1] && frame_y < (lookup[gi*ATTRS + 1] + lookup[gi*ATTRS + 3]));
            assign gen_1[gi] = (~ufds_settings_mode) && ((frame_x > (lookup[gi*ATTRS]) && frame_x <= (lookup[gi*ATTRS] + lookup[gi*ATTRS + 2])) && (frame_y >= lookup[gi*ATTRS + 1] && frame_y < (lookup[gi*ATTRS + 1] + lookup[gi*ATTRS + 3])));
        end
    endgenerate

    wire [0 : (NUM_ufds - 1)] ufds;
    wire [0 : (NUM_ufds - 1)] ufds_1;
    genvar ui;
    generate
        for (ui = 0; ui < NUM_ufds; ui = ui + 1) begin : UFDS_OVERLAYS
            assign ufds[ui] = ufds_settings_mode && ((frame_x >= (lookup[(NUM_usr + ui)*ATTRS]) && frame_x <= (lookup[(NUM_usr + ui)*ATTRS] + lookup[(NUM_usr + ui)*ATTRS + 2])) && (frame_y >= lookup[(NUM_usr + ui)*ATTRS + 1] && frame_y < (lookup[(NUM_usr + ui)*ATTRS + 1] + lookup[(NUM_usr + ui)*ATTRS + 3])));
            assign ufds_1[ui] = ufds_settings_mode && ((frame_x > (lookup[(NUM_usr + ui)*ATTRS]) && frame_x <= (lookup[(NUM_usr + ui)*ATTRS] + lookup[(NUM_usr + ui)*ATTRS + 2])) && (frame_y >= lookup[(NUM_usr + ui)*ATTRS + 1] && frame_y < (lookup[(NUM_usr + ui)*ATTRS + 1] + lookup[(NUM_usr + ui)*ATTRS + 3])));
        end
    endgenerate

    wire gauss_tab, gauss_tab_1;
    wire gauss_sq, gauss_sq_1;
    wire med_sq, med_sq_1;
    wire erode_1_sq, erode_1_sq_1;
    wire erode_2_sq, erode_2_sq_1;
    wire dilate_1_sq, dilate_1_sq_1;
    wire dilate_2_sq, dilate_2_sq_1;

    // assign gauss_tab = (frame_x >= gauss_tab_x && frame_x <= (gauss_tab_x + lookup[(NUM_ACTL - 7)*ATTRS + 2])) && (frame_y >= gauss_tab_y && frame_y < (gauss_tab_y + lookup[(NUM_ACTL - 7)*ATTRS + 3]));
    // assign gauss_tab_1 = (frame_x > gauss_tab_x && frame_x <= (gauss_tab_x + lookup[(NUM_ACTL - 7)*ATTRS + 2])) && (frame_y >= gauss_tab_y && frame_y < (gauss_tab_y + lookup[(NUM_ACTL - 7)*ATTRS + 3]));
    // assign gauss_tab = (~ufds_settings_mode) && (frame_x >= gauss_tab_x && frame_x <= (gauss_tab_x + lookup[(NUM_ACTL - 7)*ATTRS + 2])) && (frame_y >= gauss_tab_y && frame_y < 320);
    // assign gauss_tab_1 = (~ufds_settings_mode) && (frame_x > gauss_tab_x && frame_x <= (gauss_tab_x + lookup[(NUM_ACTL - 7)*ATTRS + 2])) && (frame_y >= gauss_tab_y && frame_y < 320);
    assign gauss_tab = (~ufds_settings_mode) && (frame_x >= gauss_tab_x && frame_x <= (gauss_tab_x + lookup[24*ATTRS + 2])) && (frame_y >= gauss_tab_y && frame_y < lookup[24*ATTRS + 3] + gauss_tab_y);
    assign gauss_tab_1 = (~ufds_settings_mode) && (frame_x > gauss_tab_x && frame_x <= (gauss_tab_x + lookup[24*ATTRS + 2])) && (frame_y >= gauss_tab_y && frame_y < lookup[24*ATTRS + 3] + gauss_tab_y);
    assign gauss_sq = (~ufds_settings_mode) && (frame_x >= gauss_x && frame_x <= (gauss_x + lookup[(NUM_ACTL - 6)*ATTRS + 2])) && (frame_y >= gauss_y && frame_y < (gauss_y + lookup[(NUM_ACTL - 6)*ATTRS + 3]));
    assign gauss_sq_1 = (~ufds_settings_mode) && (frame_x > gauss_x && frame_x <= (gauss_x + lookup[(NUM_ACTL - 6)*ATTRS + 2])) && (frame_y >= gauss_y && frame_y < (gauss_y + lookup[(NUM_ACTL - 6)*ATTRS + 3]));
    assign med_sq = (~ufds_settings_mode) && (frame_x >= med_x && frame_x <= (med_x + lookup[(NUM_ACTL - 5)*ATTRS + 2])) && (frame_y >= med_y && frame_y < (med_y + lookup[(NUM_ACTL - 5)*ATTRS + 3]));
    assign med_sq_1 = (~ufds_settings_mode) && (frame_x > med_x && frame_x <= (med_x + lookup[(NUM_ACTL - 5)*ATTRS + 2])) && (frame_y >= med_y && frame_y < (med_y + lookup[(NUM_ACTL - 5)*ATTRS + 3]));
    assign erode_1_sq = (~ufds_settings_mode) && (frame_x >= erode_1_x && frame_x <= (erode_1_x + lookup[(NUM_ACTL - 4)*ATTRS + 2])) && (frame_y >= erode_1_y && frame_y < (erode_1_y + lookup[(NUM_ACTL - 4)*ATTRS + 3]));
    assign erode_1_sq_1 = (~ufds_settings_mode) && (frame_x > erode_1_x && frame_x <= (erode_1_x + lookup[(NUM_ACTL - 4)*ATTRS + 2])) && (frame_y >= erode_1_y && frame_y < (erode_1_y + lookup[(NUM_ACTL - 4)*ATTRS + 3]));
    assign erode_2_sq = (~ufds_settings_mode) && (frame_x >= erode_2_x && frame_x <= (erode_2_x + lookup[(NUM_ACTL - 3)*ATTRS + 2])) && (frame_y >= erode_2_y && frame_y < (erode_2_y + lookup[(NUM_ACTL - 3)*ATTRS + 3]));
    assign erode_2_sq_1 = (~ufds_settings_mode) && (frame_x > erode_2_x && frame_x <= (erode_2_x + lookup[(NUM_ACTL - 3)*ATTRS + 2])) && (frame_y >= erode_2_y && frame_y < (erode_2_y + lookup[(NUM_ACTL - 3)*ATTRS + 3]));
    assign dilate_1_sq = (~ufds_settings_mode) && (frame_x >= dilate_1_x && frame_x <= (dilate_1_x + lookup[(NUM_ACTL - 2)*ATTRS + 2])) && (frame_y >= dilate_1_y && frame_y < (dilate_1_y + lookup[(NUM_ACTL - 2)*ATTRS + 3]));
    assign dilate_1_sq_1 = (~ufds_settings_mode) && (frame_x > dilate_1_x && frame_x <= (dilate_1_x + lookup[(NUM_ACTL - 2)*ATTRS + 2])) && (frame_y >= dilate_1_y && frame_y < (dilate_1_y + lookup[(NUM_ACTL - 2)*ATTRS + 3]));
    assign dilate_2_sq = (~ufds_settings_mode) && (frame_x >= dilate_2_x && frame_x <= (dilate_2_x + lookup[(NUM_ACTL - 1)*ATTRS + 2])) && (frame_y >= dilate_2_y && frame_y < (dilate_2_y + lookup[(NUM_ACTL - 1)*ATTRS + 3]));
    assign dilate_2_sq_1 = (~ufds_settings_mode) && (frame_x > dilate_2_x && frame_x <= (dilate_2_x + lookup[(NUM_ACTL - 1)*ATTRS + 2])) && (frame_y >= dilate_2_y && frame_y < (dilate_2_y + lookup[(NUM_ACTL - 1)*ATTRS + 3]));

    reg [9:0] gauss_tab_x, gauss_x, med_x, erode_1_x, erode_2_x, dilate_1_x, dilate_2_x;
    reg [8:0] gauss_tab_y, gauss_y, med_y, erode_1_y, erode_2_y, dilate_1_y, dilate_2_y;
    integer eye_i_idx;
    integer eye_start_addr;

    always @ (posedge clk) begin
        gauss_tab_x <= gauss_t_x;
        dilate_2_x <= x[59:50] + 1;
        dilate_1_x <= x[49:40] + 1;
        erode_2_x <= x[39:30] + 4;
        erode_1_x<= x[29:20] + 4;
        med_x <= x[19:10] + 7;
        gauss_x <= x[9:0] + 1;

        gauss_tab_y <= gauss_t_y;
        dilate_2_y <= y[53:45] + 11;
        dilate_1_y <= y[44:36] + 11;
        erode_2_y <= y[35:27] + 11;
        erode_1_y <= y[26:18] + 11;
        med_y <= y[17:9] + 4;
        gauss_y <= y[8:0] + 4;
    end

    integer i, j;
    reg [2:0] sel; // 0:gauss 1:median 2:erode1 3:erode2 4:dilate1 5:dilate2 7:none
    always @ (*) begin
        // Default: resolve static elements (non-overlapping)
        for (i = 0; i < NUM_usr; i = i + 1) begin
            if (gen[i]) begin
                // overlay_addr = ((frame_y - lookup[i*ATTRS + 1]) * lookup[i*ATTRS + 2]) + (frame_x - lookup[i*ATTRS]) + lookup[i*ATTRS + 4];

                // If this static element is one of the eye icons (lookup indices 13..16)
                // pick the start address for the 'open' eye image when it matches `final_out`,
                // otherwise use the 'closed' eye image.
                if ((i >= 14) && (i <= 17)) begin
                    eye_i_idx = i - 14; // 0..3
                    // lookup[14*ATTRS + 4] == start addr for open-eye bitmap
                    // lookup[15*ATTRS + 4] == start addr for closed-eye bitmap (shared in this asset layout)
                    eye_start_addr = (eye_i_idx == final_out) ? lookup[14*ATTRS + 4] : lookup[15*ATTRS + 4];
                    overlay_addr = ((frame_y - lookup[i*ATTRS + 1]) * lookup[i*ATTRS + 2]) + (frame_x - lookup[i*ATTRS]) + eye_start_addr;
                end else begin
                    overlay_addr = ((frame_y - lookup[i*ATTRS + 1]) * lookup[i*ATTRS + 2]) + (frame_x - lookup[i*ATTRS]) + lookup[i*ATTRS + 4];
                end
            end
        end

        for (j = 0; j < NUM_ufds; j = j + 1) begin
            if (ufds[j]) begin
                overlay_addr = ((frame_y - lookup[(NUM_usr + j)*ATTRS + 1]) * lookup[(NUM_usr + j)*ATTRS + 2]) + (frame_x - lookup[(NUM_usr + j)*ATTRS]) + lookup[(NUM_usr + j)*ATTRS + 4];
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
        else if ((front_idx == 3'd6) && gauss_tab)     sel = 3'd6;
        // Otherwise fall back to fixed z-order
        else if (gauss_sq)      sel = 3'd0;
        else if (med_sq)        sel = 3'd1;
        else if (erode_1_sq)    sel = 3'd2;
        else if (erode_2_sq)    sel = 3'd3;
        else if (dilate_1_sq)   sel = 3'd4;
        else if (dilate_2_sq)   sel = 3'd5;
        else if (gauss_tab)     sel = 3'd6;

        case (sel)
            3'd0: overlay_addr = ((frame_y - gauss_y) * lookup[(NUM_ACTL - 6)*ATTRS + 2]) + (frame_x - gauss_x) + lookup[(NUM_ACTL - 6)*ATTRS + 4];
            3'd1: overlay_addr = ((frame_y - med_y) * lookup[(NUM_ACTL - 5)*ATTRS + 2]) + (frame_x - med_x) + lookup[(NUM_ACTL - 5)*ATTRS + 4];
            3'd2: overlay_addr = ((frame_y - erode_1_y) * lookup[(NUM_ACTL - 4)*ATTRS + 2]) + (frame_x - erode_1_x) + lookup[(NUM_ACTL - 4)*ATTRS + 4];
            3'd3: overlay_addr = ((frame_y - erode_2_y) * lookup[(NUM_ACTL - 3)*ATTRS + 2]) + (frame_x - erode_2_x) + lookup[(NUM_ACTL - 3)*ATTRS + 4];
            3'd4: overlay_addr = ((frame_y - dilate_1_y) * lookup[(NUM_ACTL - 2)*ATTRS + 2]) + (frame_x - dilate_1_x) + lookup[(NUM_ACTL - 2)*ATTRS + 4];
            3'd5: overlay_addr = ((frame_y - dilate_2_y) * lookup[(NUM_ACTL - 1)*ATTRS + 2]) + (frame_x - dilate_2_x) + lookup[(NUM_ACTL - 1)*ATTRS + 4];
            // 3'd6: overlay_addr = ((frame_y - gauss_tab_y) * lookup[(NUM_ACTL - 7)*ATTRS + 2]) + (frame_x - gauss_tab_x) + lookup[(NUM_ACTL - 7)*ATTRS + 4];
            3'd6: overlay_addr = ((frame_y - gauss_tab_y) * lookup[24*ATTRS + 2]) + (frame_x - gauss_tab_x) + lookup[24*ATTRS + 4];
            default: /* keep last overlay_addr from static elements */ ;
        endcase
    end

    // to_write goes high when overlay enabled and current x/y count is within range
    // wire to_write_int;
    // assign to_write_int = en ? ((|gen) || gauss_sq || med_sq || erode_1_sq || erode_2_sq || dilate_1_sq || dilate_2_sq) : 1'b0;

    // always @ (posedge clk25) begin
    //     to_write <= to_write_int;
    // end
    assign to_write = en ? ((|gen_1) || (|ufds_1) || gauss_tab_1 || gauss_sq_1 || med_sq_1 || erode_1_sq_1 || erode_2_sq_1 || dilate_1_sq_1 || dilate_2_sq_1) : 1'b0;
endmodule
