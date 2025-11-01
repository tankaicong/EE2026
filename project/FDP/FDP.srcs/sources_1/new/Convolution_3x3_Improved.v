`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Convolution_3x3_Improved
// - Same interface as Convolution_3x3
// - Kernel sliding/window, padding, addressing, and timing logic copied from Median_Filter.v
// - Only the mathematical operation differs: perform per-channel 3x3 dot product
//////////////////////////////////////////////////////////////////////////////////

(* use_dsp = "yes" *)
module Convolution_3x3_Improved
#(
    parameter IMAGE_WIDTH   = 310,
    parameter IMAGE_HEIGHT  = 240,
    parameter PIXEL_DEPTH   = 12,           // RGB444 packed as {R[3:0], G[3:0], B[3:0]}
    parameter COEF_WIDTH    = 8,            // signed coeffs width
    parameter signed [COEF_WIDTH-1:0]
        k00 = 0, k01 = 0, k02 = 0,
        k10 = 0, k11 = 1, k12 = 0,
        k20 = 0, k21 = 0, k22 = 0,
    parameter signed [COEF_WIDTH+7:0] BIAS = 0, // optional bias added per-channel before shifting
    parameter integer SCALE = 0                  // arithmetic right shift applied after BIAS
)
(
    input  wire                 clk,
    input  wire                 reset,
    input  wire                 frame_start,          // assert during VSYNC to reset per-frame state
    input  wire                 we,                   // 1 = input sample valid this cycle

    // Select which input is used on each valid cycle
    input  wire                 mode_rgb,             // 1 = RGB444 on pixel_rgb_in, 0 = bitmap on pixel_bin_in
    input  wire [PIXEL_DEPTH-1:0] pixel_rgb_in,       // RGB444
    input  wire                 pixel_bin_in,         // 1-bit bitmap

    input  wire signed [11:0]   addr_off_col,
    input  wire signed [11:0]   addr_off_row,

    output reg  [PIXEL_DEPTH-1:0] pixel_out,          // RGB444 filtered output
    output reg  [16:0]           addr_out,            // 0..(IMAGE_WIDTH*IMAGE_HEIGHT-1)
    output reg                   pixel_valid
);

    // Internal running flag: becomes 1 once the frame starts receiving pixels,
    // stays 1 through internal padding flush, then returns to 0 until next frame_start.
    reg running;

    // --------------------
    // Row delays via BRAM (color only)
    // Two cascaded line delays (depth = IMAGE_WIDTH) for color to match Median_Filter behavior
    // --------------------
    wire [PIXEL_DEPTH-1:0] color_ld1_out, color_ld2_out;

    // 3x3 sliding window shift registers per row (oldest at index 0)
    reg [PIXEL_DEPTH-1:0] cw0 [0:2]; // top row color (row-2)
    reg [PIXEL_DEPTH-1:0] cw1 [0:2]; // middle row color (row-1)
    reg [PIXEL_DEPTH-1:0] cw2 [0:2]; // bottom row color (row)

    // row/column counters for current incoming sample position (row, col)
    // These counters are allowed to extend to IMAGE_WIDTH/HEIGHT during padding.
    reg [9:0]  col;                // supports >= IMAGE_WIDTH and +1 padding column
    reg [9:0]  row;                // supports >= IMAGE_HEIGHT and +1 padding row

    // Padding phase detection
    wire is_pad_col = (col >= IMAGE_WIDTH);
    wire is_pad_row = (row >= IMAGE_HEIGHT);

    // Center coordinate for current window (row-1, col-1)
    wire [9:0] cen_row = (row == 0) ? 10'd0 : (row - 10'd1);
    wire [9:0] cen_col = (col == 0) ? 10'd0 : (col - 10'd1);

    // Optional adjusted center used only for address reporting (to correct visual shift)
    // Keep arithmetic in a signed domain while checking bounds
    wire signed [11:0] adj_cen_col_s = $signed({1'b0, cen_col}) + addr_off_col;
    wire signed [11:0] adj_cen_row_s = $signed({1'b0, cen_row}) + addr_off_row;
    wire                adj_col_in   = (adj_cen_col_s >= 0) && (adj_cen_col_s < $signed(IMAGE_WIDTH));
    wire                adj_row_in   = (adj_cen_row_s >= 0) && (adj_cen_row_s < $signed(IMAGE_HEIGHT));
    wire [9:0]          adj_cen_col  = adj_cen_col_s[9:0];
    wire [9:0]          adj_cen_row  = adj_cen_row_s[9:0];

    // Valid output whenever original center is in-bounds and adjusted address is also in-bounds
    wire center_in_bounds = (cen_row < IMAGE_HEIGHT) && (cen_col < IMAGE_WIDTH);
    wire center_in_bounds_adj = center_in_bounds && adj_col_in && adj_row_in;

    // Mode mux: RGB input or replicated 1-bit bitmap; zero during padding phases
    wire [PIXEL_DEPTH-1:0] rgb_from_mode = mode_rgb ? pixel_rgb_in : (pixel_bin_in ? 12'h111 : 12'h000);

    // reset/initialization helpers and current/previous row sources (color only)
    wire [PIXEL_DEPTH-1:0] y0_col;  // current row color (with padding policy)
    wire [PIXEL_DEPTH-1:0] y1_col;  // row-1 color via line delay (with top-edge replication)
    wire [PIXEL_DEPTH-1:0] y2_col;  // row-2 color via line delay (with top-edge replication)

    wire advance = we || (running && (is_pad_col || is_pad_row));

    LineDelayBRAM #(
        .DATA_W(PIXEL_DEPTH),
        .DEPTH(IMAGE_WIDTH)
    ) color_ld1 (
        .clk(clk), .reset(reset || frame_start), .en(advance),
        .din((is_pad_col || is_pad_row) ? 12'd0 : rgb_from_mode),
        .dout(color_ld1_out)
    );

    LineDelayBRAM #(
        .DATA_W(PIXEL_DEPTH),
        .DEPTH(IMAGE_WIDTH)
    ) color_ld2 (
        .clk(clk), .reset(reset || frame_start), .en(advance),
        .din(color_ld1_out),
        .dout(color_ld2_out)
    );

    assign y0_col  = (is_pad_col || is_pad_row) ? 12'd0 : rgb_from_mode;
    // Top-edge replication using line delay outputs
    assign y1_col  = (row == 0) ? y0_col  : color_ld1_out;
    assign y2_col  = (row == 0) ? y0_col  : (row == 1 ? y1_col  : color_ld2_out);

    // Right-edge replication source selection (color only)
    reg [PIXEL_DEPTH-1:0] last_cy1_row;  // color one-line delay at last real column
    reg [PIXEL_DEPTH-1:0] last_cy2_row;  // color two-line delay at last real column
    reg [PIXEL_DEPTH-1:0] last_cy0_row;  // current color at last real column
    wire [PIXEL_DEPTH-1:0] src0_col  = is_pad_col ? last_cy0_row : y0_col;
    wire [PIXEL_DEPTH-1:0] src1_col  = is_pad_col ? last_cy1_row : y1_col;
    wire [PIXEL_DEPTH-1:0] src2_col  = is_pad_col ? last_cy2_row : y2_col;

    // Helpers to extract channels from RGB444 packed pixel
    function [3:0] get_r;
        input [PIXEL_DEPTH-1:0] px; begin get_r = px[11:8]; end
    endfunction
    function [3:0] get_g;
        input [PIXEL_DEPTH-1:0] px; begin get_g = px[7:4]; end
    endfunction
    function [3:0] get_b;
        input [PIXEL_DEPTH-1:0] px; begin get_b = px[3:0]; end
    endfunction

    // Signed math widths (same as Convolution_3x3)
    localparam integer IN_CH_WIDTH = 5; // extend 4-bit to 5-bit (unsigned magnitude)
    localparam integer PROD_WIDTH  = COEF_WIDTH + IN_CH_WIDTH;        // product width
    localparam integer ACC_WIDTH   = PROD_WIDTH + 4;                  // accumulate 9 terms

    // Signed-extend a 4-bit channel to internal signed width
    function automatic signed [IN_CH_WIDTH-1:0] sx_ch;
        input [3:0] c;
    begin
        sx_ch = {1'b0, c};
    end
    endfunction

    // Saturate a signed value to 4-bit unsigned [0..15] after optional shift
    function [3:0] sat4_shift;
        input signed [ACC_WIDTH-1:0] val_in;
        reg   signed [ACC_WIDTH+COEF_WIDTH-1:0] biased;
        reg   signed [ACC_WIDTH+COEF_WIDTH-1:0] shifted;
    begin
        biased  = val_in + BIAS;
        if (SCALE > 0) begin
            shifted = biased >>> SCALE; // arithmetic shift
        end else begin
            shifted = biased;
        end
        if (shifted <= 0) begin
            sat4_shift = 4'd0;
        end else if (shifted >= 15) begin
            sat4_shift = 4'd15;
        end else begin
            sat4_shift = shifted[3:0];
        end
    end
    endfunction

    // Precompute all 27 products as wires (per Median_Filter timing, these are combinational)
    // Row 0 products
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr00_r = $signed(k00) * $signed(sx_ch(get_r(cw0[0])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr00_g = $signed(k00) * $signed(sx_ch(get_g(cw0[0])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr00_b = $signed(k00) * $signed(sx_ch(get_b(cw0[0])));

    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr01_r = $signed(k01) * $signed(sx_ch(get_r(cw0[1])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr01_g = $signed(k01) * $signed(sx_ch(get_g(cw0[1])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr01_b = $signed(k01) * $signed(sx_ch(get_b(cw0[1])));

    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr02_r = $signed(k02) * $signed(sx_ch(get_r(cw0[2])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr02_g = $signed(k02) * $signed(sx_ch(get_g(cw0[2])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr02_b = $signed(k02) * $signed(sx_ch(get_b(cw0[2])));

    // Row 1 products
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr10_r = $signed(k10) * $signed(sx_ch(get_r(cw1[0])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr10_g = $signed(k10) * $signed(sx_ch(get_g(cw1[0])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr10_b = $signed(k10) * $signed(sx_ch(get_b(cw1[0])));

    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr11_r = $signed(k11) * $signed(sx_ch(get_r(cw1[1])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr11_g = $signed(k11) * $signed(sx_ch(get_g(cw1[1])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr11_b = $signed(k11) * $signed(sx_ch(get_b(cw1[1])));

    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr12_r = $signed(k12) * $signed(sx_ch(get_r(cw1[2])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr12_g = $signed(k12) * $signed(sx_ch(get_g(cw1[2])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr12_b = $signed(k12) * $signed(sx_ch(get_b(cw1[2])));

    // Row 2 products
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr20_r = $signed(k20) * $signed(sx_ch(get_r(cw2[0])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr20_g = $signed(k20) * $signed(sx_ch(get_g(cw2[0])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr20_b = $signed(k20) * $signed(sx_ch(get_b(cw2[0])));

    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr21_r = $signed(k21) * $signed(sx_ch(get_r(cw2[1])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr21_g = $signed(k21) * $signed(sx_ch(get_g(cw2[1])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr21_b = $signed(k21) * $signed(sx_ch(get_b(cw2[1])));

    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr22_r = $signed(k22) * $signed(sx_ch(get_r(cw2[2])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr22_g = $signed(k22) * $signed(sx_ch(get_g(cw2[2])));
    (* use_dsp = "yes" *) wire signed [PROD_WIDTH-1:0] pr22_b = $signed(k22) * $signed(sx_ch(get_b(cw2[2])));

    // Per-channel adder trees
    wire signed [ACC_WIDTH-1:0] sumR_w =
        $signed(pr00_r) + $signed(pr01_r) + $signed(pr02_r) +
        $signed(pr10_r) + $signed(pr11_r) + $signed(pr12_r) +
        $signed(pr20_r) + $signed(pr21_r) + $signed(pr22_r);

    wire signed [ACC_WIDTH-1:0] sumG_w =
        $signed(pr00_g) + $signed(pr01_g) + $signed(pr02_g) +
        $signed(pr10_g) + $signed(pr11_g) + $signed(pr12_g) +
        $signed(pr20_g) + $signed(pr21_g) + $signed(pr22_g);

    wire signed [ACC_WIDTH-1:0] sumB_w =
        $signed(pr00_b) + $signed(pr01_b) + $signed(pr02_b) +
        $signed(pr10_b) + $signed(pr11_b) + $signed(pr12_b) +
        $signed(pr20_b) + $signed(pr21_b) + $signed(pr22_b);

    integer k;
    always @(posedge clk) begin
        if (reset || frame_start) begin
            // Reset counters and state. Clear windows and buffers.
            running   <= 1'b0;
            col       <= 10'd0;
            row       <= 10'd0;
            cw0[0] <= 12'd0; cw0[1] <= 12'd0; cw0[2] <= 12'd0;
            cw1[0] <= 12'd0; cw1[1] <= 12'd0; cw1[2] <= 12'd0;
            cw2[0] <= 12'd0; cw2[1] <= 12'd0; cw2[2] <= 12'd0;
            pixel_out <= 12'd0;
            addr_out  <= 17'd0;
            pixel_valid <= 1'd0;
            last_cy1_row  <= 0;
            last_cy2_row  <= 0;
            last_cy0_row  <= 0;
        end else begin
            // Determine if we should process this cycle: real input or padding while running
            if (we) begin
                running <= 1'b1; // start running when first input arrives
            end

            if (we || (running && (is_pad_col || is_pad_row))) begin
                // Update sliding window (shift left, insert newest at [*][2])
                // Right-edge replication for padding column uses module-scope src* wires
                cw0[0] = cw0[1]; cw0[1] = cw0[2]; cw0[2] = src2_col; // top row color
                cw1[0] = cw1[1]; cw1[1] = cw1[2]; cw1[2] = src1_col; // mid row color
                cw2[0] = cw2[1]; cw2[1] = cw2[2]; cw2[2] = src0_col; // bottom color

                // Left-edge handling: only fill the missing far-left neighbor (match Median_Filter)
                if (col == 10'd0) begin
                    cw0[1] = cw0[2]; cw0[0] = cw0[2];
                    cw1[1] = cw1[2]; cw1[0] = cw1[2];
                    cw2[1] = cw2[2]; cw2[0] = cw2[2];
                end else if (col == 10'd1) begin
                    // keep single-neighbor replacement for the second column
                    cw0[0] = cw0[1];
                    cw1[0] = cw1[1];
                    cw2[0] = cw2[1];
                end

                // Remember last real column values for right-edge replication
                if (!is_pad_col && (col == (IMAGE_WIDTH-1))) begin
                    last_cy1_row  <= y1_col;
                    last_cy2_row  <= y2_col;
                    last_cy0_row  <= y0_col;
                end

                // Output when center coordinate is valid (zero-padding semantics)
                // Use adjusted address to compensate visual shift when requested
                if (center_in_bounds_adj) begin
                    pixel_out   <= { sat4_shift(sumR_w), sat4_shift(sumG_w), sat4_shift(sumB_w) };
                    addr_out    <= adj_cen_row * IMAGE_WIDTH + adj_cen_col;
                    pixel_valid <= 1'b1;
                end else begin
                    pixel_out   <= 12'd0;
                    addr_out    <= addr_out;
                    pixel_valid <= 1'b0;
                end

                // Advance position counters for next sample or padding (identical to Median_Filter)
                if (!is_pad_col && !is_pad_row) begin
                    // Real input sample
                    if (col == (IMAGE_WIDTH-1)) begin
                        col <= IMAGE_WIDTH; // enter pad column for right border
                    end else begin
                        col <= col + 10'd1;
                    end
                end else if (is_pad_col && !is_pad_row) begin
                    // Padding column at the end of a real row -> next row
                    col <= 10'd0;
                    if (row == (IMAGE_HEIGHT-1)) begin
                        row <= IMAGE_HEIGHT; // enter bottom padding row
                    end else begin
                        row <= row + 10'd1;
                    end
                end else if (!is_pad_col && is_pad_row) begin
                    // Bottom padding row over real columns
                    if (col == (IMAGE_WIDTH-1)) begin
                        col <= IMAGE_WIDTH; // final pad column for bottom row
                    end else begin
                        col <= col + 10'd1;
                    end
                end else begin // is_pad_col && is_pad_row
                    // Final padding column of the bottom padding row -> frame flush complete
                    col <= 10'd0;
                    row <= 10'd0;
                    running <= 1'b0; // stop until next frame_start and next we
                end
            end else begin
                // Idle: no input and not in a padding phase
                pixel_valid <= 1'b0;
            end
        end
    end

endmodule
