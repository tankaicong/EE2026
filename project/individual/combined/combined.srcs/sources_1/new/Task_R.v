`timescale 1ns / 1ps

// Number: A0309057A
// 3rd rightmost number: 0
// 1st rightmost number: 7

module Task_R (
    input clk, reset, sw1, sw3,
    output [7:0] JB
);

localparam CHAR_WIDTH = 16;
localparam CHAR_HEIGHT = 26;
localparam CHAR_THICKNESS = 4;

reg [2:0] counter_6p25mhz = 0;
reg [31:0] movement_counter_zero = 0;
reg [31:0] movement_counter_seven = 0;
reg clk_6p25MHz = 0;
reg [15:0] oled_data = 16'h0000;
wire oled_frame_begin, oled_sending_pixels, oled_sample_pixel;
wire [12:0] oled_pixel_index;
reg [12:0] oled_pixel_idx = 0; //0 to 6143

reg [7:0] row = 0;
reg [6:0] col = 0;
reg [7:0] r_offset_zero = 0;
reg [7:0] c_offset_zero = (96-CHAR_WIDTH)/2;  //96 screen width/2 (=48) for centre then - CHAR_WIDTH/2
reg [7:0] r_offset_seven = (64-CHAR_HEIGHT)/2;   //64 screen height/2 (=32) for centre then - CHAR_HEIGHT/2
reg [7:0] c_offset_seven = 0;
reg [7:0] offset_seven = 0;
reg [7:0] offset_zero = 0;

// offsets for next frame, updated in movement logic, applied on frame begin signal
reg [7:0] next_r_offset_zero = 0;
reg [7:0] next_c_offset_zero = (96-CHAR_WIDTH)/2;
reg [7:0] next_r_offset_seven = (64-CHAR_HEIGHT)/2;
reg [7:0] next_c_offset_seven = 0;


// divide 100 Mhz clock to 6.25Mhz
always @ (posedge clk) begin
    if (reset) begin
        counter_6p25mhz <= 0;
        clk_6p25MHz <= 0;
    end else begin
        counter_6p25mhz = counter_6p25mhz + 1;
        if (counter_6p25mhz == 0) begin //3 bit counter overflows back to 0 every 8 cycles
            clk_6p25MHz = ~clk_6p25MHz; //invert signal every 8 cycles = 16 cycles per period = 6.25 mhz
        end
    end
end

//draws the actual numbers
always @(oled_pixel_index) begin  //everytime current pixel being updated changes
    oled_pixel_idx = oled_pixel_index;
    row = oled_pixel_idx / 96; //64 rows so divide 96 columns
    col = oled_pixel_idx % 96;

    //draw number 0 in orange, 7 in blue
    if ((row>=r_offset_seven && row<r_offset_seven+CHAR_HEIGHT) && (col>=c_offset_seven && col<c_offset_seven+CHAR_WIDTH) &&   //positive mask for 7
        ~(row>=r_offset_seven+CHAR_THICKNESS && col<c_offset_seven+CHAR_WIDTH-CHAR_THICKNESS))   //negative mask for 7
    begin
        oled_data = 16'h2f5d;
    end
    else if ((row>=r_offset_zero && row<r_offset_zero+CHAR_HEIGHT) && (col>=c_offset_zero && col<c_offset_zero+CHAR_WIDTH) &&   //positive mask for 0
            ~((row>=r_offset_zero+CHAR_THICKNESS && row<r_offset_zero+CHAR_HEIGHT-CHAR_THICKNESS) && (col>=c_offset_zero+CHAR_THICKNESS && col<c_offset_zero+CHAR_WIDTH-CHAR_THICKNESS)))  //negative mask for 0
    begin
        oled_data = 16'hfd60;
    end
    else begin
        oled_data = 16'h0000;
    end
end

// buffers next positions into regs
always @ (posedge clk) begin
    if (reset) begin
        // Reset all movement counters and positions
        movement_counter_seven <= 0;
        movement_counter_zero <= 0;
        offset_seven <= 0;
        offset_zero <= 0;
        next_r_offset_zero <= 0;
        next_c_offset_zero <= (96-CHAR_WIDTH)/2;
        next_r_offset_seven <= (64-CHAR_HEIGHT)/2;
        next_c_offset_seven <= 0;
    end else begin
        // counter for seven movement (3 secs)
        if (sw1) begin
            movement_counter_seven = movement_counter_seven + 1;
            if (movement_counter_seven >= 3750000) begin  // 100000000 CCs * 3secs / 80px = 3750000 cycles per pixel
                movement_counter_seven = 0;
                if (offset_seven < 96-CHAR_WIDTH) begin
                    next_c_offset_seven = next_c_offset_seven + 1;
                    offset_seven = offset_seven + 1;
                end
                else if (offset_seven < 2*(96-CHAR_WIDTH)) begin 
                    next_c_offset_seven = next_c_offset_seven - 1;
                    offset_seven = (offset_seven == 2*(96-CHAR_WIDTH)-1) ? 0 : offset_seven + 1;
                end
            end
        end
        
        // counter for zero movement (5 secs)  
        if (sw3) begin
            movement_counter_zero = movement_counter_zero + 1;
            if (movement_counter_zero >= 13157895) begin  // 100000000 CCs * 5secs / 38px = 13157895 cycles per pixel
                movement_counter_zero = 0;
                if (offset_zero < 64-CHAR_HEIGHT) begin
                    next_r_offset_zero = next_r_offset_zero + 1;
                    offset_zero = offset_zero + 1;
                end
                else if (offset_zero < 2*(64-CHAR_HEIGHT)) begin
                    next_r_offset_zero = next_r_offset_zero - 1;
                    offset_zero = (offset_zero == 2*(64-CHAR_HEIGHT)-1) ? 0 : offset_zero + 1;
                end
            end
        end
    end
end

// apply next position only at frame start (search "screen tearing")
always @(posedge oled_frame_begin or posedge reset) begin
    if (reset) begin
        r_offset_zero <= 0;
        c_offset_zero <= (96-CHAR_WIDTH)/2;
        r_offset_seven <= (64-CHAR_HEIGHT)/2;
        c_offset_seven <= 0;
    end else begin
        r_offset_zero <= next_r_offset_zero;
        c_offset_zero <= next_c_offset_zero;
        r_offset_seven <= next_r_offset_seven;
        c_offset_seven <= next_c_offset_seven;
    end
end


Oled_Display disp(
    clk_6p25MHz,    //clk
    reset,   //reset - now properly connected!
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

endmodule