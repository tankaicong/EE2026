`timescale 1ns / 1ps

module Top_Student (
    input wire CLOCK,          // 100MHz system clock
    input wire btnC,       // Reset button
    input wire [4:0] sw,      // Switches
    output wire [7:0] JB       // PMOD OLED connections
);

    // === 3.A2 Clock divider: 100MHz -> 6.25MHz ===
    // Clock divider to generate 6.25 MHz from 100 MHz system clock
    reg [3:0] clk_div_counter = 0;
    reg clk6p25m = 0;
    
    always @(posedge CLOCK or posedge btnC) begin
            if (btnC)
                clk_div_counter <= 0;
            else begin
                if (clk_div_counter == 7) begin  // 100MHz / 6.25MHz / 2 = 8
                    clk_div_counter <= 0;
                    clk6p25m <= ~clk6p25m;
                end else
                    clk_div_counter <= clk_div_counter + 1;
            end
        end
        
//    reg [15:0] oled_data = 16'h07E0; // default green
    // === 3.A3/3.A8 Colour selection based on sw[4] ===
    reg [15:0] oled_data;
    always @(*) begin
        if (sw[4] == 1'b1)
            oled_data = 16'hF800; // Red
        else
            oled_data = 16'h07E0; // Green
    end

   wire frame_begin, sending_pixels, sample_pixel;
   wire [12:0] pixel_index;
    
    Oled_Display oled_inst (
        .clk(clk6p25m),
        .reset(btnC),             // can tie to pushbutton or 0
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