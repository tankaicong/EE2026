module Education_Tabs_ctr (
    input clk,
    input clk25,
    input rst,

    output [7:0] seg,
    output [3:0] an,
    output reg [15:0] led,

    input [9:0] frame_x,                    // VGA current x coord
    input [9:0] frame_y,                    // VGA current y coord
    input [9:0] change_x,                   // X from info_tab
    input [8:0] change_y,                   // Y from info_tab
    input [4:0] info_select,                // Which info tab to show 0 - neighbor, 1 - union, 2 - stats, 3 - filter, 4 - building, 5 - gaussian, 6 - median, 7 - erode, 8- dilate
    input signed [9:0] input_offset,
    output [11:0] edu_rgb,                  // 12-bit pixel data from edu tabs (black/white)
    output reg edu_pixel_en                 // High when this module wants top.v to overwrite pixel with edu_rgb
);

    reg [11:0] edu_tab_addr;
    // BRAM stores monochrome glyph pixels (1 bit per pixel). We'll read a 1-bit
    // pixel and expand to 4-bit palette outside this module if needed.
    wire [3:0] bram_px4;
    Single_Port_Buffer #(
        .DATA_WIDTH(1),
        .BUFFER_SIZE(2500),
        .CHOICE(1)
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

    // ----------------------------------------------------------------
    // Line selection and glyph lookup (combinational)
    // line_length = number of glyphs in the selected text line
    // glyph_code  = current glyph code at index char_idx for that line
    // use_par1    = selects 2nd paragraph (neighbors only)
    // line_idx    = 0..n-1 within the chosen paragraph; 4'hF means inactive
    // ----------------------------------------------------------------
    reg [7:0] line_length; reg [7:0] glyph_code;
    reg       use_par1;
    always @* begin
		line_length = 0; glyph_code = 0;
		if(line_idx != 4'hF) begin
			case(info_select)
				5'd0: if(!use_par1) begin
						case(line_idx)
							0: begin line_length = neighbor1_num; if(char_idx < neighbor1_num) glyph_code = neighbor1[char_idx]; end
							1: begin line_length = neighbor2_num; if(char_idx < neighbor2_num) glyph_code = neighbor2[char_idx]; end
							2: begin line_length = neighbor3_num; if(char_idx < neighbor3_num) glyph_code = neighbor3[char_idx]; end
						endcase
					  end else begin
						case(line_idx)
							0: begin line_length = neighbor4_num; if(char_idx < neighbor4_num) glyph_code = neighbor4[char_idx]; end
							1: begin line_length = neighbor5_num; if(char_idx < neighbor5_num) glyph_code = neighbor5[char_idx]; end
							2: begin line_length = neighbor6_num; if(char_idx < neighbor6_num) glyph_code = neighbor6[char_idx]; end
						endcase
					  end
				5'd1: case(line_idx)
						0: begin line_length = union1_num; if(char_idx < union1_num) glyph_code = union1[char_idx]; end
						1: begin line_length = union2_num; if(char_idx < union2_num) glyph_code = union2[char_idx]; end
						2: begin line_length = union3_num; if(char_idx < union3_num) glyph_code = union3[char_idx]; end
						3: begin line_length = union4_num; if(char_idx < union4_num) glyph_code = union4[char_idx]; end
						4: begin line_length = union5_num; if(char_idx < union5_num) glyph_code = union5[char_idx]; end
					  endcase
				5'd2: case(line_idx)
						0: begin line_length = stats1_num; if(char_idx < stats1_num) glyph_code = stats1[char_idx]; end
						1: begin line_length = stats2_num; if(char_idx < stats2_num) glyph_code = stats2[char_idx]; end
						2: begin line_length = stats3_num; if(char_idx < stats3_num) glyph_code = stats3[char_idx]; end
						3: begin line_length = stats4_num; if(char_idx < stats4_num) glyph_code = stats4[char_idx]; end
						4: begin line_length = stats5_num; if(char_idx < stats5_num) glyph_code = stats5[char_idx]; end
					  endcase
				5'd3: case(line_idx)
						0: begin line_length = filter1_num; if(char_idx < filter1_num) glyph_code = filter1[char_idx]; end
						1: begin line_length = filter2_num; if(char_idx < filter2_num) glyph_code = filter2[char_idx]; end
						2: begin line_length = filter3_num; if(char_idx < filter3_num) glyph_code = filter3[char_idx]; end
						3: begin line_length = filter4_num; if(char_idx < filter4_num) glyph_code = filter4[char_idx]; end
						4: begin line_length = filter5_num; if(char_idx < filter5_num) glyph_code = filter5[char_idx]; end
						5: begin line_length = filter6_num; if(char_idx < filter6_num) glyph_code = filter6[char_idx]; end
					  endcase
				5'd4: case(line_idx)
						0: begin line_length = building1_num; if(char_idx < building1_num) glyph_code = building1[char_idx]; end
						1: begin line_length = building2_num; if(char_idx < building2_num) glyph_code = building2[char_idx]; end
					  endcase
				default: ;
			endcase
		end
	end

    // ----------------------------------------------------------------
    // Text layout constants
    // ----------------------------------------------------------------
    localparam integer CHAR_W = 5;         // glyph width in pixels
    localparam integer CHAR_H = 8;         // glyph height in pixels
    localparam integer CELL_W = 6;         // 5 pixels + 1 spacer column
    localparam integer LINE_PITCH = 12;    // vertical distance between line tops
    localparam integer area = CHAR_W * CHAR_H;

    wire [9:0] rel_x = frame_x - change_x;
    wire [8:0] rel_y = frame_y - change_y;

    // Internal counters (relative to change_x/change_y anchor)
    reg [9:0] int_x_ctr;                 // 0..639 relative X within frame
    reg [8:0] int_y_ctr;                 // 0..479 relative Y within frame

    // Horizontal per-line stepping within a band
    reg [2:0] row_x_ctr;                 // 0..5 (0..4 glyph pixels, 5 = spacer)
    reg [3:0] glyph_row_cnt;             // 0..7 row within glyph
    reg [7:0] char_idx;                  // character index within current line
    reg [7:0] line_idx;                  // line index within paragraph (0..n-1), 4'hF means inactive

    // Active line state captured at start of scanline
    reg        line_active;              // this scanline intersects a text line's glyph rows
    reg [9:0]  x_start_reg;              // x start of the active line
    reg [7:0]  line_len_reg;             // number of characters in line (for end calc)
    reg [10:0] end_x_reg;                // x after the last spacer column
    reg        band_active;              // currently in horizontal band for this line

    // Pipeline: delay pixel-enable by 1 to align with synchronous BRAM read
    reg drive_pixel_d;

    // Expand 1-bit BRAM pixel to 12-bit RGB (white/black)
    assign edu_rgb = bram_px4[0] ? 12'hF00 : 12'h0FF;

    // Helper: compute which line is active for a given y, paragraph base, and num lines
    // Returns: active flag, local line index (0..), glyph_row (0..7)
    reg        act_flag;
    reg [2:0]  act_li;
    reg [3:0]  act_row;

    reg [9:0] d;
    reg [9:0] d0;
    reg [9:0] d1;
    reg [9:0] d_m1;
    reg [9:0] d_m2;
    reg [9:0] d_m3;
    reg [9:0] d_m4;
    reg [9:0] d_m5;
    reg [9:0] d0_m1;
    reg [9:0] d0_m2;
    reg [9:0] d0_m3;
    reg [9:0] d0_m4;
    reg [9:0] d1_m1;
    reg [9:0] d1_m2;

    reg [11:0] base;
    reg [11:0] row5;

    // Determine which paragraph/line is active at start of each scanline and
    // update the per-line state and horizontal counters.
    always @ (posedge clk25) begin
        if (rst) begin
            int_x_ctr    <= 10'd0;
            int_y_ctr    <= 9'd0;
            row_x_ctr    <= 3'd0;
            glyph_row_cnt<= 4'd0;
            char_idx     <= 8'd0;
            line_idx     <= 8'hF;
            line_active  <= 1'b0;
            x_start_reg  <= 10'd0;
            line_len_reg <= 8'd0;
            end_x_reg    <= 11'd0;
            band_active  <= 1'b0;
            drive_pixel_d<= 1'b0;
            edu_pixel_en <= 1'b0;
            edu_tab_addr <= 12'd0;
            use_par1     <= 1'b0;
        end else begin
            // Form relative counters from frame position
            if (rel_x == 0 && rel_y == 0) begin
                // New frame at the anchor
                int_x_ctr <= 10'd0;
                int_y_ctr <= 9'd0;
                band_active <= 1'b0;
                row_x_ctr <= 3'd0;
                char_idx  <= 8'd0;
            end else if (rel_x == 0) begin
                // New scanline relative to anchor
                int_x_ctr <= 10'd0;
                int_y_ctr <= int_y_ctr + 9'd1;
                band_active <= 1'b0;
                row_x_ctr <= 3'd0;
                char_idx  <= 8'd0;

                // Evaluate which line (if any) is active for this scanline
                // Defaults
                line_active <= 1'b0;
                line_idx    <= 8'hF;
                x_start_reg <= 10'd0;
                line_len_reg<= 8'd0;
                glyph_row_cnt <= 4'd0;
                use_par1 <= 1'b0;

                // Compute line selection based on info_select
                // Helper for neighbors: two paragraphs
                if (info_select == 5'd0) begin
                    // Paragraph 0
                    if (int_y_ctr >= neighbor_stats[0*3 + 1]) begin
                        // delta from paragraph 0 top
                        
                        d0 = int_y_ctr - neighbor_stats[0*3 + 1];
                        // Up to 3 lines
                        if (d0 < CHAR_H) begin
                            line_active   <= 1'b1; line_idx <= 8'd0; act_row <= d0[3:0]; act_li <= 3'd0; act_flag <= 1'b1; use_par1 <= 1'b0; x_start_reg <= neighbor_stats[0*3 + 0];
                        end else if (d0 < (LINE_PITCH + CHAR_H)) begin
                            if (d0 >= LINE_PITCH) begin
                                d0_m1 = d0 - LINE_PITCH;
                                line_active   <= 1'b1; line_idx <= 8'd1; act_row <= d0_m1[3:0]; act_li <= 3'd1; act_flag <= 1'b1; use_par1 <= 1'b0; x_start_reg <= neighbor_stats[0*3 + 0];
                            end
                        end else if (d0 < (2*LINE_PITCH + CHAR_H)) begin
                            if (d0 >= (2*LINE_PITCH)) begin
                                d0_m2 = d0 - (2*LINE_PITCH);
                                line_active   <= 1'b1; line_idx <= 8'd2; act_row <= d0_m2[3:0]; act_li <= 3'd2; act_flag <= 1'b1; use_par1 <= 1'b0; x_start_reg <= neighbor_stats[0*3 + 0];
                            end
                        end
                    end
                    // Paragraph 1 takes precedence if it matches (lower on screen)
                    if (!line_active && (int_y_ctr >= neighbor_stats[1*3 + 1])) begin
                        d1 = int_y_ctr - neighbor_stats[1*3 + 1];
                        if (d1 < CHAR_H) begin
                            line_active   <= 1'b1; line_idx <= 8'd0; act_row <= d1[3:0]; act_li <= 3'd0; act_flag <= 1'b1; use_par1 <= 1'b1; x_start_reg <= neighbor_stats[1*3 + 0];
                        end else if (d1 < (LINE_PITCH + CHAR_H)) begin
                            if (d1 >= LINE_PITCH) begin
                                d1_m1 = d1 - LINE_PITCH;
                                line_active   <= 1'b1; line_idx <= 8'd1; act_row <= d1_m1[3:0]; act_li <= 3'd1; act_flag <= 1'b1; use_par1 <= 1'b1; x_start_reg <= neighbor_stats[1*3 + 0];
                            end
                        end else if (d1 < (2*LINE_PITCH + CHAR_H)) begin
                            if (d1 >= (2*LINE_PITCH)) begin
                                d1_m2 = d1 - (2*LINE_PITCH);
                                line_active   <= 1'b1; line_idx <= 8'd2; act_row <= d1_m2[3:0]; act_li <= 3'd2; act_flag <= 1'b1; use_par1 <= 1'b1; x_start_reg <= neighbor_stats[1*3 + 0];
                            end
                        end
                    end
                    if (line_active) begin
                        glyph_row_cnt <= act_row;
                    end
                end else if (info_select == 5'd1) begin
                    // Union: 1 paragraph, 5 lines
                    if (int_y_ctr >= union_stats[0*3 + 1]) begin
                        d = int_y_ctr - union_stats[0*3 + 1];
                        if (d < CHAR_H) begin
                            line_active <= 1'b1; line_idx <= 8'd0; glyph_row_cnt <= d[3:0]; x_start_reg <= union_stats[0*3 + 0];
                        end else if (d < (LINE_PITCH + CHAR_H)) begin
                            if (d >= LINE_PITCH) begin
                                d_m1 = d - LINE_PITCH;
                                line_active <= 1'b1; line_idx <= 8'd1; glyph_row_cnt <= d_m1[3:0]; x_start_reg <= union_stats[0*3 + 0];
                            end
                        end else if (d < (2*LINE_PITCH + CHAR_H)) begin
                            if (d >= (2*LINE_PITCH)) begin
                                d_m2 = d - (2*LINE_PITCH);
                                line_active <= 1'b1; line_idx <= 8'd2; glyph_row_cnt <= d_m2[3:0]; x_start_reg <= union_stats[0*3 + 0];
                            end
                        end else if (d < (3*LINE_PITCH + CHAR_H)) begin
                            if (d >= (3*LINE_PITCH)) begin
                                d_m3 = d - (3*LINE_PITCH);
                                line_active <= 1'b1; line_idx <= 8'd3; glyph_row_cnt <= d_m3[3:0]; x_start_reg <= union_stats[0*3 + 0];
                            end
                        end else if (d < (4*LINE_PITCH + CHAR_H)) begin
                            if (d >= (4*LINE_PITCH)) begin
                                d_m4 = d - (4*LINE_PITCH);
                                line_active <= 1'b1; line_idx <= 8'd4; glyph_row_cnt <= d_m4[3:0]; x_start_reg <= union_stats[0*3 + 0];
                            end
                        end
                    end
                    use_par1 <= 1'b0;
                end else if (info_select == 5'd2) begin
                    // Statistics: 1 paragraph, 5 lines
                    if (int_y_ctr >= statistics_stats[0*3 + 1]) begin
                        d = int_y_ctr - statistics_stats[0*3 + 1];
                        if (d < CHAR_H) begin
                            line_active <= 1'b1; line_idx <= 8'd0; glyph_row_cnt <= d[3:0]; x_start_reg <= statistics_stats[0*3 + 0];
                        end else if (d < (LINE_PITCH + CHAR_H)) begin
                            if (d >= LINE_PITCH) begin
                                d_m1 = d - LINE_PITCH;
                                line_active <= 1'b1; line_idx <= 8'd1; glyph_row_cnt <= d_m1[3:0]; x_start_reg <= statistics_stats[0*3 + 0];
                            end
                        end else if (d < (2*LINE_PITCH + CHAR_H)) begin
                            if (d >= (2*LINE_PITCH)) begin
                                d_m2 = d - (2*LINE_PITCH);
                                line_active <= 1'b1; line_idx <= 8'd2; glyph_row_cnt <= d_m2[3:0]; x_start_reg <= statistics_stats[0*3 + 0];
                            end
                        end else if (d < (3*LINE_PITCH + CHAR_H)) begin
                            if (d >= (3*LINE_PITCH)) begin
                                d_m3 = d - (3*LINE_PITCH);
                                line_active <= 1'b1; line_idx <= 8'd3; glyph_row_cnt <= d_m3[3:0]; x_start_reg <= statistics_stats[0*3 + 0];
                            end
                        end else if (d < (4*LINE_PITCH + CHAR_H)) begin
                            if (d >= (4*LINE_PITCH)) begin
                                d_m4 = d - (4*LINE_PITCH);
                                line_active <= 1'b1; line_idx <= 8'd4; glyph_row_cnt <= d_m4[3:0]; x_start_reg <= statistics_stats[0*3 + 0];
                            end
                        end
                    end
                    use_par1 <= 1'b0;
                end else if (info_select == 5'd3) begin
                    // Filters: 1 paragraph, 6 lines
                    if (int_y_ctr >= filter_stats[0*3 + 1]) begin
                        d = int_y_ctr - filter_stats[0*3 + 1];
                        if (d < CHAR_H) begin
                            line_active <= 1'b1; line_idx <= 8'd0; glyph_row_cnt <= d[3:0]; x_start_reg <= filter_stats[0*3 + 0];
                        end else if (d < (LINE_PITCH + CHAR_H)) begin
                            if (d >= LINE_PITCH) begin
                                d_m1 = d - LINE_PITCH;
                                line_active <= 1'b1; line_idx <= 8'd1; glyph_row_cnt <= d_m1[3:0]; x_start_reg <= filter_stats[0*3 + 0];
                            end
                        end else if (d < (2*LINE_PITCH + CHAR_H)) begin
                            if (d >= (2*LINE_PITCH)) begin
                                d_m2 = d - (2*LINE_PITCH);
                                line_active <= 1'b1; line_idx <= 8'd2; glyph_row_cnt <= d_m2[3:0]; x_start_reg <= filter_stats[0*3 + 0];
                            end
                        end else if (d < (3*LINE_PITCH + CHAR_H)) begin
                            if (d >= (3*LINE_PITCH)) begin
                                d_m3 = d - (3*LINE_PITCH);
                                line_active <= 1'b1; line_idx <= 8'd3; glyph_row_cnt <= d_m3[3:0]; x_start_reg <= filter_stats[0*3 + 0];
                            end
                        end else if (d < (4*LINE_PITCH + CHAR_H)) begin
                            if (d >= (4*LINE_PITCH)) begin
                                d_m4 = d - (4*LINE_PITCH);
                                line_active <= 1'b1; line_idx <= 8'd4; glyph_row_cnt <= d_m4[3:0]; x_start_reg <= filter_stats[0*3 + 0];
                            end
                        end else if (d < (5*LINE_PITCH + CHAR_H)) begin
                            if (d >= (5*LINE_PITCH)) begin
                                d_m5 = d - (5*LINE_PITCH);
                                line_active <= 1'b1; line_idx <= 8'd5; glyph_row_cnt <= d_m5[3:0]; x_start_reg <= filter_stats[0*3 + 0];
                            end
                        end
                    end
                    use_par1 <= 1'b0;
                end else if (info_select == 5'd4) begin
                    // Buildings: 1 paragraph, 2 lines
                    if (int_y_ctr >= building_stats[0*3 + 1]) begin
                        d = int_y_ctr - building_stats[0*3 + 1];
                        if (d < CHAR_H) begin
                            line_active <= 1'b1; line_idx <= 8'd0; glyph_row_cnt <= d[3:0]; x_start_reg <= building_stats[0*3 + 0];
                        end else if (d < (LINE_PITCH + CHAR_H)) begin
                            if (d >= LINE_PITCH) begin
                                d_m1 = d - LINE_PITCH;
                                line_active <= 1'b1; line_idx <= 8'd1; glyph_row_cnt <= d_m1[3:0]; x_start_reg <= building_stats[0*3 + 0];
                            end
                        end
                    end
                    use_par1 <= 1'b0;
                end else begin
                    // Inactive for other selections here
                    line_active <= 1'b0; line_idx <= 8'hF; use_par1 <= 1'b0;
                end

                // Latch line length for this scanline
                if (line_active) begin
                    line_len_reg <= line_length; // produced by combinational case below
                    // Compute horizontal end position (x_start + line_len * CELL_W)
                    // *6 = *4 + *2
                    end_x_reg <= x_start_reg + {3'b000, line_length, 1'b0} + {2'b00, line_length, 2'b00};
                end else begin
                    line_len_reg <= 8'd0;
                    end_x_reg    <= 11'd0;
                end
            end else begin
                // Same scanline, step horizontally
                int_x_ctr <= int_x_ctr + 10'd1;

                // Start band at x_start
                if (line_active && (int_x_ctr == x_start_reg)) begin
                    band_active <= 1'b1;
                    row_x_ctr   <= 3'd0;
                    char_idx    <= 8'd0;
                end

                // Advance within band
                if (band_active) begin
                    if (row_x_ctr == 3'd5) begin
                        row_x_ctr <= 3'd0;
                        char_idx  <= char_idx + 8'd1;
                    end else begin
                        row_x_ctr <= row_x_ctr + 3'd1;
                    end
                    // End band after last spacer of last char
                    if (int_x_ctr >= end_x_reg[9:0]) begin
                        band_active <= 1'b0;
                    end
                end
            end

            // BRAM address and pixel enable pipeline
            // Drive pixel when in band and on glyph columns (exclude spacer col) and within line length
            // Note: BRAM is 1-cycle synchronous read; delay enable by 1 cycle
            begin : PIXEL_GEN
                reg drive_pixel;
                drive_pixel = band_active && (row_x_ctr < 3'd5) && (char_idx < line_len_reg) && line_active;
                // Delay enable exactly one cycle to match synchronous BRAM output
                drive_pixel_d <= drive_pixel;

                // Address calculation: base + row*5 + col
                // base = glyph_code * 40 = code*32 + code*8
                // row*5 = (row<<2) + row
                // col = row_x_ctr
                // Guard: if not driving, keep address at 0 to avoid X propagation
                if (drive_pixel) begin
                    // compute base
                    base = ({glyph_code, 5'b0}) + ({glyph_code, 3'b0});
                    row5 = ({8'd0, glyph_row_cnt, 2'b00}) + {8'd0, glyph_row_cnt};
                    edu_tab_addr <= base + row5 + {9'd0, row_x_ctr};
                end else begin
                    edu_tab_addr <= 12'd0;
                end

                // Align enable with BRAM output latency
                edu_pixel_en  <= drive_pixel_d;
            end
        end
    end
endmodule