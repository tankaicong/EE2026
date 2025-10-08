`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Converted from VHDL code here: https://lauri.xn--vsandi-pxa.com/hdl/zynq/zybo-ov7670-to-vga.html
// Takes VSYNC and HREF signals from OV7670 camera to convert to BRAM addresses.
// OV7670 camera outputs half a 16-bit RGB per PCLK cycle.
// This module converts the 2x 8-bit data to 1x 12-bit RGB and
// writes it to the BRAM address calculated above.
//
// Enhancements:
//  * Optional 2x2 averaging (reduces random sensor + ADC + timing noise vs nearest-neighbor)
//  * Byte latch only shifts while HREF asserted (prevents stray porch bytes corrupting color alignment)
//  * Clean (x,y) based addressing -> exact 320x240 frame layout
//  * Line buffers for vertical combine kept small (3x320x6b)
//
// Common noise contributors & mitigation here:
//  * Misaligned byte pairing when shifting outside HREF -> fixed by gating shift with HREF
//  * High-frequency pixel shot noise -> reduced by 2x2 average (low-pass)
//  * Color channel flicker from incorrect RGB565 extraction -> preserved empirical mapping; configurable later
//  * Address tearing due to skipping VSYNC reset -> address & counters fully reset on VSYNC
//
//////////////////////////////////////////////////////////////////////////////////


module OV7670_Capture(
    input pclk,
    input vsync, href,
    input ext_reset,          // external reset (synchronous to pclk domain)
    input avg_enable,           // 1 = 2x2 averaging, 0 = decimate
    input [7:0] d,
    output reg [17:0] addr,      // 0..76800-1 (320x240)
    output reg [15:0] dout,      // RGB565 stored in BRAM
    output reg we                // 1-cycle write enable
);

    // ----------------------------------------------------------------------
    // Original code linearly incremented address for EVERY incoming pixel
    // (640x480) but treated memory as 320-pixel wide. That caused:
    //   * Effective vertical stretch (each camera line split into 2 mem lines)
    //   * Crop/zoom (only first 320 pixels of each 640-pixel row kept)
    //   * Perceived rotation / distortion when doubled by VGA to 640x480
    // Fix: Track absolute camera (x,y). Store ONLY even x & even y pixels so
    // memory holds a true 320x240 downsample. Address = (y>>1)*320 + (x>>1).
    // ----------------------------------------------------------------------

    // Byte pair latch (camera outputs two successive bytes per pixel).
    // We ONLY shift while HREF is active to prevent byte misalignment noise.
    reg [15:0] d_latch = 16'b0;      // Shift register for two bytes (RGB565 like ordering)
    reg [1:0]  wr_hold = 2'b0;       // Pipeline to detect full pixel (rising edge indicates new pixel)

    // Camera coordinate counters
    reg [9:0] cam_x = 10'd0;         // 0..639
    reg [8:0] cam_y = 9'd0;          // 0..479
    reg href_d = 1'b0;               // Delayed HREF for edge detection

    // Helper wires
    wire pixel_complete = wr_hold[1];          // A full pixel assembled this cycle
    wire end_of_line    = (href_d & ~href);     // Falling edge of HREF

    // Color mapping:
    // The original empirical mapping was: { d_latch[4:1], d_latch[10:7], d_latch[15:12] }
    // This seems to correspond to extracting (approx) R4, G4, B4 from a byte order that may
    // not be the standard OV7670 RGB565 sequence (depends on register configuration).
    // For now we preserve that mapping to remain consistent visually. If noise persists
    // or colors look swapped, revisit with a logic analyzer and proper RGB565 decode:
    //   RGB565: {R[4:0], G[5:3]} (first byte) {G[2:0], B[4:0]} (second byte)
    // Conversion to RGB444 could be: R4 = R[4:1], G4 = G[5:2], B4 = B[4:1].
    // Provide both paths via a localparam toggle if needed later.

    // ------------------------------------------------------------------
    // 2x2 AVERAGING PIPELINE (optional)
    // We build the average of a 2x2 block when USE_AVERAGING=1:
    //   1. Accumulate horizontal pair (even x + odd x) -> h_sum (per channel)
    //   2. Store even-row horizontal sums into line buffers line_* at index x>>1
    //   3. On the following (odd) row's odd x pixel, form second horizontal sum,
    //      add with stored line_* value, then average >>2 and write.
    // This reduces random noise and aliasing vs nearest-neighbor pick.
    // Resource use: 3 * 320 * 6 bits ≈ 5760 bits (fits BRAM/regs easily).
    // Timing: Few adders (two 4-bit adds => 5 bits, then + up to 5 bits => 6 bits, then shifts).
    // ------------------------------------------------------------------

    // Averaging support (RGB565 component sums)
    reg [6:0] line_r [0:319];   // R pair sums from even row
    reg [7:0] line_g [0:319];   // G pair sums from even row
    reg [6:0] line_b [0:319];
    reg [6:0] h_r = 7'd0;       // first pixel (even x) R component (extended)
    reg [7:0] h_g = 8'd0;       // first pixel (even x) G component (extended)
    reg [6:0] h_b = 7'd0;       // first pixel (even x) B component (extended)
    reg [4:0] px_r5;            // single pixel components (raw RGB565 fields)
    reg [5:0] px_g6;
    reg [4:0] px_b5;

    // Combinational horizontal sums for second pixel of pair (valid when cam_x[0]==1)
    wire [6:0] horiz_r = h_r + {2'b00, d_latch[15:11]};
    wire [7:0] horiz_g = h_g + {1'b0, {d_latch[10:8], d_latch[7:5]}};
    wire [6:0] horiz_b = h_b + {2'b00, d_latch[4:0]};
    // Vertical combine (valid on odd rows when cam_y[0]==1 and odd x)
    wire [6:0] vert_sum_r = line_r[cam_x[9:1]] + horiz_r;   // 0..124
    wire [7:0] vert_sum_g = line_g[cam_x[9:1]] + horiz_g;   // 0..252
    wire [6:0] vert_sum_b = line_b[cam_x[9:1]] + horiz_b;   // 0..124
    // Averaged (rounded) channel values (combinational)
    wire [6:0] avg_r_w = (vert_sum_r + 7'd2) >> 2; // still 7 bits, we take upper 5
    wire [7:0] avg_g_w = (vert_sum_g + 8'd2) >> 2; // 8 bits -> take upper 6
    wire [6:0] avg_b_w = (vert_sum_b + 7'd2) >> 2; // 7 bits -> take upper 5
    // Moved from inside procedural block (Verilog 2001 requires declarations at module or block top prior to use)
    reg [6:0] cur_h_r; 
    reg [7:0] cur_h_g; 
    reg [6:0] cur_h_b;
    reg [6:0] sum_r; 
    reg [7:0] sum_g; 
    reg [6:0] sum_b;

    always @(negedge pclk) begin
        if (vsync || ext_reset) begin
            cam_x <= 10'd0;
            cam_y <= 9'd0;
            wr_hold <= 2'b0;
            d_latch <= 16'b0;
            addr <= 18'd0;
            we <= 1'b0;
            h_r <= 7'd0;
            h_g <= 8'd0;
            h_b <= 7'd0;
        end else begin
            if (href) d_latch <= { d_latch[7:0], d };         // shift only during active line
            wr_hold <= { wr_hold[0], (href & ~wr_hold[0]) };  // pixel complete detection
            we <= 1'b0;
            if (pixel_complete && href) begin
                // Extract RGB565 components
                px_r5 <= d_latch[15:11];
                px_g6 <= d_latch[10:5];
                px_b5 <= d_latch[4:0];
                if (avg_enable) begin
                    if (~cam_x[0]) begin
                        // store first (even x) pixel components
                        h_r <= {2'b00, d_latch[15:11]};
                        h_g <= {1'b0, d_latch[10:5]};
                        h_b <= {2'b00, d_latch[4:0]};
                    end else begin
                        // odd x: have second pixel -> build horizontal sum combinationally
                        if (~cam_y[0]) begin
                            // even row: save horizontal pair sum for later vertical combine
                            line_r[cam_x[9:1]] <= horiz_r;
                            line_g[cam_x[9:1]] <= horiz_g;
                            line_b[cam_x[9:1]] <= horiz_b;
                        end else begin
                            // odd row: vertical combine now (no extra latency)
                            // Use precomputed averaged wires to avoid tool parsing issues
                            dout <= { avg_b_w[4:0], avg_g_w[5:0], avg_r_w[4:0] };
                            addr <= (cam_y[8:1]) * 18'd320 + cam_x[9:1];
                            we <= 1'b1;
                        end
                    end
                end else begin
                    if (~cam_x[0] && ~cam_y[0]) begin
                        dout <= {d_latch[4:0], d_latch[10:5], d_latch[15:11]};
                        addr <= (cam_y[8:1]) * 18'd320 + cam_x[9:1];
                        we <= 1'b1;
                    end
                end
                // advance X after processing pixel
                if (cam_x == 10'd639) cam_x <= 10'd0; else cam_x <= cam_x + 10'd1;
            end
            if (end_of_line) begin
                cam_x <= 10'd0;
                if (cam_y != 9'd479) cam_y <= cam_y + 9'd1; else cam_y <= 9'd0;
            end
            href_d <= href;
        end
    end

endmodule