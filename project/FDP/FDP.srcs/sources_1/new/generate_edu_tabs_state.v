// generate_edu_tabs_state.v
// Simplified text renderer using pixel-clock counters (no div/mod) and
// internal X/Y counters for glyph addressing. No debug ports.
// Optional parameters:
//  - CODE_IS_BASE: when set, glyph arrays store top-left base addresses
//    instead of glyph indices (pre-multiplied by 40).
//  - ROW_MAJOR: 1 if BRAM stores glyphs row-major; 0 if column-major.

module Education_Tabs_State #(
	parameter CODE_IS_BASE = 1'b0,
	parameter ROW_MAJOR    = 1'b1
) (
    input        clk,
	input        clk25,
	input        rst,
	input [9:0]  frame_x,
	input [9:0]  frame_y,
	input [9:0]  change_x,
	input [8:0]  change_y,
	input [4:0]  info_select,
	output reg   edu_pixel_en,
	output [11:0] edu_rgb
);

	// BRAM interface (embedded for self-contained module)
	reg  [11:0] edu_tab_addr;
	wire [0:0]  bram_bit;
	Single_Port_Buffer #(
		.DATA_WIDTH(1),
		.BUFFER_SIZE(2500)
	) glyph_bram (
		.clk(clk25),
		.addr(edu_tab_addr),
		.dout(bram_bit)
	);

	assign edu_rgb = bram_bit ? 12'hF00 : 12'hFFF; // black foreground

	// ---------------- Constants ----------------
	localparam integer GLYPH_W    = 5;
	localparam integer GLYPH_H    = 8;
	localparam integer CELL_W     = GLYPH_W + 1;  // spacer column
	localparam integer LINE_PITCH = 12;           // vertical distance between line starts
	localparam integer GLYPH_SIZE = GLYPH_W * GLYPH_H; // 40

	// ---------------- Glyph Arrays ----------------
	localparam integer  neighbor1_num = 29,
						neighbor2_num = 26,
						neighbor3_num = 6,
						neighbor4_num = 31,
						neighbor5_num = 29,
						neighbor6_num = 33;
	localparam integer neighbor_paragraphs = 2;
	localparam integer neighbor1 [0:neighbor1_num-1] = {4,26,28,33,52,48,33,34,45,30,52,41,34,49,30,37,57,53,58,52,34,44,52,26,52,39,40,29,30};
	localparam integer neighbor2 [0:neighbor2_num-1] = {34,13,52,0,52,6,17,8,3,55,52,13,4,8,6,7,1,14,20,17,18,52,5,14,17,12};
	localparam integer neighbor3 [0:neighbor3_num-1] = {30,3,6,4,18,56};
	localparam integer neighbor4 [0:neighbor4_num-1] = {5,40,43,52,11,30,31,45,55,52,20,41,41,30,43,52,11,30,31,45,55,52,20,41,41,30,43,52,26,39,29};
	localparam integer neighbor5 [0:neighbor5_num-1] = {20,41,41,30,43,52,17,34,32,33,45,52,41,34,49,30,37,55,52,31,34,39,29,52,45,33,30,34,43};
	localparam integer neighbor6 [0:neighbor6_num-1] = {43,40,40,45,52,27,50,52,48,26,37,36,34,39,32,52,46,41,52,45,33,30,34,43,52,41,26,43,30,39,45,44,56};
	localparam integer neighbor_stats [0:neighbor_paragraphs*3-1] = {93,38,3, 93,90,3};

	localparam integer union_paragraphs = 1;
	localparam integer union_stats [0:union_paragraphs*3-1] = {93,38,5};
	localparam integer union1_num=25, union2_num=29, union3_num=30, union4_num=26, union5_num=24;
	localparam integer union1 [0:union1_num-1] = {0,37,37,40,28,26,45,30,52,28,46,43,43,30,39,45,52,41,34,49,30,37,52,34,31};
	localparam integer union2 [0:union2_num-1] = {39,30,34,32,33,27,40,46,43,44,52,33,26,47,30,52,39,40,52,43,40,40,45,44,57,34,45,52,34};
	localparam integer union3 [0:union3_num-1] = {26,52,39,30,48,52,28,40,38,41,40,39,30,39,45,58,56,52,4,37,44,30,55,52,41,34,28,36,52,26};
	localparam integer union4 [0:union4_num-1] = {39,30,34,32,33,27,40,46,43,34,39,32,52,28,40,38,41,40,39,30,39,45,52,26,39,29};
	localparam integer union5 [0:union5_num-1] = {46,39,34,40,39,52,34,39,45,40,52,40,39,30,52,28,40,38,41,40,39,30,39,45};

	localparam integer statistics_paragraphs=1;
	localparam integer statistics_stats [0:statistics_paragraphs*3-1] = {93,38,5};
	localparam integer stats1_num=22, stats2_num=30, stats3_num=31, stats4_num=28, stats5_num=18;
	localparam integer stats1 [0:stats1_num-1] = {0,44,52,31,43,26,38,30,52,27,46,34,37,29,44,55,52,46,39,34,40,39};
	localparam integer stats2 [0:stats2_num-1] = {39,30,34,32,33,27,40,46,43,44,52,26,39,29,52,32,43,40,48,52,28,40,38,41,40,39,30,39,45,44};
	localparam integer stats3 [0:stats3_num-1] = {4,26,28,33,52,28,40,38,41,40,39,30,39,45,52,44,45,40,43,30,44,52,26,52,43,46,39,39,34,39,32};
	localparam integer stats4 [0:stats4_num-1] = {26,43,30,26,52,28,40,46,39,45,52,26,39,29,52,38,34,39,55,52,38,26,49,52,49,55,52,50};
	localparam integer stats5 [0:stats5_num-1] = {31,40,43,52,27,40,46,39,29,34,39,32,52,27,40,49,30,44};

	localparam integer filter_paragraphs=1;
	localparam integer filter_stats [0:filter_paragraphs*3-1] = {93,38,6};
	localparam integer filter1_num=31, filter2_num=26, filter3_num=28, filter4_num=26, filter5_num=29, filter6_num=31;
	localparam integer filter1 [0:filter1_num-1] = {17,30,38,40,47,30,52,45,34,39,50,52,28,40,38,41,40,39,30,39,45,44,52,26,44,52,45,33,30,43,30};
	localparam integer filter2 [0:filter2_num-1] = {38,26,50,52,27,30,52,39,40,34,44,30,55,52,27,50,52,38,34,39,52,26,43,30,26,55};
	localparam integer filter3 [0:filter3_num-1] = {33,30,34,32,33,45,55,52,48,34,29,45,33,52,26,44,52,41,26,43,26,38,30,45,30,43,44,56};
	localparam integer filter4 [0:filter4_num-1] = {2,33,40,40,44,30,52,48,33,34,28,33,52,41,26,43,26,38,30,45,30,43,44,52,45,40};
	localparam integer filter5 [0:filter5_num-1] = {29,30,45,30,43,38,34,39,30,52,48,33,34,28,33,52,41,26,43,26,38,30,45,30,43,44,52,45,40};
	localparam integer filter6 [0:filter6_num-1] = {26,43,30,26,55,52,33,30,34,32,33,45,55,52,48,34,29,45,33,55,52,41,43,40,49,34,38,34,45,50,58};

	localparam integer building_paragraphs=1;
	localparam integer building_stats [0:building_paragraphs*3-1] = {93,38,2};
	localparam integer building1_num=27, building2_num=16;
	localparam integer building1 [0:building1_num-1] = {15,34,28,36,52,46,41,52,45,40,52,54,52,28,40,38,41,40,39,30,39,45,44,52,26,39,29};
	localparam integer building2 [0:building2_num-1] = {29,43,26,48,52,45,33,30,34,43,52,27,40,49,30,44};

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
    wire [2:0] temp2 = temp [2:0];
	wire [2:0] glyph_row_now = line_active_vert ? temp : 3'd0;

	// Line length & glyph code from counters
	reg [7:0] line_length; reg [7:0] glyph_code;
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

	// Inside glyph (exclude spacer)
	wire inside_char = h_band_valid && (glyph_col_cnt < GLYPH_W) && (glyph_row_cnt < GLYPH_H) && (char_idx < line_length);

	// Address calculation
	wire [11:0] glyph_base = CODE_IS_BASE ? glyph_code[11:0] : (glyph_code * GLYPH_SIZE);
	wire [11:0] row_offset = ROW_MAJOR ? (glyph_row_cnt * GLYPH_W) : (glyph_col_cnt * GLYPH_H);
	wire [11:0] col_offset = ROW_MAJOR ? glyph_col_cnt : glyph_row_cnt;
	wire [11:0] addr_calc  = glyph_base + row_offset + col_offset;

	// Register outputs (align with synchronous BRAM)
	always @(posedge clk25 or posedge rst) begin
		if(rst) begin
			edu_pixel_en <= 1'b0;
			edu_tab_addr <= 12'd0;
		end else begin
			edu_pixel_en <= inside_char;
			edu_tab_addr <= inside_char ? addr_calc : 12'd0;
		end
	end

endmodule
