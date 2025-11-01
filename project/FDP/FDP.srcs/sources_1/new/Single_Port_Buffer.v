`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.11.2025 04:58:09
// Design Name: 
// Module Name: Single_Port_Buffer
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


module Single_Port_Buffer
#(  parameter DATA_WIDTH = 4,
    parameter BUFFER_SIZE = 30000)  // 2 * 320 * 240
(
    input clk,             // clk25 25 MHz
    input [17:0] addr,     //18-bit address covers 2*76800 = 153600 pixels
    output reg [3:0] dout        //4 bit white/black pixel data
    );

    (* ram_style = "block" *)
    reg [DATA_WIDTH-1:0] BRAM [BUFFER_SIZE-1:0];
    initial begin
        $readmemh("letters.mem", BRAM);
    end
    always @(posedge clk) begin
        dout <= BRAM[addr];
    end
endmodule
