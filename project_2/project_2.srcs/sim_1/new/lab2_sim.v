`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.08.2025 23:35:45
// Design Name: 
// Module Name: lab2_sim
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


module lab2_sim(
    );
    
    reg [4:0] A, B;
    reg pb;
    wire [4:0] S;
    wire [3:0] an;
    wire [7:0] seg;
    
    lab2 sim(A, B, pb, S, an, seg);
    
    initial begin
        A = 5'b10001; B = 5'b01001; pb = 0; #10;
        A = 5'b10011; B = 5'b01101; pb = 0; #10;
        A = 5'b01111; B = 5'b01111; pb = 0; #10;
        A = 5'b01110; B = 5'b01011; pb = 1; #10;
        A = 5'b00011; B = 5'b11111; pb = 1; #10;
        A = 5'b01011; B = 5'b11110; pb = 1; #10;
    end
    
endmodule
