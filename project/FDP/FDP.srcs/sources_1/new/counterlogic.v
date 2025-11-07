module Education_Tabs (
    input clk,
    input clk25,
    input rst,
    input [9:0] frame_x,                    // VGA current x coord
    input [9:0] frame_y,                    // VGA current y coord
    input [9:0] change_x,                   // X from info_tab
    input [8:0] change_y,                   // Y from info_tab
    input [4:0] info_select,                // Which info tab to show 0 - neighbor, 1 - union, 2 - stats, 3 - filter, 4 - building, 5 - gaussian, 6 - median, 7 - erode, 8- dilate
    output [11:0] edu_rgb,                  // 12-bit pixel data from edu tabs (black/white)
    output reg edu_pixel_en                 // High when this module wants top.v to overwrite pixel with edu_rgb
);

    reg [11:0] edu_tab_addr;
    // BRAM stores monochrome glyph pixels (1 bit per pixel). We'll read a 1-bit
    // pixel and expand to 4-bit palette outside this module if needed.
    wire [3:0] bram_px4;
    Single_Port_Buffer #(
        .DATA_WIDTH(1),
        .BUFFER_SIZE(2500)
    ) edu_tab_bram (
        .clk(clk25),
        .addr(edu_tab_addr),
        .dout(bram_px4)
    );


// ---------- NEIGHBOURS ----------
    localparam integer  neighbor1_num = 29,
                        neighbor2_num = 26,
                        neighbor3_num = 6,
                        neighbor4_num = 31,
                        neighbor5_num = 29,
                        neighbor6_num = 33;

    localparam integer neighbor_paragraphs = 2;

    localparam integer neighbor1 [0: (neighbor1_num - 1)] = {
        4, 26, 28, 33, 52, 48, 33, 34, 45, 30, 52, 41, 34, 49, 30, 37, 57, 53, 58, 52, 34, 44, 52, 26, 52, 39, 40, 29, 30
    };
    localparam integer neighbor2 [0: (neighbor2_num - 1)] = {
        34, 13, 52, 0, 52, 6, 17, 8, 3, 55, 52, 13, 4, 8, 6, 7, 1, 14, 20, 17, 18, 52, 5, 14, 17, 12
    };
    localparam integer neighbor3 [0: (neighbor3_num - 1)] = {
        30, 3, 6, 4, 18, 56
    };
    localparam integer neighbor4 [0: (neighbor4_num - 1)] = {
        5, 40, 43, 52, 11, 30, 31, 45, 55, 52, 20, 41, 41, 30, 43, 52, 11, 30, 31, 45, 55, 52, 20, 41, 41, 30, 43, 52, 26, 39, 29
    };
    localparam integer neighbor5 [0: (neighbor5_num - 1)] = {
        20, 41, 41, 30, 43, 52, 17, 34, 32, 33, 45, 52, 41, 34, 49, 30, 37, 55, 52, 31, 34, 39, 29, 52, 45, 33, 30, 34, 43
    };
    localparam integer neighbor6 [0: (neighbor6_num - 1)] = {
        43, 40, 40, 45, 52, 27, 50, 52, 48, 26, 37, 36, 34, 39, 32, 52, 46, 41, 52, 45, 33, 30, 34, 43, 52, 41, 26, 43, 30, 39, 45, 44, 56
    };

    // Start coords of neighbor paragraphs
    localparam integer neighbor_stats [0 : (neighbor_paragraphs * 3) - 1] = {
        93, 38, 3,     // X start, Y start, num lines 1st paragraph
        93, 90, 3      // X start, Y start, num lines 2nd paragraph 
    };

    // NOTE: removed a stray/incorrect block that referenced PIX_Y_TOP/PIX_X.
    // The main address generation is below and handles info_select cases.



// ---------- Union Components (disabled for now; neighbors only) ----------

    // Start of Union components paragraphs
    localparam integer union_paragraphs = 1;
    localparam integer union_stats [0 : (union_paragraphs * 3) - 1] = {
        93, 38, 5     // X start, Y start 1st paragraph
    };

    localparam integer union1_num = 25,
                     union2_num = 29,
                     union3_num = 30,
                     union4_num = 26,
                     union5_num = 24;

    localparam integer union1 [0 : (union1_num - 1)] = {
        0, 37, 37, 40, 28, 26, 45, 30, 52, 28, 46, 43, 43, 30, 39, 45, 52, 41, 34, 49, 30, 37, 52, 34, 31
    };
    localparam integer union2 [0 : (union2_num - 1)] = {
        39, 30, 34, 32, 33, 27, 40, 46, 43, 44, 52, 33, 26, 47, 30, 52, 39, 40, 52, 43, 40, 40, 45, 44, 57, 34, 45, 52, 34
    };
    localparam integer union3 [0 : (union3_num - 1)] = {
        26, 52, 39, 30, 48, 52, 28, 40, 38, 41, 40, 39, 30, 39, 45, 58, 56, 52, 4, 37, 44, 30, 55, 52, 41, 34, 28, 36, 52, 26
    };
    localparam integer union4 [0 : (union4_num - 1)] = {
        39, 30, 34, 32, 33, 27, 40, 46, 43, 34, 39, 32, 52, 28, 40, 38, 41, 40, 39, 30, 39, 45, 52, 26, 39, 29
    };
    localparam integer union5 [0 : (union5_num - 1)] = {
        46, 39, 34, 40, 39, 52, 34, 39, 45, 40, 52, 40, 39, 30, 52, 28, 40, 38, 41, 40, 39, 30, 39, 45
    };


// ---------- Statistics ----------
    localparam integer statistics_paragraphs = 1;
    localparam integer statistics_stats [0 : (statistics_paragraphs * 3) - 1] = {
        93, 38, 5     // X start, Y start 1st paragraph
    };

    localparam integer stats1_num = 22,
                     stats2_num = 30,
                     stats3_num = 31,
                     stats4_num = 28,
                     stats5_num = 18;
    localparam integer stats1 [0 : (stats1_num - 1)] = {
        0, 44, 52, 31, 43, 26, 38, 30, 52, 27, 46, 34, 37, 29, 44, 55, 52, 46, 39, 34, 40, 39
    };

    localparam integer stats2 [0 : (stats2_num - 1)] = {
        39, 30, 34, 32, 33, 27, 40, 46, 43, 44, 52, 26, 39, 29, 52, 32, 43, 40, 48, 52, 28, 40, 38, 41, 40, 39, 30, 39, 45, 44
    };
    localparam integer stats3 [0 : (stats3_num - 1)] = {
        4, 26, 28, 33, 52, 28, 40, 38, 41, 40, 39, 30, 39, 45, 52, 44, 45, 40, 43, 30, 44, 52, 26, 52, 43, 46, 39, 39, 34, 39, 32
    };
    localparam integer stats4 [0 : (stats4_num - 1)] = {
        26, 43, 30, 26, 52, 28, 40, 46, 39, 45, 52, 26, 39, 29, 52, 38, 34, 39, 55, 52, 38, 26, 49, 52, 49, 55, 52, 50
    };
    localparam integer stats5 [0 : (stats5_num - 1)] = {
        31, 40, 43, 52, 27, 40, 46, 39, 29, 34, 39, 32, 52, 27, 40, 49, 30, 44
    };


// ---------- Filters ----------

    localparam integer filter_paragraphs = 1;
    localparam integer filter_stats [0 : (filter_paragraphs * 3) - 1] = {
        93, 38, 6     // X start, Y start 1st paragraph
    };

    localparam integer filter1_num = 31;
    localparam integer filter2_num = 26;
    localparam integer filter3_num = 28;
    localparam integer filter4_num = 26;
    localparam integer filter5_num = 29;
    localparam integer filter6_num = 31;

    localparam integer filter1 [0 : (filter1_num - 1)] = {
        17, 30, 38, 40, 47, 30, 52, 45, 34, 39, 50, 52, 28, 40, 38, 41, 40, 39, 30, 39, 45, 44, 52, 26, 44, 52, 45, 33, 30, 43, 30
    };
    localparam integer filter2 [0 : (filter2_num - 1)] = {
        38, 26, 50, 52, 27, 30, 52, 39, 40, 34, 44, 30, 55, 52, 27, 50, 52, 38, 34, 39, 52, 26, 43, 30, 26, 55
    };
    localparam integer filter3 [0 : (filter3_num - 1)] = {
        33, 30, 34, 32, 33, 45, 55, 52, 48, 34, 29, 45, 33, 52, 26, 44, 52, 41, 26, 43, 26, 38, 30, 45, 30, 43, 44, 56
    };
    localparam integer filter4 [0 : (filter4_num - 1)] = {
        2, 33, 40, 40, 44, 30, 52, 48, 33, 34, 28, 33, 52, 41, 26, 43, 26, 38, 30, 45, 30, 43, 44, 52, 45, 40
    };
    localparam integer filter5 [0 : (filter5_num - 1)] = {
        29, 30, 45, 30, 43, 38, 34, 39, 30, 52, 48, 33, 34, 28, 33, 52, 41, 26, 43, 26, 38, 30, 45, 30, 43, 44, 52, 45, 40
    };
    localparam integer filter6 [0 : (filter6_num - 1)] = {
        26, 43, 30, 26, 55, 52, 33, 30, 34, 32, 33, 45, 55, 52, 48, 34, 29, 45, 33, 55, 52, 41, 43, 40, 49, 34, 38, 34, 45, 50, 58
    };


// ---------- Buildings ----------
    localparam integer building_paragraphs = 1;
    localparam integer building_stats [0 : (building_paragraphs * 3) - 1] = {
        93, 38, 2     // X start, Y start 1st paragraph
    };
    localparam integer building1_num = 27;
    localparam integer building2_num = 16;

    localparam integer building1 [0 : (building1_num - 1)] = {
        15, 34, 28, 36, 52, 46, 41, 52, 45, 40, 52, 54, 52, 28, 40, 38, 41, 40, 39, 30, 39, 45, 44, 52, 26, 39, 29
    };
    localparam integer building2 [0 : (building2_num - 1)] = {
        29, 43, 26, 48, 52, 45, 33, 30, 34, 43, 52, 27, 40, 49, 30, 44
    };


// ---------- GAUSSIAN ----------

// ---------- MEDIAN ----------

// ---------- ERODE ----------

// ---------- DILATE ----------

    localparam integer width = 5, height = 8;
    localparam integer area = width * height;

    wire [9:0] rel_x = frame_x - change_x;
    wire [8:0] rel_y = frame_y - change_y;

    reg [9:0] int_x_ctr;
    reg [8:0] int_y_ctr;

    always @ (posedge clk25) begin
        
    end

endmodule;