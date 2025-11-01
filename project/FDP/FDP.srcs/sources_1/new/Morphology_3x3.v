`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 3x3 Morphology (Erode/Dilate) for 1-bit bitmap images (streaming)
// - Input is a 1-bit bitmap pixel stream with write-enable (we)
// - Output is a 1-bit bitmap with the same streaming/address handshake as Convolution_3x3
// - Zero-padding semantics at image boundaries; produces outputs for all pixels
// - Operation selection via op_dilate: 1 = dilation (OR of 3x3), 0 = erosion (AND of 3x3)
//
// Timing/latency:
//   Output corresponds to the center of the current 3x3 window, aligned to
//   (row-1, col-1) relative to the input sample position. The module injects
//   a padding column and row of zeros to flush the right/bottom borders.
//////////////////////////////////////////////////////////////////////////////////

module Morphology_3x3
#(
    parameter IMAGE_WIDTH   = 310,
    parameter IMAGE_HEIGHT  = 240
)
(
    input  wire        clk,
    input  wire        reset,
    input  wire        frame_start,   // assert during VSYNC to reset per-frame state
    input  wire        we,            // 1 = input sample valid this cycle

    input  wire        pixel_in,      // 1-bit bitmap input
    input  wire        op_dilate,     // 1 = dilate (OR of 3x3), 0 = erode (AND of 3x3)

    input  wire signed [11:0] addr_off_col,
    input  wire signed [11:0] addr_off_row,

    output reg         pixel_out,     // 1-bit morphology result
    output reg [17:0]  addr_out,      // 0..(IMAGE_WIDTH*IMAGE_HEIGHT-1)
    output reg         pixel_valid
);

    // Internal running flag: becomes 1 once the frame starts receiving pixels,
    // stays 1 through internal padding flush, then returns to 0 until next frame_start.
    reg running;

    // Line buffers for past 2 rows (bitmap)
    reg linebuf1 [0:IMAGE_WIDTH-1];  // row-1
    reg linebuf2 [0:IMAGE_WIDTH-1];  // row-2

    // 3x3 sliding window per row (oldest at index 0)
    reg w0 [0:2]; // top row bits (row-2)
    reg w1 [0:2]; // middle row bits (row-1)
    reg w2 [0:2]; // bottom row bits (row)

    // row/column counters for current incoming sample position (row, col)
    // These counters are allowed to extend to IMAGE_WIDTH/HEIGHT during padding.
    reg [9:0]  col;  // supports >= 310 and +1 padding column
    reg [9:0]  row;  // supports >= 240 and +1 padding row

    // Detect padding phases
    wire is_pad_col = (col >= IMAGE_WIDTH);
    wire is_pad_row = (row >= IMAGE_HEIGHT);

    // Center coordinate for current window (row-1, col-1)
    wire [9:0] cen_row = (row == 0) ? 10'd0 : (row - 10'd1);
    wire [9:0] cen_col = (col == 0) ? 10'd0 : (col - 10'd1);

    // Valid output whenever center is within image bounds; allow runtime offset for address reporting
    wire center_in_bounds = (row != 0) && (col != 0) &&
                            (cen_row < IMAGE_HEIGHT) && (cen_col < IMAGE_WIDTH);
    // Adjusted center coordinate used only for address reporting
    wire signed [11:0] adj_cen_col_s = $signed({1'b0, cen_col}) + addr_off_col;
    wire signed [11:0] adj_cen_row_s = $signed({1'b0, cen_row}) + addr_off_row;
    wire                adj_col_in   = (adj_cen_col_s >= 0) && (adj_cen_col_s < $signed(IMAGE_WIDTH));
    wire                adj_row_in   = (adj_cen_row_s >= 0) && (adj_cen_row_s < $signed(IMAGE_HEIGHT));
    wire [9:0]          adj_cen_col  = adj_cen_col_s[9:0];
    wire [9:0]          adj_cen_row  = adj_cen_row_s[9:0];
    wire                center_in_bounds_adj = center_in_bounds && adj_col_in && adj_row_in;

    // Current input bit with zero-padding during pad phases
    wire cur_bit = (is_pad_col || is_pad_row) ? 1'b0 : pixel_in;

    // Previous rows at current column (guard during pad column)
    reg prev1; // row-1, same col
    reg prev2; // row-2, same col

    integer k;
    always @(posedge clk) begin
        if (reset || frame_start) begin
            // Reset counters and state. Clear windows and buffers.
            running     <= 1'b0;
            col         <= 10'd0;
            row         <= 10'd0;
            w0[0] <= 1'b0; w0[1] <= 1'b0; w0[2] <= 1'b0;
            w1[0] <= 1'b0; w1[1] <= 1'b0; w1[2] <= 1'b0;
            w2[0] <= 1'b0; w2[1] <= 1'b0; w2[2] <= 1'b0;
            pixel_out   <= 1'b0;
            addr_out    <= 18'd0;
            pixel_valid <= 1'b0;
            for (k = 0; k < IMAGE_WIDTH; k = k + 1) begin
                linebuf1[k] <= 1'b0;
                linebuf2[k] <= 1'b0;
            end
        end else begin
            // Start running once first input arrives
            if (we) begin
                running <= 1'b1;
            end

            // Process on real input or during padding flush
            if (we || (running && (is_pad_col || is_pad_row))) begin
                // Safe reads from line buffers
                if (is_pad_col) begin
                    prev1 = 1'b0;
                    prev2 = 1'b0;
                end else begin
                    prev1 = linebuf1[col];
                    prev2 = linebuf2[col];
                end

                // Update sliding window (shift left, insert newest at [*][2])
                w0[0] = w0[1]; w0[1] = w0[2]; w0[2] = prev2; // top row from row-2
                w1[0] = w1[1]; w1[1] = w1[2]; w1[2] = prev1; // middle from row-1
                w2[0] = w2[1]; w2[1] = w2[2]; w2[2] = cur_bit; // bottom inserts current

                // Update line buffers for next rows when within real column range
                if (!is_pad_col) begin
                    linebuf2[col] <= prev1;
                    linebuf1[col] <= cur_bit;
                end

                // Morphology core: OR for dilation, AND for erosion
                begin : morph_core
                    reg any1;
                    reg all1;
                    reg res;
                    any1 = w0[0] | w0[1] | w0[2] |
                           w1[0] | w1[1] | w1[2] |
                           w2[0] | w2[1] | w2[2];
                    all1 = w0[0] & w0[1] & w0[2] &
                           w1[0] & w1[1] & w1[2] &
                           w2[0] & w2[1] & w2[2];
                    res  = op_dilate ? any1 : all1;

                    if (center_in_bounds_adj) begin
                        pixel_out   <= res;
                        addr_out    <= adj_cen_row * IMAGE_WIDTH + adj_cen_col;
                        pixel_valid <= 1'b1;
                    end else begin
                        pixel_out   <= 1'b0;
                        addr_out    <= addr_out;
                        pixel_valid <= 1'b0;
                    end
                end

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
