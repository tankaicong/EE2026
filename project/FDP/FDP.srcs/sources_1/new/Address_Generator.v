`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2025 01:31:26 AM
// Design Name: 
// Module Name: Address_Generator
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


module Address_Generator(
    input clk25,
    input enable,
    output reg [17:0] frame_addr,   //VGA address
    output reg [17:0] bram_addr  //BRAM address
    );

    reg [9:0] col = 10'd0; //640 max
    reg [8:0] row = 9'd0;  //480 max

    always @(posedge clk25) begin
        if (enable == 1'b0) begin
            col = 10'd0;
            row = 9'd0;
        end
        else begin
            frame_addr = col + row * 10'd640;
            bram_addr = (col >> 1) + (row >> 1) * 9'd320; //divide by 2
            if (col == 10'd639) begin
                col = 10'd0;
                if (row == 9'd479) begin
                    row = 9'd0;
                end else begin
                    row = row + 9'd1;
                end
            end else begin
                col = col + 10'd1;
            end
        end
    end
endmodule
