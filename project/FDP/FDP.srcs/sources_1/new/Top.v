`timescale 1ns / 1ps

module Top(
    input clk, btnU,
    input [11:0] sw,
    output Hsync,
    output Vsync,
    output [11:0] vgaRGB    //4-bit red, 4-bit green, 4-bit blue
    );

    reg [11:0] rgb_reg;
    wire video_on;
    wire p_tick;
    wire [9:0] x;
    wire [9:0] y;
    
    VGA_Controller vga(clk, btnU, video_on, Hsync, Vsync, p_tick, x, y);

    always @(posedge clk or posedge btnU) begin
        if (btnU)   //reset
            rgb_reg <= 12'h000; // RGB value during active video
        else
            rgb_reg <= sw; // blank during porches and sync intervals
    end

    assign vgaRGB = video_on ? rgb_reg : 12'h000; // RGB value during active video

endmodule
