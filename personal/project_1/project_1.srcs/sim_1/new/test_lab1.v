`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.08.2025 09:44:55
// Design Name: 
// Module Name: simulation_module
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


module simulation_module(
    );
    reg [9:0] sw;
    wire [9:0] led;
    wire [6:0] seg;
    wire dp;
    wire [3:0] an;
    
    lab1 out(sw, led, seg, dp, an);
    
    initial begin
//        sw = 10'b1010100001;
        sw = 10'b0010100001;
            
            
    end
endmodule
