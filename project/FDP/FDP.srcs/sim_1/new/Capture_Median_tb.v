`timescale 1ns/1ps

module Capture_Median_tb;

    // Camera model
    wire        pclk;
    wire        vsync;
    wire        href;
    wire [7:0]  d;

    // Capture outputs
    wire [16:0] addr;
    wire [11:0] dout;
    wire        we;

    // Median outputs
    wire [11:0] median_rgb;
    wire [17:0] median_addr;
    wire        median_valid;

    localparam  FRAME_WIDTH = 50;
    localparam  FRAME_HEIGHT = 6;

    // Instantiate camera model (small frame for quick sim)
    OV7670_Model #(
        .PCLK_PERIOD_NS(4),
        .WIDTH_PX(FRAME_WIDTH),
        .HEIGHT_LINES(FRAME_HEIGHT),
        .HBLANK_BYTES(4),
        .VBLANK_LINES(2)
    ) cam (
        .pclk(pclk),
        .vsync(vsync),
        .href(href),
        .d(d)
    );

    // Capture stage under test
    OV7670_Capture u_cap (
        .pclk(pclk),
        .vsync(vsync),
        .href(href),
        .ext_reset(1'b0),
        .d(d),
        .addr(addr),
        .dout(dout),
        .we(we)
    );

    // Median filter under test
    Median_Filter #(
        .KERNEL_SIZE(3),
        .PIXEL_DEPTH(12),
        .IMAGE_WIDTH((FRAME_WIDTH-20)/2), // filter expects 310-wide active capture
        .IMAGE_HEIGHT(FRAME_HEIGHT/2)
    ) u_med (
        .clk(pclk),
        .reset(1'b0),
        .frame_start(vsync),
        .pixel_in(dout),
        .we(we),
        .pixel_out(median_rgb),
        .addr_out(median_addr),
        .pixel_valid(median_valid)
    );

    // Simple monitor
    always @(posedge pclk) begin
        if (median_valid) begin
            $display("t=%0t addr=%0d rgb=%03h", $time, median_addr, median_rgb);
        end
    end

endmodule
