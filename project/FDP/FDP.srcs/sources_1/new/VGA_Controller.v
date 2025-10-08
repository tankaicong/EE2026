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
    output [17:0] frame_addr,    // BRAM address for 320x240 frame (doubled to 640x480)
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

    assign active_area = ~blank;

    // ------------------------------------------------------------------
    // Frame buffer layout (written by capture module):
    //   Stored resolution: 320 x 240 (row-major, addr = y*320 + x)
    // VGA outputs 640 x 480 by doubling pixels in both axes.
    // We derive the 320x240 source coordinate by shifting counters.
    // ------------------------------------------------------------------
    localparam SRC_WIDTH  = 320;
    localparam SRC_HEIGHT = 240;
    wire [8:0] src_y = vCounter[9:1]; // vCounter >> 1 (0..239)
    wire [8:0] src_x = hCounter[9:1]; // hCounter >> 1 (0..319)
    assign frame_addr = src_y * SRC_WIDTH + src_x; 

    // Main synchronous process on clk25 (rising edge)
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

        // Pixel outputs (when not blank) - READ FROM BRAM
        if (blank == 1'b0) begin
            // Read from BRAM (restored original functionality)
            vga_red   <= frame_pixel[11:8];
            vga_green <= frame_pixel[7:4];
            vga_blue  <= frame_pixel[3:0];
            
            // Direct test pattern (commented out - was working)
            // if (hCounter < 320 && vCounter < 240) begin
            //     vga_red <= 4'hF; vga_green <= 4'h0; vga_blue <= 4'h0;  // Red
            // end else if (hCounter >= 320 && vCounter < 240) begin
            //     vga_red <= 4'h0; vga_green <= 4'hF; vga_blue <= 4'h0;  // Green
            // end else if (hCounter < 320 && vCounter >= 240) begin
            //     vga_red <= 4'h0; vga_green <= 4'h0; vga_blue <= 4'hF;  // Blue
            // end else begin
            //     vga_red <= 4'hF; vga_green <= 4'hF; vga_blue <= 4'hF;  // White
            // end
        end else begin
            vga_red   <= 4'b0;
            vga_green <= 4'b0;
            vga_blue  <= 4'b0;
        end

        // Frame addressing & blanking logic
        if (vCounter >= vRez) begin
            blank   <= 1'b1;
        end else begin
            if (hCounter < hRez) begin
                blank   <= 1'b0;
            end else begin
                blank <= 1'b1;
            end
        end

        // Horizontal sync pulse (VHDL: if hCounter > hStartSync and hCounter <= hEndSync)
        if ((hCounter > hStartSync) && (hCounter <= hEndSync)) begin
            vga_hsync <= hsync_active;
        end else begin
            vga_hsync <= ~hsync_active;
        end

        // Vertical sync pulse (VHDL: if vCounter >= vStartSync and vCounter < vEndSync)
        if ((vCounter >= vStartSync) && (vCounter < vEndSync)) begin
            vga_vsync <= vsync_active;
        end else begin
            vga_vsync <= ~vsync_active;
        end
    end

endmodule