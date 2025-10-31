`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Simple LUTRAM implementation of dual port buffer 
//////////////////////////////////////////////////////////////////////////////////


module Dual_Port_Buffer
#(  parameter DATA_WIDTH = 12,
    parameter BUFFER_SIZE = 74400)  // 2 * 310 * 240

(
    input clka, // pclk 24 MHz
    input wea,
    input [17:0] addra,    //18-bit address covers 2*74400 = 148800 pixels
    input [DATA_WIDTH-1:0] dina,    //12 bit RGB444 pixel data
    input clkb, // clk25 25 MHz
    input [17:0] addrb,     //18-bit address covers 2*74400 = 148800 pixels
    output reg [DATA_WIDTH-1:0] doutb    //12 bit RGB444 pixel data
    );

    (* ram_style = "block" *)
    reg [DATA_WIDTH-1:0] bram [BUFFER_SIZE-1:0];

    always @(posedge clka) begin
        if (wea) begin
            bram[addra] <= dina;
        end
    end

    always @(posedge clkb) begin
        doutb <= bram[addrb];
    end

endmodule