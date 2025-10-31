`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Reference for creating pseudo randomised data using LFSR in verilog: 
// https://nandland.com/lfsr-linear-feedback-shift-register/
// https://www.geeksforgeeks.org/digital-logic/linear-feedback-shift-registers-lfsr/
// This module generates a randomised canvas with a mosaic pattern and random shapes
// (rectangles and circles) using a 16-bit LFSR-like pseudo-random number generator.
//////////////////////////////////////////////////////////////////////////////////

module Randomised_Canvas(
    input  wire        clk,           // pixel clock (clk25)
    input  wire        reset,         // sync reset in clk domain (e.g., vga_reset)
    input  wire        btnC,          // push button for reseed (async to clk)
    input  wire [9:0]  frame_x,       // VGA x (0..639)
    input  wire [9:0]  frame_y,       // VGA y (0..479)
    input  wire        in_roi,        // Region of interest flag
    input  wire        active_area,   // VGA active area flag
    output reg  [11:0] pixel_out      // RGB444 pixel output
);

    // ROI: same as Top.v definition for UFDS (x in [10,319], y in [0,239]) on source grid (divide by 2)
    wire [9:0] fx = frame_x;
    wire [9:0] fy = frame_y;
    wire [8:0] src_x = fx[9:1] - 10; // 0..309
    wire [7:0] src_y = fy[9:1];      // 0..239

    // Synchronize btnC into this clk domain and detect rising edge
    reg [2:0] btnC_sync = 3'b000;
    always @(posedge clk) begin
        btnC_sync <= {btnC_sync[1:0], btnC};
    end
    wire btnC_rise = btnC_sync[0] & ~btnC_sync[1];

    // 16-bit LFSR-like seed updated on btn press; stable between presses
    reg  [15:0] rand_seed = 16'hA5C3;
    wire        lfsr_fb   = rand_seed[15] ^ rand_seed[13] ^ rand_seed[12] ^ rand_seed[10];
    always @(posedge clk) begin
        if (reset) begin
            rand_seed <= 16'hA5C3;
        end else if (btnC_rise) begin
            rand_seed <= {rand_seed[14:0], lfsr_fb} ^ 16'h5A3C;
        end
    end

    // Mosaic color by 16x16 tile
    wire [4:0] tile_x = src_x[8:4]; // 0..19
    wire [3:0] tile_y = src_y[7:4]; // 0..14
    wire [15:0] mix_val = ({rand_seed[7:0], rand_seed[15:8]} ^ {tile_x, tile_y, 7'd0}) + {rand_seed[10:0], tile_x};
    wire [11:0] mosaic_color = {mix_val[11:8], mix_val[7:4], mix_val[3:0]};
    // ~1/64 tiles become white for detection targets
    wire [15:0] tile_hash = mix_val ^ {1'b0, rand_seed[3:0], tile_x, tile_y, 2'b00};
    wire        tile_is_white = (tile_hash[5:0] == 6'b000000);

    // Random shapes (4 shapes, each rect or circle) derived from rand_seed
    wire [15:0] seed0 = rand_seed ^ 16'h1357;
    wire [15:0] seed1 = {rand_seed[7:0], rand_seed[15:8]} ^ 16'h2468;
    wire [15:0] seed2 = (rand_seed << 3) ^ 16'h9B1E;
    wire [15:0] seed3 = (rand_seed << 1) ^ (rand_seed >> 2) ^ 16'hC0DE;

    // Rectangle sizes (min 12)
    wire [8:0] r0_w = 9'd12 + {3'b0, seed0[5:0]};
    wire [7:0] r0_h = 8'd12 + {2'b0, seed0[11:6]};
    wire [8:0] r1_w = 9'd12 + {3'b0, seed1[5:0]};
    wire [7:0] r1_h = 8'd12 + {2'b0, seed1[11:6]};
    wire [8:0] r2_w = 9'd12 + {3'b0, seed2[5:0]};
    wire [7:0] r2_h = 8'd12 + {2'b0, seed2[11:6]};
    wire [8:0] r3_w = 9'd12 + {3'b0, seed3[5:0]};
    wire [7:0] r3_h = 8'd12 + {2'b0, seed3[11:6]};

    // Raw positions
    wire [8:0] r0_x_raw = {1'b0, seed0[8:0]};
    wire [7:0] r0_y_raw = seed0[15:8];
    wire [8:0] r1_x_raw = {1'b0, seed1[8:0]};
    wire [7:0] r1_y_raw = seed1[15:8];
    wire [8:0] r2_x_raw = {1'b0, seed2[8:0]};
    wire [7:0] r2_y_raw = seed2[15:8];
    wire [8:0] r3_x_raw = {1'b0, seed3[8:0]};
    wire [7:0] r3_y_raw = seed3[15:8];

    // Clamp to ROI (310x240)
    wire [8:0] r0_x = (r0_x_raw > (9'd309 - r0_w)) ? (9'd309 - r0_w) : r0_x_raw;
    wire [7:0] r0_y = (r0_y_raw > (8'd239 - r0_h)) ? (8'd239 - r0_h) : r0_y_raw;
    wire [8:0] r1_x = (r1_x_raw > (9'd309 - r1_w)) ? (9'd309 - r1_w) : r1_x_raw;
    wire [7:0] r1_y = (r1_y_raw > (8'd239 - r1_h)) ? (8'd239 - r1_h) : r1_y_raw;
    wire [8:0] r2_x = (r2_x_raw > (9'd309 - r2_w)) ? (9'd309 - r2_w) : r2_x_raw;
    wire [7:0] r2_y = (r2_y_raw > (8'd239 - r2_h)) ? (8'd239 - r2_h) : r2_y_raw;
    wire [8:0] r3_x = (r3_x_raw > (9'd309 - r3_w)) ? (9'd309 - r3_w) : r3_x_raw;
    wire [7:0] r3_y = (r3_y_raw > (8'd239 - r3_h)) ? (8'd239 - r3_h) : r3_y_raw;

    // Circles: radius in [6..30] and clamped centers
    wire [5:0] c0_r = 6'd6 + seed0[5:0];
    wire [5:0] c1_r = 6'd6 + seed1[5:0];
    wire [5:0] c2_r = 6'd6 + seed2[5:0];
    wire [5:0] c3_r = 6'd6 + seed3[5:0];
    wire [8:0] c0_cx = (r0_x_raw > (9'd309 - {3'b000, c0_r})) ? (9'd309 - {3'b000, c0_r}) : r0_x_raw;
    wire [7:0] c0_cy = (r0_y_raw > (8'd239 - {2'b00, c0_r})) ? (8'd239 - {2'b00, c0_r}) : r0_y_raw;
    wire [8:0] c1_cx = (r1_x_raw > (9'd309 - {3'b000, c1_r})) ? (9'd309 - {3'b000, c1_r}) : r1_x_raw;
    wire [7:0] c1_cy = (r1_y_raw > (8'd239 - {2'b00, c1_r})) ? (8'd239 - {2'b00, c1_r}) : r1_y_raw;
    wire [8:0] c2_cx = (r2_x_raw > (9'd309 - {3'b000, c2_r})) ? (9'd309 - {3'b000, c2_r}) : r2_x_raw;
    wire [7:0] c2_cy = (r2_y_raw > (8'd239 - {2'b00, c2_r})) ? (8'd239 - {2'b00, c2_r}) : r2_y_raw;
    wire [8:0] c3_cx = (r3_x_raw > (9'd309 - {3'b000, c3_r})) ? (9'd309 - {3'b000, c3_r}) : r3_x_raw;
    wire [7:0] c3_cy = (r3_y_raw > (8'd239 - {2'b00, c3_r})) ? (8'd239 - {2'b00, c3_r}) : r3_y_raw;

    // Type selection: 0=rect, 1=circle
    wire sh0_circle = seed0[0];
    wire sh1_circle = seed1[0];
    wire sh2_circle = seed2[0];
    wire sh3_circle = seed3[0];

    // Colors (some forced white)
    wire [11:0] sh0_color = (seed0[1] & seed0[2]) ? 12'hFFF : {seed0[11:8], seed0[7:4], seed0[3:0]};
    wire [11:0] sh1_color = (seed1[1] & seed1[2]) ? 12'hFFF : {seed1[11:8], seed1[7:4], seed1[3:0]};
    wire [11:0] sh2_color = (seed2[1] & seed2[2]) ? 12'hFFF : {seed2[11:8], seed2[7:4], seed2[3:0]};
    wire [11:0] sh3_color = (seed3[1] & seed3[2]) ? 12'hFFF : {seed3[11:8], seed3[7:4], seed3[3:0]};

    // Point-in-rectangle tests
    wire sh0_in_rect = (src_x >= r0_x) && (src_x < r0_x + r0_w) && (src_y >= r0_y) && (src_y < r0_y + r0_h);
    wire sh1_in_rect = (src_x >= r1_x) && (src_x < r1_x + r1_w) && (src_y >= r1_y) && (src_y < r1_y + r1_h);
    wire sh2_in_rect = (src_x >= r2_x) && (src_x < r2_x + r2_w) && (src_y >= r2_y) && (src_y < r2_y + r2_h);
    wire sh3_in_rect = (src_x >= r3_x) && (src_x < r3_x + r3_w) && (src_y >= r3_y) && (src_y < r3_y + r3_h);

    // Point-in-circle tests using squared distance
    wire [9:0] dx0 = (src_x >= c0_cx) ? (src_x - c0_cx) : (c0_cx - src_x);
    wire [8:0] dy0 = (src_y >= c0_cy) ? (src_y - c0_cy) : (c0_cy - src_y);
    wire [18:0] d2_0 = dx0*dx0 + {10'd0, dy0}*{10'd0, dy0};
    wire [11:0] r2_0 = {6'd0, c0_r} * {6'd0, c0_r};
    wire sh0_in_circ = (d2_0 <= {7'd0, r2_0});

    wire [9:0] dx1 = (src_x >= c1_cx) ? (src_x - c1_cx) : (c1_cx - src_x);
    wire [8:0] dy1 = (src_y >= c1_cy) ? (src_y - c1_cy) : (c1_cy - src_y);
    wire [18:0] d2_1 = dx1*dx1 + {10'd0, dy1}*{10'd0, dy1};
    wire [11:0] r2_1 = {6'd0, c1_r} * {6'd0, c1_r};
    wire sh1_in_circ = (d2_1 <= {7'd0, r2_1});

    wire [9:0] dx2 = (src_x >= c2_cx) ? (src_x - c2_cx) : (c2_cx - src_x);
    wire [8:0] dy2 = (src_y >= c2_cy) ? (src_y - c2_cy) : (c2_cy - src_y);
    wire [18:0] d2_2 = dx2*dx2 + {10'd0, dy2}*{10'd0, dy2};
    wire [11:0] r2_2 = {6'd0, c2_r} * {6'd0, c2_r};
    wire sh2_in_circ = (d2_2 <= {7'd0, r2_2});

    wire [9:0] dx3 = (src_x >= c3_cx) ? (src_x - c3_cx) : (c3_cx - src_x);
    wire [8:0] dy3 = (src_y >= c3_cy) ? (src_y - c3_cy) : (c3_cy - src_y);
    wire [18:0] d2_3 = dx3*dx3 + {10'd0, dy3}*{10'd0, dy3};
    wire [11:0] r2_3 = {6'd0, c3_r} * {6'd0, c3_r};
    wire sh3_in_circ = (d2_3 <= {7'd0, r2_3});

    // Combined shape hits
    wire sh0_hit = sh0_circle ? sh0_in_circ : sh0_in_rect;
    wire sh1_hit = sh1_circle ? sh1_in_circ : sh1_in_rect;
    wire sh2_hit = sh2_circle ? sh2_in_circ : sh2_in_rect;
    wire sh3_hit = sh3_circle ? sh3_in_circ : sh3_in_rect;

    always @(posedge clk) begin
        if (reset) begin
            pixel_out <= 12'h000;
        end else if (in_roi) begin
            // Priority: shapes over white tiles over mosaic
            if (sh0_hit) pixel_out <= sh0_color;
            else if (sh1_hit) pixel_out <= sh1_color;
            else if (sh2_hit) pixel_out <= sh2_color;
            else if (sh3_hit) pixel_out <= sh3_color;
            else pixel_out <= (tile_is_white ? 12'hFFF : mosaic_color);
        end else begin
            pixel_out <= 12'h000;
        end
    end

endmodule

