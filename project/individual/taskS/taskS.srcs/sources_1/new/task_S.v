`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.10.2025 02:57:05
// Design Name: 
// Module Name: task_S
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


module task_S(
    input clk,
    input reset,
    input frame_begin,  // 1-cycle pulse at 60 Hz based on Oled module
    input sample_pixel, // 1-cycle pulse by display module to request next pixel data
    input [12:0] pixel_index, // counts from 0 to 6143 (96*64-1) for pixels to update
    input btnU, btnD, btnL, btnR,
    output [15:0] pixel_data
    );
    
    // OLED is configured with 96 columns (x) and 64 rows (y) of pixels, each use 7 bit rep.
    parameter SCREEN_WIDTH = 96;
    parameter SCREEN_HEIGHT = 64;
    parameter SCREEN_CENTER_X = 48;
    parameter SCREEN_CENTER_Y = 32;

    parameter CIRCLE_RADIUS = 12; // in pixels

    parameter SQUARE_TOP_LEFT_X = 4; 
    parameter SQUARE_TOP_LEFT_Y = 40; 
    parameter SQUARE_SIDE_LENGTH = 25;
    parameter LINE_THICKNESS = 3; 

    parameter [15:0] RED = 16'hF800;
    parameter [15:0] BLACK = 16'h0000;
    parameter [15:0] WHITE = 16'hFFFF;
    parameter [15:0] GREEN = 16'h07E0;

    // circle state that needs to be updated every movement
    reg [6:0] circle_centre_x = SCREEN_CENTER_X;
    reg [6:0] circle_centre_y = SCREEN_CENTER_Y;
    reg [6:0] radius = CIRCLE_RADIUS;

    /**
    Display for every pixel(x,y)
    pixel index increments left to right (x), then top to bottom (y)
    pixel_index = 95 → x = 95 % 96 = 95, y = 95 / 96 = 0 → (95, 0)
    pixel_index = 96 → x = 96 % 96 = 0, y = 96 / 96 = 1 → (0, 1)
    */
    wire [6:0] x = pixel_index % SCREEN_WIDTH;
    wire [6:0] y = pixel_index / SCREEN_WIDTH;
    reg [15:0] pix = BLACK;
    assign pixel_data = pix;

    // for red circle
    wire inside_circle;
    identify_circle circle_test (
        .x(x),
        .y(y),
        .center_x(circle_centre_x),
        .center_y(circle_centre_y),
        .radius(radius),
        .inside_circle(inside_circle)
    );

    // for hollow square with digit 0 inside
    wire inside_square_boundary;
    identify_square_boundary #(
        .TOP_LEFT_X(SQUARE_TOP_LEFT_X),
        .TOP_LEFT_Y(SQUARE_TOP_LEFT_Y),
        .SIDE_LENGTH(SQUARE_SIDE_LENGTH),
        .LINE_THICKNESS(LINE_THICKNESS)
    ) square_boundary_inst (
        .x(x),
        .y(y),
        .inside_square_boundary(inside_square_boundary)
    );

    // for '0' inside the square: treat as rectangular ring (height 12, width 8, same line thickness 3)
   parameter CHAR_HEIGHT = 12;
   parameter CHAR_WIDTH  = 8;
   // inner cavity of the square
   parameter INNER_W = SQUARE_SIDE_LENGTH - 2*LINE_THICKNESS;
   parameter INNER_H = SQUARE_SIDE_LENGTH - 2*LINE_THICKNESS;
   // center the digit inside the inner cavity
   parameter CHAR_TOP_LEFT_X = SQUARE_TOP_LEFT_X + LINE_THICKNESS + (INNER_W - CHAR_WIDTH)/2;
   parameter CHAR_TOP_LEFT_Y = SQUARE_TOP_LEFT_Y + LINE_THICKNESS + (INNER_H - CHAR_HEIGHT)/2;
   wire inside_digit0;
   identify_rect_border #(
       .TOP_LEFT_X(CHAR_TOP_LEFT_X),
       .TOP_LEFT_Y(CHAR_TOP_LEFT_Y),
       .WIDTH(CHAR_WIDTH),
       .HEIGHT(CHAR_HEIGHT),
       .THICKNESS(LINE_THICKNESS)
   ) digit0_inst (
       .x(x),
       .y(y),
       .inside_rect_border(inside_digit0)
   );

    // Display output logic
    // always @(posedge pixel_index or posedge reset) begin
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pix <= BLACK;
        end else if (sample_pixel) begin
            if (inside_circle) begin
                pix <= RED;
            end else if (inside_digit0) begin
                pix <= GREEN;
            end else if (inside_square_boundary) begin
                pix <= WHITE;
            end else begin
                pix <= BLACK;
            end
        end
    end

    // movement control
    reg moving = 1'b0;
    reg [1:0] dir = 2'b00; // 00=U, 01=D, 10=L, 11=R
    wire [6:0] next_circle_x;
    wire [6:0] next_circle_y;
    wire can_move;
    get_next_check_collision #(
        .WIDTH(SCREEN_WIDTH),
        .HEIGHT(SCREEN_HEIGHT),
        .SQUARE_X(SQUARE_TOP_LEFT_X),
        .SQUARE_Y(SQUARE_TOP_LEFT_Y),
        .SQUARE_SIDE(SQUARE_SIDE_LENGTH),
        .LINE_THICKNESS(LINE_THICKNESS)
    ) check_collision_inst (
        .circle_x(circle_centre_x),
        .circle_y(circle_centre_y),
        .radius(radius),
        .dir(dir),
        .next_cx(next_circle_x),
        .next_cy(next_circle_y),
        .can_move(can_move)
    );

    // movement speed (35-55 pixels per second = (96-12*2)/(35 to 55) = 2s to 1.3s from left to right)
    parameter MOVE_EVERY_FRAMES = 24; // change this to adjust speed
    reg [6:0] frame_count = 7'd0;
    // always @(posedge frame_begin or posedge reset) begin
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            frame_count <= 7'd0;
        end else begin
            if (frame_begin) begin
                if (frame_count == MOVE_EVERY_FRAMES-1) begin
                    frame_count <= 7'd0;
                end else begin
                    frame_count <= frame_count + 7'd1;
                end
            end
        end
    end
    wire move_now = (frame_count == MOVE_EVERY_FRAMES-1) ? 1'b1 : 1'b0;

    // // update movement state
    // always @(posedge frame_begin or posedge reset) begin
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            moving <= 1'b0;
            dir <= 2'b00; // default up
            circle_centre_x <= SCREEN_CENTER_X;
            circle_centre_y <= SCREEN_CENTER_Y;
        end else begin
            if (btnU) begin moving <= 1'b1; dir <= 2'b00; end
            else if (btnD) begin moving <= 1'b1; dir <= 2'b01; end
            else if (btnL) begin moving <= 1'b1; dir <= 2'b10; end
            else if (btnR) begin moving <= 1'b1; dir <= 2'b11; end

            if (move_now && moving && can_move) begin // speed based on move_now
                circle_centre_x <= next_circle_x;
                circle_centre_y <= next_circle_y;
            end
            // else hold position at edge
        end
    end

endmodule

// identify pixels that are in the circle using eqn of circle: (x-cx)^2 + (y-cy)^2 <= r^2
module identify_circle(
    input [6:0] x, 
    input [6:0] y, 
    input [6:0] center_x,
    input [6:0] center_y,
    input [6:0] radius,
    output inside_circle
    );
    
    wire [7:0] dx;
    wire [7:0] dy;
    wire [17:0] distance_squared;
    wire [17:0] radius_squared;
    
    assign dx = (x > center_x) ? (x - center_x) : (center_x - x); // since can be left or right of center
    assign dy = (y > center_y) ? (y - center_y) : (center_y - y); // same above or below
    assign distance_squared = dx*dx + dy*dy;
    assign radius_squared = radius * radius;
    assign inside_circle = (distance_squared <= radius_squared) ? 1'b1 : 1'b0;

endmodule

// identify pixels on a hollow square boundary (four 3-px-thick bands)
module identify_square_boundary #(
    parameter TOP_LEFT_X = 4,
    parameter TOP_LEFT_Y = 40,
    parameter SIDE_LENGTH = 25,
    parameter LINE_THICKNESS = 3
 )(
    input [6:0] x,
    input [6:0] y,
    output inside_square_boundary
);
    parameter X0 = TOP_LEFT_X;
    parameter Y0 = TOP_LEFT_Y;
    parameter X1 = TOP_LEFT_X + SIDE_LENGTH - 1;
    parameter Y1 = TOP_LEFT_Y + SIDE_LENGTH - 1;
    parameter T  = LINE_THICKNESS;

    wire in_left = (x >= X0) && (x <= X0+T-1) && (y >= Y0) && (y <= Y1);
    wire in_right = (x >= X1-T+1) && (x <= X1) && (y >= Y0) && (y <= Y1);
    wire in_top = (y >= Y0) && (y <= Y0+T-1) && (x >= X0) && (x <= X1);
    wire in_bottom = (y >= Y1-T+1) && (y <= Y1) && (x >= X0) && (x <= X1);
    assign inside_square_boundary = in_left | in_right | in_top | in_bottom;
endmodule

// generic rectangular border detector (used for digit '0')
module identify_rect_border #(
    parameter TOP_LEFT_X = 0,
    parameter TOP_LEFT_Y = 0,
    parameter WIDTH = 8,
    parameter HEIGHT = 12,
    parameter THICKNESS = 3
)(
    input [6:0] x,
    input [6:0] y,
    output inside_rect_border
);
    parameter RX0 = TOP_LEFT_X;
    parameter RY0 = TOP_LEFT_Y;
    parameter RX1 = TOP_LEFT_X + WIDTH  - 1;
    parameter RY1 = TOP_LEFT_Y + HEIGHT - 1;
    parameter T = THICKNESS;

    wire in_left = (x >= RX0) && (x <= RX0+T-1) && (y >= RY0) && (y <= RY1);
    wire in_right = (x >= RX1-T+1) && (x <= RX1) && (y >= RY0) && (y <= RY1);
    wire in_top = (y >= RY0) && (y <= RY0+T-1) && (x >= RX0) && (x <= RX1);
    wire in_bottom = (y >= RY1-T+1) && (y <= RY1) && (x >= RX0) && (x <= RX1);
    assign inside_rect_border = in_left | in_right | in_top | in_bottom;
endmodule

// given next movement does it collide (wall and white square)
module get_next_check_collision #(
    parameter WIDTH = 96,
    parameter HEIGHT = 64,
    parameter SQUARE_X   = 4,
    parameter SQUARE_Y   = 40,
    parameter SQUARE_SIDE= 20,
    parameter LINE_THICKNESS   = 3
)(
    input [6:0] circle_x,
    input [6:0] circle_y,
    input [6:0] radius,
    input [1:0] dir,       // 00=U, 01=D, 10=L, 11=R
    output wire [6:0] next_cx,
    output wire [6:0] next_cy,
    output wire can_move
);
    // Apply 1-pixel step in the given direction
    assign next_cx = (dir == 2'b10) ? (circle_x - 7'd1) :
                     (dir == 2'b11) ? (circle_x + 7'd1) :
                                      circle_x;

    assign next_cy = (dir == 2'b00) ? (circle_y - 7'd1) :
                     (dir == 2'b01) ? (circle_y + 7'd1) :
                                      circle_y;

    // Stay fully on-screen: radius <= next_cx <= WIDTH-1-radius, likewise for y
    wire [6:0] max_circle_center_x = (WIDTH-1)  - radius;
    wire [6:0] max_circle_center_y = (HEIGHT-1) - radius;

    wire within_walls = (next_cx >= radius) && (next_cx <= max_circle_center_x) &&
                        (next_cy >= radius) && (next_cy <= max_circle_center_y);

    // Treat hollow square boundary as obstacle: AABB overlap with circle's bounding box
    // Circle AABB (clamped to screen)
    // wire [7:0] cx8 = {1'b0, next_cx};
    // wire [7:0] cy8 = {1'b0, next_cy};
    // wire [7:0] r8 = {1'b0, radius};
    // wire [7:0] cminx = (cx8 > r8) ? (cx8 - r8) : 8'd0;
    // wire [7:0] cminy = (cy8 > r8) ? (cy8 - r8) : 8'd0;
    // wire [7:0] cmaxx = cx8 + r8;
    // wire [7:0] cmaxy = cy8 + r8;

    // Four band rectangles
    parameter X0 = SQUARE_X;
    parameter Y0 = SQUARE_Y;
    parameter X1 = SQUARE_X + SQUARE_SIDE - 1;
    parameter Y1 = SQUARE_Y + SQUARE_SIDE - 1;
    parameter T = LINE_THICKNESS;

    // Precompute the band (currently a rectangle around the circle)
    // // Left band
    // wire [7:0] lb_x0 = X0[7:0];
    // wire [7:0] lb_x1 = X0+T-1;
    // wire [7:0] lb_y0 = Y0[7:0];
    // wire [7:0] lb_y1 = Y1[7:0];
    // // Right band
    // wire [7:0] rb_x0 = X1-T+1;
    // wire [7:0] rb_x1 = X1[7:0];
    // wire [7:0] rb_y0 = Y0[7:0];
    // wire [7:0] rb_y1 = Y1[7:0];
    // // Top band
    // wire [7:0] tb_x0 = X0[7:0];
    // wire [7:0] tb_x1 = X1[7:0];
    // wire [7:0] tb_y0 = Y0[7:0];
    // wire [7:0] tb_y1 = Y0+T-1;
    // // Bottom band
    // wire [7:0] bb_x0 = X0[7:0];
    // wire [7:0] bb_x1 = X1[7:0];
    // wire [7:0] bb_y0 = Y1-T+1;
    // wire [7:0] bb_y1 = Y1[7:0];

    // function automatic overlap(input [7:0] ax0, input [7:0] ay0, input [7:0] ax1, input [7:0] ay1,
    //                            input [7:0] bx0, input [7:0] by0, input [7:0] bx1, input [7:0] by1);
    //     overlap = (ax1 >= bx0) && (ax0 <= bx1) && (ay1 >= by0) && (ay0 <= by1);
    // endfunction

    // wire hit_left = overlap(cminx, cminy, cmaxx, cmaxy, lb_x0, lb_y0, lb_x1, lb_y1);
    // wire hit_right = overlap(cminx, cminy, cmaxx, cmaxy, rb_x0, rb_y0, rb_x1, rb_y1);
    // wire hit_top = overlap(cminx, cminy, cmaxx, cmaxy, tb_x0, tb_y0, tb_x1, tb_y1);
    // wire hit_bottom = overlap(cminx, cminy, cmaxx, cmaxy, bb_x0, bb_y0, bb_x1, bb_y1);
    // wire hits_square = hit_left | hit_right | hit_top | hit_bottom;

    // Four sample points on circle boundary
    wire [6:0] p_top_x = next_cx;
    wire [6:0] p_top_y = next_cy - radius;
    wire [6:0] p_bot_x = next_cx;
    wire [6:0] p_bot_y = next_cy + radius;
    wire [6:0] p_left_x = next_cx - radius;
    wire [6:0] p_left_y = next_cy;
    wire [6:0] p_right_x = next_cx + radius;
    wire [6:0] p_right_y = next_cy;

    // Point-in-band test (any of the 4 bands)
    function automatic point_hits_square(input [6:0] px, input [6:0] py);
        reg in_left, in_right, in_top, in_bottom;
        begin
            in_left = (px >= X0) && (px <= X0+T-1) && (py >= Y0) && (py <= Y1);
            in_right = (px >= X1-T+1) && (px <= X1) && (py >= Y0) && (py <= Y1);
            in_top = (py >= Y0) && (py <= Y0+T-1) && (px >= X0) && (px <= X1);
            in_bottom = (py >= Y1-T+1) && (py <= Y1) && (px >= X0) && (px <= X1);
            point_hits_square = in_left | in_right | in_top | in_bottom;
        end
    endfunction

        // Four-point collision: acceptable if small diagonal overlap occurs elsewhere
    wire hits_square =
          point_hits_square(p_top_x,   p_top_y)
        | point_hits_square(p_bot_x,   p_bot_y)
        | point_hits_square(p_left_x,  p_left_y)
        | point_hits_square(p_right_x, p_right_y);

    assign can_move = within_walls && !hits_square;

endmodule