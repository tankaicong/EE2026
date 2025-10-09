`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/04/2025 09:56:43 PM
// Design Name: 
// Module Name: Seven_Seg
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


module Seven_Seg(
    input clk,
    input [15:0] num,               //4 hex digits
    input [3:0] dd,                 //decimal points, 1 for activated, 0 for off
    output reg [7:0] seg,
    output reg [3:0] an
    );

reg [1:0] refresh_counter = 0;      //cycle between 4 anodes
reg [4:0] current_digit;            //[4] = decimal point, [3:0] = hex digit
reg [17:0] counter_381hz = 0;       //18 bit counter, for 381hz clock enable signal
reg clock_enable_381hz = 0;         //clock enable signal for 381hz

always @(posedge clk) begin
    counter_381hz <= counter_381hz + 1;
    if (counter_381hz == 0) clock_enable_381hz = 1;
    else clock_enable_381hz = 0;
    
    if (clock_enable_381hz) begin
        refresh_counter <= refresh_counter + 1;
        case (refresh_counter)
            2'b00: begin
                an = 4'b1110;       //activate an0
                current_digit = {dd[0], num[3:0]};
            end
            2'b01: begin
                an = 4'b1101;       //activate an1
                current_digit = {dd[1], num[7:4]};
            end
            2'b10: begin
                an = 4'b1011;       //activate an2
                current_digit = {dd[2], num[11:8]};
            end
            2'b11: begin
                an = 4'b0111;       //activate an3
                current_digit = {dd[3], num[15:12]};
            end
        endcase
        case (current_digit[3:0])   //hex to 7-seg encoding
            4'h0: seg[6:0] = 7'b1000000;
            4'h1: seg[6:0] = 7'b1111001;
            4'h2: seg[6:0] = 7'b0100100;
            4'h3: seg[6:0] = 7'b0110000;
            4'h4: seg[6:0] = 7'b0011001;
            4'h5: seg[6:0] = 7'b0010010;
            4'h6: seg[6:0] = 7'b0000010;
            4'h7: seg[6:0] = 7'b1111000;
            4'h8: seg[6:0] = 7'b0000000;
            4'h9: seg[6:0] = 7'b0010000;
            4'hA: seg[6:0] = 7'b0001000;
            4'hB: seg[6:0] = 7'b0000011;
            4'hC: seg[6:0] = 7'b1000110;
            4'hD: seg[6:0] = 7'b0100001;
            4'hE: seg[6:0] = 7'b0000110;
            4'hF: seg[6:0] = 7'b0001110;
            default: seg[6:0] = 7'b1111111; //turn off all segments
        endcase
        seg[7] = ~current_digit[4]; //decimal point, active low
    end
end

endmodule
