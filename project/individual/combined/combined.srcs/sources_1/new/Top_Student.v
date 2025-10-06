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
    input [15:0] sw,
    input btnU, btnD, btnL, btnR, btnC,
    output [7:0] seg,
    output [3:0] an,
    output [7:0] JB
);

wire [7:0] JB_S;
wire [7:0] JB_R;
wire [7:0] JB_Q;
wire [7:0] JB_P;

Seven_Seg ss(clk, 16'h5102, 4'b0100, seg, an);
Task_R taskR(clk, ~sw[14], sw[1], sw[3], JB_R);
Task_S taskS(clk, ~sw[15], btnU, btnD, btnL, btnR, JB_S);
Task_P taskP(clk, ~sw[12], btnL, btnR, JB_P);
Task_Q taskQ(clk, ~sw[13], {btnR, btnL, btnC}, JB_Q);

assign JB = (sw[15]) ? JB_S :
            (sw[14]) ? JB_R :
            (sw[13]) ? JB_Q :
            (sw[12]) ? JB_P :
            8'b00000000;

endmodule