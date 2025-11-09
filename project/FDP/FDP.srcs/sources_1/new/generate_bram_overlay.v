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
    input [3:0] morph_state,        // Morphology state (leftmost is left squares)
    input [2:0] info_idx,           // Info tab index (0 - neighbor, 1 - union, 2 - stats, 3 - filter, 4 - building, 5 - gaussian, 6 - median, 7 - erode, 8- dilate)
    input menu_mode,                // Menu mode active
    output to_write,                // HIGH for write to VGA, LOW for no write
    // output menu_write,              // HIGH for menu write to VGA
    output [3:0] image_pixel,       // BRAM color output (encoded, decode in Top.v)
    output gauss_sq,
    output med_sq,
    output erode1_sq,
    output erode2_sq,
    output dilate1_sq,
    output dilate2_sq
);
    /* Takes in X and Y coordinate for movable boxes in order:
    Gaussian, Median, Erode 1, Erode 2, Dilate 1, Dilate 2
    Outputs to_write signal HIGH when any overlay pixel is to be drawn
    and the corresponding BRAM pixel data address for that overlay
    en is used to turn on/off the overlay */
    // Access BRAM
    reg [17:0] overlay_addr;
    // Single_Port_Buffer #(
    //     .CHOICE(0)
    // ) single_buffer (
    //     .clk(clk25),
    //     .addr(overlay_addr),
    //     .dout(image_pixel)  
    // );

    overlay_mem single_buffer(
        .clka(clk25),
        .addra(overlay_addr),
        .douta(image_pixel)
    );

    // Localparams for pixels
    localparam integer NUM_usr = 24;        // Number of user things to generate
    localparam integer NUM_ufds = 66;       // Number of UFDS things to generate
    localparam integer NUM_menu = 2;        // Number of menu things to generate
    localparam integer NUM_ACTL = 115;      // (last index + 1) + 6 moving, just to store address of moving parts
    localparam integer ATTRS = 5;           // Number of attributes per thing
    localparam integer lookup [0 : (NUM_ACTL * ATTRS) - 1] = {
        // X, Y, x-size, y-size, bram_offset            // Index, desc, start-end row in csv, start addr, num rows (= numpixels), next addr (start + rows)
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
        409,  459, 92, 12, 47920, 	// 73 Frame end = 2
        503,  459, 3, 12, 49722, 	// 74 1 (one) 2
        489,  398, 13, 10, 33589, 	// 75 small arrow 7
        509,  331, 74, 18, 51242, 	// 76 Bounding
        531,  352, 30, 12, 52574, 	// 77 Box
        510,  394, 3, 18, 52934, 	// 78 num1
        528,  394, 13, 18, 52988, 	// 79 num2
        552,  394, 11, 18, 53222, 	// 80 num3
        574,  394, 15, 18, 53420, 	// 81 num4
        425,  390, 20, 23, 53690, 	// 82 big 4
        458,  391, 20, 21, 54150, 	// 83 big 16
        424,  421, 23, 21, 54570, 	// 84 big 36
        456,  421, 23, 21, 55053, 	// 85 big 64

        608,  328, 24, 30, 55536, 	// 86 T
        607,  358, 26, 30, 56256, 	// 87 R
        606,  388, 28, 60, 57036, 	// 88 AC
        607,  448, 26, 30, 58716, 	// 89 K

        181,  270, 159, 26, 59496, 	// 90 Insert
        363,  270, 104, 26, 63630, 	// 91 Coin

        3,  31, 88, 44, 34415, 	    // 92 FR tab pic 1 (FR)
        18,  80, 55, 46, 66334, 	// 93 FR tab pic 2
        130,  9, 83, 12, 32593, 	// 94 FR tab header
        18,  32, 55, 46, 68864, 	// 95 Union pic 1
        18,  80, 55, 46, 71394, 	// 96 Union pic 2
        144,  9, 44, 12, 38327, 	// 97 Union tab header
        17,  31, 55, 46, 73924, 	// 98 Update pic 1
        17,  80, 55, 46, 76454, 	// 99 Update pic 2
        116,  9, 55, 17, 43017, 	// 100 Update tab header
        177,  9, 42, 12, 43952, 	// 101 stats tab header
        18,  31, 57, 45, 78984, 	// 102 filter pic 1
        18,  81, 57, 45, 81549, 	// 103 filter pic 2
        149,  9, 42, 12, 49790, 	// 104 filter tab header
        18,  31, 57, 45, 84114, 	// 105 bb pic 1
        18,  80, 57, 45, 86679, 	// 106 bb pic 2
        114,  7, 74, 18, 51242, 	// 107 bounding tab header
        191,  7, 30, 12, 52574, 	// 108 box tab header
        475,  204, 68, 26, 89244, 	// 109 gaussian
        402,  357, 56, 26, 91012, 	// 110 median
        468,  352, 40, 34, 92468, 	// 111 erode 1
        510,  352, 40, 34, 92468, 	// 112 erode 2
        552,  352, 40, 34, 93828, 	// 113 dilate 1
        595,  352, 40, 34, 93828 	// 114 dilate 2
    };

    // User settings wires
    wire [0 : (NUM_usr - 1)] gen;
    wire [0 : (NUM_usr - 1)] gen_1;
    genvar gi;
    generate
        for (gi = 0; gi < NUM_usr; gi = gi + 1) begin : GEN_OVERLAYS
            assign gen[gi] = (~ufds_settings_mode) && (~menu_mode) && (frame_x >= (lookup[gi*ATTRS]) && frame_x <= (lookup[gi*ATTRS] + lookup[gi*ATTRS + 2])) && (frame_y >= lookup[gi*ATTRS + 1] && frame_y < (lookup[gi*ATTRS + 1] + lookup[gi*ATTRS + 3]));
            assign gen_1[gi] = (~ufds_settings_mode) && (~menu_mode) && ((frame_x > (lookup[gi*ATTRS]) && frame_x <= (lookup[gi*ATTRS] + lookup[gi*ATTRS + 2])) && (frame_y >= lookup[gi*ATTRS + 1] && frame_y < (lookup[gi*ATTRS + 1] + lookup[gi*ATTRS + 3])));
        end
    endgenerate

    wire [0 : (NUM_ufds - 1)] ufds;
    wire [0 : (NUM_ufds - 1)] ufds_1;
    genvar ui;
    generate
        // for (ui = 0; ui < NUM_ufds; ui = ui + 1) begin : UFDS_OVERLAYS
        for (ui = 1; ui < NUM_ufds + 1; ui = ui + 1) begin : UFDS_OVERLAYS
            assign ufds[ui] = ufds_settings_mode && ((frame_x >= (lookup[(NUM_usr + ui)*ATTRS]) && frame_x <= (lookup[(NUM_usr + ui)*ATTRS] + lookup[(NUM_usr + ui)*ATTRS + 2])) && (frame_y >= lookup[(NUM_usr + ui)*ATTRS + 1] && frame_y < (lookup[(NUM_usr + ui)*ATTRS + 1] + lookup[(NUM_usr + ui)*ATTRS + 3])));
            assign ufds_1[ui] = ufds_settings_mode && ((frame_x > (lookup[(NUM_usr + ui)*ATTRS]) && frame_x <= (lookup[(NUM_usr + ui)*ATTRS] + lookup[(NUM_usr + ui)*ATTRS + 2])) && (frame_y >= lookup[(NUM_usr + ui)*ATTRS + 1] && frame_y < (lookup[(NUM_usr + ui)*ATTRS + 1] + lookup[(NUM_usr + ui)*ATTRS + 3])));
        end
    endgenerate

    wire [0 : (NUM_menu - 1)] menu;
    wire [0 : (NUM_menu - 1)] menu_1;
    genvar mi;
    generate
        for (mi = 0; mi < NUM_menu; mi = mi + 1) begin : MENU_OVERLAYS
            assign menu[mi] = menu_mode && ((frame_x >= (lookup[(NUM_usr + NUM_ufds + mi)*ATTRS]) && frame_x <= (lookup[(NUM_usr + NUM_ufds + mi)*ATTRS] + lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 2])) && (frame_y >= lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 1] && frame_y < (lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 1] + lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 3])));
            assign menu_1[mi] = menu_mode && ((frame_x > (lookup[(NUM_usr + NUM_ufds + mi)*ATTRS]) && frame_x <= (lookup[(NUM_usr + NUM_ufds + mi)*ATTRS] + lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 2])) && (frame_y >= lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 1] && frame_y < (lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 1] + lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 3])));
        end
    endgenerate


    // assign gauss_tab = (frame_x >= gauss_tab_x && frame_x <= (gauss_tab_x + lookup[(NUM_ACTL - 7)*ATTRS + 2])) && (frame_y >= gauss_tab_y && frame_y < (gauss_tab_y + lookup[(NUM_ACTL - 7)*ATTRS + 3]));
    // assign gauss_tab_1 = (frame_x > gauss_tab_x && frame_x <= (gauss_tab_x + lookup[(NUM_ACTL - 7)*ATTRS + 2])) && (frame_y >= gauss_tab_y && frame_y < (gauss_tab_y + lookup[(NUM_ACTL - 7)*ATTRS + 3]));
    // assign gauss_tab = (~ufds_settings_mode) && (frame_x >= gauss_tab_x && frame_x <= (gauss_tab_x + lookup[(NUM_ACTL - 7)*ATTRS + 2])) && (frame_y >= gauss_tab_y);
    // assign gauss_tab_1 = (~ufds_settings_mode) && (frame_x > gauss_tab_x && frame_x <= (gauss_tab_x + lookup[(NUM_ACTL - 7)*ATTRS + 2])) && (frame_y >= gauss_tab_y);
    assign gauss_tab = (ufds_settings_mode) && (frame_x >= gauss_tab_x && frame_x <= (gauss_tab_x + lookup[24*ATTRS + 2])) && (frame_y >= gauss_tab_y && frame_y < lookup[24*ATTRS + 3] + gauss_tab_y);
    assign gauss_tab_1 = (ufds_settings_mode) && (frame_x > gauss_tab_x && frame_x <= (gauss_tab_x + lookup[24*ATTRS + 2])) && (frame_y >= gauss_tab_y && frame_y < lookup[24*ATTRS + 3] + gauss_tab_y);
    assign gauss_sq = (~ufds_settings_mode) && (frame_x >= gauss_x && frame_x <= (gauss_x + lookup[(NUM_ACTL - 6)*ATTRS + 2])) && (frame_y >= gauss_y && frame_y < (gauss_y + lookup[(NUM_ACTL - 6)*ATTRS + 3]));
    assign gauss_sq_1 = (~ufds_settings_mode) && (frame_x > gauss_x && frame_x <= (gauss_x + lookup[(NUM_ACTL - 6)*ATTRS + 2])) && (frame_y >= gauss_y && frame_y < (gauss_y + lookup[(NUM_ACTL - 6)*ATTRS + 3]));
    assign med_sq = (~ufds_settings_mode) && (frame_x >= med_x && frame_x <= (med_x + lookup[(NUM_ACTL - 5)*ATTRS + 2])) && (frame_y >= med_y && frame_y < (med_y + lookup[(NUM_ACTL - 5)*ATTRS + 3]));
    assign med_sq_1 = (~ufds_settings_mode) && (frame_x > med_x && frame_x <= (med_x + lookup[(NUM_ACTL - 5)*ATTRS + 2])) && (frame_y >= med_y && frame_y < (med_y + lookup[(NUM_ACTL - 5)*ATTRS + 3]));

    assign erode_1_sq = (~ufds_settings_mode) && (~menu_mode) && (frame_x >= erode_1_x && frame_x <= (erode_1_x + lookup[(NUM_ACTL - 4)*ATTRS + 2])) && (frame_y >= erode_1_y && frame_y < (erode_1_y + lookup[(NUM_ACTL - 4)*ATTRS + 3]));
    assign erode_1_sq_1 = (~ufds_settings_mode) && (~menu_mode) && (frame_x > erode_1_x && frame_x <= (erode_1_x + lookup[(NUM_ACTL - 4)*ATTRS + 2])) && (frame_y >= erode_1_y && frame_y < (erode_1_y + lookup[(NUM_ACTL - 4)*ATTRS + 3]));
    assign erode_2_sq = (~ufds_settings_mode) && (~menu_mode) && (frame_x >= erode_2_x && frame_x <= (erode_2_x + lookup[(NUM_ACTL - 3)*ATTRS + 2])) && (frame_y >= erode_2_y && frame_y < (erode_2_y + lookup[(NUM_ACTL - 3)*ATTRS + 3]));
    assign erode_2_sq_1 = (~ufds_settings_mode) && (~menu_mode) && (frame_x > erode_2_x && frame_x <= (erode_2_x + lookup[(NUM_ACTL - 3)*ATTRS + 2])) && (frame_y >= erode_2_y && frame_y < (erode_2_y + lookup[(NUM_ACTL - 3)*ATTRS + 3]));
    assign dilate_1_sq = (~ufds_settings_mode) && (~menu_mode) && (frame_x >= dilate_1_x && frame_x <= (dilate_1_x + lookup[(NUM_ACTL - 2)*ATTRS + 2])) && (frame_y >= dilate_1_y && frame_y < (dilate_1_y + lookup[(NUM_ACTL - 2)*ATTRS + 3]));
    assign dilate_1_sq_1 = (~ufds_settings_mode) && (~menu_mode) && (frame_x > dilate_1_x && frame_x <= (dilate_1_x + lookup[(NUM_ACTL - 2)*ATTRS + 2])) && (frame_y >= dilate_1_y && frame_y < (dilate_1_y + lookup[(NUM_ACTL - 2)*ATTRS + 3]));
    assign dilate_2_sq = (~ufds_settings_mode) && (~menu_mode) && (frame_x >= dilate_2_x && frame_x <= (dilate_2_x + lookup[(NUM_ACTL - 1)*ATTRS + 2])) && (frame_y >= dilate_2_y && frame_y < (dilate_2_y + lookup[(NUM_ACTL - 1)*ATTRS + 3]));
    assign dilate_2_sq_1 = (~ufds_settings_mode) && (~menu_mode) && (frame_x > dilate_2_x && frame_x <= (dilate_2_x + lookup[(NUM_ACTL - 1)*ATTRS + 2])) && (frame_y >= dilate_2_y && frame_y < (dilate_2_y + lookup[(NUM_ACTL - 1)*ATTRS + 3]));

    // assign object_title = (menu_mode) && (frame_x >= lookup[86*ATTRS] && frame_x <= (lookup[86*ATTRS] + lookup[86*ATTRS + 2])) && (frame_y >= lookup[86*ATTRS + 1] && frame_y < (lookup[86*ATTRS + 1] + lookup[86*ATTRS + 3]));
    // assign object_title_1 = (menu_mode) && (frame_x > lookup[86*ATTRS] && frame_x <= (lookup[86*ATTRS] + lookup[86*ATTRS + 2])) && (frame_y >= lookup[86*ATTRS + 1] && frame_y < (lookup[86*ATTRS + 1] + lookup[86*ATTRS + 3]));
    // assign tracking_title = (menu_mode) && (frame_x >= lookup[87*ATTRS] && frame_x <= (lookup[87*ATTRS] + lookup[87*ATTRS + 2])) && (frame_y >= lookup[87*ATTRS + 1] && frame_y < (lookup[87*ATTRS + 1] + lookup[87*ATTRS + 3]));
    // assign tracking_title_1 = (menu_mode) && (frame_x > lookup[87*ATTRS] && frame_x <= (lookup[87*ATTRS] + lookup[87*ATTRS + 2])) && (frame_y >= lookup[87*ATTRS + 1] && frame_y < (lookup[87*ATTRS + 1] + lookup[87*ATTRS + 3]));
    // assign insert = (menu_mode) && (frame_x >= lookup[(NUM_ACTL - 25)*ATTRS] && frame_x <= (lookup[(NUM_ACTL - 25)*ATTRS] + lookup[(NUM_ACTL - 25)*ATTRS + 2])) && (frame_y >= lookup[(NUM_ACTL - 25)*ATTRS + 1] && frame_y < (lookup[(NUM_ACTL - 25)*ATTRS + 1] + lookup[(NUM_ACTL - 25)*ATTRS + 3]));
    // assign insert_1 = (menu_mode) && (frame_x > lookup[(NUM_ACTL - 25)*ATTRS] && frame_x <= (lookup[(NUM_ACTL - 25)*ATTRS] + lookup[(NUM_ACTL - 25)*ATTRS + 2])) && (frame_y >= lookup[(NUM_ACTL - 25)*ATTRS + 1] && frame_y < (lookup[(NUM_ACTL - 25)*ATTRS + 1] + lookup[(NUM_ACTL - 25)*ATTRS + 3]));
    
    // assign coin = (menu_mode) && (frame_x >= lookup[(NUM_ACTL - 24)*ATTRS] && frame_x <= (lookup[(NUM_ACTL - 24)*ATTRS] + lookup[(NUM_ACTL - 24)*ATTRS + 2])) && (frame_y >= lookup[(NUM_ACTL - 24)*ATTRS + 1] && frame_y < (lookup[(NUM_ACTL - 24)*ATTRS + 1] + lookup[(NUM_ACTL - 24)*ATTRS + 3]));
    // assign coin_1 = (menu_mode) && (frame_x > lookup[(NUM_ACTL - 24)*ATTRS] && frame_x <= (lookup[(NUM_ACTL - 24)*ATTRS] + lookup[(NUM_ACTL - 24)*ATTRS + 2])) && (frame_y >= lookup[(NUM_ACTL - 24)*ATTRS + 1] && frame_y < (lookup[(NUM_ACTL - 24)*ATTRS + 1] + lookup[(NUM_ACTL - 24)*ATTRS + 3]));


    // UFDS, Sample Neighbour/Find Roots
    assign fr_tab_pic_1 = (ufds_settings_mode) && (info_idx == 3'd1) && (frame_x >= (lookup[(NUM_ACTL - 23)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 23)*ATTRS] + lookup[(NUM_ACTL - 23)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 23)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 23) * ATTRS + 1] + lookup[(NUM_ACTL - 23)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;
    assign fr_tab_pic_1_1 = (ufds_settings_mode) && (info_idx == 3'd1) && (frame_x > (lookup[(NUM_ACTL - 23)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 23)*ATTRS] + lookup[(NUM_ACTL - 23)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 23)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 23) * ATTRS + 1] + lookup[(NUM_ACTL - 23)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;

    assign fr_tab_pic_2 = (ufds_settings_mode) && (info_idx == 3'd1) && (frame_x >= (lookup[(NUM_ACTL - 22)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 22)*ATTRS] + lookup[(NUM_ACTL - 22)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 22)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 22) * ATTRS + 1] + lookup[(NUM_ACTL - 22)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;
    assign fr_tab_pic_2_1 = (ufds_settings_mode) && (info_idx == 3'd1) && (frame_x > (lookup[(NUM_ACTL - 22)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 22)*ATTRS] + lookup[(NUM_ACTL - 22)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 22)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 22) * ATTRS + 1] + lookup[(NUM_ACTL - 22)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;

    assign fr_tab_hdr = (ufds_settings_mode) && (info_idx == 3'd1) && (frame_x >= (lookup[(NUM_ACTL - 21)*ATTRS] + gauss_tab_x) && frame_x < (lookup[(NUM_ACTL - 21)*ATTRS] + lookup[(NUM_ACTL - 21)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 21)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 21)*ATTRS + 1] + lookup[(NUM_ACTL - 21)*ATTRS + 3] + gauss_tab_y));
    assign fr_tab_hdr_1 = (ufds_settings_mode) && (info_idx == 3'd1) && (frame_x > (lookup[(NUM_ACTL - 21)*ATTRS] + gauss_tab_x) && frame_x < (lookup[(NUM_ACTL - 21)*ATTRS] + lookup[(NUM_ACTL - 21)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 21)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 21)*ATTRS + 1] + lookup[(NUM_ACTL - 21)*ATTRS + 3] + gauss_tab_y));

    // UFDS, Union Components
    assign union_tab_pic_1 = (ufds_settings_mode) && (info_idx == 3'd2) && (frame_x >= (lookup[(NUM_ACTL - 20)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 20)*ATTRS] + lookup[(NUM_ACTL - 20)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 20)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 20)*ATTRS + 1] + lookup[(NUM_ACTL - 20)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;
    assign union_tab_pic_1_1 = (ufds_settings_mode) && (info_idx == 3'd2) && (frame_x > (lookup[(NUM_ACTL - 20)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 20)*ATTRS] + lookup[(NUM_ACTL - 20)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 20)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 20)*ATTRS + 1] + lookup[(NUM_ACTL - 20)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;

    assign union_tab_pic_2 = (ufds_settings_mode) && (info_idx == 3'd2) && (frame_x >= (lookup[(NUM_ACTL - 19)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 19)*ATTRS] + lookup[(NUM_ACTL - 19)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 19)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 19)*ATTRS + 1] + lookup[(NUM_ACTL - 19)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;
    assign union_tab_pic_2_1 = (ufds_settings_mode) && (info_idx == 3'd2) && (frame_x > (lookup[(NUM_ACTL - 19)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 19)*ATTRS] + lookup[(NUM_ACTL - 19)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 19)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 19)*ATTRS + 1] + lookup[(NUM_ACTL - 19)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;

    assign union_tab_hdr = (ufds_settings_mode) && (info_idx == 3'd2) && (frame_x >= (lookup[(NUM_ACTL - 18)*ATTRS] + gauss_tab_x) && frame_x < (lookup[(NUM_ACTL - 18)*ATTRS] + lookup[(NUM_ACTL - 18)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 18)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 18)*ATTRS + 1] + lookup[(NUM_ACTL - 18)*ATTRS + 3] + gauss_tab_y));
    assign union_tab_hdr_1 = (ufds_settings_mode) && (info_idx == 3'd2) && (frame_x > (lookup[(NUM_ACTL - 18)*ATTRS] + gauss_tab_x) && frame_x < (lookup[(NUM_ACTL - 18)*ATTRS] + lookup[(NUM_ACTL - 18)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 18)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 18)*ATTRS + 1] + lookup[(NUM_ACTL - 18)*ATTRS + 3] + gauss_tab_y));
    
    // UFDS, Update Stats
    assign update_tab_pic_1 = (ufds_settings_mode) && (info_idx == 3'd3) && (frame_x >= (lookup[(NUM_ACTL - 17)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 17)*ATTRS] + lookup[(NUM_ACTL - 17)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 17)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 17)*ATTRS + 1] + lookup[(NUM_ACTL - 17)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;
    assign update_tab_pic_1_1 = (ufds_settings_mode) && (info_idx == 3'd3) && (frame_x > (lookup[(NUM_ACTL - 17)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 17)*ATTRS] + lookup[(NUM_ACTL - 17)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 17)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 17)*ATTRS + 1] + lookup[(NUM_ACTL - 17)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;

    assign update_tab_pic_2 = (ufds_settings_mode) && (info_idx == 3'd3) && (frame_x >= (lookup[(NUM_ACTL - 16)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 16)*ATTRS] + lookup[(NUM_ACTL - 16)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 16)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 16)*ATTRS + 1] + lookup[(NUM_ACTL - 16)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;
    assign update_tab_pic_2_1 = (ufds_settings_mode) && (info_idx == 3'd3) && (frame_x > (lookup[(NUM_ACTL - 16)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 16)*ATTRS] + lookup[(NUM_ACTL - 16)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 16)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 16)*ATTRS + 1] + lookup[(NUM_ACTL - 16)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;

    assign update_tab_hdr_1 = (ufds_settings_mode) && (info_idx == 3'd3) && (frame_x >= (lookup[(NUM_ACTL - 15)*ATTRS] + gauss_tab_x) && frame_x < (lookup[(NUM_ACTL - 15)*ATTRS] + lookup[(NUM_ACTL - 15)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 15)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 15)*ATTRS + 1] + lookup[(NUM_ACTL - 15)*ATTRS + 3] + gauss_tab_y));
    assign update_tab_hdr_1_1 = (ufds_settings_mode) && (info_idx == 3'd3) && (frame_x > (lookup[(NUM_ACTL - 15)*ATTRS] + gauss_tab_x) && frame_x < (lookup[(NUM_ACTL - 15)*ATTRS] + lookup[(NUM_ACTL - 15)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 15)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 15)*ATTRS + 1] + lookup[(NUM_ACTL - 15)*ATTRS + 3] + gauss_tab_y));

    assign update_tab_hdr_2 = (ufds_settings_mode) && (info_idx == 3'd3) && (frame_x >= (lookup[(NUM_ACTL - 14)*ATTRS] + gauss_tab_x) && frame_x < (lookup[(NUM_ACTL - 14)*ATTRS] + lookup[(NUM_ACTL - 14)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 14)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 14)*ATTRS + 1] + lookup[(NUM_ACTL - 14)*ATTRS + 3] + gauss_tab_y));
    assign update_tab_hdr_2_1 = (ufds_settings_mode) && (info_idx == 3'd3) && (frame_x > (lookup[(NUM_ACTL - 14)*ATTRS] + gauss_tab_x) && frame_x < (lookup[(NUM_ACTL - 14)*ATTRS] + lookup[(NUM_ACTL - 14)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 14)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 14)*ATTRS + 1] + lookup[(NUM_ACTL - 14)*ATTRS + 3] + gauss_tab_y));

    // UFDS, Filter stats
    assign filter_tab_pic_1 = (ufds_settings_mode) && (info_idx == 3'd4) && (frame_x >= (lookup[(NUM_ACTL - 13)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 13)*ATTRS] + lookup[(NUM_ACTL - 13)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 13)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 13)*ATTRS + 1] + lookup[(NUM_ACTL - 13)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;
    assign filter_tab_pic_1_1 = (ufds_settings_mode) && (info_idx == 3'd4) && (frame_x > (lookup[(NUM_ACTL - 13)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 13)*ATTRS] + lookup[(NUM_ACTL - 13)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 13)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 13)*ATTRS + 1] + lookup[(NUM_ACTL - 13)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;

    assign filter_tab_pic_2 = (ufds_settings_mode) && (info_idx == 3'd4) && (frame_x >= (lookup[(NUM_ACTL - 12)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 12)*ATTRS] + lookup[(NUM_ACTL - 12)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 12)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 12)*ATTRS + 1] + lookup[(NUM_ACTL - 12)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;
    assign filter_tab_pic_2_1 = (ufds_settings_mode) && (info_idx == 3'd4) && (frame_x > (lookup[(NUM_ACTL - 12)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 12)*ATTRS] + lookup[(NUM_ACTL - 12)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 12)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 12)*ATTRS + 1] + lookup[(NUM_ACTL - 12)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;

    assign filter_tab_hdr = (ufds_settings_mode) && (info_idx == 3'd4) && (frame_x >= (lookup[(NUM_ACTL - 11)*ATTRS] + gauss_tab_x) && frame_x < (lookup[(NUM_ACTL - 11)*ATTRS] + lookup[(NUM_ACTL - 11)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 11)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 11)*ATTRS + 1] + lookup[(NUM_ACTL - 11)*ATTRS + 3] + gauss_tab_y));
    assign filter_tab_hdr_1 = (ufds_settings_mode) && (info_idx == 3'd4) && (frame_x > (lookup[(NUM_ACTL - 11)*ATTRS] + gauss_tab_x) && frame_x < (lookup[(NUM_ACTL - 11)*ATTRS] + lookup[(NUM_ACTL - 11)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 11)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 11)*ATTRS + 1] + lookup[(NUM_ACTL - 11)*ATTRS + 3] + gauss_tab_y));

    // UFDS, Bounding Box
    assign bb_tab_pic_1 = (ufds_settings_mode) && (info_idx == 3'd5) && (frame_x >= (lookup[(NUM_ACTL - 10)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 10)*ATTRS] + lookup[(NUM_ACTL - 10)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 10)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 10)*ATTRS + 1] + lookup[(NUM_ACTL - 10)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;
    assign bb_tab_pic_1_1 = (ufds_settings_mode) && (info_idx == 3'd5) && (frame_x > (lookup[(NUM_ACTL - 10)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 10)*ATTRS] + lookup[(NUM_ACTL - 10)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 10)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 10)*ATTRS + 1] + lookup[(NUM_ACTL - 10)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;

    assign bb_tab_pic_2 = (ufds_settings_mode) && (info_idx == 3'd5) && (frame_x >= (lookup[(NUM_ACTL - 9)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 9)*ATTRS] + lookup[(NUM_ACTL - 9)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 9)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 9)*ATTRS + 1] + lookup[(NUM_ACTL - 9)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;
    assign bb_tab_pic_2_1 = (ufds_settings_mode) && (info_idx == 3'd5) && (frame_x > (lookup[(NUM_ACTL - 9)*ATTRS] + gauss_tab_x) && frame_x <= (lookup[(NUM_ACTL - 9)*ATTRS] + lookup[(NUM_ACTL - 9)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 9)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 9)*ATTRS + 1] + lookup[(NUM_ACTL - 9)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;

    assign bb_tab_hdr_1 = (ufds_settings_mode) && (info_idx == 3'd5) && (frame_x >= (lookup[(NUM_ACTL - 8)*ATTRS] + gauss_tab_x) && frame_x < (lookup[(NUM_ACTL - 8)*ATTRS] + lookup[(NUM_ACTL - 8)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 8)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 8)*ATTRS + 1] + lookup[(NUM_ACTL - 8)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;
    assign bb_tab_hdr_1_1 = (ufds_settings_mode) && (info_idx == 3'd5) && (frame_x > (lookup[(NUM_ACTL - 8)*ATTRS] + gauss_tab_x) && frame_x < (lookup[(NUM_ACTL - 8)*ATTRS] + lookup[(NUM_ACTL - 8)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 8)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 8)*ATTRS + 1] + lookup[(NUM_ACTL - 8)*ATTRS + 3] + gauss_tab_y)) && frame_y < 326;

    assign bb_tab_hdr_2 = (ufds_settings_mode) && (info_idx == 3'd5) && (frame_x >= (lookup[(NUM_ACTL - 7)*ATTRS] + gauss_tab_x) && frame_x < (lookup[(NUM_ACTL - 7)*ATTRS] + lookup[(NUM_ACTL - 7)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 7)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 7)*ATTRS + 1] + lookup[(NUM_ACTL - 7)*ATTRS + 3] + gauss_tab_y));
    assign bb_tab_hdr_2_1 = (ufds_settings_mode) && (info_idx == 3'd5) && (frame_x > (lookup[(NUM_ACTL - 7)*ATTRS] + gauss_tab_x) && frame_x < (lookup[(NUM_ACTL - 7)*ATTRS] + lookup[(NUM_ACTL - 7)*ATTRS + 2] + gauss_tab_x)) && (frame_y >= (lookup[(NUM_ACTL - 7)*ATTRS + 1] + gauss_tab_y) && frame_y < (lookup[(NUM_ACTL - 7)*ATTRS + 1] + lookup[(NUM_ACTL - 7)*ATTRS + 3] + gauss_tab_y));

    reg [9:0] gauss_tab_x, gauss_x, med_x, erode_1_x, erode_2_x, dilate_1_x, dilate_2_x;
    reg [8:0] gauss_tab_y, gauss_y, med_y, erode_1_y, erode_2_y, dilate_1_y, dilate_2_y;

    always @ (posedge clk) begin
        gauss_tab_x <= gauss_t_x;
        dilate_2_x <= x[59:50];
        dilate_1_x <= x[49:40];
        erode_2_x <= x[39:30];
        erode_1_x<= x[29:20];
        med_x <= x[19:10] + 7;
        gauss_x <= x[9:0] + 1;

        gauss_tab_y <= gauss_t_y;
        dilate_2_y <= y[53:45];
        dilate_1_y <= y[44:36];
        erode_2_y <= y[35:27];
        erode_1_y <= y[26:18];
        med_y <= y[17:9] + 4;
        gauss_y <= y[8:0] + 4;
    end

    integer eye_i_idx;
    integer eye_start_addr;
    integer i, j, k;
    reg [2:0] sel; // 0:gauss 1:median 2:erode1 3:erode2 4:dilate1 5:dilate2 7:none
    always @ (*) begin

        // if (coin) overlay_addr = ((frame_y - lookup[89*ATTRS + 1]) * lookup[89*ATTRS + 2]) + (frame_x - lookup[89*ATTRS]) + lookup[89*ATTRS + 4];
        // else if (insert_coin) overlay_addr = ((frame_y - lookup[88*ATTRS + 1]) * lookup[88*ATTRS + 2]) + (frame_x - lookup[88*ATTRS]) + lookup[88*ATTRS + 4];
        // else if (tracking_title) overlay_addr = ((frame_y - lookup[87*ATTRS + 1]) * lookup[87*ATTRS + 2]) + (frame_x - lookup[87*ATTRS]) + lookup[87*ATTRS + 4];
        // else if (object_title) overlay_addr = ((frame_y - lookup[86*ATTRS + 1]) * lookup[86*ATTRS + 2]) + (frame_x - lookup[86*ATTRS]) + lookup[86*ATTRS + 4];
        
        // Elements within info box as least priority
        if (fr_tab_pic_1) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 23)*ATTRS + 1])) * lookup[(NUM_ACTL - 23)*ATTRS + 2]) + (frame_x - lookup[(NUM_ACTL - 23)*ATTRS]) + lookup[(NUM_ACTL - 23)*ATTRS + 4];
        else if (fr_tab_pic_2) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 22)*ATTRS + 1])) * lookup[(NUM_ACTL - 22)*ATTRS + 2]) + (frame_x - lookup[(NUM_ACTL - 22)*ATTRS]) + lookup[(NUM_ACTL - 22)*ATTRS + 4];
        else if (fr_tab_hdr) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 21)*ATTRS + 1])) * lookup[(NUM_ACTL - 21)*ATTRS + 2]) + (frame_x - lookup[(NUM_ACTL - 21)*ATTRS]) + lookup[(NUM_ACTL - 21)*ATTRS + 4];
        else if (union_tab_pic_1) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 20)*ATTRS + 1])) * lookup[(NUM_ACTL - 20)*ATTRS + 2]) + (frame_x - lookup[(NUM_ACTL - 20)*ATTRS]) + lookup[(NUM_ACTL - 20)*ATTRS + 4];
        else if (union_tab_pic_2) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 19)*ATTRS + 1])) * lookup[(NUM_ACTL - 19)*ATTRS + 2]) + (frame_x - lookup[(NUM_ACTL - 19)*ATTRS]) + lookup[(NUM_ACTL - 19)*ATTRS + 4];
        else if (union_tab_hdr) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 18)*ATTRS + 1])) * lookup[(NUM_ACTL - 18)*ATTRS + 2]) + (frame_x - lookup[(NUM_ACTL - 18)*ATTRS]) + lookup[(NUM_ACTL - 18)*ATTRS + 4];
        else if (update_tab_pic_1) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 17)*ATTRS + 1])) * lookup[(NUM_ACTL - 17)*ATTRS + 2]) + (frame_x - lookup[(NUM_ACTL - 17)*ATTRS]) + lookup[(NUM_ACTL - 17)*ATTRS + 4];
        else if (update_tab_pic_2) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 16)*ATTRS + 1])) * lookup[(NUM_ACTL - 16)*ATTRS + 2]) + (frame_x - lookup[(NUM_ACTL - 16)*ATTRS]) + lookup[(NUM_ACTL - 16)*ATTRS + 4];
        else if (update_tab_hdr_1) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 15)*ATTRS + 1])) * lookup[(NUM_ACTL - 15)*ATTRS + 2]) + (frame_x - lookup[(NUM_ACTL - 15)*ATTRS]) + lookup[(NUM_ACTL - 15)*ATTRS + 4];
        else if (update_tab_hdr_2) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 14)*ATTRS + 1])) * lookup[(NUM_ACTL - 14)*ATTRS + 2]) + (frame_x - lookup[(NUM_ACTL - 14)*ATTRS]) + lookup[(NUM_ACTL - 14)*ATTRS + 4];
        else if (filter_tab_pic_1) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 13)*ATTRS + 1])) * lookup[(NUM_ACTL - 13)*ATTRS + 2]) + (frame_x - lookup[(NUM_ACTL - 13)*ATTRS]) + lookup[(NUM_ACTL - 13)*ATTRS + 4];
        else if (filter_tab_pic_2) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 12)*ATTRS + 1])) * lookup[(NUM_ACTL - 12)*ATTRS + 2]) + (frame_x - lookup[(NUM_ACTL - 12)*ATTRS]) + lookup[(NUM_ACTL - 12)*ATTRS + 4];
        else if (filter_tab_hdr) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 11)*ATTRS + 1])) * lookup[(NUM_ACTL - 11)*ATTRS + 2]) + (frame_x - lookup[(NUM_ACTL - 11)*ATTRS]) + lookup[(NUM_ACTL - 11)*ATTRS + 4];
        else if (bb_tab_pic_1) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 10)*ATTRS + 1])) * lookup[(NUM_ACTL - 10)*ATTRS + 2]) + (frame_x - lookup[(NUM_ACTL - 10)*ATTRS]) + lookup[(NUM_ACTL - 10)*ATTRS + 4];
        else if (bb_tab_pic_2) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 9)*ATTRS + 1])) * lookup[(NUM_ACTL - 9)*ATTRS + 2]) + (frame_x - lookup[(NUM_ACTL - 9)*ATTRS]) + lookup[(NUM_ACTL - 9)*ATTRS + 4];
        else if (bb_tab_hdr_1) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 8)*ATTRS + 1])) * lookup[(NUM_ACTL - 8)*ATTRS + 2]) + (frame_x - lookup[(NUM_ACTL - 8)*ATTRS]) + lookup[(NUM_ACTL - 8)*ATTRS + 4];
        else if (bb_tab_hdr_2) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 7)*ATTRS + 1])) * lookup[(NUM_ACTL - 7)*ATTRS + 2]) + (frame_x - lookup[(NUM_ACTL - 7)*ATTRS]) + lookup[(NUM_ACTL - 7)*ATTRS + 4];


            
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

        for (k = 0; k < NUM_menu; k = k + 1) begin
            if (menu[k]) begin
                overlay_addr = ((frame_y - lookup[(NUM_usr + NUM_ufds + k)*ATTRS + 1]) * lookup[(NUM_usr + NUM_ufds + k)*ATTRS + 2]) + (frame_x - lookup[(NUM_usr + NUM_ufds + k)*ATTRS]) + lookup[(NUM_usr + NUM_ufds + k)*ATTRS + 4];
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

            3'd2: 
            if (morph_state[0]) begin
                overlay_addr = ((frame_y - erode_1_y) * lookup[(NUM_ACTL - 4)*ATTRS + 2]) + (frame_x - erode_1_x) + lookup[(NUM_ACTL - 4)*ATTRS + 4];
            end else begin
                overlay_addr = ((frame_y - erode_1_y) * lookup[(NUM_ACTL - 2)*ATTRS + 2]) + (frame_x - erode_1_x) + lookup[(NUM_ACTL - 2)*ATTRS + 4];
            end

            3'd3:
            if (morph_state[1]) begin
                overlay_addr = ((frame_y - erode_2_y) * lookup[(NUM_ACTL - 3)*ATTRS + 2]) + (frame_x - erode_2_x) + lookup[(NUM_ACTL - 3)*ATTRS + 4];
            end else begin
                overlay_addr = ((frame_y - erode_2_y) * lookup[(NUM_ACTL - 1)*ATTRS + 2]) + (frame_x - erode_2_x) + lookup[(NUM_ACTL - 1)*ATTRS + 4];
            end

            3'd4:
            if (morph_state[2]) begin
                overlay_addr = ((frame_y - dilate_1_y) * lookup[(NUM_ACTL - 4)*ATTRS + 2]) + (frame_x - dilate_1_x) + lookup[(NUM_ACTL - 4)*ATTRS + 4];
            end else begin
                overlay_addr = ((frame_y - dilate_1_y) * lookup[(NUM_ACTL - 2)*ATTRS + 2]) + (frame_x - dilate_1_x) + lookup[(NUM_ACTL - 2)*ATTRS + 4];
            end

            3'd5:
            if (morph_state[3]) begin
                overlay_addr = ((frame_y - dilate_2_y) * lookup[(NUM_ACTL - 3)*ATTRS + 2]) + (frame_x - dilate_2_x) + lookup[(NUM_ACTL - 3)*ATTRS + 4];
            end else begin
                overlay_addr = ((frame_y - dilate_2_y) * lookup[(NUM_ACTL - 1)*ATTRS + 2]) + (frame_x - dilate_2_x) + lookup[(NUM_ACTL - 1)*ATTRS + 4];
            end

            // 3'd2: overlay_addr = ((frame_y - erode_1_y) * lookup[(NUM_ACTL - 4)*ATTRS + 2]) + (frame_x - erode_1_x) + lookup[(NUM_ACTL - 4)*ATTRS + 4];
            // 3'd3: overlay_addr = ((frame_y - erode_2_y) * lookup[(NUM_ACTL - 3)*ATTRS + 2]) + (frame_x - erode_2_x) + lookup[(NUM_ACTL - 3)*ATTRS + 4];
            // 3'd4: overlay_addr = ((frame_y - dilate_1_y) * lookup[(NUM_ACTL - 2)*ATTRS + 2]) + (frame_x - dilate_1_x) + lookup[(NUM_ACTL - 2)*ATTRS + 4];
            // 3'd5: overlay_addr = ((frame_y - dilate_2_y) * lookup[(NUM_ACTL - 1)*ATTRS + 2]) + (frame_x - dilate_2_x) + lookup[(NUM_ACTL - 1)*ATTRS + 4];
            // 3'd6: overlay_addr = ((frame_y - gauss_tab_y) * lookup[(NUM_ACTL - 7)*ATTRS + 2]) + (frame_x - gauss_tab_x) + lookup[(NUM_ACTL - 7)*ATTRS + 4];

            3'd6: overlay_addr = ((frame_y - gauss_tab_y) * lookup[24*ATTRS + 2]) + (frame_x - gauss_tab_x) + lookup[24*ATTRS + 4];
            default: /* keep last overlay_addr from static elements */ ;
        endcase
    
        // Elements within info box (no need priority, cuts off after certain y value)
        if (fr_tab_pic_1) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 23)*ATTRS + 1] + gauss_tab_y)) * lookup[(NUM_ACTL - 23)*ATTRS + 2]) + (frame_x - (lookup[(NUM_ACTL - 23)*ATTRS] + gauss_tab_x)) + lookup[(NUM_ACTL - 23)*ATTRS + 4];
        if (fr_tab_pic_2) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 22)*ATTRS + 1] + gauss_tab_y)) * lookup[(NUM_ACTL - 22)*ATTRS + 2]) + (frame_x - (lookup[(NUM_ACTL - 22)*ATTRS] + gauss_tab_x)) + lookup[(NUM_ACTL - 22)*ATTRS + 4];
        if (fr_tab_hdr) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 21)*ATTRS + 1] + gauss_tab_y)) * lookup[(NUM_ACTL - 21)*ATTRS + 2]) + (frame_x - (lookup[(NUM_ACTL - 21)*ATTRS] + gauss_tab_x)) + lookup[(NUM_ACTL - 21)*ATTRS + 4];
        if (union_tab_pic_1) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 20)*ATTRS + 1] + gauss_tab_y)) * lookup[(NUM_ACTL - 20)*ATTRS + 2]) + (frame_x - (lookup[(NUM_ACTL - 20)*ATTRS] + gauss_tab_x)) + lookup[(NUM_ACTL - 20)*ATTRS + 4];
        if (union_tab_pic_2) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 19)*ATTRS + 1] + gauss_tab_y)) * lookup[(NUM_ACTL - 19)*ATTRS + 2]) + (frame_x - (lookup[(NUM_ACTL - 19)*ATTRS] + gauss_tab_x)) + lookup[(NUM_ACTL - 19)*ATTRS + 4];
        if (union_tab_hdr) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 18)*ATTRS + 1] + gauss_tab_y)) * lookup[(NUM_ACTL - 18)*ATTRS + 2]) + (frame_x - (lookup[(NUM_ACTL - 18)*ATTRS] + gauss_tab_x)) + lookup[(NUM_ACTL - 18)*ATTRS + 4];
        if (update_tab_pic_1) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 17)*ATTRS + 1] + gauss_tab_y)) * lookup[(NUM_ACTL - 17)*ATTRS + 2]) + (frame_x - (lookup[(NUM_ACTL - 17)*ATTRS] + gauss_tab_x)) + lookup[(NUM_ACTL - 17)*ATTRS + 4];
        if (update_tab_pic_2) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 16)*ATTRS + 1] + gauss_tab_y)) * lookup[(NUM_ACTL - 16)*ATTRS + 2]) + (frame_x - (lookup[(NUM_ACTL - 16)*ATTRS] + gauss_tab_x)) + lookup[(NUM_ACTL - 16)*ATTRS + 4];
        if (update_tab_hdr_1) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 15)*ATTRS + 1] + gauss_tab_y)) * lookup[(NUM_ACTL - 15)*ATTRS + 2]) + (frame_x - (lookup[(NUM_ACTL - 15)*ATTRS] + gauss_tab_x)) + lookup[(NUM_ACTL - 15)*ATTRS + 4];
        if (update_tab_hdr_2) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 14)*ATTRS + 1] + gauss_tab_y)) * lookup[(NUM_ACTL - 14)*ATTRS + 2]) + (frame_x - (lookup[(NUM_ACTL - 14)*ATTRS] + gauss_tab_x)) + lookup[(NUM_ACTL - 14)*ATTRS + 4];
        if (filter_tab_pic_1) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 13)*ATTRS + 1] + gauss_tab_y)) * lookup[(NUM_ACTL - 13)*ATTRS + 2]) + (frame_x - (lookup[(NUM_ACTL - 13)*ATTRS] + gauss_tab_x)) + lookup[(NUM_ACTL - 13)*ATTRS + 4];
        if (filter_tab_pic_2) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 12)*ATTRS + 1] + gauss_tab_y)) * lookup[(NUM_ACTL - 12)*ATTRS + 2]) + (frame_x - (lookup[(NUM_ACTL - 12)*ATTRS] + gauss_tab_x)) + lookup[(NUM_ACTL - 12)*ATTRS + 4];
        if (filter_tab_hdr) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 11)*ATTRS + 1] + gauss_tab_y)) * lookup[(NUM_ACTL - 11)*ATTRS + 2]) + (frame_x - (lookup[(NUM_ACTL - 11)*ATTRS] + gauss_tab_x)) + lookup[(NUM_ACTL - 11)*ATTRS + 4];
        if (bb_tab_pic_1) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 10)*ATTRS + 1] + gauss_tab_y)) * lookup[(NUM_ACTL - 10)*ATTRS + 2]) + (frame_x - (lookup[(NUM_ACTL - 10)*ATTRS] + gauss_tab_x)) + lookup[(NUM_ACTL - 10)*ATTRS + 4];
        if (bb_tab_pic_2) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 9)*ATTRS + 1] + gauss_tab_y)) * lookup[(NUM_ACTL - 9)*ATTRS + 2]) + (frame_x - (lookup[(NUM_ACTL - 9)*ATTRS] + gauss_tab_x)) + lookup[(NUM_ACTL - 9)*ATTRS + 4];
        if (bb_tab_hdr_1) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 8)*ATTRS + 1] + gauss_tab_y)) * lookup[(NUM_ACTL - 8)*ATTRS + 2]) + (frame_x - (lookup[(NUM_ACTL - 8)*ATTRS] + gauss_tab_x)) + lookup[(NUM_ACTL - 8)*ATTRS + 4];
        if (bb_tab_hdr_2) overlay_addr = ((frame_y - (lookup[(NUM_ACTL - 7)*ATTRS + 1] + gauss_tab_y)) * lookup[(NUM_ACTL - 7)*ATTRS + 2]) + (frame_x - (lookup[(NUM_ACTL - 7)*ATTRS] + gauss_tab_x)) + lookup[(NUM_ACTL - 7)*ATTRS + 4];
    end

    // to_write goes high when overlay enabled and current x/y count is within range
    // wire to_write_int;
    // assign to_write_int = en ? ((|gen) || gauss_sq || med_sq || erode_1_sq || erode_2_sq || dilate_1_sq || dilate_2_sq) : 1'b0;

    // always @ (posedge clk25) begin
    //     to_write <= to_write_int;
    // end
    assign to_write = en ? ((|gen_1) || (|ufds_1) || (|menu_1) || 
        gauss_tab_1 || gauss_sq_1 || med_sq_1 || erode_1_sq_1 || erode_2_sq_1 || dilate_1_sq_1 || dilate_2_sq_1 ||
        fr_tab_pic_1_1 || fr_tab_pic_2_1 || fr_tab_hdr_1 ||
        union_tab_pic_1_1 || union_tab_pic_2_1 || union_tab_hdr_1 ||
        update_tab_pic_1_1 || update_tab_pic_2_1 || update_tab_hdr_1_1 || update_tab_hdr_2_1 ||
        filter_tab_pic_1_1 || filter_tab_pic_2_1 || filter_tab_hdr_1 ||
        bb_tab_pic_1_1 || bb_tab_pic_2_1 || bb_tab_hdr_1_1 || bb_tab_hdr_2_1
    ) : 1'b0;

endmodule
