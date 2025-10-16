`timescale 1ns / 1ps
`define SIMULATION
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2025 10:40:01
// Design Name: 
// Module Name: mouse_movement_sim
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


module mouse_movement_sim(
);
    reg clk;
    reg btnU;
    reg left;
    wire [15:0] led;
    wire [11:0] vga_RGB;

    mouse_movement uut (
        .clk(clk), 
        .btnU(btnU), 
        .Mouse_Clk(), // Not used in simulation
        .Mouse_Data(), // Not used in simulation
        .left_sim(left),
        .led(led), 
        .vga_RGB(vga_RGB)
    );

    initial clk = 0;
    always #5 clk = ~clk; // 10ns period

    initial begin
        // Initialize Inputs
        clk = 0;
        btnU = 1; // Start with reset active
        left = 0; // No click initially
        #20;
        btnU = 0; // Release reset

        repeat (10) begin
            simulate_left_click();
            #50;
        end

        #100_000_000;
        $stop;
    end

    task simulate_left_click;
    begin
        left = 1; // left click
        #30;
        left = 0; // release left click
    end
    endtask

endmodule
