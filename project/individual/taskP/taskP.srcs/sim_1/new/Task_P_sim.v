`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.10.2025 15:58:25
// Design Name: 
// Module Name: Task_P_sim
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


`timescale 1ns / 1ps

module Task_P_sim;

    // Inputs
    reg CLOCK = 0;
    reg btnL = 0;
    reg btnR = 0;
    reg btnReset = 0;

    // Outputs
    wire [7:0] JB;

    // Instantiate the DUT (Device Under Test)
    Task_P uut (
        .CLOCK(CLOCK),
        .btnL(btnL),
        .btnR(btnR),
        .btnReset(btnReset),
        .JB(JB)
    );

    // Clock generator: 100 MHz -> period = 10ns
    always #5 CLOCK = ~CLOCK;

    // Test procedure
    initial begin

        // Simulate a quick press of btnL
        #100;  // wait 100ns
        btnL = 1;
        #20;   // held for 20ns
        btnL = 0;

        // Wait for debounce to clear
        #25_000_000; // 25ms simulated wait (scaled down for speed)

        // Press btnR
        btnR = 1;
        #20;
        btnR = 0;

        // Long press btnL
        #100_000;
        btnL = 1;
        #5_000_000;   // hold for a long time (5ms simulated)
        btnL = 0;

        #100_000;
        $finish;
    end

endmodule
