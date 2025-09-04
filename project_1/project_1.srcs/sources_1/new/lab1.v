`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.08.2025 09:18:30
// Design Name: 
// Module Name: lab1
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


module lab1(
    input [9:0] sw,
    output [9:0] led,
    output [6:0] seg,
    output dp,
    output [3:0] an 
    );
    
    //number: 09057A
    assign led = sw;
    assign seg = 7'b0001000;    //show 'A'
    assign dp = 1;   //OFF dp
    
    wire xnor_res;
    assign xnor_res = ~(|(sw ^ 10'b1010100001));    //1'b1 (OFF) if SW9,7,5,0 ON, else 1'b0 (ON)
    assign an = {xnor_res, 1'b0, 1'b0, xnor_res}; //last digit 7 -> (OFF,ON,ON,OFF)

endmodule
