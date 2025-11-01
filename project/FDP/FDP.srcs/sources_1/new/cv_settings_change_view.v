`timescale 1ns / 1ps
// Change-view selector for CV settings bottom row
// Provides 4 mutually-exclusive toggle boxes positioned by caller.
// Default selection is the box after CAM (index 0). Outputs 2-bit code per mapping:
// idx0 -> 2'b00, idx1 -> 2'b01, idx2 -> 2'b11, idx3 -> 2'b10

module cv_settings_change_view (
    input  wire        clk,
    input  wire        reset,            // sync reset (clk domain)
    input  wire        settings_active,  // enable hit-testing when active
    input  wire [9:0]  mouse_x,          // VGA coords
    input  wire [8:0]  mouse_y,
    input  wire        left_edge,        // debounced rising edge of left click
    // Four rectangles: (x, y, w, h)
    input  wire [9:0]  x0, input wire [8:0] y0, input wire [9:0] w0, input wire [8:0] h0,
    input  wire [9:0]  x1, input wire [8:0] y1, input wire [9:0] w1, input wire [8:0] h1,
    input  wire [9:0]  x2, input wire [8:0] y2, input wire [9:0] w2, input wire [8:0] h2,
    input  wire [9:0]  x3, input wire [8:0] y3, input wire [9:0] w3, input wire [8:0] h3,
    // Outputs
    output reg  [3:0]  toggled_flags,    // one-hot, only selected bit is 1
    output reg  [1:0]  final_out          // encoded per mapping
);

    // Selection index (0..3); default to the box after CAM (0)
    reg [1:0] sel_idx;

    // Hit tests (include border and interior)
    wire in0 = (mouse_x >= x0) && (mouse_x < (x0 + w0)) && (mouse_y >= y0) && (mouse_y < (y0 + h0));
    wire in1 = (mouse_x >= x1) && (mouse_x < (x1 + w1)) && (mouse_y >= y1) && (mouse_y < (y1 + h1));
    wire in2 = (mouse_x >= x2) && (mouse_x < (x2 + w2)) && (mouse_y >= y2) && (mouse_y < (y2 + h2));
    wire in3 = (mouse_x >= x3) && (mouse_x < (x3 + w3)) && (mouse_y >= y3) && (mouse_y < (y3 + h3));

    // Selection update
    always @(posedge clk) begin
        if (reset) begin
            sel_idx <= 2'd0; // default: after CAM
        end else if (settings_active && left_edge) begin
            // Priority if overlapping (should not happen), choose leftmost in order 0..3
            if (in0) sel_idx <= 2'd0;
            else if (in1) sel_idx <= 2'd1;
            else if (in2) sel_idx <= 2'd2;
            else if (in3) sel_idx <= 2'd3;
        end
    end

    // Drive flags and encoded selection; cannot untoggle (always one selected)
    always @(*) begin
        toggled_flags = 4'b0000;
        case (sel_idx)
            2'd0: begin toggled_flags = 4'b0001; final_out = 2'b00; end // after CAM
            2'd1: begin toggled_flags = 4'b0010; final_out = 2'b01; end // after PRE
            2'd2: begin toggled_flags = 4'b0100; final_out = 2'b11; end // after BITMAP
            default: begin toggled_flags = 4'b1000; final_out = 2'b10; end // after MORPH
        endcase
    end

endmodule
