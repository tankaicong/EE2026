`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 5x5 Median filter for image processing (streaming)
// - Same external interface/behavior as Median_Filter (3x3), but kernel = 5x5
// - Streaming design with 4 line buffers and 5x5 sliding window
// - Grayscale median-of-25 is computed via a fully combinational odd-even
//   transposition network (carries color along for arg-median)
// - Edges: pixel_valid=0 and pixel_out=0; addr_out holds; upstream can use RAW
//////////////////////////////////////////////////////////////////////////////////

module Median_Filter_5x5
#(  parameter PIXEL_DEPTH  = 12,      // RGB444
    parameter GRAY_DEPTH   = 4,       // Grayscale
    parameter IMAGE_WIDTH  = 320,
    parameter IMAGE_HEIGHT = 240)
(
    input clk,
    input reset,
    input frame_start,                       // assert during VSYNC
    input [PIXEL_DEPTH-1:0] pixel_in,        // RGB444
    input we,                                // 1 = pixel valid this cycle
    output reg [11:0] pixel_out,             // RGB444 of the pixel whose grayscale is the window median
    output reg [17:0] addr_out,              // 0..(IMAGE_WIDTH*IMAGE_HEIGHT-1)
    output reg pixel_valid
);

    // Convert to 4-bit grayscale using 0.25R + 0.5G + 0.25B
    wire [3:0] r4 = pixel_in[11:8];
    wire [3:0] g4 = pixel_in[7:4];
    wire [3:0] b4 = pixel_in[3:0];
    wire [GRAY_DEPTH+2:0] sum_w = {2'b00, r4} + {1'b0, g4, 1'b0} + {2'b00, b4}; // r + 2*g + b
    wire [GRAY_DEPTH-1:0] gray4_in = sum_w >> 2;

    // K parameters
    localparam integer KS = 5;
    localparam integer K2 = (KS-1)/2; // 2
    localparam integer N  = KS*KS;    // 25

    // Line buffers for previous 4 rows (gray and color)
    reg [GRAY_DEPTH-1:0] linebuf  [1:KS-1][0:IMAGE_WIDTH-1];
    reg [PIXEL_DEPTH-1:0] clinebuf[1:KS-1][0:IMAGE_WIDTH-1];

    // Sliding window (5 rows x 5 cols), oldest at col 0
    reg [GRAY_DEPTH-1:0]  w  [0:KS-1][0:KS-1];
    reg [PIXEL_DEPTH-1:0] cw [0:KS-1][0:KS-1];

    // Position counters
    reg [9:0]  col; // >= 320
    reg [8:0]  row; // >= 240
    reg [17:0] in_index;

    // Window valid when we have at least K-1 rows and cols behind us
    wire window_valid = (row >= KS-1) && (row < IMAGE_HEIGHT) &&
                        (col >= KS-1) && (col < IMAGE_WIDTH);

    integer k, i, r, c, pass;
    reg [GRAY_DEPTH-1:0] p1, p2, p3, p4;  // previous rows gray at this column
    reg [PIXEL_DEPTH-1:0] cp1, cp2, cp3, cp4; // previous rows color at this column

    // Temporary arrays for odd-even sort (carry color with gray)
    reg [GRAY_DEPTH-1:0] ag [0:N-1];
    reg [PIXEL_DEPTH-1:0] ac [0:N-1];
    reg [GRAY_DEPTH-1:0] tg;
    reg [PIXEL_DEPTH-1:0] tc;

    always @(posedge clk) begin
        if (reset || frame_start) begin
            // reset state
            col      <= 10'd0;
            row      <= 9'd0;
            in_index <= 18'd0;
            pixel_out <= 12'd0;
            addr_out  <= 18'd0;
            pixel_valid <= 1'b0;

            // Clear window
            for (r = 0; r < KS; r = r + 1) begin
                for (c = 0; c < KS; c = c + 1) begin
                    w[r][c]  <= {GRAY_DEPTH{1'b0}};
                    cw[r][c] <= {PIXEL_DEPTH{1'b0}};
                end
            end
            // Initialize line buffers
            for (k = 0; k < IMAGE_WIDTH; k = k + 1) begin
                for (i = 1; i < KS; i = i + 1) begin
                    linebuf[i][k]  <= {GRAY_DEPTH{1'b0}};
                    clinebuf[i][k] <= {PIXEL_DEPTH{1'b0}};
                end
            end
        end else begin
            if (we) begin
                // Read previous rows at this column
                p1  = linebuf[1][col];
                p2  = linebuf[2][col];
                p3  = linebuf[3][col];
                p4  = linebuf[4][col];
                cp1 = clinebuf[1][col];
                cp2 = clinebuf[2][col];
                cp3 = clinebuf[3][col];
                cp4 = clinebuf[4][col];

                // Shift window left for all rows
                for (r = 0; r < KS; r = r + 1) begin
                    for (c = 0; c < KS-1; c = c + 1) begin
                        w[r][c]  = w[r][c+1];
                        cw[r][c] = cw[r][c+1];
                    end
                end
                // Insert newest rightmost samples per row (top=oldest row)
                w[0][KS-1]  = p4;  cw[0][KS-1] = cp4; // row-4
                w[1][KS-1]  = p3;  cw[1][KS-1] = cp3; // row-3
                w[2][KS-1]  = p2;  cw[2][KS-1] = cp2; // row-2
                w[3][KS-1]  = p1;  cw[3][KS-1] = cp1; // row-1
                w[4][KS-1]  = gray4_in;  cw[4][KS-1] = pixel_in; // current row

                // Update line buffers (vertical shift at this column)
                linebuf[4][col]  <= linebuf[3][col];
                linebuf[3][col]  <= linebuf[2][col];
                linebuf[2][col]  <= linebuf[1][col];
                linebuf[1][col]  <= gray4_in;

                clinebuf[4][col] <= clinebuf[3][col];
                clinebuf[3][col] <= clinebuf[2][col];
                clinebuf[2][col] <= clinebuf[1][col];
                clinebuf[1][col] <= pixel_in;

                // Build flattened window arrays ag/ac (row-major)
                for (r = 0; r < KS; r = r + 1) begin
                    for (c = 0; c < KS; c = c + 1) begin
                        ag[r*KS + c] = w[r][c];
                        ac[r*KS + c] = cw[r][c];
                    end
                end

                // Odd-even transposition sort to rank all 25 values
                // Carries color along
                for (pass = 0; pass < N; pass = pass + 1) begin
                    // start index alternates between 0 and 1
                    for (i = (pass[0]); i < N-1; i = i + 2) begin
                        if (ag[i] > ag[i+1]) begin
                            tg      = ag[i];
                            ag[i]   = ag[i+1];
                            ag[i+1] = tg;
                            tc      = ac[i];
                            ac[i]   = ac[i+1];
                            ac[i+1] = tc;
                        end
                    end
                end

                // Output when full 5x5 window is valid
                if (window_valid) begin
                    pixel_out  <= ac[N/2]; // index 12
                    addr_out   <= (row - K2) * IMAGE_WIDTH + (col - K2);
                    pixel_valid<= 1'b1;
                end else begin
                    pixel_out  <= {PIXEL_DEPTH{1'b0}};
                    addr_out   <= addr_out; // hold
                    pixel_valid<= 1'b0;
                end

                // Advance coordinates
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
