`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2025 16:46:40
// Design Name: 
// Module Name: Task_P
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
/////////////////////////////////////////////////////////////////////////////////


module Task_P(
    input wire CLOCK,
    input wire btnL,
    input wire btnR,
    output wire [7:0] JB
);
    // OLED height and width
    localparam Width  = 96;
    localparam Height = 64;
    localparam PixelCount = Width * Height;

    // Pixel index from OLED driver
    wire [12:0] pixel_index; // goes from 0 to (96*64 - 1)
    wire frame_begin, sending_pixels, sample_pixel;

    // Compute x/y coordinates for each pixel
    wire [6:0] x_coord = pixel_index % Width;
    wire [6:0] y_coord = pixel_index / Width;

    // Circle parameters
    localparam CIRCLE_X = 10;
    localparam CIRCLE_Y = 10;
    localparam CIRCLE_R = 8;
    
    reg [3:0] clk_div_counter = 0;
    reg clk6p25m = 0;
    
    always @(posedge CLOCK) begin
        clk_div_counter <= clk_div_counter + 1;
        if (clk_div_counter == 7) begin 
            clk_div_counter <= 0;
            clk6p25m <= ~clk6p25m;
        end        
    end
        
    wire circle_pixel;
    assign circle_pixel = ((x_coord - CIRCLE_X)*(x_coord - CIRCLE_X) + 
                           (y_coord - CIRCLE_Y)*(y_coord - CIRCLE_Y)) <= CIRCLE_R*CIRCLE_R;
    
    // Character parameters
    localparam MIN_HEIGHT = 50;
    localparam MIN_WIDTH  = 30;
    localparam MIN_THICKNESS = 8;
    // Digit offsets
    localparam LEFT_ROW_OFFSET  = 7;
    localparam LEFT_COL_OFFSET  = 22;
    localparam RIGHT_ROW_OFFSET = 7;
    localparam RIGHT_COL_OFFSET = 60;

    // Generate pixel for 2
    wire left_digit = (
        // Top horizontal
        (y_coord >= LEFT_ROW_OFFSET && y_coord < LEFT_ROW_OFFSET + MIN_THICKNESS &&
         x_coord >= LEFT_COL_OFFSET && x_coord < LEFT_COL_OFFSET + MIN_WIDTH) ||
    
        // top right vertical
        (y_coord >= LEFT_ROW_OFFSET && 
        y_coord <= LEFT_ROW_OFFSET + MIN_HEIGHT/2 &&
         x_coord >= LEFT_COL_OFFSET + MIN_WIDTH - MIN_THICKNESS &&
         x_coord <= LEFT_COL_OFFSET + MIN_WIDTH) ||
    
        // Middle horizontal
        (y_coord >= LEFT_ROW_OFFSET + MIN_HEIGHT/2 - MIN_THICKNESS/2 &&
         y_coord <= LEFT_ROW_OFFSET + MIN_HEIGHT/2 + MIN_THICKNESS/2 &&
         x_coord >= LEFT_COL_OFFSET && x_coord < LEFT_COL_OFFSET + MIN_WIDTH) ||
    
        // Bottom left vertical
        (y_coord >= LEFT_ROW_OFFSET + MIN_HEIGHT/2 &&
         y_coord <= LEFT_ROW_OFFSET + MIN_HEIGHT &&
         x_coord >= LEFT_COL_OFFSET &&
         x_coord <= LEFT_COL_OFFSET + MIN_THICKNESS) ||
    
        // Bottom horizontal
        (y_coord >= LEFT_ROW_OFFSET + MIN_HEIGHT - MIN_THICKNESS &&
         y_coord <= LEFT_ROW_OFFSET + MIN_HEIGHT &&
         x_coord >= LEFT_COL_OFFSET &&
         x_coord <= LEFT_COL_OFFSET + MIN_WIDTH)
    );
    
    // Generate pixel for 9
    wire right_digit = (
        // Top horizontal
        (y_coord >= RIGHT_ROW_OFFSET && 
         y_coord <= RIGHT_ROW_OFFSET + MIN_THICKNESS &&
         x_coord >= RIGHT_COL_OFFSET && 
         x_coord <= RIGHT_COL_OFFSET + MIN_WIDTH) ||
    
        // Top right vertical
        (y_coord >= RIGHT_ROW_OFFSET + MIN_THICKNESS && 
         y_coord <= RIGHT_ROW_OFFSET + MIN_HEIGHT/2 &&
         x_coord >= RIGHT_COL_OFFSET + MIN_WIDTH - MIN_THICKNESS &&
         x_coord <= RIGHT_COL_OFFSET + MIN_WIDTH) ||
    
        // Middle horizontal
        (y_coord >= RIGHT_ROW_OFFSET + MIN_HEIGHT/2 - MIN_THICKNESS/2 &&
         y_coord <= RIGHT_ROW_OFFSET + MIN_HEIGHT/2 + MIN_THICKNESS/2 &&
         x_coord >= RIGHT_COL_OFFSET && 
         x_coord <= RIGHT_COL_OFFSET + MIN_WIDTH) ||
    
        // Bottom right vertical
        (y_coord >= RIGHT_ROW_OFFSET + MIN_HEIGHT/2 &&
         y_coord <= RIGHT_ROW_OFFSET + MIN_HEIGHT &&
         x_coord >= RIGHT_COL_OFFSET + MIN_WIDTH - MIN_THICKNESS &&
         x_coord <= RIGHT_COL_OFFSET + MIN_WIDTH) ||
    
        // Top left vertical (for the top part of 9)
        (y_coord >= RIGHT_ROW_OFFSET + MIN_THICKNESS &&
         y_coord <= RIGHT_ROW_OFFSET + MIN_HEIGHT/2 &&
         x_coord >= RIGHT_COL_OFFSET &&
         x_coord <= RIGHT_COL_OFFSET + MIN_THICKNESS)
    );

    // Debounced toggles for buttons
    reg left_toggle = 1;
    reg right_toggle = 1;
    reg [24:0] btnL_counter = 0;
    reg [24:0] btnR_counter = 0;
    reg btnL_prev = 0;
    reg btnR_prev = 0;

    always @(posedge CLOCK) begin
        // Left button 
        // once button is pressed, btnL starts at 20,000,000 and counts down to 0 till btnL is available again
        // also ensure that if the button is held for very long, it is only considered as one toggle
        if (btnL_counter > 0) begin
            btnL_counter <= btnL_counter - 1;
        end
        else if (btnL && !btnL_prev) begin
            left_toggle <= ~left_toggle;
            btnL_counter <= 25'd20000000; // 200ms debounce at 100MHz
        end
        btnL_prev <= btnL;
        
        // Right button
        if (btnR_counter > 0) begin
            btnR_counter <= btnR_counter - 1;
        end
        else if (btnR && !btnR_prev) begin
            right_toggle <= ~right_toggle;
            btnR_counter <= 25'd20000000; // 200ms debounce at 100MHz
        end
        btnR_prev <= btnR;
    end

    // OLED pixel color assignment
    reg [15:0] oled_data;
    always @(*) begin
        oled_data = 16'h0000; // default black
        // Circle
        if (circle_pixel)
            oled_data = (btnL || btnR) ? 16'hF81F : 16'hFFFF; // magenta or white

        // Digits
        if (left_toggle && left_digit)
            oled_data = 16'hF800; // red
        if (right_toggle && right_digit)
            oled_data = 16'h07E0; // green
    end

    // Instantiate OLED driver
    Oled_Display oled_inst (
        .clk(clk6p25m),
        .reset(1'b0),
        .frame_begin(frame_begin),
        .sending_pixels(sending_pixels),
        .sample_pixel(sample_pixel),
        .pixel_index(pixel_index),
        .pixel_data(oled_data),
        .cs(JB[0]),
        .sdin(JB[1]),
        .sclk(JB[3]),
        .d_cn(JB[4]),
        .resn(JB[5]),
        .vccen(JB[6]),
        .pmoden(JB[7])
    );

endmodule

