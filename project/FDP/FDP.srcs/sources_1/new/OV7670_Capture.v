`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Converted from VHDL code here: https://lauri.xn--vsandi-pxa.com/hdl/zynq/zybo-ov7670-to-vga.html
// Takes VSYNC and HREF signals from OV7670 camera to convert to BRAM addresses.
// OV7670 camera outputs half a 16-bit RGB per PCLK cycle.
// This module converts the 2x 8-bit data to 1x 12-bit RGB and
// writes it to the BRAM address calculated above.
//////////////////////////////////////////////////////////////////////////////////


module OV7670_Capture(
    input pclk,
    input vsync, href,
    input ext_reset,            // external reset (synchronous to pclk domain)
    input [7:0] d,
    output reg [16:0] addr,      // 0..76800-1 (320x240)
    output reg [11:0] dout,      // Stored as 12-bit RGB444 in BRAM
    output reg we               // 1-cycle write enable
);

    // Byte pair latch (camera outputs two successive bytes per pixel).
    // We ONLY shift while HREF is active to prevent byte misalignment noise.
    reg [15:0] d_latch = 16'b0;      // Shift register for two bytes (RGB565 like ordering)
    reg [1:0]  wr_hold = 2'b0;       // Pipeline to detect full pixel (rising edge indicates new pixel)

    // Camera coordinate counters
    reg [9:0] cam_x = 10'd0;         // 0..639
    reg [8:0] cam_y = 9'd0;          // 0..479
    reg href_d = 1'b0;               // Delayed HREF for edge detection

    // Helper wires
    wire pixel_complete = wr_hold[1];       // A full pixel assembled this cycle
    wire end_of_line = (href_d & ~href);    // Falling edge of HREF

    always @(posedge pclk) begin
        if (vsync || ext_reset) begin
            cam_x <= 10'd0;
            cam_y <= 9'd0;
            wr_hold <= 2'b0;
            d_latch <= 16'b0;
            addr <= 18'd0;
            we <= 1'b0;
        end else begin
            if (href) d_latch <= { d_latch[7:0], d };         // shift only during active line
            wr_hold <= { wr_hold[0], (href & ~wr_hold[0]) };  // pixel complete detection
            we <= 1'b0;
            if (pixel_complete && href) begin
                if (~cam_x[0] && ~cam_y[0]) begin    //i only want [0:319] = 320 right-side pixels
                    // RGB444 input
                    dout <= { d_latch[3:0], d_latch[7:4], d_latch[11:8] };
                    addr <= (cam_y[8:1]) * 18'd320 + cam_x[9:1];
                    we <= 1'b1;
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