`timescale 1ns/1ps
module UFDS_Bridge (
    // Producer @ 25 MHz
    input  wire pclk,
    input  wire p_rst,
    input  wire p_valid,
    input  wire [8:0] p_x,  // 0..309 (310 pixels wide)
    input  wire [7:0] p_y,  // 0..239 (240 pixels tall)
    input  wire p_px,
    // UFDS @ 100 MHz
    input  wire clk,
    input  wire ext_reset,
    // UFDS settings
    input  wire [1:0] min_area_sel,    // 00=4, 01=16, 10=32, 11=64
    // input  wire       sort_by_prox,    // 0=area, 1=proximity
    input  wire [1:0] max_boxes_sel,   // 00=1, 01=2, 10=3, 11=4

    // UFDS single-bbox outputs
    // output wire [9:0] bbox_left, bbox_right, centroid_x,
    // output wire [8:0] bbox_top,  bbox_bottom, centroid_y,

    // UFDS top-4 concatenated outputs passthrough
    output wire [39:0] comp3210_left,
    output wire [39:0] comp3210_right,
    output wire [35:0] comp3210_top,
    output wire [35:0] comp3210_bottom,
    output wire [39:0] comp3210_cx,
    output wire [35:0] comp3210_cy,
    output wire [63:0] comp3210_area,
    output wire [2:0]  comp_count,

    // Bridge ready (mirrors UFDS ready)
    output wire ready_o,

    output wire [8:0] next_unused_label
);

    wire p_fs = (p_x==9'd0 && p_y==8'd0) ? 1'b1 : 1'b0; // frame start when x=0,y=0
    wire p_ls = (p_x==9'd0) ? 1'b1 : 1'b0;              // line start when x=0
    wire p_fe = (p_x == 9'd309 && p_y == 8'd239) ? 1'b1 : 1'b0; // frame end at last pixel (310x240)

    // FIFO signals
    wire        wr_full;
    wire        rd_empty;
    reg         rd_en;
    wire [3:0]  rd_data;

    // Enqueue every valid pixel word (4 bits)
    UFDS_FIFO #(.WIDTH(4), .ADDR_BITS(9)) u_fifo (
        .wr_clk (pclk),
        .wr_rst (p_rst | ext_reset),
        .wr_en  (p_valid),
        .wr_data({p_fs, p_ls, p_fe, p_px}),
        .wr_full(wr_full),

        .rd_clk (clk),
        .rd_rst (ext_reset | p_rst),
        .rd_en  (rd_en),
        .rd_data(rd_data),
        .rd_empty(rd_empty)
    );

    // UFDS instance
    wire ready_i;
    assign ready_o = ready_i;

    reg        in_valid_q;
    reg  fs_q, ls_q, fe_q, px_q;

    UFDS_Detector u_ufds (
        .clk(clk),
        .ext_reset(ext_reset),

        .in_valid(in_valid_q),
        .frame_start(fs_q),
        .line_start(ls_q),
        .frame_end(fe_q),
        .curr_pix(px_q),

        // Settings to UFDS core
        .min_area_sel(min_area_sel),
        // .sort_by_prox(sort_by_prox),
        .max_boxes_sel(max_boxes_sel),

        .ready_to_read(ready_i),

        // .bbox_left(bbox_left),
        // .bbox_right(bbox_right),
        // .bbox_top(bbox_top),
        // .bbox_bottom(bbox_bottom),
        // .centroid_x(centroid_x),
        // .centroid_y(centroid_y),

        .comp3210_left(comp3210_left),
        .comp3210_right(comp3210_right),
        .comp3210_top(comp3210_top),
        .comp3210_bottom(comp3210_bottom),
        .comp3210_cx(comp3210_cx),
        .comp3210_cy(comp3210_cy),
        .comp3210_area(comp3210_area),
        .comp_count(comp_count),

        .next_unused_label(next_unused_label)
    );

    // Simple 1-word read buffer to align to UFDS ready
    reg        have;
    reg [3:0] hold;
    reg        pop_inflight;

    always @(posedge clk) begin
        if (ext_reset | p_rst) begin
            rd_en        <= 1'b0;
            pop_inflight <= 1'b0;
            have         <= 1'b0;
            hold         <= 4'b0;

            in_valid_q   <= 1'b0;
            {fs_q,ls_q,fe_q,px_q} <= 4'b0;
        end else begin
            // initiate a FIFO pop when buffer empty and FIFO not empty
            if (!have && !pop_inflight && !rd_empty) begin
                rd_en        <= 1'b1;
                pop_inflight <= 1'b1;
            end else begin
                rd_en <= 1'b0;
            end

            // capture popped word one cycle after rd_en
            if (pop_inflight) begin
                hold         <= rd_data;
                have         <= 1'b1;
                pop_inflight <= 1'b0;
            end

            // default: no valid, clear strobes
            in_valid_q <= 1'b0;
            {fs_q,ls_q,fe_q,px_q} <= 4'b0;

            // when UFDS is ready and we have a word, present for exactly 1 cycle
            if (have && ready_i) begin
                {fs_q,ls_q,fe_q,px_q} <= hold;
                in_valid_q <= 1'b1;
                have <= 1'b0; // consume the buffered word
            end
        end
    end
endmodule