`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/05/2025 12:12:46 AM
// Design Name: 
// Module Name: oled_debug
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


module oled_debug(
    );

reg clk = 0;
reg clk_6p25MHz = 0;
reg reset = 1;  // Start with reset active
wire oled_frame_begin, oled_sending_pixels, oled_sample_pixel;
wire [12:0] oled_pixel_index;
reg [15:0] oled_data = 16'hFFFF; //white
wire [7:0] JB;

// Internal signals for debugging
wire [4:0] state;
wire [16:0] frame_counter;
wire [19:0] delay;

Oled_Display disp(
    clk_6p25MHz,    //clk
    reset,   //reset
    oled_frame_begin, //frame_begin
    oled_sending_pixels,  //sending_pixels
    oled_sample_pixel,    //sample_pixel
    oled_pixel_index[12:0],    //pixel_index
    oled_data,  //pixel_data
    JB[0],  //cs
    JB[1],  //sdin
    JB[3],  //sclk
    JB[4],  //d_cn
    JB[5],  //resn
    JB[6],  //vccen
    JB[7]   //pmoden
);

// Try to access internal signals for debugging (may not work in all simulators)
assign state = disp.state;
assign frame_counter = disp.frame_counter;
assign delay = disp.delay;

// Generate proper clocks
always #1 clk = ~clk; // 100 MHz (period = 10ns)
always #4 clk_6p25MHz = ~clk_6p25MHz; // 6.25 MHz (period = 160ns)

// Add comprehensive debug output
always @(negedge clk_6p25MHz) begin
    if (!reset && $time > 20000) begin
        if (state < 16) begin
            $display("Time: %0t ns | State: %2d (%s) | Frame_counter: %5d | Delay: %8d | Sending_pixels: %b", 
                     $time, state, get_state_name(state), frame_counter, delay, oled_sending_pixels);
        end else begin
            $display("Time: %0t ns | State: %2d (SendPixel) | Frame_counter: %5d | Pixel_index: %4d | Sending_pixels: %b", 
                     $time, state, frame_counter, oled_pixel_index, oled_sending_pixels);
        end
    end
end

// Function to get readable state names
function [127:0] get_state_name;
    input [4:0] state_val;
    begin
        case(state_val)
            5'b00000: get_state_name = "PowerUp";
            5'b00001: get_state_name = "Reset";
            5'b00011: get_state_name = "ReleaseReset";
            5'b00010: get_state_name = "EnableDriver";
            5'b00110: get_state_name = "DisplayOff";
            5'b00111: get_state_name = "SetRemapDisplayFormat";
            5'b00101: get_state_name = "SetStartLine";
            5'b00100: get_state_name = "SetOffset";
            5'b01100: get_state_name = "SetNormalDisplay";
            5'b01101: get_state_name = "SetMultiplexRatio";
            5'b01111: get_state_name = "SetMasterConfiguration";
            5'b01110: get_state_name = "DisablePowerSave";
            5'b01010: get_state_name = "SetPhaseAdjust";
            5'b01011: get_state_name = "SetDisplayClock";
            5'b01001: get_state_name = "SetSecondPrechargeA";
            5'b01000: get_state_name = "SetSecondPrechargeB";
            5'b11000: get_state_name = "SetSecondPrechargeC";
            5'b11001: get_state_name = "SetPrechargeLevel";
            5'b11011: get_state_name = "SetVCOMH";
            5'b11010: get_state_name = "SetMasterCurrent";
            5'b11110: get_state_name = "SetContrastA";
            5'b11111: get_state_name = "SetContrastB";
            5'b11101: get_state_name = "SetContrastC";
            5'b11100: get_state_name = "DisableScrolling";
            5'b10100: get_state_name = "ClearScreen";
            5'b10101: get_state_name = "VccEn";
            5'b10111: get_state_name = "DisplayOn";
            5'b10110: get_state_name = "PrepareNextFrame";
            5'b10010: get_state_name = "SetColAddress";
            5'b10011: get_state_name = "SetRowAddress";
            5'b10001: get_state_name = "WaitNextFrame";
            5'b10000: get_state_name = "SendPixel";
            default: get_state_name = "Unknown";
        endcase
    end
endfunction

initial begin
    // Proper reset sequence
    reset = 1;
    #1000;  // Hold reset for 1us
    reset = 0;
    $display("Reset released at time %0t", $time);
    
    // Monitor for when we reach SendPixel state
    wait(state == 5'b10000);  // Wait for SendPixel state
    $display("*** REACHED SendPixel STATE at time %0t ***", $time);
    
    // Monitor pixel_index changes
    wait(oled_pixel_index > 0);
    $display("*** PIXEL_INDEX STARTED CHANGING at time %0t, value = %d ***", $time, oled_pixel_index);
    
    // Wait for pixel_index to reach near the end to see the bug
    wait(oled_pixel_index > 6140);
    $display("*** PIXEL_INDEX NEAR END at time %0t, value = %d ***", $time, oled_pixel_index);
    
    // Run simulation long enough to see multiple frames
    #2000000000; // 2 seconds - enough for multiple complete frames
    $finish;
end

endmodule
