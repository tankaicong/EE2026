`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//  STUDENT A NAME: 
//  STUDENT B NAME:
//  STUDENT C NAME: 
//  STUDENT D NAME:  
//
//////////////////////////////////////////////////////////////////////////////////

module screen_625mhz (input CLOCK, output reg screen);
    // 100MHz / 6.25MHz = 16
    reg [4:0] COUNT = 5'b0;
    always @ (posedge CLOCK) begin
        COUNT <= (COUNT == 5'd16) ? 0 : COUNT + 1;
        screen <= (COUNT == 0) ? ~screen : screen;
    end
endmodule


module next_color(input [2:0] state, output reg [15:0] color_out);
    always @ (*) begin
        case (state)
            3'd0: color_out <= 16'hF800;   // Red
            3'd1: color_out <= 16'h001F;   // Blue
            3'd2: color_out <= 16'hFFE0;   // Yellow
            3'd3: color_out <= 16'h07E0;   // Green
            3'd4: color_out <= 16'hFFFF;   // White
            default: color_out <= 16'h0000; // Black
        endcase
    end
endmodule


module btn_debounce(input btn, input CLOCK, output reg db_btn);     // Debounce for 200ms
    reg [24:0] count = 25'b0;
    reg locked = 0, hold = 0;
    always @ (posedge CLOCK) begin
        db_btn <= 0;
        if (locked == 1) begin
            if (count < 25'd20000000) begin
                count <= count + 1;
            end
            else begin
                count <= 0;
                locked <= 0;
            end
        end
        else if (btn == 1 && locked == 0 && hold == 0) begin
            db_btn <= 1;
            count <= count + 1;
            locked <= 1;
            hold <= 1;
        end
        else if (btn == 0 && hold == 1) begin
            hold <= 0;
        end
    end
endmodule


module Task_Q (
    input CLOCK,
    input sw_rst,
    input [2:0] btn,
    output [7:0] JB
);
    wire scr_clk;
    screen_625mhz scr(CLOCK, scr_clk);
    
    wire [12:0] pixel_index;
    wire frame_begin, sending_pixels, sample_pixel;
    reg [15:0] pixel_data;

    Oled_Display oled(.clk(scr_clk), .reset(sw_rst),
    .frame_begin(frame_begin), .sending_pixels(sending_pixels),
    .sample_pixel(sample_pixel), .pixel_index(pixel_index), .pixel_data(pixel_data),
    .cs(JB[0]), .sdin(JB[1]), .sclk(JB[3]),
    .d_cn(JB[4]), .resn(JB[5]), .vccen(JB[6]), .pmoden(JB[7]));
    
    reg [2:0] left_state, ctr_state, right_state;
    
    wire [15:0] left_color, center_color, right_color;

    wire [6:0] x, y;
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;

    assign led_test = frame_begin;

    wire btnL, btnC, btnR;
    btn_debounce bC(btn[0], CLOCK, btnC);
    btn_debounce bL(btn[1], CLOCK, btnL);
    btn_debounce bR(btn[2], CLOCK, btnR);

    next_color leftnc(left_state, left_color);
    next_color centernc(ctr_state, center_color);
    next_color rightnc(right_state, right_color);

    initial begin
        left_state = 3'd0;
        ctr_state = 3'd3;
        right_state = 3'd1;
        pixel_data = 16'b0;
        if (x >= 9 && x <= 28 && y >= 35 && y <= 54) begin
            pixel_data <= center_color;
        end
        if (x >= 38 && x <= 57 && y >= 35 && y <= 54) begin
            pixel_data <= left_color;
        end
        if (x >= 67 && x <= 86 && y >= 35 && y <= 54) begin
            pixel_data <= right_color;
        end
        else begin
            pixel_data <= 16'h0000;
        end
    end

    always @ (posedge CLOCK) begin
        if (sw_rst == 1) begin
            left_state <= 3'd0;
            ctr_state <= 3'd3;
            right_state <= 3'd1;
        end
        else begin                      // Button press
            if (btnC == 1) begin      // Center button
                ctr_state <= ctr_state + 1;
            end
            if (btnL == 1) begin      // Left button
                left_state <= left_state + 1;
            end
            if (btnR == 1) begin      // Right button
                right_state <= right_state + 1;
            end
            
            // Loop back to red if overflowed
            if (left_state > 3'd4) begin
                left_state <= 3'd0;
            end
            if (ctr_state > 3'd4) begin
                ctr_state <= 3'd0;
            end
            if (right_state > 3'd4) begin
                right_state <= 3'd0;
            end
        end
    end
    
    always @ (posedge CLOCK) begin
    // always @ (posedge frame_begin) begin
        if (left_state == 3'd2 && ctr_state == 3'd4 && right_state == 3'd2) begin
            if (x >= 87 && x <= 93 && y >= 2 && y <= 15) begin
                pixel_data <= 16'hF81F;
            end
            if (x >= 89 && x <= 91 && ((y >= 4 && y <= 7) || (y >= 10 && y <= 13))) begin
                pixel_data <= 16'h0000;
            end
        end

        if (x >= 9 && x <= 28 && y >= 35 && y <= 54) begin
            pixel_data <= left_color;
        end
        else if (x >= 38 && x <= 57 && y >= 35 && y <= 54) begin
            pixel_data <= center_color;
        end
        else if (x >= 67 && x <= 86 && y >= 35 && y <= 54) begin
            pixel_data <= right_color;
        end
        else begin
            if (!(left_state == 3'd2 && ctr_state == 3'd4 && right_state == 3'd2 && x >= 87 && x <= 93 && y >= 2 && y <= 15)) begin
                pixel_data <= 16'h0000;
            end
        end
    end
endmodule