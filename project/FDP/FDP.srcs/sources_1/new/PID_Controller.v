`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2025 04:57:26 PM
// Design Name: 
// Module Name: PID_Controller
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


module PID_Controller
#(
    // parameter [31:0] KP = 32'd100,  // Proportional gain
    parameter [31:0] KP_BITSHIFT_LEFT = 32'd1, // Proportional gain bitshift (can't divide)
    parameter [31:0] KI_BITSHIFT_RIGHT = 32'd10, // Integral gain bitshift (can't divide)
    parameter [31:0] KD_BITSHIFT_RIGHT = 32'd10, // Derivative gain bitshift (can't divide)
    parameter [31:0] INTEGRAL_LIMIT = 32'd50_000 // Max integral windup limit
    //Pan limits should be 250_000 to 50_000 (+90 deg to -90 deg)
    //Tilt limits should be 183_333 to 100_000 (+30 deg to -45 deg)
)
(
    input clk,
    input reset,
    input enable,
    input signed [31:0] setpoint,
    input signed [31:0] measurement,
    input invert_error, //1 to invert error (for pan axis), 0 to not invert (tilt axis)
    output reg signed [31:0] control_output,
    input signed [31:0] KP,
    input signed [31:0] KI,
    input signed [31:0] KD,
    input signed [31:0] SERVO_MAX,
    input signed [31:0] SERVO_MIN
);

    // Internal signals
    reg signed [31:0] error;
    reg signed [31:0] integral;
    reg signed [31:0] derivative;
    reg signed [31:0] pid_sum;
    reg signed [31:0] prev_error;

    // Slow clock for PID updates (381 Hz)
    reg [17:0] counter_pid_freq = 0;       //18 bit counter, for 381hz ~= 400hz clock enable signal
    reg clock_enable_pid_freq = 0;

    // Update step
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            control_output <= 32'sd100_000;
            integral <= 32'sd0;
            prev_error <= 32'sd0;
        end else if (!enable) begin
            // When disabled, hold current control output and reset integral
            control_output <= control_output;
            integral <= 32'sd0;
            prev_error <= 32'sd0;
        end else begin
            counter_pid_freq <= counter_pid_freq + 1;
            if (counter_pid_freq == 0) clock_enable_pid_freq = 1;
            else clock_enable_pid_freq = 0;

            if (clock_enable_pid_freq) begin
                // Compute error
                error = invert_error ? (setpoint - measurement) : (measurement - setpoint);

                // Compute integral
                integral = integral + error;
                // Anti-windup: clamp integral term
                if (integral > INTEGRAL_LIMIT) integral = INTEGRAL_LIMIT;
                else if (integral < -INTEGRAL_LIMIT) integral = -INTEGRAL_LIMIT;

                // Compute derivative
                derivative = error - prev_error;

                // Compute control output
                pid_sum = ((KP * error) <<< KP_BITSHIFT_LEFT) +
                          ((KI * integral) >>> KI_BITSHIFT_RIGHT) + 
                          ((KD * derivative) >>> KD_BITSHIFT_RIGHT);

                // position control means integrate pid term
                control_output = control_output + pid_sum;
                // Clamp control output to servo limits
                if (control_output < SERVO_MIN) control_output = SERVO_MIN;
                else if (control_output > SERVO_MAX) control_output = SERVO_MAX;


                // Update previous error
                prev_error <= error;
            end
        end
    end
endmodule
