module generate_bram_overlay(
    input clk,                      // 100MHz clk
    input clk25,                    // 25MHz clk
    input en,                       // Enable overlay generation
    input [59:0] x,                 // x input for all 6 boxes (10 bits)
    input [53:0] y,                 // y input for all 6 boxes (9 bits)
    input [9:0] ufds_t_x,          // x coord of gaussian edu tab
    input [8:0] ufds_t_y,          // y coord of gaussian edu tab
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

    localparam FRAME_WIDTH = 640;
    localparam FRAME_HEIGHT = 480;
    // Localparams for pixels
    localparam integer NUM_usr = 24;        // Number of user things to generate
    localparam integer NUM_ufds = 66;       // Number of UFDS things to generate
    localparam integer NUM_menu = 15;        // Number of menu things to generate
    localparam integer NUM_ACTL = 128;      // (last index + 1) + 6 moving, just to store address of moving parts
    localparam integer ATTRS = 5;           // Number of attributes per thing
    localparam integer lookup [0 : (NUM_ACTL * ATTRS) - 1] = {
        // X, Y, x-size, y-size, bram_offset            // Index, desc, start-end row in csv, start addr, num rows (= numpixels), next addr (start + rows)
        128,  348, 12, 12, 0, 	// 0 red square
        128,  363, 12, 12, 144, 	// 1 green square
        128,  378, 12, 12, 288, 	// 2 blue square
        290,  330, 15, 15, 432, 	// 3 eyedropper
        33,  330, 81, 12, 657, 	// 4 threshold
        39,  401, 36, 29, 1629, 	// 5 raw feed
        40,  446, 34, 12, 2673, 	// 6 camera
        124,  410, 112, 18, 3081, 	// 7 preprocessing
        80,  448, 25, 8, 5097, 	// 8 yellow arrow
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
        32,  448, 25, 8, 5097, 	// 32 yellow arrow 5
        62,  444, 49, 12, 29361, 	// 33 Ready
        77,  375, 4, 4, 29949, 	// 34 Up→right
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
        77,  471, 4, 4, 49576, 	// 64 left→up
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
        164,  115, 56, 60, 59496, 	// 90 O
        224,  115, 52, 60, 62856, 	// 91 B
        280,  115, 52, 60, 65976, 	// 92 J
        336,  115, 48, 60, 69096, 	// 93 E
        388,  115, 56, 60, 71976, 	// 94 C
        448,  115, 48, 60, 75336, 	// 95 T
        136,  187, 48, 60, 75336, 	// 96 T
        188,  187, 52, 60, 78216, 	// 97 R
        244,  187, 56, 60, 81336, 	// 98 A
        304,  187, 56, 60, 71976, 	// 99 C
        364,  187, 52, 60, 84696, 	// 100 K
        420,  187, 48, 60, 69096, 	// 101 E
        472,  187, 52, 60, 78216, 	// 102 R
        181,  270, 159, 26, 87816, 	// 103 Insert
        363,  270, 104, 26, 91950, 	// 104 Coin
        3,  31, 88, 44, 34415, 	// 105 FR tab pic 1 (FR)
        18,  80, 55, 46, 94654, 	// 106 FR tab pic 2
        130,  9, 83, 12, 32593, 	// 107 FR tab header
        18,  32, 55, 46, 97184, 	// 108 Union pic 1
        18,  80, 55, 46, 99714, 	// 109 Union pic 2
        144,  9, 44, 12, 38327, 	// 110 Union tab header
        17,  31, 55, 46, 102244, 	// 111 Update pic 1
        17,  80, 55, 46, 104774, 	// 112 Update pic 2
        116,  9, 55, 17, 43017, 	// 113 Update tab header
        177,  9, 42, 12, 43952, 	// 114 stats tab header
        18,  31, 57, 45, 107304, 	// 115 filter pic 1
        18,  81, 57, 45, 109869, 	// 116 filter pic 2
        149,  9, 42, 12, 49790, 	// 117 filter tab header
        18,  31, 57, 45, 112434, 	// 118 bb pic 1
        18,  80, 57, 45, 114999, 	// 119 bb pic 2
        114,  7, 74, 18, 51242, 	// 120 bounding tab header
        191,  7, 30, 12, 52574, 	// 121 box tab header
        475,  204, 68, 26, 117564, 	// 122 gaussian
        402,  357, 56, 26, 119332, 	// 123 median
        468,  352, 40, 34, 120788, 	// 124 erode 1
        510,  352, 40, 34, 120788, 	// 125 erode 2
        552,  352, 40, 34, 122148, 	// 126 dilate 1
        595,  352, 40, 34, 122148 	// 127 dilate 2
    };

    //get next pixel coordinates so that on next clk cycle, the correct BRAM pixel is fetched
    //but to align with BRAM 2 cycle read delay, jump by 3 instead of usual 1 step
    wire [9:0] frame_x_next = (frame_x >= FRAME_WIDTH - 3) ? frame_x + 10'd3 - FRAME_WIDTH : frame_x + 10'd3;
    wire [9:0] frame_y_next = (frame_x >= FRAME_WIDTH - 3) ? ((frame_y == FRAME_HEIGHT - 1) ? frame_y + 10'd1 - FRAME_HEIGHT  : frame_y + 10'd1) : frame_y;

    wire [0 : (NUM_usr - 1)] usr_ptr_in;
    wire [0 : (NUM_usr - 1)] usr_ptr_look_ahead_in;
    genvar gi;
    generate
        for (gi=0; gi<NUM_usr; gi=gi+1) begin : GEN_OVERLAYS
            assign usr_ptr_in[gi] = (~ufds_settings_mode) && (~menu_mode) && (frame_x >= lookup[gi*ATTRS + 0] && frame_x < (lookup[gi*ATTRS + 0] + lookup[gi*ATTRS + 2]) && frame_y >= lookup[gi*ATTRS + 1] && frame_y < (lookup[gi*ATTRS + 1] + lookup[gi*ATTRS + 3]));
            assign usr_ptr_look_ahead_in[gi] = (~ufds_settings_mode) && (~menu_mode) && (frame_x_next >= lookup[gi*ATTRS + 0] && frame_x_next < (lookup[gi*ATTRS + 0] + lookup[gi*ATTRS + 2]) && frame_y_next >= lookup[gi*ATTRS + 1] && frame_y_next < (lookup[gi*ATTRS + 1] + lookup[gi*ATTRS + 3]));
        end
    endgenerate

    wire [0 : (NUM_ufds- 1)] ufds_ptr_in;
    wire [0 : (NUM_ufds - 1)] ufds_ptr_look_ahead_in;
    genvar ui;
    generate
        for (ui=1; ui<=NUM_ufds; ui=ui+1) begin : UFDS_OVERLAYS
            assign ufds_ptr_in[ui] = ufds_settings_mode && (frame_x >= lookup[(NUM_usr + ui)*ATTRS + 0] && frame_x < (lookup[(NUM_usr + ui)*ATTRS + 0] + lookup[(NUM_usr + ui)*ATTRS + 2]) && frame_y >= lookup[(NUM_usr + ui)*ATTRS + 1] && frame_y < (lookup[(NUM_usr + ui)*ATTRS + 1] + lookup[(NUM_usr + ui)*ATTRS + 3]));
            assign ufds_ptr_look_ahead_in[ui] = ufds_settings_mode && (frame_x_next >= lookup[(NUM_usr + ui)*ATTRS + 0] && frame_x_next < (lookup[(NUM_usr + ui)*ATTRS + 0] + lookup[(NUM_usr + ui)*ATTRS + 2]) && frame_y_next >= lookup[(NUM_usr + ui)*ATTRS + 1] && frame_y_next < (lookup[(NUM_usr + ui)*ATTRS + 1] + lookup[(NUM_usr + ui)*ATTRS + 3]));
        end
    endgenerate

    wire [0 : (NUM_menu- 1)] menu_ptr_in;
    wire [0 : (NUM_menu - 1)] menu_ptr_look_ahead_in;
    genvar mi;
    generate
        for (mi=0; mi<NUM_menu; mi=mi+1) begin : MENU_OVERLAYS
            assign menu_ptr_in[mi] = menu_mode && (frame_x >= lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 0] && frame_x < (lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 0] + lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 2]) && frame_y >= lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 1] && frame_y < (lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 1] + lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 3]));
            assign menu_ptr_look_ahead_in[mi] = menu_mode && (frame_x_next >= lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 0] && frame_x_next < (lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 0] + lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 2]) && frame_y_next >= lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 1] && frame_y_next < (lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 1] + lookup[(NUM_usr + NUM_ufds + mi)*ATTRS + 3]));
        end
    endgenerate


    // wire [0 : 6] usr_active_ptr_in;
    // wire [0 : 6] usr_active_ptr_look_ahead_in; 
    // wire [59:0] preproc_blocks_x = {x[59:20], (x[19:10]+8), (x[9:0]+2)};
    // wire [53:0] preproc_blocks_y = {y[53:18], (y[17:9]+4), (y[8:0]+4)};
    // genvar ai;
    // generate
    //     for (ai=0; ai<6; ai=ai+1) begin : GEN_ACTIVE_USR_OVERLAYS
    //         assign usr_active_ptr_in[ai] = (~ufds_settings_mode) && (~menu_mode) && 
    //                                             frame_x >= preproc_blocks_x[(ai+1)*10-1:ai*10] && 
    //                                             frame_x < (preproc_blocks_x[(ai+1)*10-1:ai*10] + lookup[(NUM_ACTL - (6-ai))*ATTRS + 2]) && 
    //                                             frame_y >= preproc_blocks_y[(ai+1)*9-1:ai*9] && 
    //                                             frame_y < (preproc_blocks_y[(ai+1)*9-1:ai*9] + lookup[(NUM_ACTL - (6-ai))*ATTRS + 3]);
    //         assign usr_active_ptr_look_ahead_in[ai] = (~ufds_settings_mode) && (~menu_mode) && 
    //                                                     frame_x_next >= preproc_blocks_x[(ai+1)*10-1:ai*10] && 
    //                                                     frame_x_next < (preproc_blocks_x[(ai+1)*10-1:ai*10] + lookup[(NUM_ACTL - (6-ai))*ATTRS + 2]) && 
    //                                                     frame_y_next >= preproc_blocks_y[(ai+1)*9-1:ai*9] && 
    //                                                     frame_y_next < (preproc_blocks_y[(ai+1)*9-1:ai*9] + lookup[(NUM_ACTL - (6-ai))*ATTRS + 3]);
    //     end
    // endgenerate
    // assign usr_active_ptr_in[6] = (~ufds_settings_mode) && (~menu_mode) && (frame_x >= lookup[24*ATTRS + 0] && frame_x < (lookup[24*ATTRS + 0] + lookup[24*ATTRS + 2]) && frame_y >= lookup[24*ATTRS + 1] && frame_y < (lookup[24*ATTRS + 1] + lookup[24*ATTRS + 3]));
    // assign usr_active_ptr_look_ahead_in[6] = (~ufds_settings_mode) && (~menu_mode) && (frame_x_next >= lookup[24*ATTRS + 0] && frame_x_next < (lookup[24*ATTRS + 0] + lookup[24*ATTRS + 2]) && frame_y_next >= lookup[24*ATTRS + 1] && frame_y_next < (lookup[24*ATTRS + 1] + lookup[24*ATTRS + 3]));

    //FOR SOME REASON THE GENERATE BLOCK NO WORK????????????
    wire gauss_block_ptr_in = (~ufds_settings_mode) && (~menu_mode) && (frame_x >= (x[9:0]+2) && frame_x < ((x[9:0]+2) + lookup[(NUM_ACTL - 6)*ATTRS + 2]) && frame_y >= (y[8:0]+4) && frame_y < ((y[8:0]+4) + lookup[(NUM_ACTL - 6)*ATTRS + 3]));
    wire gauss_block_ptr_look_ahead_in = (~ufds_settings_mode) && (~menu_mode) && (frame_x_next >= (x[9:0]+2) && frame_x_next < ((x[9:0]+2) + lookup[(NUM_ACTL - 6)*ATTRS + 2]) && frame_y_next >= (y[8:0]+4) && frame_y_next < ((y[8:0]+4) + lookup[(NUM_ACTL - 6)*ATTRS + 3]));
    wire median_block_ptr_in = (~ufds_settings_mode) && (~menu_mode) && (frame_x >= (x[19:10]+8) && frame_x < ((x[19:10]+8) + lookup[(NUM_ACTL - 5)*ATTRS + 2]) && frame_y >= (y[17:9]+4) && frame_y < ((y[17:9]+4) + lookup[(NUM_ACTL - 5)*ATTRS + 3]));
    wire median_block_ptr_look_ahead_in = (~ufds_settings_mode) && (~menu_mode) && (frame_x_next >= (x[19:10]+8) && frame_x_next < ((x[19:10]+8) + lookup[(NUM_ACTL - 5)*ATTRS + 2]) && frame_y_next >= (y[17:9]+4) && frame_y_next < ((y[17:9]+4) + lookup[(NUM_ACTL - 5)*ATTRS + 3]));
    wire erode_1_block_ptr_in = (~ufds_settings_mode) && (~menu_mode) && (frame_x >= (x[29:20]) && frame_x < ((x[29:20]) + lookup[(NUM_ACTL - 4)*ATTRS + 2]) && frame_y >= (y[26:18]) && frame_y < ((y[26:18]) + lookup[(NUM_ACTL - 4)*ATTRS + 3]));
    wire erode_1_block_ptr_look_ahead_in = (~ufds_settings_mode) && (~menu_mode) && (frame_x_next >= (x[29:20]) && frame_x_next < ((x[29:20]) + lookup[(NUM_ACTL - 4)*ATTRS + 2]) && frame_y_next >= (y[26:18]) && frame_y_next < ((y[26:18]) + lookup[(NUM_ACTL - 4)*ATTRS + 3]));
    wire erode_2_block_ptr_in = (~ufds_settings_mode) && (~menu_mode) && (frame_x >= (x[39:30]) && frame_x < ((x[39:30]) + lookup[(NUM_ACTL - 3)*ATTRS + 2]) && frame_y >= (y[35:27]) && frame_y < ((y[35:27]) + lookup[(NUM_ACTL - 3)*ATTRS + 3]));
    wire erode_2_block_ptr_look_ahead_in = (~ufds_settings_mode) && (~menu_mode) && (frame_x_next >= (x[39:30]) && frame_x_next < ((x[39:30]) + lookup[(NUM_ACTL - 3)*ATTRS + 2]) && frame_y_next >= (y[35:27]) && frame_y_next < ((y[35:27]) + lookup[(NUM_ACTL - 3)*ATTRS + 3]));
    wire dilate_1_block_ptr_in = (~ufds_settings_mode) && (~menu_mode) && (frame_x >= (x[49:40]) && frame_x < ((x[49:40]) + lookup[(NUM_ACTL - 2)*ATTRS + 2]) && frame_y >= (y[44:36]) && frame_y < ((y[44:36]) + lookup[(NUM_ACTL - 2)*ATTRS + 3]));
    wire dilate_1_block_ptr_look_ahead_in = (~ufds_settings_mode) && (~menu_mode) && (frame_x_next >= (x[49:40]) && frame_x_next < ((x[49:40]) + lookup[(NUM_ACTL - 2)*ATTRS + 2]) && frame_y_next >= (y[44:36]) && frame_y_next < ((y[44:36]) + lookup[(NUM_ACTL - 2)*ATTRS + 3]));
    wire dilate_2_block_ptr_in = (~ufds_settings_mode) && (~menu_mode) && (frame_x >= (x[59:50]) && frame_x < ((x[59:50]) + lookup[(NUM_ACTL - 1)*ATTRS + 2]) && frame_y >= (y[53:45]) && frame_y < ((y[53:45]) + lookup[(NUM_ACTL - 1)*ATTRS + 3]));
    wire dilate_2_block_ptr_look_ahead_in = (~ufds_settings_mode) && (~menu_mode) && (frame_x_next >= (x[59:50]) && frame_x_next < ((x[59:50]) + lookup[(NUM_ACTL - 1)*ATTRS + 2]) && frame_y_next >= (y[53:45]) && frame_y_next < ((y[53:45]) + lookup[(NUM_ACTL - 1)*ATTRS + 3]));
    


    wire ufds_tab_ptr_in = (ufds_settings_mode) && (frame_x >= ufds_t_x && frame_x < (ufds_t_x + lookup[24*ATTRS + 2])) && (frame_y >= ufds_t_y && frame_y < (ufds_t_y + lookup[24*ATTRS + 3]));
    wire ufds_tab_ptr_look_ahead_in = (ufds_settings_mode) && (frame_x_next >= ufds_t_x && frame_x_next < (ufds_t_x + lookup[24*ATTRS + 2])) && (frame_y_next >= ufds_t_y && frame_y_next < (ufds_t_y + lookup[24*ATTRS + 3]));

    // UFDS, Sample Neighbour/Find Roots
    wire fr_tab_pic_1_ptr_in = (ufds_settings_mode) && (info_idx == 3'd1) && (frame_x >= (ufds_t_x + lookup[(NUM_ACTL-23)*ATTRS + 0]) && frame_x < (ufds_t_x + lookup[(NUM_ACTL-23)*ATTRS + 0] + lookup[(NUM_ACTL-23)*ATTRS + 2])) && (frame_y >= (ufds_t_y + lookup[(NUM_ACTL-23)*ATTRS + 1]) && frame_y < (ufds_t_y + lookup[(NUM_ACTL-23)*ATTRS + 1] + lookup[(NUM_ACTL-23)*ATTRS + 3])) && frame_y < 326;
    wire fr_tab_pic_1_ptr_look_ahead_in = (ufds_settings_mode) && (info_idx == 3'd1) && (frame_x_next >= (ufds_t_x + lookup[(NUM_ACTL-23)*ATTRS + 0]) && frame_x_next < (ufds_t_x + lookup[(NUM_ACTL-23)*ATTRS + 0] + lookup[(NUM_ACTL-23)*ATTRS + 2])) && (frame_y_next >= (ufds_t_y + lookup[(NUM_ACTL-23)*ATTRS + 1]) && frame_y_next < (ufds_t_y + lookup[(NUM_ACTL-23)*ATTRS + 1] + lookup[(NUM_ACTL-23)*ATTRS + 3])) && frame_y_next < 326;

    wire fr_tab_pic_2_ptr_in = (ufds_settings_mode) && (info_idx == 3'd1) && (frame_x >= (ufds_t_x + lookup[(NUM_ACTL-22)*ATTRS + 0]) && frame_x < (ufds_t_x + lookup[(NUM_ACTL-22)*ATTRS + 0] + lookup[(NUM_ACTL-22)*ATTRS + 2])) && (frame_y >= (ufds_t_y + lookup[(NUM_ACTL-22)*ATTRS + 1]) && frame_y < (ufds_t_y + lookup[(NUM_ACTL-22)*ATTRS + 1] + lookup[(NUM_ACTL-22)*ATTRS + 3])) && frame_y < 326;
    wire fr_tab_pic_2_ptr_look_ahead_in = (ufds_settings_mode) && (info_idx == 3'd1) && (frame_x_next >= (ufds_t_x + lookup[(NUM_ACTL-22)*ATTRS + 0]) && frame_x_next < (ufds_t_x + lookup[(NUM_ACTL-22)*ATTRS + 0] + lookup[(NUM_ACTL-22)*ATTRS + 2])) && (frame_y_next >= (ufds_t_y + lookup[(NUM_ACTL-22)*ATTRS + 1]) && frame_y_next < (ufds_t_y + lookup[(NUM_ACTL-22)*ATTRS + 1] + lookup[(NUM_ACTL-22)*ATTRS + 3])) && frame_y_next < 326;

    wire fr_tab_hdr_ptr_in = (ufds_settings_mode) && (info_idx == 3'd1) && (frame_x >= (ufds_t_x + lookup[(NUM_ACTL-21)*ATTRS + 0]) && frame_x < (ufds_t_x + lookup[(NUM_ACTL-21)*ATTRS + 0] + lookup[(NUM_ACTL-21)*ATTRS + 2])) && (frame_y >= (ufds_t_y + lookup[(NUM_ACTL-21)*ATTRS + 1]) && frame_y < (ufds_t_y + lookup[(NUM_ACTL-21)*ATTRS + 1] + lookup[(NUM_ACTL-21)*ATTRS + 3]));
    wire fr_tab_hdr_ptr_look_ahead_in = (ufds_settings_mode) && (info_idx == 3'd1) && (frame_x_next >= (ufds_t_x + lookup[(NUM_ACTL-21)*ATTRS + 0]) && frame_x_next < (ufds_t_x + lookup[(NUM_ACTL-21)*ATTRS + 0] + lookup[(NUM_ACTL-21)*ATTRS + 2])) && (frame_y_next >= (ufds_t_y + lookup[(NUM_ACTL-21)*ATTRS + 1]) && frame_y_next < (ufds_t_y + lookup[(NUM_ACTL-21)*ATTRS + 1] + lookup[(NUM_ACTL-21)*ATTRS + 3]));

    // UFDS, Union Components
    wire union_tab_pic_1_ptr_in = (ufds_settings_mode) && (info_idx == 3'd2) && (frame_x >= (lookup[(NUM_ACTL-20)*ATTRS] + ufds_t_x) && frame_x <= (lookup[(NUM_ACTL-20)*ATTRS] + lookup[(NUM_ACTL-20)*ATTRS + 2] + ufds_t_x)) && (frame_y >= (lookup[(NUM_ACTL-20)*ATTRS + 1] + ufds_t_y) && frame_y < (lookup[(NUM_ACTL-20)*ATTRS + 1] + lookup[(NUM_ACTL-20)*ATTRS + 3] + ufds_t_y)) && frame_y < 326;
    wire union_tab_pic_1_ptr_look_ahead_in = (ufds_settings_mode) && (info_idx == 3'd2) && (frame_x_next >= (lookup[(NUM_ACTL-20)*ATTRS] + ufds_t_x) && frame_x_next <= (lookup[(NUM_ACTL-20)*ATTRS] + lookup[(NUM_ACTL-20)*ATTRS + 2] + ufds_t_x)) && (frame_y_next >= (lookup[(NUM_ACTL-20)*ATTRS + 1] + ufds_t_y) && frame_y_next < (lookup[(NUM_ACTL-20)*ATTRS + 1] + lookup[(NUM_ACTL-20)*ATTRS + 3] + ufds_t_y)) && frame_y_next < 326;

    wire union_tab_pic_2_ptr_in = (ufds_settings_mode) && (info_idx == 3'd2) && (frame_x >= (lookup[(NUM_ACTL-19)*ATTRS] + ufds_t_x) && frame_x <= (lookup[(NUM_ACTL-19)*ATTRS] + lookup[(NUM_ACTL-19)*ATTRS + 2] + ufds_t_x)) && (frame_y >= (lookup[(NUM_ACTL-19)*ATTRS + 1] + ufds_t_y) && frame_y < (lookup[(NUM_ACTL-19)*ATTRS + 1] + lookup[(NUM_ACTL-19)*ATTRS + 3] + ufds_t_y)) && frame_y < 326;
    wire union_tab_pic_2_ptr_look_ahead_in = (ufds_settings_mode) && (info_idx == 3'd2) && (frame_x_next >= (lookup[(NUM_ACTL-19)*ATTRS] + ufds_t_x) && frame_x_next <= (lookup[(NUM_ACTL-19)*ATTRS] + lookup[(NUM_ACTL-19)*ATTRS + 2] + ufds_t_x)) && (frame_y_next >= (lookup[(NUM_ACTL-19)*ATTRS + 1] + ufds_t_y) && frame_y_next < (lookup[(NUM_ACTL-19)*ATTRS + 1] + lookup[(NUM_ACTL-19)*ATTRS + 3] + ufds_t_y)) && frame_y_next < 326;

    wire union_tab_hdr_ptr_in = (ufds_settings_mode) && (info_idx == 3'd2) && (frame_x >= (lookup[(NUM_ACTL-18)*ATTRS] + ufds_t_x) && frame_x < (lookup[(NUM_ACTL-18)*ATTRS] + lookup[(NUM_ACTL-18)*ATTRS + 2] + ufds_t_x)) && (frame_y >= (lookup[(NUM_ACTL-18)*ATTRS + 1] + ufds_t_y) && frame_y < (lookup[(NUM_ACTL-18)*ATTRS + 1] + lookup[(NUM_ACTL-18)*ATTRS + 3] + ufds_t_y));
    wire union_tab_hdr_ptr_look_ahead_in = (ufds_settings_mode) && (info_idx == 3'd2) && (frame_x_next >= (lookup[(NUM_ACTL-18)*ATTRS] + ufds_t_x) && frame_x_next < (lookup[(NUM_ACTL-18)*ATTRS] + lookup[(NUM_ACTL-18)*ATTRS + 2] + ufds_t_x)) && (frame_y_next >= (lookup[(NUM_ACTL-18)*ATTRS + 1] + ufds_t_y) && frame_y_next < (lookup[(NUM_ACTL-18)*ATTRS + 1] + lookup[(NUM_ACTL-18)*ATTRS + 3] + ufds_t_y));

    // UFDS, Update Stats
    wire update_tab_pic_1_ptr_in = (ufds_settings_mode) && (info_idx == 3'd3) && (frame_x >= (lookup[(NUM_ACTL-17)*ATTRS] + ufds_t_x) && frame_x <= (lookup[(NUM_ACTL-17)*ATTRS] + lookup[(NUM_ACTL-17)*ATTRS + 2] + ufds_t_x)) && (frame_y >= (lookup[(NUM_ACTL-17)*ATTRS + 1] + ufds_t_y) && frame_y < (lookup[(NUM_ACTL-17)*ATTRS + 1] + lookup[(NUM_ACTL-17)*ATTRS + 3] + ufds_t_y)) && frame_y < 326;
    wire update_tab_pic_1_ptr_look_ahead_in = (ufds_settings_mode) && (info_idx == 3'd3) && (frame_x_next >= (lookup[(NUM_ACTL-17)*ATTRS] + ufds_t_x) && frame_x_next <= (lookup[(NUM_ACTL-17)*ATTRS] + lookup[(NUM_ACTL-17)*ATTRS + 2] + ufds_t_x)) && (frame_y_next >= (lookup[(NUM_ACTL-17)*ATTRS + 1] + ufds_t_y) && frame_y_next < (lookup[(NUM_ACTL-17)*ATTRS + 1] + lookup[(NUM_ACTL-17)*ATTRS + 3] + ufds_t_y)) && frame_y_next < 326;

    wire update_tab_pic_2_ptr_in = (ufds_settings_mode) && (info_idx == 3'd3) && (frame_x >= (lookup[(NUM_ACTL-16)*ATTRS] + ufds_t_x) && frame_x <= (lookup[(NUM_ACTL-16)*ATTRS] + lookup[(NUM_ACTL-16)*ATTRS + 2] + ufds_t_x)) && (frame_y >= (lookup[(NUM_ACTL-16)*ATTRS + 1] + ufds_t_y) && frame_y < (lookup[(NUM_ACTL-16)*ATTRS + 1] + lookup[(NUM_ACTL-16)*ATTRS + 3] + ufds_t_y)) && frame_y < 326;
    wire update_tab_pic_2_ptr_look_ahead_in = (ufds_settings_mode) && (info_idx == 3'd3) && (frame_x_next >= (lookup[(NUM_ACTL-16)*ATTRS] + ufds_t_x) && frame_x_next <= (lookup[(NUM_ACTL-16)*ATTRS] + lookup[(NUM_ACTL-16)*ATTRS + 2] + ufds_t_x)) && (frame_y_next >= (lookup[(NUM_ACTL-16)*ATTRS + 1] + ufds_t_y) && frame_y_next < (lookup[(NUM_ACTL-16)*ATTRS + 1] + lookup[(NUM_ACTL-16)*ATTRS + 3] + ufds_t_y)) && frame_y_next < 326;

    wire update_tab_hdr_ptr_in = (ufds_settings_mode) && (info_idx == 3'd3) && (frame_x >= (lookup[(NUM_ACTL-15)*ATTRS] + ufds_t_x) && frame_x < (lookup[(NUM_ACTL-15)*ATTRS] + lookup[(NUM_ACTL-15)*ATTRS + 2] + ufds_t_x)) && (frame_y >= (lookup[(NUM_ACTL-15)*ATTRS + 1] + ufds_t_y) && frame_y < (lookup[(NUM_ACTL-15)*ATTRS + 1] + lookup[(NUM_ACTL-15)*ATTRS + 3] + ufds_t_y));
    wire update_tab_hdr_ptr_look_ahead_in = (ufds_settings_mode) && (info_idx == 3'd3) && (frame_x_next >= (lookup[(NUM_ACTL-15)*ATTRS] + ufds_t_x) && frame_x_next < (lookup[(NUM_ACTL-15)*ATTRS] + lookup[(NUM_ACTL-15)*ATTRS + 2] + ufds_t_x)) && (frame_y_next >= (lookup[(NUM_ACTL-15)*ATTRS + 1] + ufds_t_y) && frame_y_next < (lookup[(NUM_ACTL-15)*ATTRS + 1] + lookup[(NUM_ACTL-15)*ATTRS + 3] + ufds_t_y));

    wire update_tab_hdr_2_ptr_in = (ufds_settings_mode) && (info_idx == 3'd3) && (frame_x >= (lookup[(NUM_ACTL-14)*ATTRS] + ufds_t_x) && frame_x < (lookup[(NUM_ACTL-14)*ATTRS] + lookup[(NUM_ACTL-14)*ATTRS + 2] + ufds_t_x)) && (frame_y >= (lookup[(NUM_ACTL-14)*ATTRS + 1] + ufds_t_y) && frame_y < (lookup[(NUM_ACTL-14)*ATTRS + 1] + lookup[(NUM_ACTL-14)*ATTRS + 3] + ufds_t_y));
    wire update_tab_hdr_2_ptr_look_ahead_in = (ufds_settings_mode) && (info_idx == 3'd3) && (frame_x_next >= (lookup[(NUM_ACTL-14)*ATTRS] + ufds_t_x) && frame_x_next < (lookup[(NUM_ACTL-14)*ATTRS] + lookup[(NUM_ACTL-14)*ATTRS + 2] + ufds_t_x)) && (frame_y_next >= (lookup[(NUM_ACTL-14)*ATTRS + 1] + ufds_t_y) && frame_y_next < (lookup[(NUM_ACTL-14)*ATTRS + 1] + lookup[(NUM_ACTL-14)*ATTRS + 3] + ufds_t_y));

    // UFDS, Filter stats
    wire filter_tab_pic_1_ptr_in = (ufds_settings_mode) && (info_idx == 3'd4) && (frame_x >= (lookup[(NUM_ACTL-13)*ATTRS] + ufds_t_x) && frame_x <= (lookup[(NUM_ACTL-13)*ATTRS] + lookup[(NUM_ACTL-13)*ATTRS + 2] + ufds_t_x)) && (frame_y >= (lookup[(NUM_ACTL-13)*ATTRS + 1] + ufds_t_y) && frame_y < (lookup[(NUM_ACTL-13)*ATTRS + 1] + lookup[(NUM_ACTL-13)*ATTRS + 3] + ufds_t_y)) && frame_y < 326;
    wire filter_tab_pic_1_ptr_look_ahead_in = (ufds_settings_mode) && (info_idx == 3'd4) && (frame_x_next >= (lookup[(NUM_ACTL-13)*ATTRS] + ufds_t_x) && frame_x_next <= (lookup[(NUM_ACTL-13)*ATTRS] + lookup[(NUM_ACTL-13)*ATTRS + 2] + ufds_t_x)) && (frame_y_next >= (lookup[(NUM_ACTL-13)*ATTRS + 1] + ufds_t_y) && frame_y_next < (lookup[(NUM_ACTL-13)*ATTRS + 1] + lookup[(NUM_ACTL-13)*ATTRS + 3] + ufds_t_y)) && frame_y_next < 326;

    wire filter_tab_pic_2_ptr_in = (ufds_settings_mode) && (info_idx == 3'd4) && (frame_x >= (lookup[(NUM_ACTL-12)*ATTRS] + ufds_t_x) && frame_x <= (lookup[(NUM_ACTL-12)*ATTRS] + lookup[(NUM_ACTL-12)*ATTRS + 2] + ufds_t_x)) && (frame_y >= (lookup[(NUM_ACTL-12)*ATTRS + 1] + ufds_t_y) && frame_y < (lookup[(NUM_ACTL-12)*ATTRS + 1] + lookup[(NUM_ACTL-12)*ATTRS + 3] + ufds_t_y)) && frame_y < 326;
    wire filter_tab_pic_2_ptr_look_ahead_in = (ufds_settings_mode) && (info_idx == 3'd4) && (frame_x_next >= (lookup[(NUM_ACTL-12)*ATTRS] + ufds_t_x) && frame_x_next <= (lookup[(NUM_ACTL-12)*ATTRS] + lookup[(NUM_ACTL-12)*ATTRS + 2] + ufds_t_x)) && (frame_y_next >= (lookup[(NUM_ACTL-12)*ATTRS + 1] + ufds_t_y) && frame_y_next < (lookup[(NUM_ACTL-12)*ATTRS + 1] + lookup[(NUM_ACTL-12)*ATTRS + 3] + ufds_t_y)) && frame_y_next < 326;

    wire filter_tab_hdr_ptr_in = (ufds_settings_mode) && (info_idx == 3'd4) && (frame_x >= (lookup[(NUM_ACTL-11)*ATTRS] + ufds_t_x) && frame_x < (lookup[(NUM_ACTL-11)*ATTRS] + lookup[(NUM_ACTL-11)*ATTRS + 2] + ufds_t_x)) && (frame_y >= (lookup[(NUM_ACTL-11)*ATTRS + 1] + ufds_t_y) && frame_y < (lookup[(NUM_ACTL-11)*ATTRS + 1] + lookup[(NUM_ACTL-11)*ATTRS + 3] + ufds_t_y));
    wire filter_tab_hdr_ptr_look_ahead_in = (ufds_settings_mode) && (info_idx == 3'd4) && (frame_x_next >= (lookup[(NUM_ACTL-11)*ATTRS] + ufds_t_x) && frame_x_next < (lookup[(NUM_ACTL-11)*ATTRS] + lookup[(NUM_ACTL-11)*ATTRS + 2] + ufds_t_x)) && (frame_y_next >= (lookup[(NUM_ACTL-11)*ATTRS + 1] + ufds_t_y) && frame_y_next < (lookup[(NUM_ACTL-11)*ATTRS + 1] + lookup[(NUM_ACTL-11)*ATTRS + 3] + ufds_t_y));

    // UFDS, Bounding Box
    wire bb_tab_pic_1_ptr_in = (ufds_settings_mode) && (info_idx == 3'd5) && (frame_x >= (lookup[(NUM_ACTL-10)*ATTRS] + ufds_t_x) && frame_x <= (lookup[(NUM_ACTL-10)*ATTRS] + lookup[(NUM_ACTL-10)*ATTRS + 2] + ufds_t_x)) && (frame_y >= (lookup[(NUM_ACTL-10)*ATTRS + 1] + ufds_t_y) && frame_y < (lookup[(NUM_ACTL-10)*ATTRS + 1] + lookup[(NUM_ACTL-10)*ATTRS + 3] + ufds_t_y)) && frame_y < 326;
    wire bb_tab_pic_1_ptr_look_ahead_in = (ufds_settings_mode) && (info_idx == 3'd5) && (frame_x_next >= (lookup[(NUM_ACTL-10)*ATTRS] + ufds_t_x) && frame_x_next <= (lookup[(NUM_ACTL-10)*ATTRS] + lookup[(NUM_ACTL-10)*ATTRS + 2] + ufds_t_x)) && (frame_y_next >= (lookup[(NUM_ACTL-10)*ATTRS + 1] + ufds_t_y) && frame_y_next < (lookup[(NUM_ACTL-10)*ATTRS + 1] + lookup[(NUM_ACTL-10)*ATTRS + 3] + ufds_t_y)) && frame_y_next < 326;

    wire bb_tab_pic_2_ptr_in = (ufds_settings_mode) && (info_idx == 3'd5) && (frame_x >= (lookup[(NUM_ACTL-9)*ATTRS] + ufds_t_x) && frame_x <= (lookup[(NUM_ACTL-9)*ATTRS] + lookup[(NUM_ACTL-9)*ATTRS + 2] + ufds_t_x)) && (frame_y >= (lookup[(NUM_ACTL-9)*ATTRS + 1] + ufds_t_y) && frame_y < (lookup[(NUM_ACTL-9)*ATTRS + 1] + lookup[(NUM_ACTL-9)*ATTRS + 3] + ufds_t_y)) && frame_y < 326;
    wire bb_tab_pic_2_ptr_look_ahead_in = (ufds_settings_mode) && (info_idx == 3'd5) && (frame_x_next >= (lookup[(NUM_ACTL-9)*ATTRS] + ufds_t_x) && frame_x_next <= (lookup[(NUM_ACTL-9)*ATTRS] + lookup[(NUM_ACTL-9)*ATTRS + 2] + ufds_t_x)) && (frame_y_next >= (lookup[(NUM_ACTL-9)*ATTRS + 1] + ufds_t_y) && frame_y_next < (lookup[(NUM_ACTL-9)*ATTRS + 1] + lookup[(NUM_ACTL-9)*ATTRS + 3] + ufds_t_y)) && frame_y_next < 326;

    wire bb_tab_hdr_ptr_in = (ufds_settings_mode) && (info_idx == 3'd5) && (frame_x >= (lookup[(NUM_ACTL-8)*ATTRS] + ufds_t_x) && frame_x < (lookup[(NUM_ACTL-8)*ATTRS] + lookup[(NUM_ACTL-8)*ATTRS + 2] + ufds_t_x)) && (frame_y >= (lookup[(NUM_ACTL-8)*ATTRS + 1] + ufds_t_y) && frame_y < (lookup[(NUM_ACTL-8)*ATTRS + 1] + lookup[(NUM_ACTL-8)*ATTRS + 3] + ufds_t_y)) && frame_y < 326;
    wire bb_tab_hdr_ptr_look_ahead_in = (ufds_settings_mode) && (info_idx == 3'd5) && (frame_x_next >= (lookup[(NUM_ACTL-8)*ATTRS] + ufds_t_x) && frame_x_next < (lookup[(NUM_ACTL-8)*ATTRS] + lookup[(NUM_ACTL-8)*ATTRS + 2] + ufds_t_x)) && (frame_y_next >= (lookup[(NUM_ACTL-8)*ATTRS + 1] + ufds_t_y) && frame_y_next < (lookup[(NUM_ACTL-8)*ATTRS + 1] + lookup[(NUM_ACTL-8)*ATTRS + 3] + ufds_t_y)) && frame_y_next < 326;

    wire bb_tab_hdr_2_ptr_in = (ufds_settings_mode) && (info_idx == 3'd5) && (frame_x >= (lookup[(NUM_ACTL-7)*ATTRS] + ufds_t_x) && frame_x < (lookup[(NUM_ACTL-7)*ATTRS] + lookup[(NUM_ACTL-7)*ATTRS + 2] + ufds_t_x)) && (frame_y >= (lookup[(NUM_ACTL-7)*ATTRS + 1] + ufds_t_y) && frame_y < (lookup[(NUM_ACTL-7)*ATTRS + 1] + lookup[(NUM_ACTL-7)*ATTRS + 3] + ufds_t_y));
    wire bb_tab_hdr_2_ptr_look_ahead_in = (ufds_settings_mode) && (info_idx == 3'd5) && (frame_x_next >= (lookup[(NUM_ACTL-7)*ATTRS] + ufds_t_x) && frame_x_next < (lookup[(NUM_ACTL-7)*ATTRS] + lookup[(NUM_ACTL-7)*ATTRS + 2] + ufds_t_x)) && (frame_y_next >= (lookup[(NUM_ACTL-7)*ATTRS + 1] + ufds_t_y) && frame_y_next < (lookup[(NUM_ACTL-7)*ATTRS + 1] + lookup[(NUM_ACTL-7)*ATTRS + 3] + ufds_t_y));


    integer eye_i_idx;
    integer eye_start_addr;
    integer i,j,k;
    reg [2:0] sel; // 0:gauss 1:median 2:erode1 3:erode2 4:dilate1 5:dilate2 7:none
    always @ (posedge clk25) begin

        // Elements within info box has least priority
            if (fr_tab_pic_1_ptr_look_ahead_in)        overlay_addr <= lookup[(NUM_ACTL-23)*ATTRS + 4] + ( (frame_y_next - lookup[(NUM_ACTL-23)*ATTRS + 1] - ufds_t_y) * lookup[(NUM_ACTL-23)*ATTRS + 2] )  + (frame_x_next - lookup[(NUM_ACTL-23)*ATTRS + 0] - ufds_t_x);
        else if (fr_tab_pic_2_ptr_look_ahead_in)        overlay_addr <= lookup[(NUM_ACTL-22)*ATTRS + 4] + ( (frame_y_next - lookup[(NUM_ACTL-22)*ATTRS + 1] - ufds_t_y) * lookup[(NUM_ACTL-22)*ATTRS + 2] )  + (frame_x_next - lookup[(NUM_ACTL-22)*ATTRS + 0] - ufds_t_x);
        else if (fr_tab_hdr_ptr_look_ahead_in)          overlay_addr <= lookup[(NUM_ACTL-21)*ATTRS + 4] + ( (frame_y_next - lookup[(NUM_ACTL-21)*ATTRS + 1] - ufds_t_y) * lookup[(NUM_ACTL-21)*ATTRS + 2] )  + (frame_x_next - lookup[(NUM_ACTL-21)*ATTRS + 0] - ufds_t_x);
        else if (union_tab_pic_1_ptr_look_ahead_in)     overlay_addr <= lookup[(NUM_ACTL-20)*ATTRS + 4] + ( (frame_y_next - lookup[(NUM_ACTL-20)*ATTRS + 1] - ufds_t_y) * lookup[(NUM_ACTL-20)*ATTRS + 2] )  + (frame_x_next - lookup[(NUM_ACTL-20)*ATTRS + 0] - ufds_t_x);
        else if (union_tab_pic_2_ptr_look_ahead_in)     overlay_addr <= lookup[(NUM_ACTL-19)*ATTRS + 4] + ( (frame_y_next - lookup[(NUM_ACTL-19)*ATTRS + 1] - ufds_t_y) * lookup[(NUM_ACTL-19)*ATTRS + 2] )  + (frame_x_next - lookup[(NUM_ACTL-19)*ATTRS + 0] - ufds_t_x);
        else if (union_tab_hdr_ptr_look_ahead_in)       overlay_addr <= lookup[(NUM_ACTL-18)*ATTRS + 4] + ( (frame_y_next - lookup[(NUM_ACTL-18)*ATTRS + 1] - ufds_t_y) * lookup[(NUM_ACTL-18)*ATTRS + 2] )  + (frame_x_next - lookup[(NUM_ACTL-18)*ATTRS + 0] - ufds_t_x);
        else if (update_tab_pic_1_ptr_look_ahead_in)    overlay_addr <= lookup[(NUM_ACTL-17)*ATTRS + 4] + ( (frame_y_next - lookup[(NUM_ACTL-17)*ATTRS + 1] - ufds_t_y) * lookup[(NUM_ACTL-17)*ATTRS + 2] )  + (frame_x_next - lookup[(NUM_ACTL-17)*ATTRS + 0] - ufds_t_x);
        else if (update_tab_pic_2_ptr_look_ahead_in)    overlay_addr <= lookup[(NUM_ACTL-16)*ATTRS + 4] + ( (frame_y_next - lookup[(NUM_ACTL-16)*ATTRS + 1] - ufds_t_y) * lookup[(NUM_ACTL-16)*ATTRS + 2] )  + (frame_x_next - lookup[(NUM_ACTL-16)*ATTRS + 0] - ufds_t_x);
        else if (update_tab_hdr_ptr_look_ahead_in)      overlay_addr <= lookup[(NUM_ACTL-15)*ATTRS + 4] + ( (frame_y_next - lookup[(NUM_ACTL-15)*ATTRS + 1] - ufds_t_y) * lookup[(NUM_ACTL-15)*ATTRS + 2] )  + (frame_x_next - lookup[(NUM_ACTL-15)*ATTRS + 0] - ufds_t_x);
        else if (update_tab_hdr_2_ptr_look_ahead_in)    overlay_addr <= lookup[(NUM_ACTL-14)*ATTRS + 4] + ( (frame_y_next - lookup[(NUM_ACTL-14)*ATTRS + 1] - ufds_t_y) * lookup[(NUM_ACTL-14)*ATTRS + 2] )  + (frame_x_next - lookup[(NUM_ACTL-14)*ATTRS + 0] - ufds_t_x);
        else if (filter_tab_pic_1_ptr_look_ahead_in)    overlay_addr <= lookup[(NUM_ACTL-13)*ATTRS + 4] + ( (frame_y_next - lookup[(NUM_ACTL-13)*ATTRS + 1] - ufds_t_y) * lookup[(NUM_ACTL-13)*ATTRS + 2] )  + (frame_x_next - lookup[(NUM_ACTL-13)*ATTRS + 0] - ufds_t_x);
        else if (filter_tab_pic_2_ptr_look_ahead_in)    overlay_addr <= lookup[(NUM_ACTL-12)*ATTRS + 4] + ( (frame_y_next - lookup[(NUM_ACTL-12)*ATTRS + 1] - ufds_t_y) * lookup[(NUM_ACTL-12)*ATTRS + 2] )  + (frame_x_next - lookup[(NUM_ACTL-12)*ATTRS + 0] - ufds_t_x);
        else if (filter_tab_hdr_ptr_look_ahead_in)      overlay_addr <= lookup[(NUM_ACTL-11)*ATTRS + 4] + ( (frame_y_next - lookup[(NUM_ACTL-11)*ATTRS + 1] - ufds_t_y) * lookup[(NUM_ACTL-11)*ATTRS + 2] )  + (frame_x_next - lookup[(NUM_ACTL-11)*ATTRS + 0] - ufds_t_x);
        else if (bb_tab_pic_1_ptr_look_ahead_in)        overlay_addr <= lookup[(NUM_ACTL-10)*ATTRS + 4] + ( (frame_y_next - lookup[(NUM_ACTL-10)*ATTRS + 1] - ufds_t_y) * lookup[(NUM_ACTL-10)*ATTRS + 2] )  + (frame_x_next - lookup[(NUM_ACTL-10)*ATTRS + 0] - ufds_t_x);
        else if (bb_tab_pic_2_ptr_look_ahead_in)        overlay_addr <= lookup[(NUM_ACTL-9) *ATTRS + 4] + ( (frame_y_next - lookup[(NUM_ACTL-9) *ATTRS + 1] - ufds_t_y) * lookup[(NUM_ACTL-9)*ATTRS +  2] )  + (frame_x_next - lookup[(NUM_ACTL-9)* ATTRS + 0] - ufds_t_x);
        else if (bb_tab_hdr_ptr_look_ahead_in)          overlay_addr <= lookup[(NUM_ACTL-8) *ATTRS + 4] + ( (frame_y_next - lookup[(NUM_ACTL-8) *ATTRS + 1] - ufds_t_y) * lookup[(NUM_ACTL-8)*ATTRS +  2] )  + (frame_x_next - lookup[(NUM_ACTL-8)* ATTRS + 0] - ufds_t_x);
        else if (bb_tab_hdr_2_ptr_look_ahead_in)        overlay_addr <= lookup[(NUM_ACTL-7) *ATTRS + 4] + ( (frame_y_next - lookup[(NUM_ACTL-7) *ATTRS + 1] - ufds_t_y) * lookup[(NUM_ACTL-7)*ATTRS +  2] )  + (frame_x_next - lookup[(NUM_ACTL-7)* ATTRS + 0] - ufds_t_x);        

        for (i=0; i<NUM_usr; i=i+1) begin
            if (usr_ptr_look_ahead_in[i]) begin
                if ((i >= 14) && (i <= 17)) begin
                    eye_i_idx = i - 14; // 0..3
                    // lookup[14*ATTRS + 4] == start addr for open-eye bitmap
                    // lookup[15*ATTRS + 4] == start addr for closed-eye bitmap (shared in this asset layout)
                    eye_start_addr = (eye_i_idx == final_out) ? lookup[14*ATTRS + 4] : lookup[15*ATTRS + 4];
                    overlay_addr <= eye_start_addr + (frame_y_next - lookup[i*ATTRS + 1]) * lookup[i*ATTRS + 2] + (frame_x_next - lookup[i*ATTRS + 0]);
                end else begin
                    overlay_addr <= lookup[i*ATTRS + 4] + (frame_y_next - lookup[i*ATTRS + 1]) * lookup[i*ATTRS + 2] + (frame_x_next - lookup[i*ATTRS + 0]);
                end
            end
        end
        for (j=0; j<NUM_ufds; j=j+1) begin
            if (ufds_ptr_look_ahead_in[j]) begin
                overlay_addr <= lookup[(NUM_usr + j)*ATTRS + 4] + (frame_y_next - lookup[(NUM_usr + j)*ATTRS + 1]) * lookup[(NUM_usr + j)*ATTRS + 2] + (frame_x_next - lookup[(NUM_usr + j)*ATTRS + 0]);
            end
        end
        for(k=0; k<NUM_menu; k=k+1) begin
            if (menu_ptr_look_ahead_in[k]) begin
                overlay_addr <= lookup[(NUM_usr + NUM_ufds + k)*ATTRS + 4] + (frame_y_next - lookup[(NUM_usr + NUM_ufds + k)*ATTRS + 1]) * lookup[(NUM_usr + NUM_ufds + k)*ATTRS + 2] + (frame_x_next - lookup[(NUM_usr + NUM_ufds + k)*ATTRS + 0]);
            end
        end

        // SEE ABOVE: LOOP UNROLLING BECAUSE SOMEWHERE IN GENERATE DON'T WORK
        sel = 3'd7; // none
        // Is the foreground box under the pixel?
        if      ((front_idx == 3'd0) && gauss_block_ptr_look_ahead_in) sel = 3'd0;
        else if ((front_idx == 3'd1) && median_block_ptr_look_ahead_in) sel = 3'd1;
        else if ((front_idx == 3'd2) && erode_1_block_ptr_look_ahead_in) sel = 3'd2;
        else if ((front_idx == 3'd3) && erode_2_block_ptr_look_ahead_in) sel = 3'd3;
        else if ((front_idx == 3'd4) && dilate_1_block_ptr_look_ahead_in) sel = 3'd4;
        else if ((front_idx == 3'd5) && dilate_2_block_ptr_look_ahead_in) sel = 3'd5;
        else if ((front_idx == 3'd6) && ufds_tab_ptr_look_ahead_in) sel = 3'd6;
        // Otherwise fall back to fixed z-order
        else if (gauss_block_ptr_look_ahead_in) sel = 3'd0;
        else if (median_block_ptr_look_ahead_in) sel = 3'd1;
        else if (erode_1_block_ptr_look_ahead_in) sel = 3'd2;
        else if (erode_2_block_ptr_look_ahead_in) sel = 3'd3;
        else if (dilate_1_block_ptr_look_ahead_in) sel = 3'd4;
        else if (dilate_2_block_ptr_look_ahead_in) sel = 3'd5;
        else if (ufds_tab_ptr_look_ahead_in) sel = 3'd6;

        case (sel)
            3'd0: overlay_addr <= lookup[(NUM_ACTL-6)*ATTRS+4] + (frame_y_next - (y[8:0]+4)) * lookup[(NUM_ACTL-6)*ATTRS + 2] + (frame_x_next - (x[9:0]+2));
            3'd1: overlay_addr <= lookup[(NUM_ACTL-5)*ATTRS+4] + (frame_y_next - (y[17:9]+4)) * lookup[(NUM_ACTL-5)*ATTRS + 2] + (frame_x_next - (x[19:10]+8));
            3'd2: begin
                if (morph_state[0]) overlay_addr <= lookup[(NUM_ACTL-4)*ATTRS+4] + (frame_y_next - (y[26:18])) * lookup[(NUM_ACTL-4)*ATTRS + 2] + (frame_x_next - (x[29:20]));
                else overlay_addr <= lookup[(NUM_ACTL-2)*ATTRS+4] + (frame_y_next - (y[26:18])) * lookup[(NUM_ACTL-2)*ATTRS + 2] + (frame_x_next - (x[29:20]));
            end
            3'd3: begin
                if (morph_state[1]) overlay_addr <= lookup[(NUM_ACTL-3)*ATTRS+4] + (frame_y_next - (y[35:27])) * lookup[(NUM_ACTL-3)*ATTRS + 2] + (frame_x_next - (x[39:30]));
                else overlay_addr <= lookup[(NUM_ACTL-1)*ATTRS+4] + (frame_y_next - (y[35:27])) * lookup[(NUM_ACTL-1)*ATTRS + 2] + (frame_x_next - (x[39:30]));
            end
            3'd4: begin
                if (morph_state[2]) overlay_addr <= lookup[(NUM_ACTL-4)*ATTRS+4] + (frame_y_next - (y[44:36])) * lookup[(NUM_ACTL-4)*ATTRS + 2] + (frame_x_next - (x[49:40]));
                else overlay_addr <= lookup[(NUM_ACTL-2)*ATTRS+4] + (frame_y_next - (y[44:36])) * lookup[(NUM_ACTL-2)*ATTRS + 2] + (frame_x_next - (x[49:40]));
            end
            3'd5: begin
                if (morph_state[3]) overlay_addr <= lookup[(NUM_ACTL-3)*ATTRS+4] + (frame_y_next - (y[53:45])) * lookup[(NUM_ACTL-3)*ATTRS + 2] + (frame_x_next - (x[59:50]));
                else overlay_addr <= lookup[(NUM_ACTL-1)*ATTRS+4] + (frame_y_next - (y[53:45])) * lookup[(NUM_ACTL-1)*ATTRS + 2] + (frame_x_next - (x[59:50]));
            end
            3'd6: overlay_addr <= lookup[24*ATTRS + 4] + (frame_y_next - ufds_t_y) * lookup[24*ATTRS + 2] + (frame_x_next - ufds_t_x);
            default: ;  // keep last overlay_addr from static elements
        endcase
    end

    assign to_write = en ? ((|usr_ptr_in) || (|ufds_ptr_in) || (|menu_ptr_in) || 
        // (|usr_active_ptr_in) || 
        gauss_block_ptr_in || median_block_ptr_in || erode_1_block_ptr_in || erode_2_block_ptr_in || dilate_1_block_ptr_in || dilate_2_block_ptr_in ||
        ufds_tab_ptr_in ||
        fr_tab_pic_1_ptr_in || fr_tab_pic_2_ptr_in || fr_tab_hdr_ptr_in ||
        union_tab_pic_1_ptr_in || union_tab_pic_2_ptr_in || union_tab_hdr_ptr_in ||
        update_tab_pic_1_ptr_in || update_tab_pic_2_ptr_in || update_tab_hdr_ptr_in || update_tab_hdr_2_ptr_in ||
        filter_tab_pic_1_ptr_in || filter_tab_pic_2_ptr_in || filter_tab_hdr_ptr_in ||
        bb_tab_pic_1_ptr_in || bb_tab_pic_2_ptr_in || bb_tab_hdr_ptr_in || bb_tab_hdr_2_ptr_in
    ) : 1'b0;

endmodule
