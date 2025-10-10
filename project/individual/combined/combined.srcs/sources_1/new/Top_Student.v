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

reg sw15 = 1'b0;
reg sw14 = 1'b0;
reg sw13 = 1'b0;
reg sw12 = 1'b0;
reg [24:0] count_debounce = 25'd0;

always @(posedge clk) begin
    if (sw15 != sw[15] || sw14 != sw[14] || sw13 != sw[13] || sw12 != sw[12]) begin
        if (count_debounce < 25'd1000000) begin
            count_debounce <= count_debounce + 1;
        end
        else begin
            count_debounce <= 0;
            sw15 <= sw[15];
            sw14 <= sw[14];
            sw13 <= sw[13];
            sw12 <= sw[12];
        end
    end
end

Seven_Seg ss(clk, 16'h5102, 4'b0100, seg, an);
Task_P taskP(clk, (sw15 | sw14 | sw13 | (~sw12)), btnL, btnR, JB_P);
Task_Q taskQ(clk, (sw15 | sw14 | (~sw13)), {btnR, btnL, btnC}, JB_Q);
Task_R taskR(clk, (sw15 | (~sw14)), sw[1], sw[3], JB_R);
Task_S taskS(clk, ~(sw15), btnU, btnD, btnL, btnR, JB_S);

assign JB = (sw15) ? JB_S :
            (sw14) ? JB_R :
            (sw13) ? JB_Q :
            (sw12) ? JB_P :
            8'b00000000;

endmodule