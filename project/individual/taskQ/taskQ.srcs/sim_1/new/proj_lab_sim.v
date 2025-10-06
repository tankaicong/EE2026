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

    reg CLOCK = 0;
    always #1 CLOCK = ~CLOCK;

    reg sw_rst;
    reg [2:0] btn;
    wire [7:0] JB;

    Top_Student ts(.clk(CLOCK), .sw_rst(sw_rst), .btn(btn), .JB(JB));

    initial begin
        btn = 3'b000;
        sw_rst = 0;
        CLOCK = 0;
        #10;
    end

endmodule
