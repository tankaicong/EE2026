`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2025 04:35:49 PM
// Design Name: 
// Module Name: proj_lab_sim
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


module proj_lab_sim(

    );

    input CLOCK;
    input [2:0] btn;
    output [7:0] JC;

    Top_Student ts(CLOCK, btn, JC);

    always begin
        #5 CLOCK = ~CLOCK;
    end

    initial begin
        btn = 3'b010; #10;
        btn = 3'b001; #10;
        btn = 3'b100; #10;
    end

endmodule
