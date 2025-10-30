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
    parameter IMAGE_WIDTH  = 320,
    parameter IMAGE_HEIGHT = 240)
(
    input clk,
    input reset,
    input frame_start,                       // assert during VSYNC
    input [PIXEL_DEPTH-1:0] pixel_in,        // RGB444
    input we,                              // 1 = pixel valid this cycle
    output reg [11:0] pixel_out,             // RGB444 of the pixel whose grayscale is the window median
    output reg [16:0] addr_out,               // 0..(IMAGE_WIDTH*IMAGE_HEIGHT-1)
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

    // row/column counters for current incoming pixel (row, col)
    reg [17:0] in_index;           // 0..(W*H-1)
    reg [9:0]  col;                // supports >= 320
    reg [8:0]  row;                // supports >= 240

    wire window_valid = (row >= 9'd2) && (row < IMAGE_HEIGHT) &&
                          (col >= 10'd2) && (col < IMAGE_WIDTH);


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

    // reset/initialization
    integer k;
    reg [GRAY_DEPTH-1:0] prev1; // row-1, same col
    reg [GRAY_DEPTH-1:0] prev2; // row-2, same col
    reg [PIXEL_DEPTH-1:0] cprev1;
    reg [PIXEL_DEPTH-1:0] cprev2;
    always @(posedge clk) begin
        if (reset || frame_start) begin
            // Clear counters and small state. Line buffers need not be cleared because we gate outputs with window_valid.
            col      <= 10'd0;
            row      <= 9'd0;
            in_index <= 18'd0;
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
        end else begin
            if (we) begin
                // read previous rows at current column
                prev1 = linebuf1[col];
                prev2 = linebuf2[col];
                cprev1 = clinebuf1[col];
                cprev2 = clinebuf2[col];

                // update sliding window (shift left, insert newest at [2][2])
                w0[0] = w0[1]; w0[1] = w0[2]; w0[2] = prev2;
                w1[0] = w1[1]; w1[1] = w1[2]; w1[2] = prev1;
                w2[0] = w2[1]; w2[1] = w2[2]; w2[2] = gray4_in;
                // shift color window by same amount
                cw0[0] = cw0[1]; cw0[1] = cw0[2]; cw0[2] = cprev2; // top row follows row-2 sources
                cw1[0] = cw1[1]; cw1[1] = cw1[2]; cw1[2] = cprev1; // middle follows row-1 sources
                cw2[0] = cw2[1]; cw2[1] = cw2[2]; cw2[2] = pixel_in; // bottom inserts current RGB

                // update line buffers for next rows (gray and color)
                linebuf2[col]   <= prev1;
                linebuf1[col]   <= gray4_in;
                clinebuf2[col]  <= cprev1;
                clinebuf1[col]  <= pixel_in;

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

                // only compute output when reading is valid
                if (window_valid) begin
                    if      (w0[0] == median) pixel_out = cw0[0];
                    else if (w0[1] == median) pixel_out = cw0[1];
                    else if (w0[2] == median) pixel_out = cw0[2];
                    else if (w1[0] == median) pixel_out = cw1[0];
                    else if (w1[1] == median) pixel_out = cw1[1];
                    else if (w1[2] == median) pixel_out = cw1[2];
                    else if (w2[0] == median) pixel_out = cw2[0];
                    else if (w2[1] == median) pixel_out = cw2[1];
                    else                      pixel_out = cw2[2]; // default to newest if all else fails

                    addr_out  <= (row - 1) * IMAGE_WIDTH + (col - 1);
                    pixel_valid <= 1'b1;
                end else begin
                    pixel_out <= 12'd0;
                    addr_out  <= addr_out;
                    pixel_valid <= 1'b0;
                end

                // advance position counters for next input
                if (col == (IMAGE_WIDTH-1)) begin
                    col <= 10'd0;
                    if (row == (IMAGE_HEIGHT-1)) begin
                        row <= 9'd0;
                    end else begin
                        row <= row + 9'd1;
                    end
                end else begin
                    col <= col + 10'd1;
                end
                in_index <= in_index + 18'd1;
            end
        end
    end

endmodule
