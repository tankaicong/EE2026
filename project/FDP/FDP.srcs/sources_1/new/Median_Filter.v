`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 3x3 Median filter for image processing (streaming)
// Reference (median filter hardware): http://www.isaac-scientific.com/images/PaperPDF/FSP_100040_2020081015013363641.pdf
// Reference (implementation): https://sistenix.com/sobel.html
//////////////////////////////////////////////////////////////////////////////////

module Median_Filter
#(  parameter KERNEL_SIZE  = 3,
    parameter PIXEL_DEPTH  = 12,      // RGB444
    parameter GRAY_DEPTH   = 4,       // Grayscale
    parameter IMAGE_WIDTH  = 310,
    parameter IMAGE_HEIGHT = 240)
(
    input clk,
    input reset,
    input frame_start,                       // assert during VSYNC
    input [PIXEL_DEPTH-1:0] pixel_in,        // RGB444
    input we,                                // 1 = input sample valid this cycle
    output reg [11:0] pixel_out,             // RGB444 of the pixel whose grayscale is the window median
    output reg [16:0] addr_out,              // 0..(IMAGE_WIDTH*IMAGE_HEIGHT-1)
    output reg pixel_valid
);

    // convert to grayscale 4-bit using 0.25R + 0.5G + 0.25B
    wire [3:0] r4 = pixel_in[11:8];
    wire [3:0] g4 = pixel_in[7:4];
    wire [3:0] b4 = pixel_in[3:0];
    wire [GRAY_DEPTH+2:0] sum_w = {2'b00, r4} + {1'b0, g4, 1'b0} + {2'b00, b4}; // r + 2*g + b
    wire [GRAY_DEPTH-1:0] gray4_in = sum_w >> 2;

    // grayscale and color line buffers (past 2 rows)
    reg [GRAY_DEPTH-1:0] linebuf1 [0:IMAGE_WIDTH-1];  // row-1
    reg [GRAY_DEPTH-1:0] linebuf2 [0:IMAGE_WIDTH-1];  // row-2
    reg [PIXEL_DEPTH-1:0] clinebuf1 [0:IMAGE_WIDTH-1];  // row-1 color
    reg [PIXEL_DEPTH-1:0] clinebuf2 [0:IMAGE_WIDTH-1];  // row-2 color

    // 3x3 sliding window shift registers per row (oldest at index 0)
    reg [GRAY_DEPTH-1:0] w0 [0:2]; // top row (row-2)
    reg [GRAY_DEPTH-1:0] w1 [0:2]; // middle row (row-1)
    reg [GRAY_DEPTH-1:0] w2 [0:2]; // bottom row (row)
    reg [PIXEL_DEPTH-1:0] cw0 [0:2]; // top row color
    reg [PIXEL_DEPTH-1:0] cw1 [0:2]; // middle row color
    reg [PIXEL_DEPTH-1:0] cw2 [0:2]; // bottom row color

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

    // Valid output whenever center is within image bounds and we are running.
    wire center_in_bounds = (cen_row < IMAGE_HEIGHT) && (cen_col < IMAGE_WIDTH);

    // Internal running flag: becomes 1 once the frame starts receiving pixels,
    // stays 1 through internal padding flush, then returns to 0 until next frame_start.
    reg running;


    // Helper functions for 3-element stats
    function [GRAY_DEPTH-1:0] max3;
        input [GRAY_DEPTH-1:0] a,b,c;
    begin
        max3 = (a >= b) ? ((a >= c) ? a : c) : ((b >= c) ? b : c);
    end
    endfunction

    function [GRAY_DEPTH-1:0] min3;
        input [GRAY_DEPTH-1:0] a,b,c;
    begin
        min3 = (a <= b) ? ((a <= c) ? a : c) : ((b <= c) ? b : c);
    end
    endfunction

    function [GRAY_DEPTH-1:0] mid3;
        input [GRAY_DEPTH-1:0] a,b,c;
        reg   [GRAY_DEPTH+2:0] s;
        reg   [GRAY_DEPTH-1:0] mn, mx;
    begin
        s  = a + b + c;
        mn = min3(a,b,c);
        mx = max3(a,b,c);
        mid3 = s - mn - mx;
    end
    endfunction

    // Median-of-9 regs (computed after window shift within the clocked block)
    reg [GRAY_DEPTH-1:0] m1_max, m1_mid, m1_min;
    reg [GRAY_DEPTH-1:0] m2_max, m2_mid, m2_min;
    reg [GRAY_DEPTH-1:0] m3_max, m3_mid, m3_min;
    reg [GRAY_DEPTH-1:0] min_of_max, mid_of_mid, max_of_min, median;

    // Track last valid samples at the end of a real row to support right-edge replication
    reg [GRAY_DEPTH-1:0] last_prev1_row; // grayscale linebuf1 at last real column
    reg [GRAY_DEPTH-1:0] last_prev2_row; // grayscale linebuf2 at last real column
    reg [GRAY_DEPTH-1:0] last_cur_gray_row; // current grayscale at last real column
    reg [PIXEL_DEPTH-1:0] last_cprev1_row;  // color linebuf1 at last real column
    reg [PIXEL_DEPTH-1:0] last_cprev2_row;  // color linebuf2 at last real column
    reg [PIXEL_DEPTH-1:0] last_cur_rgb_row; // current rgb at last real column

    // reset/initialization
    integer k;
    reg [GRAY_DEPTH-1:0] prev1; // row-1, same col (gray)
    reg [GRAY_DEPTH-1:0] prev2; // row-2, same col (gray)
    reg [PIXEL_DEPTH-1:0] cprev1; // row-1, same col (color)
    reg [PIXEL_DEPTH-1:0] cprev2; // row-2, same col (color)
    always @(posedge clk) begin
        if (reset || frame_start) begin
            // Reset counters and state. Clear windows and buffers.
            running   <= 1'b0;
            col       <= 10'd0;
            row       <= 10'd0;
            w0[0] <= 4'd0; w0[1] <= 4'd0; w0[2] <= 4'd0;
            w1[0] <= 4'd0; w1[1] <= 4'd0; w1[2] <= 4'd0;
            w2[0] <= 4'd0; w2[1] <= 4'd0; w2[2] <= 4'd0;
            cw0[0] <= 12'd0; cw0[1] <= 12'd0; cw0[2] <= 12'd0;
            cw1[0] <= 12'd0; cw1[1] <= 12'd0; cw1[2] <= 12'd0;
            cw2[0] <= 12'd0; cw2[1] <= 12'd0; cw2[2] <= 12'd0;
            pixel_out <= 12'd0;
            addr_out  <= 18'd0;
            pixel_valid <= 1'd0;
            for (k = 0; k < IMAGE_WIDTH; k = k + 1) begin
                linebuf1[k] <= 4'd0;
                linebuf2[k] <= 4'd0;
                clinebuf1[k] <= 12'd0;
                clinebuf2[k] <= 12'd0;
            end
            last_prev1_row   <= 0;
            last_prev2_row   <= 0;
            last_cur_gray_row<= 0;
            last_cprev1_row  <= 0;
            last_cprev2_row  <= 0;
            last_cur_rgb_row <= 0;
        end else begin
            // Determine if we should process this cycle: real input or padding while running
            if (we) begin
                running <= 1'b1; // start running when first input arrives
            end

            if (we || (running && (is_pad_col || is_pad_row))) begin
                // Safe reads from line buffers and edge replication
                if (is_pad_col) begin
                    // Replicate the last real column for right-edge padding
                    prev1  = last_prev1_row;
                    prev2  = last_prev2_row;
                    cprev1 = last_cprev1_row;
                    cprev2 = last_cprev2_row;
                end else begin
                    // Top-edge replication: when row==0, there is no prior row; use current
                    // When row==1, row-2 is out of range; replicate row-1 into row-2
                    prev1  = (row == 0) ? gray4_in : linebuf1[col];
                    prev2  = (row == 0) ? gray4_in : (row == 1 ? linebuf1[col] : linebuf2[col]);
                    cprev1 = (row == 0) ? pixel_in : clinebuf1[col];
                    cprev2 = (row == 0) ? pixel_in : (row == 1 ? clinebuf1[col] : clinebuf2[col]);
                end

                // Update sliding window (shift left, insert newest at [*][2])
                w0[0] = w0[1]; w0[1] = w0[2]; w0[2] = prev2;        // top row (gray)
                w1[0] = w1[1]; w1[1] = w1[2]; w1[2] = prev1;        // mid row (gray)
                w2[0] = w2[1]; w2[1] = w2[2]; w2[2] = (is_pad_col || is_pad_row) ? 4'd0 : gray4_in; // bottom (gray)
                // Color window mirrors grayscale sources
                cw0[0] = cw0[1]; cw0[1] = cw0[2]; cw0[2] = cprev2;   // top row color
                cw1[0] = cw1[1]; cw1[1] = cw1[2]; cw1[2] = cprev1;   // mid row color
                cw2[0] = cw2[1]; cw2[1] = cw2[2]; cw2[2] = (is_pad_col || is_pad_row) ? 12'd0 : pixel_in; // bottom color

                // Left-edge replication similar to Convolution_3x3
                if (col == 10'd0) begin
                    // replicate current/nearest values into missing neighbors
                    w0[0] = prev2; w0[1] = prev2;
                    w1[0] = prev1; w1[1] = prev1;
                    w2[0] = w2[2]; w2[1] = w2[2];
                    cw0[0] = cprev2; cw0[1] = cprev2;
                    cw1[0] = cprev1; cw1[1] = cprev1;
                    cw2[0] = cw2[2]; cw2[1] = cw2[2];
                end else if (col == 10'd1) begin
                    // far-left neighbor equals the previous column (already in [1])
                    w0[0] = w0[1];
                    w1[0] = w1[1];
                    w2[0] = w2[1];
                    cw0[0] = cw0[1];
                    cw1[0] = cw1[1];
                    cw2[0] = cw2[1];
                end

                // update line buffers for next rows (gray and color) when within real column range
                if (!is_pad_col) begin
                    linebuf2[col]   <= (row == 0) ? gray4_in : linebuf1[col];
                    linebuf1[col]   <= gray4_in;
                    clinebuf2[col]  <= (row == 0) ? pixel_in : clinebuf1[col];
                    clinebuf1[col]  <= pixel_in;

                    // Remember last real column values for right-edge replication
                    if (col == (IMAGE_WIDTH-1)) begin
                        last_prev1_row    <= (row == 0) ? gray4_in : linebuf1[col];
                        last_prev2_row    <= (row == 0) ? gray4_in : (row == 1 ? linebuf1[col] : linebuf2[col]);
                        last_cur_gray_row <= gray4_in;
                        last_cprev1_row   <= (row == 0) ? pixel_in : clinebuf1[col];
                        last_cprev2_row   <= (row == 0) ? pixel_in : (row == 1 ? clinebuf1[col] : clinebuf2[col]);
                        last_cur_rgb_row  <= pixel_in;
                    end
                end

                // Compute row-wise max, mid, min
                m1_max = max3(w0[0], w0[1], w0[2]);
                m1_min = min3(w0[0], w0[1], w0[2]);
                m1_mid = mid3(w0[0], w0[1], w0[2]);
                m2_max = max3(w1[0], w1[1], w1[2]);
                m2_min = min3(w1[0], w1[1], w1[2]);
                m2_mid = mid3(w1[0], w1[1], w1[2]);
                m3_max = max3(w2[0], w2[1], w2[2]);
                m3_min = min3(w2[0], w2[1], w2[2]);
                m3_mid = mid3(w2[0], w2[1], w2[2]);

                // combine to get median
                min_of_max = (m1_max < m2_max) ? ((m1_max < m3_max) ? m1_max : m3_max) : ((m2_max < m3_max) ? m2_max : m3_max);
                mid_of_mid = (m2_mid >= m1_mid) ?
                              (m3_mid >= m2_mid ? m2_mid : (m1_mid >= m3_mid ? m1_mid : m3_mid)) :
                              (m3_mid >= m1_mid ? m1_mid : (m2_mid >= m3_mid ? m2_mid : m3_mid));
                max_of_min = (m1_min >= m2_min) ? ((m1_min >= m3_min) ? m1_min : m3_min) : ((m2_min >= m3_min) ? m2_min : m3_min);

                median = (min_of_max >= mid_of_mid) ?
                          (max_of_min >= min_of_max ? min_of_max : (mid_of_mid >= max_of_min ? mid_of_mid : max_of_min)) :
                          (max_of_min >= mid_of_mid ? mid_of_mid : (min_of_max >= max_of_min ? min_of_max : max_of_min));

                // Output when center coordinate is valid (zero-padding semantics)
                if (center_in_bounds) begin
                    if      (w0[0] == median) pixel_out <= cw0[0];
                    else if (w0[1] == median) pixel_out <= cw0[1];
                    else if (w0[2] == median) pixel_out <= cw0[2];
                    else if (w1[0] == median) pixel_out <= cw1[0];
                    else if (w1[1] == median) pixel_out <= cw1[1];
                    else if (w1[2] == median) pixel_out <= cw1[2];
                    else if (w2[0] == median) pixel_out <= cw2[0];
                    else if (w2[1] == median) pixel_out <= cw2[1];
                    else                      pixel_out <= cw2[2]; // default to newest if all else fails

                    addr_out    <= cen_row * IMAGE_WIDTH + cen_col;
                    pixel_valid <= 1'b1;
                end else begin
                    pixel_out   <= 12'd0;
                    addr_out    <= addr_out;
                    pixel_valid <= 1'b0;
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
