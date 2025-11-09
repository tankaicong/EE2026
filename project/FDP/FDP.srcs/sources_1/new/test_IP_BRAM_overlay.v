`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2025 09:30:08 PM
// Design Name: 
// Module Name: test_IP_BRAM_overlay
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_IP_BRAM_overlay(
    input clk, btnU,
    input [1:0] sw,
    output vga_Hsync,
    output vga_Vsync,
    output [11:0] vga_RGB
);

    localparam integer FRAME_WIDTH = 640;
    localparam integer FRAME_HEIGHT = 480;
    // Localparams for pixels
    localparam integer NUM_usr = 25;        // Number of user things to generate
    localparam integer ATTRS = 5;           // Number of attributes per thing
    localparam integer lookup [0 : (NUM_usr * ATTRS) - 1] = {
        // X, Y, x-size, y-size, bram_offset            // Index, desc, start-end row in csv, start addr, num rows (= numpixels), next addr (start + rows)
        128,  348, 12, 12, 0, 	    // 0 red square
        128,  363, 12, 12, 144, 	// 1 green square
        128,  378, 12, 12, 288, 	// 2 blue square
        289,  330, 15, 15, 432, 	// 3 eyedropper
        33,  330, 81, 12, 657, 	    // 4 threshold
        39,  401, 36, 29, 1629, 	// 5 raw feed
        40,  446, 34, 12, 2673, 	// 6 camera
        124,  410, 112, 18, 3081, 	// 7 preprocessing
        80,  448, 25, 8, 5097, 	    // 8 yellow arrow
        253,  448, 25, 8, 5097, 	// 9 yellow arrow 2
        350,  448, 25, 8, 5097, 	// 10 yellow arrow 3
        539,  448, 25, 8, 5097, 	// 11 yellow arrow 4
        106,  451, 146, 2, 5297, 	// 12 yellow rect short
        376,  451, 162, 2, 5297, 	// 13 yellow rect long
        85,  435, 15, 12, 5621, 	// 14 open eye
        258,  435, 15, 12, 5801, 	// 15 eye1
        355,  435, 15, 12, 5801, 	// 16 eye2
        544,  435, 15, 12, 5801, 	// 17 eye3
        262,  410, 105, 18, 5981, 	// 18 thresholding
        282,  446, 64, 12, 7871, 	// 19 bitmap
        410,  410, 95, 18, 8639, 	// 20 morphology
        558,  401, 77, 29, 10349, 	// 21 obj detection
        578,  446, 38, 12, 12582, 	// 22 ufds
        320,  330, 196, 18, 13038, 	// 23 image processing
        362,  296, 281, 27, 16566 	// 24 gaussian edu tab
    };

    wire [16:0] frame_addr;             // logical 0..(310*240-1)
    wire [11:0] bram_final_pixel_out;            // 12-bit RGB444 from BRAM
    reg [11:0] frame_pixel;            // RGB444 to VGA
    wire [9:0] frame_x;  // current x coord in frame (0..639)
    wire [9:0] frame_y;  // current y coord in frame (0..479)
    wire active_area;

    VGA_Controller vga(
        .clk25(clk25),
        .vga_red(vga_RGB[11:8]),
        .vga_green(vga_RGB[7:4]), 
        .vga_blue(vga_RGB[3:0]),
        .vga_hsync(vga_Hsync),
        .vga_vsync(vga_Vsync),
        .frame_addr(frame_addr),
        .frame_x(frame_x),
        .frame_y(frame_y),
        .frame_pixel(frame_pixel),
        .active_area(active_area)
    );

    wire clk_status, clk25, clk24, clk50;
    display_clocks disp_clocks(
        .clk_in1(clk),
        .clk_out1(clk25),
        .clk_out2(clk24),
        .clk_out3(clk50),
        .reset(btnU),
        .locked(clk_status)
    );

    wire [17:0] addrb18 = {1'b0, frame_addr};
    wire [11:0] bram_pixel_out;
    image_mem frame_buffer( 
        .clka(1'b0),
        .wea(1'b0),
        .addra(18'd0),
        .dina(12'd0),          // write RGB444 (raw on we cycles, filtered on alt cycles)
        .clkb(clk25),
        .addrb(addrb18),
        .doutb(bram_pixel_out)   // read RGB444
    );

    wire bram_bmp_pixel_out;
    bitmap_mem bitmap_buffer(
        .clka(1'b0),
        .wea(1'b0),
        .addra(18'd0),
        .dina(12'd0), // write bitmap pixel
        .clkb(clk25),
        .addrb(addrb18),
        .doutb(bram_bmp_pixel_out) // read bitmap pixel
    );

    reg [17:0] overlay_addr_next;
    wire [3:0] overlay_pixel;
    overlay_mem single_buffer(
        .clka(clk25),
        .addra(overlay_addr_next),
        .douta(overlay_pixel)
    );

    reg [17:0] red_addr_next, green_addr_next, blue_addr_next;
    reg in_overlay;
    initial in_overlay = 1'b0;

    //get next pixel coordinates so that on next clk cycle, the correct BRAM pixel is fetched
    //but to align with BRAM 2 cycle read delay, jump by 3 instead of usual 1 step
    wire [9:0] frame_x_next = (frame_x >= FRAME_WIDTH - 3) ? 10'd0 : frame_x + 10'd3;
    wire [9:0] frame_y_next = (frame_x >= FRAME_WIDTH - 3) ? ((frame_y == FRAME_HEIGHT - 1) ? 10'd0 : frame_y + 10'd1) : frame_y;

    //original simple hardcoded version for first 3 overlays
    // wire red_in = (frame_x >= lookup[0] && frame_x < (lookup[0] + lookup[2]) && frame_y >= lookup[1] && frame_y < (lookup[1] + lookup[3]));
    // wire green_in = (frame_x >= lookup[5] && frame_x < (lookup[5] + lookup[7]) && frame_y >= lookup[6] && frame_y < (lookup[6] + lookup[8]));
    // wire blue_in = (frame_x >= lookup[10] && frame_x < (lookup[10] + lookup[12]) && frame_y >= lookup[11] && frame_y < (lookup[11] + lookup[13]));

    // wire red_look_ahead_in = (frame_x_next >= lookup[0] && frame_x_next < (lookup[0] + lookup[2]) && frame_y_next >= lookup[1] && frame_y_next < (lookup[1] + lookup[3]));
    // wire green_look_ahead_in = (frame_x_next >= lookup[5] && frame_y_next < (lookup[6] + lookup[8]) && frame_y_next >= lookup[6] && frame_y_next < (lookup[6] + lookup[8]));
    // wire blue_look_ahead_in = (frame_x_next >= lookup[10] && frame_x_next < (lookup[10] + lookup[12]) && frame_y_next >= lookup[11] && frame_y_next < (lookup[11] + lookup[13]));

    // wire [17:0] red_look_ahead_in_addr = lookup[4] + (frame_y_next - lookup[1]) * lookup[2] + (frame_x_next - lookup[0]);
    // wire [17:0] green_look_ahead_in_addr= lookup[9] + (frame_y_next - lookup[6]) * lookup[7] + (frame_x_next - lookup[5]);
    // wire [17:0] blue_look_ahead_in_addr = lookup[14] + (frame_y_next - lookup[11]) * lookup[12] + (frame_x_next - lookup[10]);

    //generated version for all cv settings overlays
    wire [0 : (NUM_usr - 1)] ptr_in;
    wire [0 : (NUM_usr - 1)] ptr_look_ahead_in;
    genvar i;
    generate
        for (i=0; i<NUM_usr; i=i+1) begin : gen_bram_addr
            assign ptr_in[i] = (frame_x >= lookup[i*ATTRS + 0] && frame_x < (lookup[i*ATTRS + 0] + lookup[i*ATTRS + 2]) && frame_y >= lookup[i*ATTRS + 1] && frame_y < (lookup[i*ATTRS + 1] + lookup[i*ATTRS + 3]));
            assign ptr_look_ahead_in[i] = (frame_x_next >= lookup[i*ATTRS + 0] && frame_x_next < (lookup[i*ATTRS + 0] + lookup[i*ATTRS + 2]) && frame_y_next >= lookup[i*ATTRS + 1] && frame_y_next < (lookup[i*ATTRS + 1] + lookup[i*ATTRS + 3]));
        end
    endgenerate

    integer j;
    always @(posedge clk25) begin
        case (sw)   // just to force bram blocks to be implemented
            2'b00: frame_pixel <= 12'h333;
            2'b01: frame_pixel <= bram_pixel_out;
            2'b10: frame_pixel <= bram_bmp_pixel_out ? 12'hFFF : 12'h000;
            default: frame_pixel <= 12'h333;
        endcase

        if (active_area) begin
            //original simple hardcoded version for first 3 overlays
            // if (red_look_ahead_in) overlay_addr_next <= red_look_ahead_in_addr;
            // else if (green_look_ahead_in) overlay_addr_next <= green_look_ahead_in_addr;
            // else if (blue_look_ahead_in) overlay_addr_next <= blue_look_ahead_in_addr;
            // else overlay_addr_next <= 18'd0;
            // if (red_in | green_in | blue_in) in_overlay = 1'b1;
            // else in_overlay = 1'b0;

            //generated version for all cv settings overlays
            for (j=0; j<NUM_usr; j=j+1) begin
                if (ptr_look_ahead_in[j]) begin
                    overlay_addr_next <= lookup[j*ATTRS + 4] + (frame_y_next - lookup[j*ATTRS + 1]) * lookup[j*ATTRS + 2] + (frame_x_next - lookup[j*ATTRS + 0]);
                end
            end
            in_overlay = |ptr_in;

            if (in_overlay) begin
                case (overlay_pixel)
                    4'h0: frame_pixel <= 12'h000;
                    4'h1: frame_pixel <= 12'hFFF;
                    4'h2: frame_pixel <= 12'h00F;
                    4'h3: frame_pixel <= 12'h0F0;
                    4'h4: frame_pixel <= 12'hF00;
                    4'h5: frame_pixel <= 12'hFF0;
                    4'h6: frame_pixel <= 12'hF0F;
                    4'h7: frame_pixel <= 12'h888;
                    4'h8: frame_pixel <= 12'hB75;
                    4'h9: frame_pixel <= 12'hECA;
                    4'hA: frame_pixel <= 12'hEDB;
                    4'hB: frame_pixel <= 12'hBEE;
                    4'hC: frame_pixel <= 12'hC70;
                    4'hD: frame_pixel <= 12'hFB0;
                    4'hE: frame_pixel <= 12'h0CF;
                    4'hF: frame_pixel <= frame_pixel; // Transparent passthrough
                endcase
            end
        end else begin
            frame_pixel <= 12'h000; // Black outside active area
        end
    end

endmodule
