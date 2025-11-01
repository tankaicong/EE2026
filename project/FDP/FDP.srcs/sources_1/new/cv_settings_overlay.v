`timescale 1ns / 1ps

// CV settings overlay in VGA (640x480) coordinates
// Draws two drop zones (borders) and six filled boxes:
//  - Preprocessing: GAUSS, MEDIAN (cyan), size 72x34
//  - Morphology: ERODE, DILATE (magenta), size 40x34

module cv_settings_overlay (
    input  wire        settings_active,
    input  wire [9:0]  px,        // VGA x (0..639)
    input  wire [8:0]  py,        // VGA y (0..479)

    // Drop zones in VGA coords
    input  wire [9:0]  pre_x,
    input  wire [8:0]  pre_y,
    input  wire [9:0]  pre_w,     // typically 148
    input  wire [8:0]  pre_h,     // typically 34
    input  wire [9:0]  morph_x,
    input  wire [8:0]  morph_y,
    input  wire [9:0]  morph_w,   // typically 166
    input  wire [8:0]  morph_h,   // typically 34

    // Box top-left positions in VGA coords
    input  wire [59:0] boxes_x,  // 6 x 10-bit
    input  wire [53:0] boxes_y,  // 6 x 9-bit

    // Index of the box to draw on top (foreground). 0..5; if out-of-range, default order applies.
    input  wire [2:0]  front_idx,

    // Outputs
    output reg         overlay_en,
    output reg [11:0]  overlay_rgb
);

    // Unpack for overlay drawing
    wire [9:0] x0 = boxes_x[9:0];
    wire [9:0] x1 = boxes_x[19:10];
    wire [9:0] x2 = boxes_x[29:20];
    wire [9:0] x3 = boxes_x[39:30];
    wire [9:0] x4 = boxes_x[49:40];
    wire [9:0] x5 = boxes_x[59:50];
    wire [8:0] y0 = boxes_y[8:0];
    wire [8:0] y1 = boxes_y[17:9];
    wire [8:0] y2 = boxes_y[26:18];
    wire [8:0] y3 = boxes_y[35:27];
    wire [8:0] y4 = boxes_y[44:36];
    wire [8:0] y5 = boxes_y[53:45];

    // Colors (RGB444)
    localparam [11:0] BLACK   = 12'h000;
    localparam [11:0] WHITE   = 12'hFFF;
    localparam [11:0] GREY    = 12'h888;
    localparam [11:0] CYAN    = 12'hFF0;
    localparam [11:0] MAGENTA = 12'hF0F;
    localparam [11:0] YELLOW  = 12'h0FF;

    // Box sizes in VGA
    localparam [9:0] W_PRE = 10'd72;
    localparam [9:0] W_MOR = 10'd40;
    localparam [8:0] H_ALL = 9'd34;

    // Drop zone borders (1px)
    wire in_pre_border;
    wire in_morph_border;
    assign in_pre_border   = ((py == pre_y) || (py == (pre_y + pre_h - 1))) ? ((px >= pre_x) && (px < (pre_x + pre_w))) :
                             ((px == pre_x) || (px == (pre_x + pre_w - 1))) ? ((py >= pre_y) && (py < (pre_y + pre_h))) : 1'b0;
    assign in_morph_border = ((py == morph_y) || (py == (morph_y + morph_h - 1))) ? ((px >= morph_x) && (px < (morph_x + morph_w))) :
                             ((px == morph_x) || (px == (morph_x + morph_w - 1))) ? ((py >= morph_y) && (py < (morph_y + morph_h))) : 1'b0;

    // Box interior checks
    wire in0 = (px >= x0) && (px < (x0 + W_PRE)) && (py >= y0) && (py < (y0 + H_ALL)); // GAUSS
    wire in1 = (px >= x1) && (px < (x1 + W_PRE)) && (py >= y1) && (py < (y1 + H_ALL)); // MEDIAN
    wire in2 = (px >= x2) && (px < (x2 + W_MOR)) && (py >= y2) && (py < (y2 + H_ALL)); // ERODE A
    wire in3 = (px >= x3) && (px < (x3 + W_MOR)) && (py >= y3) && (py < (y3 + H_ALL)); // ERODE B
    wire in4 = (px >= x4) && (px < (x4 + W_MOR)) && (py >= y4) && (py < (y4 + H_ALL)); // DILATE A
    wire in5 = (px >= x5) && (px < (x5 + W_MOR)) && (py >= y5) && (py < (y5 + H_ALL)); // DILATE B

    always @(*) begin
        overlay_en  = 1'b0;
        overlay_rgb = 12'h000;

        if (settings_active) begin
            // --- Guide lines ---
            // Horizontal black lines at y = 324 and y = 395 (full width)
            if ((py == 9'd324) || (py == 9'd395)) begin
                overlay_en  = 1'b1; overlay_rgb = BLACK;
            end
            // Vertical black lines downwards from (93,395), (262,395), (378,395), (548,395)
            if ((py >= 9'd395) && (px == 10'd93 || px == 10'd262 || px == 10'd378 || px == 10'd548)) begin
                overlay_en  = 1'b1; overlay_rgb = BLACK;
            end

            // Borders first
            if (in_pre_border) begin
                overlay_en  = 1'b1; overlay_rgb = GREY;
            end else if (in_morph_border) begin
                overlay_en  = 1'b1; overlay_rgb = GREY;
            end

            // Filled movable boxes override border. Draw the selected front_idx last for foreground.
            // First, if current pixel lies in the front_idx box, draw it immediately.
            if ((front_idx == 3'd0 && in0) || (front_idx == 3'd1 && in1) || (front_idx == 3'd2 && in2)
                || (front_idx == 3'd3 && in3) || (front_idx == 3'd4 && in4) || (front_idx == 3'd5 && in5)) begin
                overlay_en  = 1'b1;
                case (front_idx)
                    3'd0: overlay_rgb = BLACK;
                    3'd1: overlay_rgb = CYAN;
                    3'd2: overlay_rgb = MAGENTA;
                    3'd3: overlay_rgb = GREY;
                    3'd4: overlay_rgb = WHITE;
                    3'd5: overlay_rgb = YELLOW;
                    default: overlay_rgb = WHITE;
                endcase
            end else begin
                // Otherwise, draw in default priority order skipping the front_idx
                if ((front_idx != 3'd0) && in0) begin overlay_en = 1'b1; overlay_rgb = BLACK; end
                else if ((front_idx != 3'd1) && in1) begin overlay_en = 1'b1; overlay_rgb = CYAN; end
                else if ((front_idx != 3'd2) && in2) begin overlay_en = 1'b1; overlay_rgb = MAGENTA; end
                else if ((front_idx != 3'd3) && in3) begin overlay_en = 1'b1; overlay_rgb = GREY; end
                else if ((front_idx != 3'd4) && in4) begin overlay_en = 1'b1; overlay_rgb = WHITE; end
                else if ((front_idx != 3'd5) && in5) begin overlay_en = 1'b1; overlay_rgb = YELLOW; end
            end
        end
    end

endmodule
