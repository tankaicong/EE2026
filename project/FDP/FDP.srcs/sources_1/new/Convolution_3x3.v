`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 3x3 Convolution filter for image processing (streaming)
// - Supports RGB444 (per-channel) and 1-bit bitmap inputs
// - Zero-padding semantics at image boundaries (outputs for all pixels)
// - Streaming interface similar to Median_Filter: clk/reset/frame_start/we
// - Output pixel_out is RGB444; in bitmap mode the scalar result is replicated
//   across R, G, B (monochrome RGB) to keep the same interface
//
// Kernel is compile-time configurable via parameters k00..k22 (signed).
// Optional BIAS and right-shift SCALE are applied to the accumulated sum
// before clamping to 4-bit per channel.
//
// NOTE on timing/latency:
//   Output corresponds to the center of the current 3x3 window, which is
//   aligned to coordinates (row-1, col-1) relative to the input sampling.
//   To produce valid outputs for the right-most column and bottom-most row,
//   this module internally injects one column and one row of zero pixels
//   (zero-padding) after each line and at the end of the frame, respectively.
//////////////////////////////////////////////////////////////////////////////////

// Force arithmetic to use DSPs where possible to drastically reduce LUT usage
(* use_dsp = "yes" *)
module Convolution_3x3
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
    parameter integer SCALE = 0                   // arithmetic right shift applied after BIAS
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

    output reg  [PIXEL_DEPTH-1:0] pixel_out,          // RGB444 filtered output
    output reg  [16:0]           addr_out,            // 0..(IMAGE_WIDTH*IMAGE_HEIGHT-1)
    output reg                   pixel_valid
);

    // Internal running flag: becomes 1 once the frame starts receiving pixels,
    // stays 1 through internal padding flush, then returns to 0 until next frame_start.
    reg running;

    // Row delays via BRAM for color: two cascaded line delays (depth = IMAGE_WIDTH)
    wire [PIXEL_DEPTH-1:0] color_ld1_out, color_ld2_out;

    // 3x3 sliding window shift registers per row (oldest at index 0)
    reg [PIXEL_DEPTH-1:0] cw0 [0:2]; // top row color (row-2)
    reg [PIXEL_DEPTH-1:0] cw1 [0:2]; // middle row color (row-1)
    reg [PIXEL_DEPTH-1:0] cw2 [0:2]; // bottom row color (row)

    // row/column counters for current incoming sample position (row, col)
    // These counters are allowed to extend to IMAGE_WIDTH/HEIGHT during padding.
    reg [9:0]  col;                // supports >= 310 and +1 padding column
    reg [9:0]  row;                // supports >= 240 and +1 padding row

    // Convenience: detect padding phases
    wire is_pad_col = (col >= IMAGE_WIDTH);
    wire is_pad_row = (row >= IMAGE_HEIGHT);

    // Center coordinate for current window (row-1, col-1)
    wire [9:0] cen_row = (row == 0) ? 10'd0 : (row - 10'd1);
    wire [9:0] cen_col = (col == 0) ? 10'd0 : (col - 10'd1);

    // Valid output whenever center is within image bounds and we are running.
    // Allow top row and left column by relying on zero-initialized windows
    // for proper zero-padding semantics.
    wire center_in_bounds = (cen_row < IMAGE_HEIGHT) && (cen_col < IMAGE_WIDTH);

    // Select current input pixel (RGB444 or bitmap replicated) or zero during padding
    wire [PIXEL_DEPTH-1:0] rgb_from_mode = mode_rgb ? pixel_rgb_in : (pixel_bin_in ? 12'h111 : 12'h000);
    wire [PIXEL_DEPTH-1:0] cur_rgb = (is_pad_col || is_pad_row) ? 12'd0 : rgb_from_mode;

    // Previous rows via line delays with edge replication
    wire [PIXEL_DEPTH-1:0] y0_col;  // current row color (with padding)
    wire [PIXEL_DEPTH-1:0] y1_col;  // row-1 color
    wire [PIXEL_DEPTH-1:0] y2_col;  // row-2 color
    
    // Track last valid samples at the end of a real row to support right-edge replication
    reg [PIXEL_DEPTH-1:0] last_y1_col_row; // one-line delay at last real column
    reg [PIXEL_DEPTH-1:0] last_y2_col_row; // two-line delay at last real column
    reg [PIXEL_DEPTH-1:0] last_y0_col_row; // current rgb at last real column

    // Signed math widths
    localparam integer IN_CH_WIDTH = 5; // we extend 4-bit channel to 5 bits with leading 0
    localparam integer PROD_WIDTH  = COEF_WIDTH + IN_CH_WIDTH;        // product width (signed coeff * zero-extended 4-bit)
    localparam integer ACC_WIDTH   = PROD_WIDTH + 4;                  // accumulate 9 terms: add ~4 bits headroom

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

    // Signed-extend a 4-bit channel to internal signed width
    function automatic signed [IN_CH_WIDTH-1:0] sx_ch;
        input [3:0] c;
    begin
        // inputs are 0..15; treat as positive magnitude
        sx_ch = {1'b0, c};
    end
    endfunction

    // ------------------------------------------------------------------------
    // Precompute all 27 products as wires to ensure clean DSP inference.
    // Vivado may otherwise implement constant-coefficient multiplies in LUTs.
    // Mark each product with use_dsp to bias mapping to DSP48 slices.
    // ------------------------------------------------------------------------
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
    // Precomputed src selections for middle/top rows with right-edge replication
    wire [PIXEL_DEPTH-1:0] src1_col = is_pad_col ? last_y1_col_row : y1_col;
    wire [PIXEL_DEPTH-1:0] src2_col = is_pad_col ? last_y2_col_row : y2_col;

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

    integer k;
    // Instantiate line delays
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

    // Form per-row sources with top-edge replication
    assign y0_col = (is_pad_col || is_pad_row) ? 12'd0 : rgb_from_mode;
    assign y1_col = (row == 0) ? y0_col : color_ld1_out;
    assign y2_col = (row == 0) ? y0_col : (row == 1 ? y1_col : color_ld2_out);
    always @(posedge clk) begin
        if (reset || frame_start) begin
            // Reset counters and state. Clear windows and buffers.
            running     <= 1'b0;
            col         <= 10'd0;
            row         <= 10'd0;
            cw0[0] <= 12'd0; cw0[1] <= 12'd0; cw0[2] <= 12'd0;
            cw1[0] <= 12'd0; cw1[1] <= 12'd0; cw1[2] <= 12'd0;
            cw2[0] <= 12'd0; cw2[1] <= 12'd0; cw2[2] <= 12'd0;
            pixel_out   <= 12'd0;
            addr_out    <= 18'd0;
            pixel_valid <= 1'b0;
            // No BRAM clear
        end else begin
            // Determine if we should process this cycle: real input or padding while running
            if (we) begin
                running <= 1'b1; // start running when first input arrives
            end

            if (we || (running && (is_pad_col || is_pad_row))) begin
                // Update sliding window (shift left, insert newest at [*][2])
                cw0[0] = cw0[1]; cw0[1] = cw0[2]; cw0[2] = src2_col; // top row from row-2
                cw1[0] = cw1[1]; cw1[1] = cw1[2]; cw1[2] = src1_col; // middle from row-1
                cw2[0] = cw2[1]; cw2[1] = cw2[2]; cw2[2] = y0_col;   // bottom inserts current

                // Left-edge replication to avoid dim left column due to zeros
                if (col == 10'd0) begin
                    // replicate current/nearest values into missing neighbors
                    cw0[0] = cw0[2]; cw0[1] = cw0[2];
                    cw1[0] = cw1[2]; cw1[1] = cw1[2];
                    cw2[0] = cw2[2]; cw2[1] = cw2[2];
                end else if (col == 10'd1) begin
                    // far-left neighbor equals the previous column (already in [1])
                    cw0[0] = cw0[1];
                    cw1[0] = cw1[1];
                    cw2[0] = cw2[1];
                end

                // Remember last real column for right-edge replication
                if (!is_pad_col && (col == (IMAGE_WIDTH-1))) begin
                    last_y1_col_row <= y1_col;
                    last_y2_col_row <= y2_col;
                    last_y0_col_row <= y0_col;
                end

                // Convolution core in its own block to keep declarations first
                begin : conv_core
                    // Clamp each channel to 4-bit after bias/shift
                    if (center_in_bounds) begin
                        pixel_out   <= { sat4_shift(sumR_w), sat4_shift(sumG_w), sat4_shift(sumB_w) };
                        addr_out    <= cen_row * IMAGE_WIDTH + cen_col;
                        pixel_valid <= 1'b1;
                    end else begin
                        pixel_out   <= 12'd0;
                        addr_out    <= addr_out;
                        pixel_valid <= 1'b0;
                    end
                end // block: conv_core

                // Advance position counters for next sample or padding
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
