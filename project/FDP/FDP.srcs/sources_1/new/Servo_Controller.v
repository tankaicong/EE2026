`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2025 03:33:38 PM
// Design Name: 
// Module Name: Servo_Controller
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


module Servo_Controller(
    input clk,  //supply 50MHz clock
    input reset,
    input servo_en,
    input [17:0] servo_x_angle, //raw pulse width: 200_000 steps between 0.5ms to 2.5ms
    input [17:0] servo_y_angle,
    output reg servo_x_pwm,
    output reg servo_y_pwm
);

    // Servo PWM generation (50 Hz, 20 ms period)
    reg [20:0] pwm_counter = 0;

    // Offset input angle (0 to 200000) to pulse width (0.5 ms – 2.5 ms)
    wire [20:0] pulse_width_x = 50000 + servo_x_angle;
    wire [20:0] pulse_width_y = 50000 + servo_y_angle;

    always @(posedge clk) begin
        if (reset || !servo_en) begin
            // Disable servos
            pwm_counter <= 0;
            servo_x_pwm <= 1;
            servo_y_pwm <= 1;
        end else begin
            // Reset counter every 20 ms
            if (pwm_counter >= 2_000_000 - 1) pwm_counter <= 0;
            else begin
                pwm_counter <= pwm_counter + 1;
                servo_x_pwm <= (pwm_counter < pulse_width_x);
                servo_y_pwm <= (pwm_counter < pulse_width_y);
            end
        end
    end
        
endmodule
