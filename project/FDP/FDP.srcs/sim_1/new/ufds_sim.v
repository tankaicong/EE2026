`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2025 01:20:47
// Design Name: 
// Module Name: ufds_sim
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


module ufds_sim(    );
// Verifies x resets on frame_start/line_start and only increments when in_valid=1
// Verifies toggle_line flips at each new line
// Verifies neighbor helpers return zeros on the first line (edges)
// Verifies U/UL/UR fetch from the previous row when we preload labels between lines

    // Drive a full 306x240 frame through the Bridge so FS/LS/FE are correct
    localparam integer IMG_W = 24;
    localparam integer IMG_H = 12;

    reg  clk=0, pclk = 0, rst=1, p_rst=1;
    reg  in_valid=0, frame_start=0, line_start=0, frame_end=0, curr_pix=0;

    // Bridge concatenated outputs (top-4)
    wire [39:0] comp3210_left, comp3210_right, comp3210_cx;
    wire [35:0] comp3210_top, comp3210_bottom, comp3210_cy;
    wire [63:0] comp3210_area;
    wire [2:0]  comp_count;
    wire ready_o;

    // Producer-side regs (match Bridge port widths)
    reg  p_valid_r, p_px_r;
    reg  [8:0] p_x_r; // 0..305
    reg  [7:0] p_y_r; // 0..239

    // Streaming coordinates
    integer x, y;

    always @(posedge pclk) begin
        p_valid_r <= in_valid;
        // p_fs_r    <= frame_start;
        // p_ls_r    <= line_start;
        // p_fe_r    <= frame_end;
        p_x_r <= x;
        p_y_r <= y;
        p_px_r    <= curr_pix;
    end

    // 100 MHz and 25 MHz
    always #5 clk = ~clk;
    always #20 pclk = ~pclk;  // 40 ns

    

    UFDS_Bridge dut (
        .pclk(pclk), .p_rst(p_rst),
        .p_valid(p_valid_r), .p_x(p_x_r), .p_y(p_y_r), .p_px(p_px_r),
        .clk(clk), .ext_reset(rst),
        .comp3210_left(comp3210_left),
        .comp3210_right(comp3210_right),
        .comp3210_top(comp3210_top), .comp3210_bottom(comp3210_bottom),
        .comp3210_cx(comp3210_cx), .comp3210_cy(comp3210_cy),
        .comp3210_area(comp3210_area), .comp_count(comp_count),
        .ready_o(ready_o)
    );
    

    // Foreground map: 4 separated components
    // A: x=2..5,  y=1..3  (area 12)
    // B: x=9..12, y=0..1  (area 8)
    // C: x=15..17,y=5..8  (area 12)
    // D: plus centered at (20,6), arms len=1 (area 5)
    function   fg(input integer x, input integer y);
        begin
            fg = 0;
            if ((x>=2  && x<=5 ) && (y>=1 && y<=3)) fg = 1; // A
            if ((x>=9  && x<=12) && (y>=0 && y<=1)) fg = 1; // B
            if ((x>=15 && x<=17) && (y>=5 && y<=8)) fg = 1; // C
            if ((x==20 && (y>=5 && y<=7)) || ((x>=19 && x<=21) && y==6)) fg = 1; // D
        end
    endfunction

    // Push one pixel: assert on posedge, deassert on negedge (matches DUT sampling)
    task push_pixel(input integer x, input integer y, input integer px);
    begin
        // wait (dut.state == dut.S_READY);
        @(posedge pclk);
        curr_pix    = px;
        in_valid   = 1'b1;
        // frame_start = fs;
        // line_start  = ls;
        @(negedge pclk);
        in_valid    = 1'b0;
        // frame_start = 1'b0;
        // frame_end  = 1'b0;
        // line_start  = 1'b0;
    end
    endtask

    // Helpers: scan active roots by bbox and simple checks
    function integer find_by_bbox(input integer L, input integer R, input integer T, input integer B);
        integer i;
        begin
            find_by_bbox = 0;
            for (i=1; i<dut.u_ufds.next_label; i=i+1) begin
                if (dut.u_ufds.active_root[i] &&
                    dut.u_ufds.min_x[i]==L && dut.u_ufds.max_x[i]==R &&
                    dut.u_ufds.min_y[i]==T && dut.u_ufds.max_y[i]==B) begin
                    find_by_bbox = i;
                end
            end
        end
    endfunction

    task check_component(input integer expected_area,
                         input integer L, input integer R,
                         input integer T, input integer B);
        integer lbl;
        begin
            lbl = find_by_bbox(L,R,T,B);
            if (lbl == 0) begin
                $display("ERROR: bbox [L%0d R%0d T%0d B%0d] not found", L,R,T,B);
                $fatal;
            end
            if (dut.u_ufds.area[lbl] !== expected_area) begin
                $display("ERROR: area[%0d]=%0d expected %0d", lbl, dut.u_ufds.area[lbl], expected_area);
                $fatal;
            end
            $display("OK: label %0d area=%0d bbox=[L%0d R%0d T%0d B%0d]", lbl, dut.u_ufds.area[lbl], L,R,T,B);
        end
    endtask

    task check_counts(input integer expected_active, input integer expected_total_area);
        integer i, cnt, sum_area;
        begin
            cnt = 0; sum_area = 0;
            for (i=1; i<dut.u_ufds.next_label; i=i+1) begin
                if (dut.u_ufds.active_root[i]) begin
                    cnt = cnt + 1;
                    sum_area = sum_area + dut.u_ufds.area[i];
                end
            end
            if (cnt !== expected_active) begin
                $display("ERROR: active=%0d expected %0d", cnt, expected_active); $fatal;
            end
            if (sum_area !== expected_total_area) begin
                $display("ERROR: total_area=%0d expected %0d", sum_area, expected_total_area); $fatal;
            end
            $display("OK: active=%0d total_area=%0d", cnt, sum_area);
        end
    endtask

    // Optional: assert no X on neighbors when accepting a pixel
reg accept_d;
always @(posedge clk) begin
    // Delay the check by 1 cycle to allow x/y and neighbor wires to settle after line_start resets
    accept_d <= (dut.u_ufds.state==dut.u_ufds.S_READY && dut.in_valid_q);
    if (accept_d) begin
        if ((^dut.u_ufds.left_label)    === 1'bx ||
            (^dut.u_ufds.up_label)      === 1'bx ||
            (^dut.u_ufds.upleft_label)  === 1'bx ||
            (^dut.u_ufds.upright_label) === 1'bx) begin
            $display("ERROR: neighbor X at x=%0d y=%0d", dut.u_ufds.x, dut.u_ufds.y);
            $stop; // or $finish;
        end
    end
end

    
    initial begin
        // Reset
        repeat (8) @(posedge clk);
        rst = 0; p_rst = 0;

        // Wait DUT ready
        #44150;

        // Stream the full 306x240 frame; only a 24x12 region has foreground
        for (y=0; y<IMG_H; y=y+1) begin
            for (x=0; x<IMG_W; x=x+1) begin
                push_pixel(x, y, fg(x,y));
                // wait (dut.state == dut.S_READY);
            end
        end

        // Drain any in-flight merges
        repeat (2000) @(posedge clk);

        // Checks
        check_component(12, 2, 5, 1, 3);   // A
        check_component(8,  9,12, 0, 1);   // B
        check_component(12,15,17, 5, 8);   // C
        check_component(5, 19,21, 5, 7);   // D
        check_counts(4, 12+8+12+5);

        // Done: we only care that 4 components are detected and stats correct.
        // Optionally, check Bridge snapshot count == 4 and print packed outputs.
        repeat (4) @(posedge clk);
        if (comp_count !== 3'd4) begin
            $display("ERROR: comp_count via Bridge = %0d, expected 4", comp_count);
            $fatal;
        end
        $display("PASS: multi-component test; comp_count=%0d", comp_count);
        $finish;
    end

     //Successfully tested multi-component detection on 24x12 image with 4 separated objects, but poor sync
    // Test image size
//     localparam integer IMG_W = 24;
//     localparam integer IMG_H = 12;

//     reg  clk=0, rst=1;
//     reg  in_valid=0, frame_start=0, line_start=0, frame_end=0, curr_pix=0;

//     wire [8:0] bbox_left, bbox_right, centroid_x;
//     wire [7:0] bbox_top,  bbox_bottom, centroid_y;


//     // DUT
//     // If UFDS_Detector has WIDTH/HEIGHT parameters, pass .WIDTH(IMG_W), .HEIGHT(IMG_H)
//     UFDS_Detector dut(
//         .clk(clk), .ext_reset(rst),
//         .in_valid(in_valid),
//         .frame_start(frame_start),
//         .line_start(line_start),
//         .frame_end(frame_end),
//         .curr_pix(curr_pix),
//         .bbox_left(bbox_left), .bbox_right(bbox_right),
//         .bbox_top(bbox_top), .bbox_bottom(bbox_bottom),
//         .centroid_x(centroid_x), .centroid_y(centroid_y)
//     );

//     // 100 MHz
//     always #5 clk = ~clk;
    

//     // Foreground map: 4 separated components
//     // A: x=2..5,  y=1..3  (area 12)
//     // B: x=9..12, y=0..1  (area 8)
//     // C: x=15..17,y=5..8  (area 12)
//     // D: plus centered at (20,6), arms len=1 (area 5)
//     function   fg(input integer x, input integer y);
//         begin
//             fg = 0;
//             if ((x>=2  && x<=5 ) && (y>=1 && y<=3)) fg = 1; // A
//             if ((x>=9  && x<=12) && (y>=0 && y<=1)) fg = 1; // B
//             if ((x>=15 && x<=17) && (y>=5 && y<=8)) fg = 1; // C
//             if ((x==20 && (y>=5 && y<=7)) || ((x>=19 && x<=21) && y==6)) fg = 1; // D
//         end
//     endfunction

//     // Push one pixel: assert on posedge, deassert on negedge (matches DUT sampling)
//     task push_pixel(input   fs, input   ls, input   px);
//     begin
//         // wait (dut.state == dut.S_READY);
//         @(posedge clk);
//         curr_pix    = px;
//         in_valid   = 1'b1;
//         frame_start = fs;
//         line_start  = ls;
//         @(negedge clk);
//         in_valid    = 1'b0;
//         frame_start = 1'b0;
//         frame_end  = 1'b0;
//         line_start  = 1'b0;
//     end
//     endtask

//     // Helpers: scan active roots by bbox and simple checks
//     function integer find_by_bbox(input integer L, input integer R, input integer T, input integer B);
//         integer i;
//         begin
//             find_by_bbox = 0;
//             for (i=1; i<dut.next_label; i=i+1) begin
//                 if (dut.active_root[i] &&
//                     dut.min_x[i]==L && dut.max_x[i]==R &&
//                     dut.min_y[i]==T && dut.max_y[i]==B) begin
//                     find_by_bbox = i;
//                 end
//             end
//         end
//     endfunction

//     task check_component(input integer expected_area,
//                          input integer L, input integer R,
//                          input integer T, input integer B);
//         integer lbl;
//         begin
//             lbl = find_by_bbox(L,R,T,B);
//             if (lbl == 0) begin
//                 $display("ERROR: bbox [L%0d R%0d T%0d B%0d] not found", L,R,T,B);
//                 $fatal;
//             end
//             if (dut.area[lbl] !== expected_area) begin
//                 $display("ERROR: area[%0d]=%0d expected %0d", lbl, dut.area[lbl], expected_area);
//                 $fatal;
//             end
//             $display("OK: label %0d area=%0d bbox=[L%0d R%0d T%0d B%0d]", lbl, dut.area[lbl], L,R,T,B);
//         end
//     endtask

//     task check_counts(input integer expected_active, input integer expected_total_area);
//         integer i, cnt, sum_area;
//         begin
//             cnt = 0; sum_area = 0;
//             for (i=1; i<dut.next_label; i=i+1) begin
//                 if (dut.active_root[i]) begin
//                     cnt = cnt + 1;
//                     sum_area = sum_area + dut.area[i];
//                 end
//             end
//             if (cnt !== expected_active) begin
//                 $display("ERROR: active=%0d expected %0d", cnt, expected_active); $fatal;
//             end
//             if (sum_area !== expected_total_area) begin
//                 $display("ERROR: total_area=%0d expected %0d", sum_area, expected_total_area); $fatal;
//             end
//             $display("OK: active=%0d total_area=%0d", cnt, sum_area);
//         end
//     endtask

//     // Optional: assert no X on neighbors when accepting a pixel
// always @(posedge clk) begin
//     if (dut.state==dut.S_READY && in_valid) begin
//         if ((^dut.left_label)    === 1'bx ||
//             (^dut.up_label)      === 1'bx ||
//             (^dut.upleft_label)  === 1'bx ||
//             (^dut.upright_label) === 1'bx) begin
//             $display("ERROR: neighbor X at x=%0d y=%0d", dut.x, dut.y);
//             $stop; // or $finish;
//         end
//     end
// end

//     integer x, y;
//     initial begin
//         // Reset
//         repeat (4) @(posedge clk);
//         rst = 0;

//         // Wait DUT ready
//         #44150;

//         // Stream the 24x12 frame
//         for (y=0; y<IMG_H; y=y+1) begin
//             for (x=0; x<IMG_W; x=x+1) begin
//                 push_pixel((y==0 && x==0), (x==0), fg(x,y));
//                 // wait (dut.state == dut.S_READY);
//             end
//         end

//         // Drain merges
//         repeat (100) @(posedge clk);

//         // Checks
//         check_component(12, 2, 5, 1, 3);   // A
//         check_component(8,  9,12, 0, 1);   // B
//         check_component(12,15,17, 5, 8);   // C
//         check_component(5, 19,21, 5, 7);   // D
//         check_counts(4, 12+8+12+5);

//         // Validate single-bbox outputs (largest component = A)
//         // Give a couple cycles for any last updates to settle
//         repeat (4) @(posedge clk);
//         if (bbox_left   !== 9'd2 ||
//             bbox_right  !== 9'd5 ||
//             bbox_top    !== 8'd1 ||
//             bbox_bottom !== 8'd3 ||
//             centroid_x  !== 9'd3 ||
//             centroid_y  !== 8'd2) begin
//             $display("ERROR: bbox outputs mismatch. got L%0d R%0d T%0d B%0d CX=%0d CY=%0d, expected L2 R5 T1 B3 CX=3 CY=2",
//                      bbox_left, bbox_right, bbox_top, bbox_bottom, centroid_x, centroid_y);
//             $fatal;
//         end else begin
//             $display("OK: single-bbox outputs match largest component A.");
//         end

//         $display("PASS: multi-component test");
//         $finish;
//     end


    

    /* // Successfully tested 3x8 pixel block with 2x3 object
    );
    // DUT ports
    reg  clk = 0;
    reg  rst = 1;
    reg  in_valid = 0;
    reg  frame_start = 0;
    reg  line_start = 0;
    reg  frame_end = 0;
    reg  curr_pix = 0;

    wire [8:0] bbox_left, bbox_right, centroid_x;
    wire [7:0] bbox_top,  bbox_bottom, centroid_y;

    // Instantiate DUT
    UFDS_Detector dut (
        .clk(clk),
        .ext_reset(rst),
        .in_valid(in_valid),
        .frame_start(frame_start),
        .line_start(line_start),
        .frame_end(frame_end),
        .curr_pix(curr_pix),
        .bbox_left(bbox_left),
        .bbox_right(bbox_right),
        .bbox_top(bbox_top),
        .bbox_bottom(bbox_bottom),
        .centroid_x(centroid_x),
        .centroid_y(centroid_y)
    );

    // Clock
    always #5 clk = ~clk;

    // Helpers
    task push_pixel(input fs, input ls, input px);
        begin
            wait (dut.state == dut.S_READY);
            @(posedge clk);
            curr_pix    = px;
            in_valid    = 1;
            frame_start = fs;
            line_start  = ls;
            @(negedge clk);
            in_valid    = 0;
            frame_start = 0;
            frame_end   = 0;
            line_start  = 0;
        end
    endtask

    integer xi, yi;
    initial begin


        // reset
        repeat (4) @(posedge clk);
        rst = 0;

        // wait for init sweeps to complete
        #44150;

        // feed 3 lines of 8 pixels with a simple 2x3 block at (x=2..3,y=0..2)
        for (yi=0; yi<3; yi=yi+1) begin
            for (xi=0; xi<8; xi=xi+1) begin
                push_pixel((yi==0 && xi==0), (xi==0), ((xi>=2 && xi<=3) ? 1:0));
                wait (dut.state == dut.S_READY);
            end
        end

    end
    */

    /*
        // Reset
        repeat (3) @(posedge clk);
        rst = 0;

        // Start of frame, first pixel (x starts at 0, y=0)
        // Drive first pixel with both frame_start and line_start asserted
        drive_pixel(1, 1, 1, 0, 0);
        // After first pixel, x should have incremented (only because in_valid=1)
        //x should be 1 after first valid pixel
        //y should be 0 on first line
        // Neighbors at (y=0) must be zero (no previous row)
        //line0_pixel0

        // Second pixel on first line
        drive_pixel(1, 0, 0, 0, 1);
        //x should increment to 2");
        //line0_pixel1 // top neighbors are still 0; left is current-row label (still 0)

        // Stall one cycle: x must not change when in_valid=0
        @(negedge clk);
        drive_pixel(0, 0, 0, 0, 0);
        @(posedge clk);
        //x must hold during stall (in_valid=0)

        // More pixels on first line (not strictly needed)
        drive_pixel(1, 0, 0, 0, 1); // x=3
        drive_pixel(1, 0, 0, 0, 1); // x=4
        //x should be 4 after two more pixels

        // Start second line: assert line_start; no valid pixel this cycle
        drive_pixel(0, 0, 1, 0, 0);
        //x should reset to 0 on new line when in_valid=0
        //y should increment to 1 at new line
        // toggle_line must flip each new line
        // Save toggle state and check it flipped relative to first line
        //toggle_line should be 1 on second line

        // Preload previous row labels so we can test neighbor helpers (prev=row1 when toggle_line=1)
        // We will test at x=2 on second line: UL=row1[1], U=row1[2], UR=row1[3]
        dut.row1_labels[1] = 12'hA1;
        dut.row1_labels[2] = 12'hA2;
        dut.row1_labels[3] = 12'hA3;

        // Pixel x=0 on second line: all neighbors except U/UR zero (but prev row initialized zeros except indices above)
        drive_pixel(1, 0, 0, 0, 1); // x becomes 1
        // At x=0, UL=0, L=0, U=row1[0]=0 (we didn't set), UR=row1[1]=A1 but boundary at x=0 still allows UR
        //            "L at x=0 must be 0");
        //            "UL at x=0 must be 0");
        //            "U at x=0 expected 0");
        //       "UR at x=0 should equal row1[1]");

        // Pixel x=1 on second line: UL=row1[0]=0, U=row1[1]=A1, UR=row1[2]=A2
        drive_pixel(1, 0, 0, 0, 1); // x becomes 2
        //            "UL at x=1 expected 0");
        //       "U at x=1 should equal row1[1]");
        //       "UR at x=1 should equal row1[2]");

        // Pixel x=2 on second line: UL=row1[1]=A1, U=row1[2]=A2, UR=row1[3]=A3
        drive_pixel(1, 0, 0, 0, 1); // x becomes 3
        //      "UL at x=2 should equal row1[1]");
        //      "U at x=2 should equal row1[2]");
        //      "UR at x=2 should equal row1[3]");

        // L check note:
        // Current code writes current-row labels each pixel (right now zero), so L will be 0 in these tests.
        // After we add label assignment, we can extend this to check L against the label at x-1.

    end
    */
endmodule
