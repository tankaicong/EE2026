`timescale 1ns / 1ps
// Info tab animation for CV settings
// Behavior
// - Open tab: top-left at (443,296), size 177x24. When clicked, a single pixel at (359,296) moves up to y=0 over ~1.5s.
// - Close tab: appears at (443,0), size 177x24, only after the pixel reaches y=0. When clicked, the pixel moves back down to y=296 over ~1.5s.
// - Info color: The moving pixel changes color based on 7 info clicks:
//   CAMERA (bottom CAM), GAUSS (movable), MEDIAN (movable), ERODE (either of the two), DILATE (either), BITMAP (bottom), UFDS (bottom).
//   Initial color is CYAN (CAMERA). Colors used: CAMERA=CYAN, GAUSS=BLUE, MEDIAN=GREEN, ERODE=RED, DILATE=YELLOW, BITMAP=WHITE, UFDS=MAGENTA.

module cv_settings_info_tab (
    input wire clk, // clk25
    input wire reset, // sync reset in clk domain
    input wire settings_active, // enable click processing when settings screen is active
    input wire [9:0] mouse_x, // VGA mouse X (for tab clicks)
    input wire [8:0] mouse_y, // VGA mouse Y (for tab clicks)
    input wire left_edge, // 1-cycle pulse on debounced left click
    // Pulses from overlay for bottom-row boxes
    // input wire cam_box_click,
    input wire bitmap_box_click,
    input wire ufds_box_click,
    // Pulses from drag-drop for movable boxes
    input wire gauss_click,
    input wire median_click,
    input wire erode_click,
    input wire dilate_click,
    output reg [9:0] pix_x, // moving pixel X (VGA coords)
    output reg [8:0] pix_y, // moving pixel Y (VGA coords)
    output reg [2:0] info_idx, // 0=CAMERA,1=GAUSS,2=MEDIAN,3=ERODE,4=DILATE,5=BITMAP,6=UFDS
    output reg [11:0] pix_rgb // moving pixel color (RGB444)
);

    // Tab rectangles
    localparam [9:0] OPEN_X = 10'd443;
    localparam [8:0] OPEN_Y = 9'd296;
    localparam [9:0] TAB_W = 10'd177;
    localparam [8:0] TAB_H = 9'd24;
    localparam [9:0] CLOSE_X = 10'd443;
    localparam [8:0] CLOSE_Y = 9'd0;

    // --- Colors (RGB444 BGR order) ---
    localparam [11:0] BLACK = 12'h000;
    localparam [11:0] WHITE = 12'hFFF;
    localparam [11:0] CYAN = 12'hFF0;
    localparam [11:0] BLUE = 12'hECA;
    localparam [11:0] GREEN = 12'h0F0;
    localparam [11:0] RED = 12'h00F;
    localparam [11:0] YELLOW = 12'h0FF;
    localparam [11:0] MAGENTA = 12'hF0F;

    // Info color index: 0=CAMERA,1=GAUSS,2=MEDIAN,3=ERODE,4=DILATE,5=BITMAP,6=UFDS
    // Default GAUSS
    // Map index to color
    // wire [11:0] info_color =
    //     // (info_idx == 3'd0) ? CYAN   :
    //     (info_idx == 3'd1) ? BLUE   :
    //     (info_idx == 3'd2) ? GREEN  :
    //     (info_idx == 3'd3) ? RED    :
    //     (info_idx == 3'd4) ? YELLOW :
    //     (info_idx == 3'd5) ? WHITE  :
    //                           MAGENTA;

    // Top-Left pixel positions
    localparam [9:0] PIX_X = 10'd359; // fixed X
    localparam [8:0] PIX_Y_INIT = 9'd296; // depends on tab height
    localparam [8:0] PIX_Y_TOP = 9'd1;

    // Movement timing: 1.5s at 25 MHz
    localparam integer CLK_HZ = 25000000;
    localparam integer MOVE_TIME_CY = 37500000; // cycles
    localparam integer DISTANCE = 296; // pixels to move (296 -> 0)
    // Integer step cycles approximation: 37500000 / 296 ≈ 126689
    localparam integer STEP_CYCLES = 126689;
    // FSM states
    localparam [1:0] S_CLOSED = 2'd0; // open tab visible at (443,296), pixel at y=296
    localparam [1:0] S_OPENING = 2'd1; // animating upwards to y=0
    localparam [1:0] S_OPEN = 2'd2; // close tab visible at (443,0), pixel at y=0
    localparam [1:0] S_CLOSING = 2'd3; // animating downwards to y=296

    reg [1:0] state = S_CLOSED;

    // Per-pixel step timer
    reg [31:0] step_cnt = 32'd0;

    // Click hit-tests (include border)
    wire open_tab_click = settings_active && (state == S_CLOSED) && left_edge &&
                            (mouse_x >= OPEN_X) && (mouse_x < (OPEN_X + TAB_W)) &&
                            (mouse_y >= OPEN_Y) && (mouse_y < (OPEN_Y + TAB_H));
    wire close_tab_click = settings_active && (state == S_OPEN) && left_edge &&
                            (mouse_x >= CLOSE_X) && (mouse_x < (CLOSE_X + TAB_W)) &&
                            (mouse_y >= CLOSE_Y) && (mouse_y < (CLOSE_Y + TAB_H));

    // Pixel X is fixed
    always @(posedge clk) begin
        if (reset) pix_x <= PIX_X; else pix_x <= PIX_X;
    end

    // State and vertical position update
    always @(posedge clk) begin
        if (reset) begin
            state <= S_CLOSED;
            pix_y <= PIX_Y_INIT;
            step_cnt <= 0;
            pix_rgb <= BLUE; // initial GAUSS color
            info_idx <= 3'd1; // initial GAUSS
        end else begin
            // Info clicks: update index, then drive color
            if (settings_active) begin
                if (gauss_click) info_idx <= 3'd1;
                else if (median_click) info_idx <= 3'd2;
                else if (erode_click) info_idx <= 3'd3;
                else if (dilate_click) info_idx <= 3'd4;
                // else if (cam_box_click) info_idx <= 3'd0;
                else if (bitmap_box_click) info_idx <= 3'd5;
                else if (ufds_box_click) info_idx <= 3'd6;
            end
            // pix_rgb <= info_color;
            case (state)
                S_CLOSED: begin
                    step_cnt <= 0;
                    pix_y <= PIX_Y_INIT;
                    if (open_tab_click) begin
                        state <= S_OPENING;
                        step_cnt <= 0;
                    end
                end
                S_OPENING: begin
                    // Move up by 1 pixel every STEP_CYCLES cycles
                    if (step_cnt >= STEP_CYCLES - 1) begin
                        step_cnt <= 0;
                        if (pix_y > PIX_Y_TOP) begin
                            pix_y <= pix_y - 1;
                        end
                        if (pix_y == PIX_Y_TOP) begin
                            state <= S_OPEN;
                        end
                    end else begin
                        step_cnt <= step_cnt + 1;
                    end
                end
                S_OPEN: begin
                    step_cnt <= 0;
                    pix_y <= PIX_Y_TOP;
                    if (close_tab_click) begin
                        state <= S_CLOSING;
                        step_cnt <= 0;
                    end
                end
                S_CLOSING: begin
                    // Move down by 1 pixel every STEP_CYCLES cycles
                    if (step_cnt >= STEP_CYCLES - 1) begin
                        step_cnt <= 0;
                        if (pix_y < PIX_Y_INIT) begin
                            pix_y <= pix_y + 1;
                        end
                        if (pix_y == PIX_Y_INIT) begin
                            state <= S_CLOSED;
                        end
                    end else begin
                        step_cnt <= step_cnt + 1;
                    end
                end
                default: begin
                    state <= S_CLOSED;
                    pix_y <= PIX_Y_INIT;
                    step_cnt <= 0;
                end
            endcase
        end
    end

endmodule
