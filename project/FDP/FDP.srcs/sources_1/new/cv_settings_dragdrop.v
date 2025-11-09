`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////////////////////////
// CV Settings Drag & Drop manager
// This settings is how users learn about CV. it allows users to configure the image processing pipeline. 
// The process are encapsulated as: raw camera -> preprocessing (gaussian blur, median filter or both) -> 
//                                  threshholding into a bitmap -> morphology (erode, dilate, each can be done twice, 
//                                  and can be done in any order) -> UFDS (object detection).
//
// Configuring what happens at preprocessing and what happens at morphology happens through GUI drag and drop style
// - 6 movable boxes (2 preprocessing, 4 morphology)
// - There are two drop boxes, one for preprocessing only and another for morphology.
// - Handles click-drag, drop, snap of boxes, hover flags
// - Computes placement order per drop zone (based on left to right)
// - Outputs two concatenated top-left positions by x and y (boxes_x, boxes_y)
// - Outputs two concatenated order vectors for morphology and preprocessing (morph_order_vector, pre_order_vector)
//
// When the user hovers on one of the movable boxes, there should be a wire that registers the mouse is currently 
// over the box. When left click, the box should start moving on the screen. When the user releases the left click, 
// check if the movable box's center pixel is in the drop box. If it is, the movable box will snap right into the drop box, 
// but if it is not, it will snap back to its initial position. Preprocessing movable boxes can only be placed in the preprocessing drop box, 
// so even if they are placed in morphology drop box, it will snap back to its initial position, same for those for morphology. 
//
// For placement of these movable boxes in the drop boxes, whichever boxes that are placed should be always centralised 
// and placed apart nicely in a horizontal fashion within the drop boxes. The order also matters, so gaussian blur can either be before 
// or after median filter if both are placed in the box, and this order must be recorded. Same for the 2 erode and 2 dilates, it can be erode only, 
// or erode dilate, or even dilate dilate erode if the user wishes.
//
// - All internal logic uses VGA coords (x: 0..639, y: 0..479)
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////

module cv_settings_dragdrop (
    input wire clk, // use clk25 from VGA domain
    input wire reset, // sync reset (vga_reset)
    input wire settings_active, // 1 when settings UI is visible (S_CV_SETTINGS)

    input wire [9:0] mouse_x, // 0..639
    input wire [8:0] mouse_y, // 0..479
    input wire mouse_left,           // debounced level
    input wire mouse_left_edge,      // debounced rising edge (press)
    input wire mouse_left_fall,      // debounced falling edge (release)

    // drop boxes
    input wire [9:0] pre_x, // top-left X
    input wire [8:0] pre_y, // top-left Y
    input wire [9:0] pre_w, // width
    input wire [8:0] pre_h, // height
    input wire [9:0] morph_x, // top-left X 
    input wire [8:0] morph_y, // top-left Y 
    input wire [9:0] morph_w, // width
    input wire [8:0] morph_h, // height

    // Scroll wheel pulses: up = set to ERODE, down = set to DILATE
    input wire scroll_up,
    input wire scroll_down,

    // concatenated top-left positions (send to BRAM)
    output wire [59:0] boxes_x, // 6 x 10 bit, {box5..box0}
    output wire [53:0] boxes_y, // 6 x 9 bit, {box5..box0}
    output wire [59:0] boxes_x_test,
    output wire [53:0] boxes_y_test,
    output wire [7:0] rtest, // for testing,
    output wire [11:0] box_order_vector,
    output wire [3:0] placed_morph_vector,
    output wire [3:0] hover_vector,

    // hover flags: 1 when mouse is currently over the box (for educational box to pop out)
    // output wire [5:0] hover, // box0..box5

    // recorded orders for morphology: up to 4 steps, 2-bit code per step
    output reg [2:0] morph_count,
    // 01 = ERODE, 10 = DILATE
    // output reg [1:0] morph_order0,
    // output reg [1:0] morph_order1,
    // output reg [1:0] morph_order2,
    // output reg [1:0] morph_order3,

    // also expose how many pre boxes are placed and their chronological order
    // output reg [1:0] pre_count,
    // 01 = GAUSS, 10 = MEDIAN
    // output reg [1:0] pre_order0,
    // output reg [1:0] pre_order1,
    // concatenated order outputs (leftmost box in LSB, rightmost in MSB)
    // output wire [7:0] morph_order_vector, // [1:0]=leftmost, [7:6]=rightmost
    output wire [3:0] morph_vector,
    output wire [3:0] box_morph_vector,
    output wire [3:0] pre_order_vector, // [1:0]=leftmost, [3:2]=rightmost
    // New: 4-bit morphology vector by left-to-right order. 1=DILATE, 0=ERODE or not placed
    
    // z-order control: index of box to render on top (foreground)
    output reg  [2:0] front_idx,
    output reg [9:0] front_idx_box_x,
    output reg [8:0] front_idx_box_y,
    // debug/telemetry (optional): expose dragging and drop reasons
    // output wire       dragging_o,
    // output reg  [1:0] drop_reason, // 1=fall-edge, 2=sustain-low (bitwise)
    // One-cycle click pulses for info categories (derived from hover and left_edge)
    output wire       gauss_click,
    output wire       median_click,
    output wire       erode_click,
    output wire       dilate_click
    // output wire hov2, hov3, hov4, hov5
);

    assign rtest = {r2, r3, r4, r5};
    assign placed_morph_vector = {placed5_morph, placed4_morph, placed3_morph, placed2_morph};
    assign hover_vector = {hov5, hov4, hov3, hov2};

    reg [1:0] pre_order0, pre_order1;
    reg [1:0] morph_order0, morph_order1, morph_order2, morph_order3;

    // --------------- Box definitions ----------------
    // preprocessing boxes (cyan): GAUSS, MEDIAN (72x34)
    localparam [9:0] W_PRE = 10'd72;
    localparam [8:0] H_ALL = 9'd34; // all boxes uniform height 34

    // ,orphology boxes (magenta): ERODE/DILATE (40x34)
    localparam [9:0] W_MOR = 10'd40;

    // initial positions: (320,352),(394,352),(468,352),(510,352),(552,352),(594,352)
    localparam [9:0] X0_INIT = 10'd320;
    localparam [9:0] X1_INIT = 10'd394;
    localparam [9:0] X2_INIT = 10'd468;
    localparam [9:0] X3_INIT = 10'd510;
    localparam [9:0] X4_INIT = 10'd552;
    localparam [9:0] X5_INIT = 10'd594;
    localparam [8:0] Y_INIT = 9'd352;

    // box types
    localparam [2:0] T_GAUSS = 3'd1;
    localparam [2:0] T_MEDIAN = 3'd2;
    localparam [2:0] T_ERODE = 3'd3;
    localparam [2:0] T_DILATE = 3'd4;

    // registers for current top-left positions
    // x0 is box0 (GAUSS), x1 is box1 (MEDIAN), x2 is box2 (ERODE A), x3 is box3 (ERODE B), x4 is box4 (DILATE A), x5 is box5 (DILATE B)
    reg [9:0] x0, x1, x2, x3, x4, x5;
    reg [8:0] y0, y1, y2, y3, y4, y5;

    // Dynamic type flags for the 4 morphology boxes (hover + scroll to toggle)
    // is_erodeX == 1 means this box is an ERODE step; 0 means DILATE.
    reg is_erode2, is_erode3, is_erode4, is_erode5;
    initial begin
        is_erode2 = 1'b1; // box2 starts as ERODE
        is_erode3 = 1'b1; // box3 starts as ERODE
        is_erode4 = 1'b0; // box4 starts as DILATE
        is_erode5 = 1'b0; // box5 starts as DILATE
    end

    // Flags: placed into drop boxes
    reg placed0_pre, placed1_pre; // GAUSS, MEDIAN
    reg placed2_morph, placed3_morph; // ERODE A, ERODE B
    reg placed4_morph, placed5_morph; // DILATE A, DILATE B

    // Dragging state
    reg dragging;
    reg [2:0] drag_idx; // for dragging of each state FSM
    reg left_q; // retained for compatibility (not primary trigger anymore)
    // Drag release filter: require continuous low for a short window before treating as a drop
    reg [21:0] drag_rel_cnt; // ~ up to 80ms at 25MHz for 2_000_000
    localparam [21:0] DRAG_RELEASE_TH = 22'd2000000; // 80 ms sustained-low required to drop

    // Local helpers for left-to-right ordering
    reg [9:0] ax, bx, cx, dx; // sortable x positions for morph boxes 2..5
    reg [1:0] ac, bc, cc, dc; // corresponding codes (01=ERODE, 10=DILATE)
    reg [9:0] tmpx; reg [1:0] tmpc; // swap temps

    // hover stuff
    wire hov0 = (mouse_x >= x0) && (mouse_x < (x0 + W_PRE)) && (mouse_y >= y0) && (mouse_y < (y0 + H_ALL));
    wire hov1 = (mouse_x >= x1) && (mouse_x < (x1 + W_PRE)) && (mouse_y >= y1) && (mouse_y < (y1 + H_ALL));
    wire hov2 = (mouse_x >= x2) && (mouse_x < (x2 + W_MOR)) && (mouse_y >= y2) && (mouse_y < (y2 + H_ALL));
    wire hov3 = (mouse_x >= x3) && (mouse_x < (x3 + W_MOR)) && (mouse_y >= y3) && (mouse_y < (y3 + H_ALL));
    wire hov4 = (mouse_x >= x4) && (mouse_x < (x4 + W_MOR)) && (mouse_y >= y4) && (mouse_y < (y4 + H_ALL));
    wire hov5 = (mouse_x >= x5) && (mouse_x < (x5 + W_MOR)) && (mouse_y >= y5) && (mouse_y < (y5 + H_ALL));
    // assign hover = {hov5, hov4, hov3, hov2, hov1, hov0};

    // Click pulses per category for info tab module
    assign gauss_click  = settings_active && mouse_left_edge && hov0;
    assign median_click = settings_active && mouse_left_edge && hov1;
    assign erode_click  = settings_active && mouse_left_edge && (hov2 || hov3);
    assign dilate_click = settings_active && mouse_left_edge && (hov4 || hov5);

    // top-left mouse-aligned positions so a box centers under the cursor while dragging
    wire [9:0] mx_pre = (mouse_x <= (W_PRE>>1)) ? 10'd0 : (mouse_x - (W_PRE>>1));
    wire [8:0] my_all = (mouse_y <= (H_ALL>>1)) ? 9'd0 : (mouse_y - (H_ALL>>1));
    wire [9:0] mx_mor = (mouse_x <= (W_MOR>>1)) ? 10'd0 : (mouse_x - (W_MOR>>1));

    // in-drop checks using center point, check if the center of a box lies within the corresponding drop zone
    // a box only snaps if its type matches the zone (pre vs morph); otherwise it snaps back.
    wire in_pre0 = ((x0 + (W_PRE>>1)) >= pre_x) && ((x0 + (W_PRE>>1)) < (pre_x + pre_w))
                && ((y0 + (H_ALL>>1)) >= pre_y) && ((y0 + (H_ALL>>1)) < (pre_y + pre_h));
    wire in_pre1 = ((x1 + (W_PRE>>1)) >= pre_x) && ((x1 + (W_PRE>>1)) < (pre_x + pre_w))
                && ((y1 + (H_ALL>>1)) >= pre_y) && ((y1 + (H_ALL>>1)) < (pre_y + pre_h));

    wire in_m2 = ((x2 + (W_MOR>>1)) >= morph_x) && ((x2 + (W_MOR>>1)) < (morph_x + morph_w))
              && ((y2 + (H_ALL>>1)) >= morph_y) && ((y2 + (H_ALL>>1)) < (morph_y + morph_h));
    wire in_m3 = ((x3 + (W_MOR>>1)) >= morph_x) && ((x3 + (W_MOR>>1)) < (morph_x + morph_w))
              && ((y3 + (H_ALL>>1)) >= morph_y) && ((y3 + (H_ALL>>1)) < (morph_y + morph_h));
    wire in_m4 = ((x4 + (W_MOR>>1)) >= morph_x) && ((x4 + (W_MOR>>1)) < (morph_x + morph_w))
              && ((y4 + (H_ALL>>1)) >= morph_y) && ((y4 + (H_ALL>>1)) < (morph_y + morph_h));
    wire in_m5 = ((x5 + (W_MOR>>1)) >= morph_x) && ((x5 + (W_MOR>>1)) < (morph_x + morph_w))
              && ((y5 + (H_ALL>>1)) >= morph_y) && ((y5 + (H_ALL>>1)) < (morph_y + morph_h));

    // compute left margins for centralized layout (center one pre box, or center two side-by-side)
    wire [9:0] pre_left_margin_1 = (pre_w - W_PRE) >> 1; // one box case
    wire [9:0] pre_left_margin_2 = (pre_w - (W_PRE<<1)) >> 1; // two boxes case

    // for morph zone (N=1 to 4): margin = (morph_w - N*W_MOR)/2 (the left offset to center 1-4 morph boxes evenly)
    wire [9:0] morph_left_margin_1 = (morph_w - (W_MOR)) >> 1; // one box case
    wire [9:0] morph_left_margin_2 = (morph_w - (W_MOR<<1)) >> 1; // two boxes case
    wire [9:0] morph_left_margin_3 = (morph_w - (W_MOR*3)) >> 1; // three boxes case
    wire [9:0] morph_left_margin_4 = (morph_w - (W_MOR<<2)) >> 1; // four boxes case

    reg [1:0] r2; reg [1:0] r3; reg [1:0] r4; reg [1:0] r5;
    reg [2:0] mc; // local next-value for morph_count used for same-cycle layout decisions

    // Initialization and edge sampling
    always @(posedge clk) begin
        if (reset) begin
            // initial positions
            x0 <= X0_INIT; y0 <= Y_INIT;
            x1 <= X1_INIT; y1 <= Y_INIT;
            x2 <= X2_INIT; y2 <= Y_INIT;
            x3 <= X3_INIT; y3 <= Y_INIT;
            x4 <= X4_INIT; y4 <= Y_INIT;
            x5 <= X5_INIT; y5 <= Y_INIT;

            placed0_pre <= 1'b0; placed1_pre <= 1'b0;
            placed2_morph <= 1'b0; placed3_morph <= 1'b0; placed4_morph <= 1'b0; placed5_morph <= 1'b0;
            dragging <= 1'b0; drag_idx <= 3'd0; left_q <= 1'b0;
            drag_rel_cnt <= 20'd0;

            // pre_count <= 2'd0; 
            pre_order0 <= 2'b00; pre_order1 <= 2'b00;
            morph_count <= 3'd0; 
            morph_order0 <= 2'b00; morph_order1 <= 2'b00; morph_order2 <= 2'b00; morph_order3 <= 2'b00;
            front_idx <= 3'd0;

            // Default types: keep initial semantics (2,3 start as ERODE; 4,5 start as DILATE)
            is_erode2 <= 1'b1; is_erode3 <= 1'b1; is_erode4 <= 1'b0; is_erode5 <= 1'b0;
        end else begin
            // sample left button
            left_q <= mouse_left;

            // update release filter only while dragging
            if (dragging) begin
                if (mouse_left) begin
                    drag_rel_cnt <= 22'd0;
                end else if (drag_rel_cnt < DRAG_RELEASE_TH) begin
                    drag_rel_cnt <= drag_rel_cnt + 1'b1;
                end
            end else begin
                drag_rel_cnt <= 22'd0;
            end

            // default: if settings not active, ignore interactions but keep positions
            if (!settings_active) begin
                dragging <= 1'b0;
                // drop_reason <= 2'b00;
            end else begin
                // Hover + scroll to set type (not while dragging)
                if (!dragging) begin
                    if (scroll_down) begin // set to ERODE, NOTE: YES its inverted, NO i dont know why
                        if (hov2) is_erode2 <= 1'b1;
                        else if (hov3) is_erode3 <= 1'b1;
                        else if (hov4) is_erode4 <= 1'b1;
                        else if (hov5) is_erode5 <= 1'b1;
                    end
                    if (scroll_up) begin // set to DILATE, NOTE: YES its inverted, NO i dont know why
                        if (hov2) is_erode2 <= 1'b0;
                        else if (hov3) is_erode3 <= 1'b0;
                        else if (hov4) is_erode4 <= 1'b0;
                        else if (hov5) is_erode5 <= 1'b0;
                    end
                end

                // Start dragging on clean debounced press edge
                if (mouse_left_edge && !dragging) begin
                    if (hov0) begin dragging <= 1'b1; drag_idx <= 3'd0; front_idx <= 3'd0; end
                    else if (hov1) begin dragging <= 1'b1; drag_idx <= 3'd1; front_idx <= 3'd1; end
                    else if (hov2) begin dragging <= 1'b1; drag_idx <= 3'd2; front_idx <= 3'd2; end
                    else if (hov3) begin dragging <= 1'b1; drag_idx <= 3'd3; front_idx <= 3'd3; end
                    else if (hov4) begin dragging <= 1'b1; drag_idx <= 3'd4; front_idx <= 3'd4; end
                    else if (hov5) begin dragging <= 1'b1; drag_idx <= 3'd5; front_idx <= 3'd5; end
                end

                // while held: follow mouse
                if (dragging && mouse_left) begin
                    case (drag_idx)
                        3'd0: begin x0 <= (mx_pre > (10'd639 - W_PRE)) ? (10'd639 - W_PRE) : mx_pre; y0 <= (my_all > (9'd479 - H_ALL)) ? (9'd479 - H_ALL) : my_all; end
                        3'd1: begin x1 <= (mx_pre > (10'd639 - W_PRE)) ? (10'd639 - W_PRE) : mx_pre; y1 <= (my_all > (9'd479 - H_ALL)) ? (9'd479 - H_ALL) : my_all; end
                        3'd2: begin x2 <= (mx_mor > (10'd639 - W_MOR)) ? (10'd639 - W_MOR) : mx_mor; y2 <= (my_all > (9'd479 - H_ALL)) ? (9'd479 - H_ALL) : my_all; end
                        3'd3: begin x3 <= (mx_mor > (10'd639 - W_MOR)) ? (10'd639 - W_MOR) : mx_mor; y3 <= (my_all > (9'd479 - H_ALL)) ? (9'd479 - H_ALL) : my_all; end
                        3'd4: begin x4 <= (mx_mor > (10'd639 - W_MOR)) ? (10'd639 - W_MOR) : mx_mor; y4 <= (my_all > (9'd479 - H_ALL)) ? (9'd479 - H_ALL) : my_all; end
                        3'd5: begin x5 <= (mx_mor > (10'd639 - W_MOR)) ? (10'd639 - W_MOR) : mx_mor; y5 <= (my_all > (9'd479 - H_ALL)) ? (9'd479 - H_ALL) : my_all; end
                    endcase
                end

                // Drop only on sustained-low (ignore brief dips/falling edges to avoid false releases)
                if (dragging && (drag_rel_cnt >= DRAG_RELEASE_TH)) begin
                    // drop_reason[0] <= 1'b0;                 // bit0: falling-edge release disabled
                    // drop_reason[1] <= 1'b1;                 // bit1: released by sustained low
                    case (drag_idx)
                        // GAUSS (0)
                        3'd0: begin
                            if (in_pre0) begin
                                placed0_pre <= 1'b1;
                            end else begin
                                // snap back and remove if previously placed
                                x0 <= X0_INIT; y0 <= Y_INIT;
                                placed0_pre <= 1'b0;
                            end
                        end
                        // MEDIAN (1)
                        3'd1: begin
                            if (in_pre1) begin
                                placed1_pre <= 1'b1;
                            end else begin
                                x1 <= X1_INIT; y1 <= Y_INIT;
                                placed1_pre <= 1'b0;
                            end
                        end
                        // ERODE A (2)
                        3'd2: begin
                            if (in_m2) begin
                                placed2_morph <= 1'b1;
                            end else begin
                                x2 <= X2_INIT; y2 <= Y_INIT;
                                placed2_morph <= 1'b0;
                            end
                        end
                        // ERODE B (3)
                        3'd3: begin
                            if (in_m3) begin
                                placed3_morph <= 1'b1;
                            end else begin
                                x3 <= X3_INIT; y3 <= Y_INIT;
                                placed3_morph <= 1'b0;
                            end
                        end
                        // DILATE A (4)
                        3'd4: begin
                            if (in_m4) begin
                                placed4_morph <= 1'b1;
                            end else begin
                                x4 <= X4_INIT; y4 <= Y_INIT;
                                placed4_morph <= 1'b0;
                            end
                        end
                        // DILATE B (5)
                        3'd5: begin
                            if (in_m5) begin
                                placed5_morph <= 1'b1;
                            end else begin
                                x5 <= X5_INIT; y5 <= Y_INIT;
                                placed5_morph <= 1'b0;
                            end
                        end
                    endcase

                    dragging <= 1'b0; // stop dragging after drop
                end
            end

            // snap positions into drop zones when placed and not actively dragging
            if (!dragging) begin
                // PRE drop snapped positions (two slots max) based on physical order
                if (placed0_pre || placed1_pre) begin
                    if (placed0_pre ^ placed1_pre) begin
                        // exactly one placed -> center
                        if (placed0_pre) begin x0 <= pre_x + pre_left_margin_1; y0 <= pre_y; end
                        if (placed1_pre) begin x1 <= pre_x + pre_left_margin_1; y1 <= pre_y; end
                    end else if (placed0_pre && placed1_pre) begin
                        // two placed -> side by side
                        // check when user released which is more left to be first
                        if (x0 <= x1) begin 
                            x0 <= pre_x + pre_left_margin_2; y0 <= pre_y;
                            x1 <= pre_x + pre_left_margin_2 + W_PRE; y1 <= pre_y;
                        end else begin
                            x1 <= pre_x + pre_left_margin_2; y1 <= pre_y;
                            x0 <= pre_x + pre_left_margin_2 + W_PRE; y0 <= pre_y;
                        end
                    end
                end

                // MORPH drop snapped positions (up to 4), based on current left-to-right ranks
                // Count placed using local next-value (avoid 1-cycle stale read of morph_count)
                mc = {1'b0, placed2_morph} + {1'b0, placed3_morph} + {1'b0, placed4_morph} + {1'b0, placed5_morph};
                // Compute “ranks” r2 to r5 = number of other morph boxes strictly to the left, i.e., count of those whose x is less than this box’s x.
                // NOTE: Piggybacked as a check for where each block is in the pipeline
                // e.g. when B1 (i.e. prev erode1), B3 (i.e. prev dilate1) is placed in the pipeline as ... --> B3 -> B1 --> ...
                // r2 (i.e. B1) will be 1, r4 (i.e. B3) will be 0, 
                // r3,r5 (i.e. B2, B4) will both be 2 (next possible position) but can be ignored by using the placedX_morph flags
                r2 = (placed3_morph && ((x3 < x2) || ((x3 == x2) && (3 < 2))))
                         + (placed4_morph && ((x4 < x2) || ((x4 == x2) && (4 < 2))))
                         + (placed5_morph && ((x5 < x2) || ((x5 == x2) && (5 < 2))));

                r3 = (placed2_morph && ((x2 < x3) || ((x2 == x3) && (2 < 3))))
                         + (placed4_morph && ((x4 < x3) || ((x4 == x3) && (4 < 3))))
                         + (placed5_morph && ((x5 < x3) || ((x5 == x3) && (5 < 3))));

                r4 = (placed2_morph && ((x2 < x4) || ((x2 == x4) && (2 < 4))))
                         + (placed3_morph && ((x3 < x4) || ((x3 == x4) && (3 < 4))))
                         + (placed5_morph && ((x5 < x4) || ((x5 == x4) && (5 < 4))));

                r5 = (placed2_morph && ((x2 < x5) || ((x2 == x5) && (2 < 5))))
                         + (placed3_morph && ((x3 < x5) || ((x3 == x5) && (3 < 5))))
                         + (placed4_morph && ((x4 < x5) || ((x4 == x5) && (4 < 5))));

                // Base offset by count (use mc)
                if (mc == 3'd1) begin
                    if (placed2_morph) begin x2 <= morph_x + morph_left_margin_1; y2 <= morph_y; end
                    if (placed3_morph) begin x3 <= morph_x + morph_left_margin_1; y3 <= morph_y; end
                    if (placed4_morph) begin x4 <= morph_x + morph_left_margin_1; y4 <= morph_y; end
                    if (placed5_morph) begin x5 <= morph_x + morph_left_margin_1; y5 <= morph_y; end
                end else if (mc == 3'd2) begin
                    if (placed2_morph) begin x2 <= morph_x + morph_left_margin_2 + (W_MOR * r2); y2 <= morph_y; end
                    if (placed3_morph) begin x3 <= morph_x + morph_left_margin_2 + (W_MOR * r3); y3 <= morph_y; end
                    if (placed4_morph) begin x4 <= morph_x + morph_left_margin_2 + (W_MOR * r4); y4 <= morph_y; end
                    if (placed5_morph) begin x5 <= morph_x + morph_left_margin_2 + (W_MOR * r5); y5 <= morph_y; end
                end else if (mc == 3'd3) begin
                    if (placed2_morph) begin x2 <= morph_x + morph_left_margin_3 + (W_MOR * r2); y2 <= morph_y; end
                    if (placed3_morph) begin x3 <= morph_x + morph_left_margin_3 + (W_MOR * r3); y3 <= morph_y; end
                    if (placed4_morph) begin x4 <= morph_x + morph_left_margin_3 + (W_MOR * r4); y4 <= morph_y; end
                    if (placed5_morph) begin x5 <= morph_x + morph_left_margin_3 + (W_MOR * r5); y5 <= morph_y; end
                end else if (mc == 3'd4) begin
                    if (placed2_morph) begin x2 <= morph_x + morph_left_margin_4 + (W_MOR * r2); y2 <= morph_y; end
                    if (placed3_morph) begin x3 <= morph_x + morph_left_margin_4 + (W_MOR * r3); y3 <= morph_y; end
                    if (placed4_morph) begin x4 <= morph_x + morph_left_margin_4 + (W_MOR * r4); y4 <= morph_y; end
                    if (placed5_morph) begin x5 <= morph_x + morph_left_margin_4 + (W_MOR * r5); y5 <= morph_y; end
                end

                // Update registered morph_count after using mc for layout
                morph_count <= mc;
            end

            // Morphology processing order: left-to-right by x position (ignore chronological)
            // Seed sortable pairs (x, code) with sentinel x for non-placed boxes and dynamic type codes
            ax = placed2_morph ? x2 : 10'd1023; ac = is_erode2 ? 2'b01 : 2'b10; // dynamic ERODE/DILATE
            bx = placed3_morph ? x3 : 10'd1023; bc = is_erode3 ? 2'b01 : 2'b10;
            cx = placed4_morph ? x4 : 10'd1023; cc = is_erode4 ? 2'b01 : 2'b10;
            dx = placed5_morph ? x5 : 10'd1023; dc = is_erode5 ? 2'b01 : 2'b10;

            // Sorting network for 4 elements (A,B,C,D) ascending by x
            if (ax > bx) begin tmpx = ax; ax = bx; bx = tmpx; tmpc = ac; ac = bc; bc = tmpc; end
            if (cx > dx) begin tmpx = cx; cx = dx; dx = tmpx; tmpc = cc; cc = dc; dc = tmpc; end
            if (ax > cx) begin tmpx = ax; ax = cx; cx = tmpx; tmpc = ac; ac = cc; cc = tmpc; end
            if (bx > dx) begin tmpx = bx; bx = dx; dx = tmpx; tmpc = bc; bc = dc; dc = tmpc; end
            if (bx > cx) begin tmpx = bx; bx = cx; cx = tmpx; tmpc = bc; bc = cc; cc = tmpc; end

            // Write outputs, zeroing out sentinel entries
            morph_order0 <= (ax == 10'd1023) ? 2'b00 : ac;
            morph_order1 <= (bx == 10'd1023) ? 2'b00 : bc;
            morph_order2 <= (cx == 10'd1023) ? 2'b00 : cc;
            morph_order3 <= (dx == 10'd1023) ? 2'b00 : dc;

            // Preprocessing count and order (left-to-right by x)
            // pre_count <= {1'b0, placed0_pre} + {1'b0, placed1_pre};
            if (!placed0_pre && !placed1_pre) begin
                pre_order0 <= 2'b00; pre_order1 <= 2'b00;
            end else if (placed0_pre && !placed1_pre) begin
                pre_order0 <= 2'b01; pre_order1 <= 2'b00; // only GAUSS
            end else if (!placed0_pre && placed1_pre) begin
                pre_order0 <= 2'b10; pre_order1 <= 2'b00; // only MED
            end else begin
                if (x0 <= x1) begin pre_order0 <= 2'b01; pre_order1 <= 2'b10; end
                else begin pre_order0 <= 2'b10; pre_order1 <= 2'b01; end
            end
        end
    end
    // outputs
    assign boxes_x = {x5[9:0], x4[9:0], x3[9:0], x2[9:0], x1[9:0], x0[9:0]};
    assign boxes_y = {y5[8:0], y4[8:0], y3[8:0], y2[8:0], y1[8:0], y0[8:0]};

    // Concatenated order
    assign morph_order_vector = {morph_order3, morph_order2, morph_order1, morph_order0};
    // 4-bit morphology vector (LSB = leftmost placed morph box). Bit=1 for DILATE, 0 for ERODE or not placed.
    // Each bit derived by comparing morph_orderX == 2'b10 (DILATE code).
    assign morph_vector = { (morph_order3 == 2'b10),
                            (morph_order2 == 2'b10),
                            (morph_order1 == 2'b10),
                            (morph_order0 == 2'b10) };
    assign box_morph_vector = {~is_erode5, ~is_erode4, ~is_erode3, ~is_erode2};
    assign pre_order_vector = {pre_order1, pre_order0};
    // assign dragging_o = dragging;

    // order of boxes inside the morphology pipeline (0=none, 1=box2, 2=box3, 3=box4, 4=box5)
    assign box_order_vector[2:0] = (placed2_morph && r2==0) ? 3'd1 :
                                  (placed3_morph && r3==0) ? 3'd2 :
                                  (placed4_morph && r4==0) ? 3'd3 :
                                  (placed5_morph && r5==0) ? 3'd4 : 3'd0;
    assign box_order_vector[5:3] = (placed2_morph && r2==1) ? 3'd1 :
                                  (placed3_morph && r3==1) ? 3'd2 :
                                  (placed4_morph && r4==1) ? 3'd3 :
                                  (placed5_morph && r5==1) ? 3'd4 : 3'd0;
    assign box_order_vector[8:6] = (placed2_morph && r2==2) ? 3'd1 :
                                  (placed3_morph && r3==2) ? 3'd2 :
                                  (placed4_morph && r4==2) ? 3'd3 :
                                  (placed5_morph && r5==2) ? 3'd4 : 3'd0;
    assign box_order_vector[11:9] = (placed2_morph && r2==3) ? 3'd1 :
                                  (placed3_morph && r3==3) ? 3'd2 :
                                  (placed4_morph && r4==3) ? 3'd3 :
                                  (placed5_morph && r5==3) ? 3'd4 : 3'd0;

    // assign x, y positions based on which box is in which order slot in morphology pipeline
    assign boxes_y_test[17:0] = {y1[8:0], y0[8:0]};    
    assign boxes_y_test[26:18] = box_order_vector[2:0] == 3'd1 ? y2[8:0] :
                                box_order_vector[2:0] == 3'd2 ? y3[8:0] :
                                box_order_vector[2:0] == 3'd3 ? y4[8:0] :
                                box_order_vector[2:0] == 3'd4 ? y5[8:0] : 
                                y2[8:0];   // no box placed, default to home position
    assign boxes_y_test[35:27] = box_order_vector[5:3] == 3'd1 ? y2[8:0] :
                                box_order_vector[5:3] == 3'd2 ? y3[8:0] :
                                box_order_vector[5:3] == 3'd3 ? y4[8:0] :
                                box_order_vector[5:3] == 3'd4 ? y5[8:0] : 
                                y3[8:0];
    assign boxes_y_test[44:36] = box_order_vector[8:6] == 3'd1 ? y2[8:0] :
                                box_order_vector[8:6] == 3'd2 ? y3[8:0] :
                                box_order_vector[8:6] == 3'd3 ? y4[8:0] :
                                box_order_vector[8:6] == 3'd4 ? y5[8:0] : 
                                y4[8:0];
    assign boxes_y_test[53:45] = box_order_vector[11:9] == 3'd1 ? y2[8:0] :
                                box_order_vector[11:9] == 3'd2 ? y3[8:0] :
                                box_order_vector[11:9] == 3'd3 ? y4[8:0] :
                                box_order_vector[11:9] == 3'd4 ? y5[8:0] : 
                                y5[8:0];

    assign boxes_x_test[19:0] = {x1[9:0], x0[9:0]};
    assign boxes_x_test[29:20] = box_order_vector[2:0] == 3'd1 ? x2[9:0] :
                                box_order_vector[2:0] == 3'd2 ? x3[9:0] :
                                box_order_vector[2:0] == 3'd3 ? x4[9:0] :
                                box_order_vector[2:0] == 3'd4 ? x5[9:0] : 
                                x2[9:0];   // no box placed, default to home position
    assign boxes_x_test[39:30] = box_order_vector[5:3] == 3'd1 ? x2[9:0] :
                                box_order_vector[5:3] == 3'd2 ? x3[9:0] :
                                box_order_vector[5:3] == 3'd3 ? x4[9:0] :
                                box_order_vector[5:3] == 3'd4 ? x5[9:0] : 
                                x3[9:0];
    assign boxes_x_test[49:40] = box_order_vector[8:6] == 3'd1 ? x2[9:0] :
                                box_order_vector[8:6] == 3'd2 ? x3[9:0] :
                                box_order_vector[8:6] == 3'd3 ? x4[9:0] :
                                box_order_vector[8:6] == 3'd4 ? x5[9:0] : 
                                x4[9:0];
    assign boxes_x_test[59:50] = box_order_vector[11:9] == 3'd1 ? x2[9:0] :
                                box_order_vector[11:9] == 3'd2 ? x3[9:0] :
                                box_order_vector[11:9] == 3'd3 ? x4[9:0] :
                                box_order_vector[11:9] == 3'd4 ? x5[9:0] : 
                                x5[9:0];

endmodule
