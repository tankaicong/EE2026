`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2025 10:42:42 AM
// Design Name: 
// Module Name: taskR_sim
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


module taskR_sim(

    );
    reg clk, btnU;
    reg [12:0] oled_pixel_idx = 0; //0 to 6143]
    reg sim_oled_frame_begin = 0;
    wire [7:0] JB;

    Top_Student uut (
        .clk(clk),
        .btnU(btnU), 
        // .sim_oled_pixel_index(oled_pixel_idx),
        .sim_oled_frame_begin(sim_oled_frame_begin),
        .JB(JB)
    );

    initial begin
        clk = 0;
        btnU = 0;
        sim_oled_frame_begin = 0;
    end

    always #2 sim_oled_frame_begin = ~sim_oled_frame_begin;
    always #1 clk = ~clk; // Toggle clock every 5 time units
    // always @(posedge clk) begin
    //     //make oled_pixel_idx count from 0 to 6143 every clk cycle
    //     if (oled_pixel_idx < 6143) begin
    //         oled_pixel_idx = oled_pixel_idx + 1;
    //     end else begin
    //         oled_pixel_idx = 0;
    //     end
    // end
endmodule
