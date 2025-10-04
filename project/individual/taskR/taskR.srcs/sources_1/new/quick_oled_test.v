`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 04:02:28 AM
// Design Name: 
// Module Name: quick_oled_test
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


module quick_oled_test(
    input clk,
    output [7:0] JB
);

reg [2:0] counter_6p25mhz = 0;
reg clk_6p25MHz = 0;

reg [15:0] oled_data = 16'h0000;
wire oled_frame_begin, oled_sending_pixels, oled_sample_pixel;
wire [12:0] oled_pixel_index;

always @ (posedge clk) begin
    counter_6p25mhz = counter_6p25mhz + 1;
    if (counter_6p25mhz == 0) begin //3 bit counter overflows back to 0 every 8 cycles
        clk_6p25MHz = ~clk_6p25MHz; //invert signal every 8 cycles = 16 cycles per period = 6.25 mhz
    end
end

Oled_Display disp(
    clk_6p25MHz,    //clk
    btnU,   //reset
    oled_frame_begin, //frame_begin
    oled_sending_pixels,  //sending_pixels
    oled_sample_pixel,    //sample_pixel
    oled_pixel_index[12:0],    //pixel_index
    oled_data,  //pixel_data
    JB[0],  //cs
    JB[1],  //sdin
    JB[3],  //sclk
    JB[4],  //d_cn
    JB[5],  //resn
    JB[6],  //vccen
    JB[7]   //pmoden
);
endmodule
