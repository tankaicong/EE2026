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

module Convolution_3x3
#(
    parameter IMAGE_WIDTH   = 306,
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

    // Color line buffers (past 2 rows) - store RGB444 for each pixel column
    reg [PIXEL_DEPTH-1:0] clinebuf1 [0:IMAGE_WIDTH-1];  // row-1 color
    reg [PIXEL_DEPTH-1:0] clinebuf2 [0:IMAGE_WIDTH-1];  // row-2 color

    // 3x3 sliding window shift registers per row (oldest at index 0)
    reg [PIXEL_DEPTH-1:0] cw0 [0:2]; // top row color (row-2)
    reg [PIXEL_DEPTH-1:0] cw1 [0:2]; // middle row color (row-1)
    reg [PIXEL_DEPTH-1:0] cw2 [0:2]; // bottom row color (row)

    // row/column counters for current incoming sample position (row, col)
    // These counters are allowed to extend to IMAGE_WIDTH/HEIGHT during padding.
    reg [9:0]  col;                // supports >= 306 and +1 padding column
    reg [9:0]  row;                // supports >= 240 and +1 padding row

    // Convenience: detect padding phases
    wire is_pad_col = (col >= IMAGE_WIDTH);
    wire is_pad_row = (row >= IMAGE_HEIGHT);

    // Center coordinate for current window (row-1, col-1)
    wire [9:0] cen_row = (row == 0) ? 10'd0 : (row - 10'd1);
    wire [9:0] cen_col = (col == 0) ? 10'd0 : (col - 10'd1);

    // Valid output whenever center is within image bounds and we are running
    wire center_in_bounds = (row != 0) && (col != 0) &&
                            (cen_row < IMAGE_HEIGHT) && (cen_col < IMAGE_WIDTH);

    // Select current input pixel (RGB444 or bitmap replicated) or zero during padding
    wire [PIXEL_DEPTH-1:0] rgb_from_mode = mode_rgb ? pixel_rgb_in : (pixel_bin_in ? 12'h111 : 12'h000);
    wire [PIXEL_DEPTH-1:0] cur_rgb = (is_pad_col || is_pad_row) ? 12'd0 : rgb_from_mode;

    // Previous rows at current column (guard reads during pad column)
    reg [PIXEL_DEPTH-1:0] cprev1; // row-1, same col
    reg [PIXEL_DEPTH-1:0] cprev2; // row-2, same col

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
            for (k = 0; k < IMAGE_WIDTH; k = k + 1) begin
                clinebuf1[k] <= 12'd0;
                clinebuf2[k] <= 12'd0;
            end
        end else begin
            // Determine if we should process this cycle: real input or padding while running
            if (we) begin
                running <= 1'b1; // start running when first input arrives
            end

            if (we || (running && (is_pad_col || is_pad_row))) begin
                // Safe reads from line buffers
                if (is_pad_col) begin
                    cprev1 = 12'd0;
                    cprev2 = 12'd0;
                end else begin
                    cprev1 = clinebuf1[col];
                    cprev2 = clinebuf2[col];
                end

                // Update sliding window (shift left, insert newest at [*][2])
                cw0[0] = cw0[1]; cw0[1] = cw0[2]; cw0[2] = cprev2; // top row from row-2
                cw1[0] = cw1[1]; cw1[1] = cw1[2]; cw1[2] = cprev1; // middle from row-1
                cw2[0] = cw2[1]; cw2[1] = cw2[2]; cw2[2] = cur_rgb; // bottom inserts current

                // Update line buffers for next rows (color) when within real column range
                if (!is_pad_col) begin
                    clinebuf2[col] <= cprev1;
                    clinebuf1[col] <= cur_rgb;
                end

                // Convolution core in its own block to keep declarations first
                begin : conv_core
                    reg signed [ACC_WIDTH-1:0] sumR, sumG, sumB;
                    reg signed [PROD_WIDTH-1:0] p;
                    sumR = 0; sumG = 0; sumB = 0;

                    // Row 0
                    p = $signed(k00) * $signed({1'b0, get_r(cw0[0])}); sumR = sumR + p;
                    p = $signed(k00) * $signed({1'b0, get_g(cw0[0])}); sumG = sumG + p;
                    p = $signed(k00) * $signed({1'b0, get_b(cw0[0])}); sumB = sumB + p;

                    p = $signed(k01) * $signed({1'b0, get_r(cw0[1])}); sumR = sumR + p;
                    p = $signed(k01) * $signed({1'b0, get_g(cw0[1])}); sumG = sumG + p;
                    p = $signed(k01) * $signed({1'b0, get_b(cw0[1])}); sumB = sumB + p;

                    p = $signed(k02) * $signed({1'b0, get_r(cw0[2])}); sumR = sumR + p;
                    p = $signed(k02) * $signed({1'b0, get_g(cw0[2])}); sumG = sumG + p;
                    p = $signed(k02) * $signed({1'b0, get_b(cw0[2])}); sumB = sumB + p;

                    // Row 1
                    p = $signed(k10) * $signed({1'b0, get_r(cw1[0])}); sumR = sumR + p;
                    p = $signed(k10) * $signed({1'b0, get_g(cw1[0])}); sumG = sumG + p;
                    p = $signed(k10) * $signed({1'b0, get_b(cw1[0])}); sumB = sumB + p;

                    p = $signed(k11) * $signed({1'b0, get_r(cw1[1])}); sumR = sumR + p;
                    p = $signed(k11) * $signed({1'b0, get_g(cw1[1])}); sumG = sumG + p;
                    p = $signed(k11) * $signed({1'b0, get_b(cw1[1])}); sumB = sumB + p;

                    p = $signed(k12) * $signed({1'b0, get_r(cw1[2])}); sumR = sumR + p;
                    p = $signed(k12) * $signed({1'b0, get_g(cw1[2])}); sumG = sumG + p;
                    p = $signed(k12) * $signed({1'b0, get_b(cw1[2])}); sumB = sumB + p;

                    // Row 2
                    p = $signed(k20) * $signed({1'b0, get_r(cw2[0])}); sumR = sumR + p;
                    p = $signed(k20) * $signed({1'b0, get_g(cw2[0])}); sumG = sumG + p;
                    p = $signed(k20) * $signed({1'b0, get_b(cw2[0])}); sumB = sumB + p;

                    p = $signed(k21) * $signed({1'b0, get_r(cw2[1])}); sumR = sumR + p;
                    p = $signed(k21) * $signed({1'b0, get_g(cw2[1])}); sumG = sumG + p;
                    p = $signed(k21) * $signed({1'b0, get_b(cw2[1])}); sumB = sumB + p;

                    p = $signed(k22) * $signed({1'b0, get_r(cw2[2])}); sumR = sumR + p;
                    p = $signed(k22) * $signed({1'b0, get_g(cw2[2])}); sumG = sumG + p;
                    p = $signed(k22) * $signed({1'b0, get_b(cw2[2])}); sumB = sumB + p;

                    // Clamp each channel to 4-bit after bias/shift
                    if (center_in_bounds) begin
                        pixel_out   <= { sat4_shift(sumR), sat4_shift(sumG), sat4_shift(sumB) };
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
