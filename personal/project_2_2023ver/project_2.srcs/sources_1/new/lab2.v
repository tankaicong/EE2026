`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.08.2025 22:57:49
// Design Name: 
// Module Name: lab2
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

//number: A0309057A
//2nd rightmost value: 5
//3rd rightmost value: 0

module full_adder(input A, B, CIN, output S, COUT);
    assign S = A^B^CIN;
    assign COUT = A&B | CIN&(A^B);
endmodule

module two_bit_adder(input [1:0] A, B, input C0,
                     output [1:0] S, output C2);
    wire C1;
    full_adder fa0(A[0], B[0], C0, S[0], C1);
    full_adder fa1(A[1], B[1], C1, S[1], C2);
endmodule

module three_bit_adder(input [2:0] A, B, input C0,
                       output [2:0] S, output C3);
    wire C1, C2;
    full_adder fa0(A[0], B[0], C0, S[0], C1);
    full_adder fa1(A[1], B[1], C1, S[1], C2);
    full_adder fa2(A[2], B[2], C2, S[2], C3);
endmodule


module lab2(
    input [4:0] A, B,
    input pb,
    output [4:0] S,
    output [3:0] an,
    output [7:0] seg
    );

    //5-bit adder (2 MSB + 3 LSB)
    wire C;
    wire[4:0] DR, AR;
    three_bit_adder lsb_adder(A[2:0], B[2:0], 0, DR[2:0], C);  //0 carry in
    two_bit_adder msb_adder(A[4:3],B[4:3], C, DR[4:3]);    //carry out ignored
    assign AR = {DR[3:0], 1'b0};    //LSL #1, ignore MSB
    
    assign seg = 8'b11101010;
    assign an = pb ? 4'b0001 : 4'b1110;
    assign S = pb ? AR : DR;
    
endmodule
