`timescale 1ns / 1ps

// Draw a 9-pixel layered border around a rectangle: 3px black (outer), 3px white (middle), 3px black (inner).
// Parameters allow customizing position, size, and each layer thickness.
// in_fill is the boolean for whether a pixel is fully inside the box's border
module layered_box #(
    parameter integer TOP_LEFT_X    = 0,
    parameter integer TOP_LEFT_Y    = 0,
    parameter integer WIDTH         = 60,
    parameter integer HEIGHT        = 60,
    parameter integer OUTER_THICK   = 1,  // outer black
    parameter integer MID_THICK     = 1,  // white band
    parameter integer INNER_THICK   = 1   // inner black
)(
    input  wire [8:0] x,  // source X (0..309)
    input  wire [7:0] y,  // source Y (0..239)
    output wire        in_black_outer,
    output wire        in_white_mid,
    output wire        in_black_inner,
    output wire        in_fill,        // fully inside (content area, not border)
    output wire        in_any_border   // any of the 3 bands
);

    localparam integer X0 = TOP_LEFT_X;
    localparam integer Y0 = TOP_LEFT_Y;
    localparam integer X1 = TOP_LEFT_X + WIDTH  - 1;
    localparam integer Y1 = TOP_LEFT_Y + HEIGHT - 1;
    localparam integer T0 = OUTER_THICK;
    localparam integer T1 = MID_THICK;
    localparam integer T2 = INNER_THICK;
    localparam integer T_SUM = OUTER_THICK + MID_THICK + INNER_THICK;

    // Outer black band (adjacent to outermost edges)
    wire top_outer    = (y >= Y0)           && (y <= Y0 + T0 - 1) && (x >= X0)           && (x <= X1);
    wire bottom_outer = (y >= Y1 - T0 + 1)  && (y <= Y1)          && (x >= X0)           && (x <= X1);
    wire left_outer   = (x >= X0)           && (x <= X0 + T0 - 1) && (y >= Y0)           && (y <= Y1);
    wire right_outer  = (x >= X1 - T0 + 1)  && (x <= X1)          && (y >= Y0)           && (y <= Y1);
    assign in_black_outer = top_outer | bottom_outer | left_outer | right_outer;

    // Middle white band (after shrinking by OUTER_THICK)
    localparam integer X0_M = X0 + T0;
    localparam integer Y0_M = Y0 + T0;
    localparam integer X1_M = X1 - T0;
    localparam integer Y1_M = Y1 - T0;
    wire top_mid    = (y >= Y0_M)          && (y <= Y0_M + T1 - 1) && (x >= X0_M)         && (x <= X1_M);
    wire bottom_mid = (y >= Y1_M - T1 + 1) && (y <= Y1_M)          && (x >= X0_M)         && (x <= X1_M);
    wire left_mid   = (x >= X0_M)          && (x <= X0_M + T1 - 1) && (y >= Y0_M)         && (y <= Y1_M);
    wire right_mid  = (x >= X1_M - T1 + 1) && (x <= X1_M)          && (y >= Y0_M)         && (y <= Y1_M);
    assign in_white_mid = top_mid | bottom_mid | left_mid | right_mid;

    // Inner black band (after shrinking by OUTER_THICK + MID_THICK)
    localparam integer X0_I = X0 + T0 + T1;
    localparam integer Y0_I = Y0 + T0 + T1;
    localparam integer X1_I = X1 - (T0 + T1);
    localparam integer Y1_I = Y1 - (T0 + T1);
    wire top_inner    = (y >= Y0_I)          && (y <= Y0_I + T2 - 1) && (x >= X0_I)         && (x <= X1_I);
    wire bottom_inner = (y >= Y1_I - T2 + 1) && (y <= Y1_I)          && (x >= X0_I)         && (x <= X1_I);
    wire left_inner   = (x >= X0_I)          && (x <= X0_I + T2 - 1) && (y >= Y0_I)         && (y <= Y1_I);
    wire right_inner  = (x >= X1_I - T2 + 1) && (x <= X1_I)          && (y >= Y0_I)         && (y <= Y1_I);
    assign in_black_inner = top_inner | bottom_inner | left_inner | right_inner;

    // Fill (content area), fully inside after removing all borders
    localparam integer X0_F = X0 + T_SUM;
    localparam integer Y0_F = Y0 + T_SUM;
    localparam integer X1_F = X1 - T_SUM;
    localparam integer Y1_F = Y1 - T_SUM;
    assign in_fill = (x >= X0_F) && (x <= X1_F) && (y >= Y0_F) && (y <= Y1_F);

    assign in_any_border = in_black_outer | in_white_mid | in_black_inner;

endmodule
