`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Converted from VHDL code here: https://lauri.xn--vsandi-pxa.com/hdl/zynq/zybo-ov7670-to-vga.html
// Overall controller module for OV7670, transfers config registers over I2C
//////////////////////////////////////////////////////////////////////////////////

module OV7670_Controller(
    input clk,
    input resend,
    output config_finished,
    output sioc,
    inout siod,
    output reset,
    output pwdn,
    output xclk
);

    // Internal signals
    reg sys_clk = 1'b0;
    reg clk_div = 1'b0;
    wire [15:0] command;
    wire finished;
    wire taken;
    wire send;

    // Constant device I2C write address
    localparam [7:0] CAMERA_ADDRESS = 8'h42;

    // Configuration finished output
    assign config_finished = finished;

    // Send signal is active until finished
    assign send = ~finished;

    // Instantiate I2C sender
    I2C_Controller i2c(clk, siod, sioc, taken, send, CAMERA_ADDRESS, command[15:8], command[7:0]);

    // Normal operation: reset high, power-up enabled
    assign reset = 1'b1;
    assign pwdn  = 1'b0;
    assign xclk  = clk; // input clock directly set to 25 MHz

    // Instantiate register generator
    OV7670_Registers camera_regs(clk, resend, taken, command, finished);

    // Simple clock divider (xclk toggles every clk cycle)
    // always @(posedge clk) begin
    //     clk_div <= clk_div + 1;
    //     if (clk_div == 1'b1) begin
    //         sys_clk <= ~sys_clk;    // Toggle every 2 cycles = 25MHz
    //     end
    // end

endmodule