`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
  input clk,
  input reset,
  input [15:0] sw,
  input btnU, btnD, btnL, btnR,
  output [7:0] JB
  );

  // OLED DISPLAY
  wire frame_begin, sending_pixels, sample_pixel;
  wire [12:0] pixel_index; 
  wire [15:0] pixel_data;
  wire cs, sdin, sclk, d_cn, resn, vccen, pmoden;
  wire clk6p25m;
  clk6p25m clk6p25m_inst(clk, reset, clk6p25m);

  Oled_Display oled_display_inst(
    .clk(clk6p25m), 
    .reset(reset), 
    .frame_begin(frame_begin), 
    .sending_pixels(sending_pixels), 
    .sample_pixel(sample_pixel), 
    .pixel_index(pixel_index), 
    .pixel_data(pixel_data), 
    .cs(cs), 
    .sdin(sdin), 
    .sclk(sclk), 
    .d_cn(d_cn), 
    .resn(resn), 
    .vccen(vccen), 
    .pmoden(pmoden)
  );

  assign JB[0] = cs;    
  assign JB[1] = sdin;   
  assign JB[3] = sclk;   
  assign JB[4] = d_cn;   
  assign JB[5] = resn;   
  assign JB[6] = vccen;  
  assign JB[7] = pmoden;   

  // Task S: movable red circle with square walls
  task_S task_s_inst (
    .clk(clk),
    .reset(reset),
    .frame_begin(frame_begin),
    .sample_pixel(sample_pixel),
    .pixel_index(pixel_index),  
    .btnU(btnU),
    .btnD(btnD),
    .btnL(btnL),
    .btnR(btnR),
    .pixel_data(pixel_data)
  );   

endmodule

module clk6p25m(
  input clk,
  input reset,
  output reg slow_clk
);  
    reg [2:0] COUNT = 3'd0;
    
    always @ (posedge clk) begin
        if (reset) begin
          COUNT <= 3'd0;
          slow_clk <= 1'b0;
        end else begin
          if (COUNT == 3'd7) begin
            COUNT <= 3'd0;
            slow_clk <= ~slow_clk;
          end else begin
            COUNT <= COUNT + 3'd1;
          end
        end
    end
endmodule