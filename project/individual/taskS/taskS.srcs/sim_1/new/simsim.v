`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2025 21:25:32
// Design Name: 
// Module Name: simsim
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


module simsim(
    );
  // 100 MHz clock
  reg clk = 0; always #5 clk = ~clk;

  // Reset
  reg reset = 1;
  initial begin
    repeat (10) @(posedge clk);
    reset = 0;
  end

  // Buttons (not pressed)
  reg btnU=0, btnD=0, btnL=0, btnR=0;

  // OLED handshake
  wire frame_begin, sending_pixels, sample_pixel;
  wire [12:0] pixel_index;
  wire [15:0] pixel_data;
  wire cs, sdin, sclk, d_cn, resn, vccen, pmoden;

  Oled_Display oled (
    .clk(clk),
    .reset(reset),
    .frame_begin(frame_begin),
    .sending_pixels(sending_pixels),
    .sample_pixel(sample_pixel),
    .pixel_index(pixel_index),
    .pixel_data(pixel_data),
    .cs(cs), .sdin(sdin), .sclk(sclk), .d_cn(d_cn),
    .resn(resn), .vccen(vccen), .pmoden(pmoden)
  );

  task_S dut (
    .clk(clk),
    .reset(reset),
    .frame_begin(frame_begin),
    .sample_pixel(sample_pixel),
    .pixel_index(pixel_index),
    .btnU(btnU), .btnD(btnD), .btnL(btnL), .btnR(btnR),
    .pixel_data(pixel_data)
  );

  // Capture 96x64 pixels
  localparam integer PIXELS = 96*64;
  reg [15:0] mem [0:PIXELS-1];
  integer sample_count = 0;

  always @(posedge clk) begin
    if (reset) begin
      sample_count <= 0;
    end else if (sample_pixel) begin
      mem[pixel_index] <= pixel_data;
      sample_count <= sample_count + 1;
    end
  end

endmodule
