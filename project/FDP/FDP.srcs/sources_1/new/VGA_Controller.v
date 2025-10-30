`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Converted from VHDL code here: https://lauri.xn--vsandi-pxa.com/hdl/zynq/zybo-ov7670-to-vga.html
// Generate analog 640x480 VGA, from double scanned BRAM
//////////////////////////////////////////////////////////////////////////////////

module VGA_Controller(
    input clk25,
    output reg [3:0] vga_red,
    output reg [3:0] vga_green,
    output reg [3:0] vga_blue,
    output reg vga_hsync,
    output reg vga_vsync,
    output [16:0] frame_addr,    // BRAM address for 320x240 frame (doubled to 640x480)
    output [9:0] frame_x,  // current x coord in frame (0..639)
    output [9:0] frame_y,  // current y coord in frame (0..479)
    input [11:0] frame_pixel,
    output active_area
);

    // Timing constants (same values as VHDL)
    localparam integer hRez = 640;
    localparam integer hStartSync = 640 + 16;
    localparam integer hEndSync = 640 + 16 + 96;
    localparam integer hMaxCount = 640 + 16 + 96 + 48;

    localparam integer vRez = 480;
    localparam integer vStartSync = 480 + 11;
    localparam integer vEndSync = 480 + 11 + 2;
    localparam integer vMaxCount = 480 + 11 + 2 + 31;

    localparam hsync_active = 1'b0;
    localparam vsync_active = 1'b0;

    // counters and internal signals
    reg [9:0] hCounter = 10'd0;
    reg [9:0] vCounter = 10'd0;
    reg blank = 1'b1;
    // Align incoming BRAM data (1-cycle latency) to current address timing
    reg [11:0] frame_pixel_q;

    assign active_area = ~blank;

    // Calculate frame address from doubled coordinates
    localparam SRC_WIDTH  = 320;
    localparam SRC_HEIGHT = 240;
    wire [8:0] src_y = vCounter[9:1]; // vCounter (0-479)  >> 1 (0..239)
    wire [8:0] src_x = hCounter[9:1]; // hCounter (0..639) >> 1 (0..319)
    // Clamp to avoid unsigned underflow when cropping left 14 pixels
    assign frame_addr = src_y * 320 + src_x;     // crop to 320 right-side pixels
    assign frame_x = hCounter;
    assign frame_y = vCounter;

    always @(posedge clk25) begin
        // Count the horizontal and vertical positions
        if (hCounter == hMaxCount - 1) begin
            hCounter <= 10'd0;
            if (vCounter == vMaxCount - 1) begin
                vCounter <= 10'd0;
            end else begin
                vCounter <= vCounter + 10'd1;
            end
        end else begin
            hCounter <= hCounter + 10'd1;
        end

        // Register incoming pixel to align with current address timing
        frame_pixel_q <= frame_pixel;

        // Pixel outputs (when not blank) - READ FROM BRAM (aligned)
        // Start outputting a couple cycles earlier so the first shown pixel maps
        // to src_x_adj == 0 (i.e., the leftmost cropped column).
        if (hCounter >= 30) begin
            if (blank == 1'b0) begin
                vga_red   <= frame_pixel_q[11:8];
                vga_green <= frame_pixel_q[7:4];
                vga_blue  <= frame_pixel_q[3:0];
            end else begin
                vga_red   <= 4'b0;
                vga_green <= 4'b0;
                vga_blue  <= 4'b0;
            end
        end else begin
            vga_red   <= 4'b0;
            vga_green <= 4'b0;
            vga_blue  <= 4'b0;
        end

        // Frame addressing & blanking logic
        if (vCounter >= vRez) begin
            blank <= 1'b1;
        end else begin
            if (hCounter < hRez) begin
                blank <= 1'b0;
            end else begin
                blank <= 1'b1;
            end
        end

        // Horizontal sync pulse
        if ((hCounter > hStartSync) && (hCounter <= hEndSync)) begin
            vga_hsync <= hsync_active;
        end else begin
            vga_hsync <= ~hsync_active;
        end

        // Vertical sync pulse
        if ((vCounter >= vStartSync) && (vCounter < vEndSync)) begin
            vga_vsync <= vsync_active;
        end else begin
            vga_vsync <= ~vsync_active;
        end
    end

endmodule