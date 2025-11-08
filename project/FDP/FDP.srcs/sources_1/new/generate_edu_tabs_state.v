// generate_edu_tabs_state.v
// Simplified text renderer using pixel-clock counters (no div/mod) and
// internal X/Y counters for glyph addressing. No debug ports.
// Optional parameters:
//  - CODE_IS_BASE: when set, glyph arrays store top-left base addresses
//    instead of glyph indices (pre-multiplied by 40).
//  - ROW_MAJOR: 1 if BRAM stores glyphs row-major; 0 if column-major.

module Education_Tabs_State #(
	parameter CODE_IS_BASE   = 1'b0,
	parameter ROW_MAJOR      = 1'b1,
	// Number of cycles between address present and valid BRAM data
	// Set to 1 for typical inferred ROM/BRAM, 2 if an extra output reg is enabled
	parameter integer BRAM_LATENCY = 1
) (
    input        clk,
	input        clk25,
	input        rst,

    output [7:0] seg,
    output [3:0] an,
    output reg [15:0] led,

	input [9:0]  frame_x,
	input [9:0]  frame_y,
	input [9:0]  change_x,
	input [8:0]  change_y,
	input [4:0]  info_select,
	input signed [9:0]  input_offset, // signed vertical/horizontal address offset (+/-)
	output reg   edu_pixel_en,
	output [11:0] edu_rgb
);
    reg [15:0] ss_output; 
    always @ (*) begin
        // ss_output <= (rel_x == 94 && rel_y == 39) ? edu_tab_addr : ss_output;
        ss_output[1:0] <= (rel_x == 94 && rel_y == 51) ? edu_tab_addr : ss_output[1:0];
        ss_output[3:2] <= (rel_x == 94 && rel_y == 52) ? edu_tab_addr : ss_output[3:2];

        // led[7:0] <= (rel_x == 94 && rel_y == 51) ? edu_tab_addr : led[7:0];
        // led[15:8] <= (rel_x == 94 && rel_y == 52) ? edu_tab_addr : led[15:8];
        led[7] <= (rel_x == 94 && rel_y == 51) ? bram_bit : led[7];
        led[6] <= (rel_x == 95 && rel_y == 51) ? bram_bit : led[6];
        led[5] <= (rel_x == 96 && rel_y == 51) ? bram_bit : led[5];
        led[4] <= (rel_x == 97 && rel_y == 51) ? bram_bit : led[4];
        led[3] <= (rel_x == 98 && rel_y == 51) ? bram_bit : led[3];
        led[2] <= (rel_x == 99 && rel_y == 51) ? bram_bit : led[2];
        led[1] <= (rel_x == 100 && rel_y == 51) ? bram_bit : led[1];
        led[0] <= (rel_x == 101 && rel_y == 51) ? bram_bit : led[0];

        led[15] <= (rel_x == 94 && rel_y == 52) ? bram_bit : led[15];
        led[14] <= (rel_x == 95 && rel_y == 52) ? bram_bit : led[14];
        led[13] <= (rel_x == 96 && rel_y == 52) ? bram_bit : led[13];
        led[12] <= (rel_x == 97 && rel_y == 52) ? bram_bit : led[12];
        led[11] <= (rel_x == 98 && rel_y == 52) ? bram_bit : led[11];
        led[10] <= (rel_x == 99 && rel_y == 52) ? bram_bit : led[10];
        led[9] <= (rel_x == 100 && rel_y == 52) ? bram_bit : led[9];
        led[8] <= (rel_x == 101 && rel_y == 52) ? bram_bit : led[8];
    end
    Seven_Seg ssd (
        .clk(clk),
        .num(ss_output),
        .dd(4'b0000),
        .seg(seg),
        .an(an)
    );

	// BRAM interface (embedded for self-contained module)
	reg  [11:0] edu_tab_addr;
	wire [0:0]  bram_bit;
	Single_Port_Buffer #(
		.DATA_WIDTH(1),
		.BUFFER_SIZE(2500),
        .CHOICE(1)
	) glyph_bram (
		.clk(clk25),
		.addr(edu_tab_addr),
		.dout(bram_bit)
	);

	assign edu_rgb = bram_bit[0] ? 12'hFFF : 12'h000;

// ---------------- Constants ----------------
	localparam integer GLYPH_W    = 5;
	localparam integer GLYPH_H    = 8;
	localparam integer CELL_W     = GLYPH_W + 1;  // spacer column
	localparam integer LINE_PITCH = 12;           // vertical distance between line starts
	localparam integer GLYPH_SIZE = GLYPH_W * GLYPH_H; // 40

// ---------- NEIGHBOURS ----------
    localparam integer  neighbor1_num = 29,
                        neighbor2_num = 26,
                        neighbor3_num = 6,
                        neighbor4_num = 31,
                        neighbor5_num = 29,
                        neighbor6_num = 32;

    localparam integer neighbor_paragraphs = 2;

    localparam integer neighbor1 [0: (neighbor1_num - 1)] = {
        4, 26, 28, 33, 52, 48, 33, 34, 45, 30, 52, 41, 34, 49, 30, 37, 55, 57, 56, 52, 34, 44, 52, 26, 52, 39, 40, 29, 30
    };
    localparam integer neighbor2 [0: (neighbor2_num - 1)] = {
        34, 39, 52, 26, 52, 32, 43, 34, 29, 53, 52, 39, 30, 34, 32, 33, 27, 40, 46, 43, 44, 52, 31, 40, 43, 38
    };
    localparam integer neighbor3 [0: (neighbor3_num - 1)] = {
        30, 29, 32, 30, 44, 54
    };
    localparam integer neighbor4 [0: (neighbor4_num - 1)] = {
        5, 40, 43, 52, 11, 30, 31, 45, 53, 52, 20, 41, 41, 30, 43, 52, 11, 30, 31, 45, 53, 52, 20, 41, 41, 30, 43, 52, 26, 39, 29
    };
    localparam integer neighbor5 [0: (neighbor5_num - 1)] = {
        20, 41, 41, 30, 43, 52, 17, 34, 32, 33, 45, 52, 41, 34, 49, 30, 37, 53, 52, 31, 34, 39, 29, 52, 45, 33, 30, 34, 43
    };
    localparam integer neighbor6 [0: (neighbor6_num - 1)] = {
        43, 40, 40, 45, 52, 27, 50, 52, 48, 26, 37, 36, 34, 39, 32, 52, 46, 41, 52, 45, 33, 30, 34, 43, 52, 41, 26, 43, 30, 39, 45, 44
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
    localparam integer union_paragraphs = 2;
    localparam integer union_stats [0 : (union_paragraphs * 3) - 1] = {
        93, 38, 3,     // X start, Y start, num lines 1st paragraph
        93, 90, 3      // X start, Y start, num lines 2nd paragraph
    };

    localparam integer union1_num = 25,
                     union2_num = 30,
                     union3_num = 17,
                     union4_num = 25,
                     union5_num = 24,
                     union6_num = 14;

    localparam integer union1 [0 : (union1_num - 1)] = {
        0, 37, 37, 40, 28, 26, 45, 30, 52, 28, 46, 43, 43, 30, 39, 45, 52, 41, 34, 49, 30, 37, 52, 34, 31
    };
    localparam integer union2 [0 : (union2_num - 1)] = {
        39, 30, 34, 32, 33, 27, 40, 46, 43, 44, 52, 33, 26, 47, 30, 52, 39, 40, 52, 43, 40, 40, 45, 44, 55, 34, 45, 52, 34, 44
    };
    localparam integer union3 [0 : (union3_num - 1)] = {
        26, 52, 39, 30, 48, 52, 28, 40, 38, 41, 40, 39, 30, 39, 45, 56, 54
    };
    localparam integer union4 [0 : (union4_num - 1)] = {
        4, 37, 44, 30, 53, 52, 41, 34, 28, 36, 52, 26, 52, 39, 30, 34, 32, 33, 27, 40, 46, 43, 34, 39, 32
    };
    localparam integer union5 [0 : (union5_num - 1)] = {
        28, 40, 38, 41, 40, 39, 30, 39, 45, 52, 26, 39, 29, 52, 46, 39, 34, 40, 39, 52, 34, 39, 45, 40
    };
    localparam integer union6 [0 : (union6_num - 1)] = {
        40, 39, 30, 52, 28, 40, 38, 41, 40, 39, 30, 39, 45, 54
    };


// ---------- Statistics ----------
    localparam integer statistics_paragraphs = 2;
    localparam integer statistics_stats [0 : (statistics_paragraphs * 3) - 1] = {
        93, 38, 3,    // X start, Y start 1st paragraph
        93, 90, 3     // X start, Y start 2nd paragraph
    };

    localparam integer stats1_num = 22,
                        stats2_num = 19,
                        stats3_num = 11,
                        stats4_num = 31,
                        stats5_num = 28,
                        stats6_num = 19;
    localparam integer stats1 [0 : (stats1_num - 1)] = {
        0, 44, 52, 31, 43, 26, 38, 30, 52, 27, 46, 34, 37, 29, 44, 53, 52, 46, 39, 34, 40, 39
    };

    localparam integer stats2 [0 : (stats2_num - 1)] = {
        39, 30, 34, 32, 33, 27, 40, 46, 43, 44, 52, 26, 39, 29, 52, 32, 43, 40, 48
    };
    localparam integer stats3 [0 : (stats3_num - 1)] = {
        28, 40, 38, 41, 40, 39, 30, 39, 45, 44, 54
    };
    localparam integer stats4 [0 : (stats4_num - 1)] = {
        4, 26, 28, 33, 52, 28, 40, 38, 41, 40, 39, 30, 39, 45, 52, 44, 45, 40, 43, 30, 44, 52, 26, 52, 43, 46, 39, 39, 34, 39, 32
    };
    localparam integer stats5 [0 : (stats5_num - 1)] = {
        26, 43, 30, 26, 52, 28, 40, 46, 39, 45, 52, 26, 39, 29, 52, 38, 34, 39, 53, 52, 38, 26, 49, 52, 49, 53, 52, 50
    };
    localparam integer stats6 [0 : (stats6_num - 1)] = {
        31, 40, 43, 52, 27, 40, 46, 39, 29, 34, 39, 32, 52, 27, 40, 49, 30, 44, 54
    };


// ---------- Filters ----------

    localparam integer filter_paragraphs = 2;
    localparam integer filter_stats [0 : (filter_paragraphs * 3) - 1] = {
        93, 38, 3,    // X start, Y start 1st paragraph
        93, 90, 3     // X start, Y start 2nd paragraph
    };

    localparam integer filter1_num = 31;
    localparam integer filter2_num = 26;
    localparam integer filter3_num = 29;
    localparam integer filter4_num = 29;
    localparam integer filter5_num = 22;
    localparam integer filter6_num = 8;

    localparam integer filter1 [0 : (filter1_num - 1)] = {
        17, 30, 38, 40, 47, 30, 52, 45, 34, 39, 50, 52, 28, 40, 38, 41, 40, 39, 30, 39, 45, 44, 52, 26, 44, 52, 45, 33, 30, 43, 30
    };
    localparam integer filter2 [0 : (filter2_num - 1)] = {
        38, 26, 50, 52, 27, 30, 52, 39, 40, 34, 44, 30, 53, 52, 27, 50, 52, 38, 34, 39, 52, 26, 43, 30, 26, 54
    };
    localparam integer filter3 [0 : (filter3_num - 1)] = {
        55, 39, 40, 54, 52, 40, 31, 52, 41, 34, 49, 30, 37, 52, 34, 39, 52, 26, 52, 28, 40, 38, 41, 40, 39, 30, 39, 45, 56
    };
    localparam integer filter4 [0 : (filter4_num - 1)] = {
        30, 54, 32, 54, 53, 52, 60, 52, 38, 30, 26, 39, 44, 52, 28, 40, 38, 41, 40, 39, 30, 39, 45, 44, 52, 48, 34, 45, 33
    };
    localparam integer filter5 [0 : (filter5_num - 1)] = {
        37, 30, 44, 44, 52, 45, 33, 26, 39, 52, 60, 52, 41, 34, 49, 30, 37, 44, 52, 26, 43, 30
    };
    localparam integer filter6 [0 : (filter6_num - 1)] = {
        34, 39, 47, 26, 37, 34, 29, 54
    };


// ---------- Buildings ----------
    localparam integer building_paragraphs = 2;
    localparam integer building_stats [0 : (building_paragraphs * 3) - 1] = {
        93, 38, 3,    // X start, Y start 1st paragraph
        93, 90, 3     // X start, Y start 2nd paragraph
    };
    localparam integer building1_num = 11;
    localparam integer building2_num = 16;
    localparam integer building3_num = 17;
    localparam integer building4_num = 22;
    localparam integer building5_num = 19;
    localparam integer building6_num = 17;

    localparam integer building1 [0 : (building1_num - 1)] = {
        15, 34, 28, 36, 52, 46, 41, 52, 45, 40, 52
    };
    localparam integer building2 [0 : (building2_num - 1)] = {
        57, 52, 40, 43, 52, 58, 52, 40, 43, 52, 59, 52, 40, 43, 52, 60
    };

    localparam integer building3 [0 : (building3_num - 1)] = {
        47, 26, 37, 34, 29, 52, 28, 40, 38, 41, 40, 39, 30, 39, 45, 44, 54
    };
    localparam integer building4 [0 : (building4_num - 1)] = {
        20, 44, 34, 39, 32, 52, 38, 34, 39, 53, 52, 38, 26, 49, 53, 52, 28, 30, 39, 45, 43, 30
    };
    localparam integer building5 [0 : (building5_num - 1)] = {
        40, 31, 52, 49, 53, 52, 50, 53, 52, 29, 43, 26, 48, 52, 45, 33, 30, 34, 43
    };
    localparam integer building6 [0 : (building6_num - 1)] = {
        43, 30, 44, 41, 30, 28, 45, 34, 47, 30, 52, 27, 40, 49, 30, 44, 54
    };


// ---------- GAUSSIAN ----------

// ---------- MEDIAN ----------

// ---------- ERODE ----------

// ---------- DILATE ----------

	// ---------------- Paragraph selection ----------------
	reg [9:0] par0_start_x, par0_start_y, par1_start_x, par1_start_y;
	reg [3:0] par0_lines, par1_lines;
	always @* begin
		par0_start_x=0; par0_start_y=0; par0_lines=0; par1_start_x=0; par1_start_y=0; par1_lines=0;
		case(info_select)
			5'd0: begin
				par0_start_x = neighbor_stats[0]; par0_start_y = neighbor_stats[1]; par0_lines = neighbor_stats[2];
				par1_start_x = neighbor_stats[3]; par1_start_y = neighbor_stats[4]; par1_lines = neighbor_stats[5];
			end
			5'd1: begin par0_start_x = union_stats[0]; par0_start_y = union_stats[1]; par0_lines = union_stats[2]; end
			5'd2: begin par0_start_x = statistics_stats[0]; par0_start_y = statistics_stats[1]; par0_lines = statistics_stats[2]; end
			5'd3: begin par0_start_x = filter_stats[0]; par0_start_y = filter_stats[1]; par0_lines = filter_stats[2]; end
			5'd4: begin par0_start_x = building_stats[0]; par0_start_y = building_stats[1]; par0_lines = building_stats[2]; end
			default: ;
		endcase
	end

	// Relative coords
	wire [9:0] rel_x = frame_x - change_x;
	wire [9:0] rel_y = frame_y - change_y;

	// Line resolution function
	function automatic [3:0] resolve_line_idx;
		input [9:0] y; input [9:0] base_y; input [3:0] lines; integer i; begin
			resolve_line_idx = 4'hF;
			for(i=0;i<8;i=i+1) begin
				if(i < lines) begin
					if((y >= base_y + i*LINE_PITCH) && (y < base_y + i*LINE_PITCH + GLYPH_H)) resolve_line_idx = i[3:0];
				end
			end
		end endfunction

	// Active paragraph selection
	reg use_par1; reg [3:0] line_idx; reg [9:0] active_start_x, active_start_y; reg [3:0] active_lines;
	always @* begin
		use_par1 = 0; line_idx = resolve_line_idx(rel_y, par0_start_y, par0_lines);
		active_start_x = par0_start_x; active_start_y = par0_start_y; active_lines = par0_lines;
		if(line_idx == 4'hF && par1_lines != 0) begin
			line_idx = resolve_line_idx(rel_y, par1_start_y, par1_lines);
			if(line_idx != 4'hF) begin
				use_par1 = 1; active_start_x = par1_start_x; active_start_y = par1_start_y; active_lines = par1_lines;
			end
		end
	end

	// Counters
	reg [7:0] char_idx;        // character index in line
	reg [2:0] glyph_col_cnt;   // horizontal position inside cell (0..CELL_W-1)
	reg [2:0] glyph_row_cnt;   // vertical position inside glyph (0..GLYPH_H-1)

	wire line_active_vert = (line_idx != 4'hF) && (rel_y >= active_start_y);

	wire [3:0] temp = (rel_y - (active_start_y + line_idx*LINE_PITCH));
	wire [2:0] glyph_row_now = line_active_vert ? temp[2:0] : 3'd0;

		// Line length & glyph code from counters (and prefetch glyph code for next char)
		reg [7:0] line_length; reg [7:0] glyph_code; reg [7:0] glyph_code_pre;
	always @* begin
				line_length = 0; glyph_code = 0; glyph_code_pre = 0;
		if(line_idx != 4'hF) begin
			case(info_select)
				5'd0: if(!use_par1) begin
						case(line_idx)
														0: begin line_length = neighbor1_num; if(char_idx < neighbor1_num) glyph_code = neighbor1[char_idx]; if(char_next < neighbor1_num) glyph_code_pre = neighbor1[char_next]; end
														1: begin line_length = neighbor2_num; if(char_idx < neighbor2_num) glyph_code = neighbor2[char_idx]; if(char_next < neighbor2_num) glyph_code_pre = neighbor2[char_next]; end
														2: begin line_length = neighbor3_num; if(char_idx < neighbor3_num) glyph_code = neighbor3[char_idx]; if(char_next < neighbor3_num) glyph_code_pre = neighbor3[char_next]; end
						endcase
					  end else begin
						case(line_idx)
														0: begin line_length = neighbor4_num; if(char_idx < neighbor4_num) glyph_code = neighbor4[char_idx]; if(char_next < neighbor4_num) glyph_code_pre = neighbor4[char_next]; end
														1: begin line_length = neighbor5_num; if(char_idx < neighbor5_num) glyph_code = neighbor5[char_idx]; if(char_next < neighbor5_num) glyph_code_pre = neighbor5[char_next]; end
														2: begin line_length = neighbor6_num; if(char_idx < neighbor6_num) glyph_code = neighbor6[char_idx]; if(char_next < neighbor6_num) glyph_code_pre = neighbor6[char_next]; end
						endcase
					  end
								5'd1: case(line_idx)
												0: begin line_length = union1_num; if(char_idx < union1_num) glyph_code = union1[char_idx]; if(char_next < union1_num) glyph_code_pre = union1[char_next]; end
												1: begin line_length = union2_num; if(char_idx < union2_num) glyph_code = union2[char_idx]; if(char_next < union2_num) glyph_code_pre = union2[char_next]; end
												2: begin line_length = union3_num; if(char_idx < union3_num) glyph_code = union3[char_idx]; if(char_next < union3_num) glyph_code_pre = union3[char_next]; end
												3: begin line_length = union4_num; if(char_idx < union4_num) glyph_code = union4[char_idx]; if(char_next < union4_num) glyph_code_pre = union4[char_next]; end
												4: begin line_length = union5_num; if(char_idx < union5_num) glyph_code = union5[char_idx]; if(char_next < union5_num) glyph_code_pre = union5[char_next]; end
											endcase
				5'd2: case(line_idx)
												0: begin line_length = stats1_num; if(char_idx < stats1_num) glyph_code = stats1[char_idx]; if(char_next < stats1_num) glyph_code_pre = stats1[char_next]; end
												1: begin line_length = stats2_num; if(char_idx < stats2_num) glyph_code = stats2[char_idx]; if(char_next < stats2_num) glyph_code_pre = stats2[char_next]; end
												2: begin line_length = stats3_num; if(char_idx < stats3_num) glyph_code = stats3[char_idx]; if(char_next < stats3_num) glyph_code_pre = stats3[char_next]; end
												3: begin line_length = stats4_num; if(char_idx < stats4_num) glyph_code = stats4[char_idx]; if(char_next < stats4_num) glyph_code_pre = stats4[char_next]; end
												4: begin line_length = stats5_num; if(char_idx < stats5_num) glyph_code = stats5[char_idx]; if(char_next < stats5_num) glyph_code_pre = stats5[char_next]; end
					  endcase
				5'd3: case(line_idx)
												0: begin line_length = filter1_num; if(char_idx < filter1_num) glyph_code = filter1[char_idx]; if(char_next < filter1_num) glyph_code_pre = filter1[char_next]; end
												1: begin line_length = filter2_num; if(char_idx < filter2_num) glyph_code = filter2[char_idx]; if(char_next < filter2_num) glyph_code_pre = filter2[char_next]; end
												2: begin line_length = filter3_num; if(char_idx < filter3_num) glyph_code = filter3[char_idx]; if(char_next < filter3_num) glyph_code_pre = filter3[char_next]; end
												3: begin line_length = filter4_num; if(char_idx < filter4_num) glyph_code = filter4[char_idx]; if(char_next < filter4_num) glyph_code_pre = filter4[char_next]; end
												4: begin line_length = filter5_num; if(char_idx < filter5_num) glyph_code = filter5[char_idx]; if(char_next < filter5_num) glyph_code_pre = filter5[char_next]; end
												5: begin line_length = filter6_num; if(char_idx < filter6_num) glyph_code = filter6[char_idx]; if(char_next < filter6_num) glyph_code_pre = filter6[char_next]; end
					  endcase
				5'd4: case(line_idx)
												0: begin line_length = building1_num; if(char_idx < building1_num) glyph_code = building1[char_idx]; if(char_next < building1_num) glyph_code_pre = building1[char_next]; end
												1: begin line_length = building2_num; if(char_idx < building2_num) glyph_code = building2[char_idx]; if(char_next < building2_num) glyph_code_pre = building2[char_next]; end
					  endcase
				default: ;
			endcase
		end
	end

	// Horizontal band gating
	wire h_band_start = line_active_vert && (rel_x == active_start_x);
	wire h_band_valid = line_active_vert && (rel_x >= active_start_x) && (rel_x < active_start_x + line_length*CELL_W);

	// Counters update
	always @(posedge clk25 or posedge rst) begin
		if(rst) begin
			char_idx      <= 0;
			glyph_col_cnt <= 0;
			glyph_row_cnt <= 0;
		end else begin
			glyph_row_cnt <= glyph_row_now; // direct mapping
			if(!h_band_valid) begin
				char_idx      <= 0;
				glyph_col_cnt <= 0;
			end else begin
				if(h_band_start) begin
					char_idx      <= 0;
					glyph_col_cnt <= 0;
				end else begin
					glyph_col_cnt <= glyph_col_cnt + 1'b1;
					if(glyph_col_cnt == CELL_W-1) begin
						glyph_col_cnt <= 0;
						char_idx      <= char_idx + 1'b1;
					end
				end
			end
		end
	end

	// Prefetch next pixel position to hide BRAM latency
	wire [2:0] col_next = (!h_band_valid) ? 3'd0 :
						  (h_band_start) ? 3'd0 :
						  (glyph_col_cnt == CELL_W-1) ? 3'd0 :
						  (glyph_col_cnt + 3'd1);
	wire [7:0] char_next = (!h_band_valid) ? 8'd0 :
						   (h_band_start) ? 8'd0 :
						   (glyph_col_cnt == CELL_W-1) ? (char_idx + 8'd1) :
						   char_idx;

	// Will the NEXT pixel be inside a glyph (exclude spacer)?
	wire pre_inside_char = h_band_valid && (col_next < GLYPH_W) && (glyph_row_cnt < GLYPH_H) && (char_next < line_length);

	// Address calculation (prefetch for next pixel)
	wire [11:0] glyph_base_pre = CODE_IS_BASE ? glyph_code_pre[11:0] : (glyph_code_pre * GLYPH_SIZE);
	wire [11:0] row_offset_pre = ROW_MAJOR ? (glyph_row_cnt * GLYPH_W) : (col_next * GLYPH_H);
	wire [11:0] col_offset_pre = ROW_MAJOR ? col_next : glyph_row_cnt;
	// Signed offset addition with clamping to BRAM range (0 .. 2499)
	localparam [11:0] BUF_LAST = 12'd2499;
	wire [11:0] addr_base_pre = glyph_base_pre + row_offset_pre + col_offset_pre; // 0..(<2500)
	wire signed [12:0] addr_signed_pre = $signed({1'b0,addr_base_pre}) + input_offset; // sign-extend base then add offset
	wire [11:0] addr_calc_pre = (addr_signed_pre < 0) ? 12'd0 : (addr_signed_pre > BUF_LAST) ? BUF_LAST : addr_signed_pre[11:0];

	// Align outputs with synchronous BRAM latency
	reg pre_inside_char_d1, pre_inside_char_d2;
	wire inside_char_aligned = (BRAM_LATENCY==2) ? pre_inside_char_d2 : pre_inside_char_d1;

	always @(posedge clk25 or posedge rst) begin
		if(rst) begin
			edu_pixel_en   <= 1'b0;
			edu_tab_addr   <= 12'd0;
			pre_inside_char_d1 <= 1'b0;
			pre_inside_char_d2 <= 1'b0;
		end else begin
			// present address for next pixel; data will be valid next cycle(s)
			edu_tab_addr   <= pre_inside_char ? addr_calc_pre : 12'd0;
			// pipeline enable to match BRAM latency
			pre_inside_char_d1 <= pre_inside_char;
			pre_inside_char_d2 <= pre_inside_char_d1;
			edu_pixel_en   <= inside_char_aligned;
		end
	end

endmodule
