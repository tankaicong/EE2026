`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/06/2025 07:48:10 PM
// Design Name: 
// Module Name: Top_Sim
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


module Top_Sim(

    );

reg clk, btnU;
wire video_on;    // ON while pixel counts for x and y and within display area
wire [9:0] x;    // pixel x coordinate
wire [9:0] y;    // pixel y coordinate
wire hsync;      // horizontal sync output
wire vsync;      // vertical sync output
wire p_tick;     // pixel tick

// Instantiate the VGA controller
VGA_Controller VGA_unit (clk, btnU, hsync, vsync, video_on, p_tick, x, y);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100MHz clock

    for (integer i = 0; i < 10; i = i + 1) begin
        rgb_reg <= rgb_reg+1; // RGB value during active video
    end
end

endmodule