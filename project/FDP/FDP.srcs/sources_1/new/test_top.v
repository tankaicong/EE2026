module test_top(
    input clk,
    input btnU,
    output [15:0] led,
    output [7:0] seg,
    output [3:0] an,
    input [15:0] sw,

    inout mouse_clk,
    inout mouse_data,

    output vga_Hsync,
    output vga_Vsync,
    output [11:0] vga_RGB
);

    // ----------- CLOCKS ----------- //
    // Generate 25 MHz (for VGA) and 24 MHz (for camera) clocks from 100 MHz input
    wire clk_status, clk25, clk24, clk50;
    display_clocks disp_clocks(
        .clk_in1(clk),
        .clk_out1(clk25),
        .clk_out2(clk24),
        .clk_out3(clk50),
        .reset(btnU),
        .locked(clk_status)
    );

    // ----------- VGA CONTROLLER ----------- //
    // Wire for BRAM address from VGA controller
    wire [16:0] frame_addr;             // logical 0..(320*240-1)
    wire [11:0] image_pixel;            // 12-bit RGB444 from BRAM
    reg [11:0] frame_pixel;            // RGB444 to VGA
    wire [9:0] frame_x;  // current x coord in frame (0..639)
    wire [9:0] frame_y;  // current y coord in frame (0..479)
    wire active_area;

    VGA_Controller vga(
        .clk25(clk25),
        .vga_red(vga_RGB[11:8]),
        .vga_green(vga_RGB[7:4]), 
        .vga_blue(vga_RGB[3:0]),
        .vga_hsync(vga_Hsync),
        .vga_vsync(vga_Vsync),
        .frame_addr(frame_addr),
        .frame_x(frame_x),
        .frame_y(frame_y),
        .frame_pixel(frame_pixel),
        .active_area(active_area)
    );



    // ----------- VGA MOUSE INTERFACE ----------- //
    // Synchronize reset to mouse controller clock domain
    reg [2:0] mouse_rst_sync = 3'b111;
    always @(posedge clk) begin
        mouse_rst_sync <= {mouse_rst_sync[1:0], btnU};
    end
    wire mouse_reset = mouse_rst_sync[2];

    wire left_click, right_click, new_event;
    wire [11:0] mouse_x_raw, mouse_y_raw;
    wire [3:0] zpos;
    
    MouseCtl mouse_instance (
        .clk(clk),
        .rst(mouse_reset),
        .ps2_clk(mouse_clk),
        .ps2_data(mouse_data),
        .xpos(mouse_x_raw),
        .ypos(mouse_y_raw),
        .zpos(zpos),
        .left(left_click),
        .right(right_click),
        .new_event(new_event),
        // .setx(1'b0),
        // .sety(1'b0),
        .setmax_x(10'd640),
        .setmax_y(9'd480),
        .setx(),
        .sety(),
        // .setmax_x(),
        // .setmax_y(),
        // .value(12'd1024)
        .value()
    );

    // Synchronize mouse inputs to clk25 domain with main VGA logic
    reg [2:0] left_click_sync = 3'b000;
    reg [2:0] right_click_sync = 3'b000;
    reg [11:0] mouse_x_sync, mouse_y_sync;

    always @(posedge clk25) begin
        if (vga_reset) begin
            left_click_sync <= 3'b000;
            right_click_sync <= 3'b000;
            mouse_x_sync <= 12'd0;
            mouse_y_sync <= 12'd0;
        end else begin
            left_click_sync <= {left_click_sync[1:0], left_click};
            right_click_sync <= {right_click_sync[1:0], right_click};
            mouse_x_sync <= mouse_x_raw;
            mouse_y_sync <= mouse_y_raw;
        end
    end

    // Generate one-cycle scroll pulses (clk25 domain) from MouseCtl zpos (4-bit signed)
    reg [3:0] zpos_sync1 = 4'd0, zpos_sync2 = 4'd0, zpos_q = 4'd0;
    reg       scroll_up_pulse = 1'b0;
    reg       scroll_down_pulse = 1'b0;
    always @(posedge clk25) begin
        if (vga_reset) begin
            zpos_sync1 <= 4'd0; zpos_sync2 <= 4'd0; zpos_q <= 4'd0;
            scroll_up_pulse <= 1'b0; scroll_down_pulse <= 1'b0;
        end else begin
            zpos_sync1 <= zpos;
            zpos_sync2 <= zpos_sync1;
            zpos_q     <= zpos_sync2;
            scroll_up_pulse   <= (zpos_sync2 != 4'd0) && (zpos_sync2[3] == 1'b0) && (zpos_q == 4'd0);
            scroll_down_pulse <= (zpos_sync2 != 4'd0) && (zpos_sync2[3] == 1'b1) && (zpos_q == 4'd0);
        end
    end

    // Simple asymmetric debouncers in clk25 domain
    // - Left/right latch immediately on press
    // - Release only after a continuous low for a slightly longer threshold to avoid false releases on hold
    localparam [19:0] RELEASE_L = 19'd2500000; // 0.1 s at 25 MHz
    localparam [19:0] RELEASE_R = 19'd500000;  // 0.02 s at 25 MHz

    // Left-click debouncer: hold won't release on short bounces
    reg [19:0] l_rel_cnt = 19'd0;
    reg        left_deb  = 1'b0; // debounced level
    always @(posedge clk25) begin
        if (vga_reset) begin
            left_deb  <= 1'b0;
            l_rel_cnt <= 19'd0;
        end else begin
            if (left_click_sync[1]) begin
                // immediate latch on press
                left_deb  <= 1'b1;
                l_rel_cnt <= 19'd0;
            end else if (left_deb) begin
                // count continuous lows before releasing
                if (l_rel_cnt >= RELEASE_L) begin
                    left_deb  <= 1'b0;
                    l_rel_cnt <= 19'd0;
                end else begin
                    l_rel_cnt <= l_rel_cnt + 1'b1;
                end
            end else begin
                l_rel_cnt <= 19'd0;
            end
        end
    end
    reg left_deb_q = 1'b0;
    always @(posedge clk25) begin
        if (vga_reset) left_deb_q <= 1'b0; else left_deb_q <= left_deb;
    end
    wire left_click_edge = left_deb & ~left_deb_q;
    wire left_click_fall = ~left_deb & left_deb_q;
    wire left_click_deb  = left_deb;

    // Right-click debouncer: same simple scheme
    reg [19:0] r_rel_cnt = 19'd0;
    reg        right_deb = 1'b0;
    always @(posedge clk25) begin
        if (vga_reset) begin
            right_deb <= 1'b0;
            r_rel_cnt <= 19'd0;
        end else begin
            if (right_click_sync[1]) begin
                right_deb <= 1'b1;
                r_rel_cnt <= 19'd0;
            end else if (right_deb) begin
                if (r_rel_cnt >= RELEASE_R) begin
                    right_deb <= 1'b0;
                    r_rel_cnt <= 19'd0;
                end else begin
                    r_rel_cnt <= r_rel_cnt + 1'b1;
                end
            end else begin
                r_rel_cnt <= 19'd0;
            end
        end
    end
    reg right_deb_q = 1'b0;
    always @(posedge clk25) begin
        if (vga_reset) right_deb_q <= 1'b0; else right_deb_q <= right_deb;
    end
    wire right_click_edge = right_deb & ~right_deb_q;
    wire right_click_deb  = right_deb;
 
    // VGA mouse - clamp to screen bounds
    // wire [9:0] mouse_x_vga = (mouse_x_sync >= 12'd639) ? 10'd639 : mouse_x_sync[9:0];
    wire [8:0] mouse_y_vga = (mouse_y_sync >= 12'd479) ? 9'd479 : mouse_y_sync[8:0];
    wire [9:0] mouse_x_vga = mouse_x_sync;
    // wire [8:0] mouse_y_vga = mouse_y_sync;
    // VGA-space 3x3 cursor for VGA-based UIs (e.g., settings overlays) to avoid source-grid offset
    wire [9:0] vga_dx = (frame_x > mouse_x_vga) ? (frame_x - mouse_x_vga) : (mouse_x_vga - frame_x);
    wire [8:0] vga_dy = (frame_y > mouse_y_vga) ? (frame_y - mouse_y_vga) : (mouse_y_vga - frame_y);
    wire       within_cursor_vga_3x3 = (vga_dx <= 10'd1) && (vga_dy <= 9'd1);

    reg [59:0] move_x = 60'h5018A751FE8A252;
    reg [53:0] move_y = 54'h2C160B0582C160;
    wire write_high;
    wire [3:0] overlay_pixel;
    generate_bram_overlay gen_ovrly (
        .clk(clk),        // 100MHz clock (used for position updates)
        .clk25(clk25),    // 25MHz VGA clock for BRAM reads
        .en(1'b1),          // Always enabled
        // .x(boxes_x_vector),
        // .y(boxes_y_vector),
        .x(move_x),
        .y(move_y),
        .gauss_t_x(info_pix_x),
        .gauss_t_y(info_pix_y),
        .frame_x(frame_x),
        .frame_y(frame_y),
        .front_idx(front_idx),
        .final_out(final_out),
        .ufds_settings_mode(0),
        .to_write(write_high),
        .image_pixel(overlay_pixel)
    );

    // Overlay pixel from settings UI (drag/drop) in VGA coordinates
    wire cv_sett_overlay_en;
    wire [11:0] cv_sett_overlay;
    // Click pulses from CV settings overlay selection boxes
    wire cam_box_clicked;
    wire bitmap_box_clicked;
    wire ufds_box_clicked;
    // Change-view selection code from overlay (00 CAM, 01 PRE, 11 BITMAP, 10 MORPH)
    cv_settings_overlay settings_cv_overlay (
        .clk(clk25), .reset(vga_reset), .settings_active(cv_settings_mode),
        .px(frame_x), .py(frame_y),
        .start_red_val(start_red_val), .end_red_val(end_red_val),
        .start_green_val(start_green_val), .end_green_val(end_green_val), 
        .start_blue_val(start_blue_val), .end_blue_val(end_blue_val),
        .mouse_x(mouse_x_vga), .mouse_y(mouse_y_vga), .left_edge(left_click_edge),
        .boxes_x(boxes_x_vector), .boxes_y(boxes_y_vector),
        .front_idx(front_idx),
        .overlay_en(cv_sett_overlay_en), .overlay_rgb(cv_sett_overlay),
        .cam_box_click(cam_box_clicked), .bitmap_box_click(bitmap_box_clicked), .ufds_box_click(ufds_box_clicked),
        .pre_x_o(PRE_X_VGA), .pre_y_o(PRE_Y_VGA), .pre_w_o(PRE_W_VGA), .pre_h_o(PRE_H_VGA),
        .morph_x_o(MORPH_X_VGA), .morph_y_o(MORPH_Y_VGA), .morph_w_o(MORPH_W_VGA), .morph_h_o(MORPH_H_VGA),
        .final_out(final_out)
    );


    // === Info tab animation: moving pixel (x,y) and color ===
    wire [9:0] info_pix_x;
    wire [8:0] info_pix_y;
    wire [2:0] info_idx;
    wire [11:0] info_pix_rgb;
    cv_settings_info_tab info_tab (
        .clk(clk25), .reset(vga_reset), .settings_active(cv_settings_mode),
        .mouse_x(mouse_x_vga), .mouse_y(mouse_y_vga), .left_edge(left_click_edge),
        .cam_box_click(cam_box_clicked), .bitmap_box_click(bitmap_box_clicked), .ufds_box_click(ufds_box_clicked),
        .gauss_click(gauss_click_mv), .median_click(median_click_mv), .erode_click(erode_click_mv), .dilate_click(dilate_click_mv),
        .pix_x(info_pix_x), .pix_y(info_pix_y), .info_idx(info_idx), .pix_rgb(info_pix_rgb)
    );

    // Education tabs text renderer (overlay strings)
    wire edu_en;
    wire [11:0] edu_rgb;
    // Education_Tabs_State gen_edu_tab (
    Education_Tabs_ctr gen_edu_tab (
    // Education_Tab gen_edu_tab (
        .clk(clk),
        .clk25(clk25),
        .rst(btnU),
        .seg(0),
        .an(0),
        .led(0),
        .frame_x(frame_x),
        .frame_y(frame_y),
        .change_x(info_pix_x),
        .change_y(info_pix_y),
        .info_select(cv_settings_mode),
        .edu_rgb(edu_rgb),
        .edu_pixel_en(edu_en),
        .input_offset(sw[14:5])
    );


    // Education tabs text renderer (overlay strings)
    wire edu_en_1;
    wire [11:0] edu_rgb_1;
    Education_Tabs_State gen_edu_tab1 (
    // Education_Tabs_ctr gen_edu_tab (
    // Education_Tab gen_edu_tab (
        .clk(clk),
        .clk25(clk25),
        .rst(btnU),
        .seg(0),
        .an(0),
        .led(0),
        .frame_x(frame_x),
        .frame_y(frame_y),
        .change_x(info_pix_x - 300),
        .change_y(info_pix_y),
        .info_select(cv_settings_mode),
        .edu_rgb(edu_rgb_1),
        .edu_pixel_en(edu_en_1),
        .input_offset(sw[14:5])
    );

    // Education tabs text renderer (overlay strings)
    wire edu_en_2;
    wire [11:0] edu_rgb_2;
    // Education_Tabs_State gen_edu_tab (
    // Education_Tabs_ctr gen_edu_tab (
    Education_Tab gen_edu_tab2 (
        .clk(clk),
        .clk25(clk25),
        .rst(btnU),
        .seg(0),
        .an(0),
        .led(0),
        .frame_x(frame_x),
        .frame_y(frame_y),
        .change_x(info_pix_x),
        .change_y(info_pix_y - 150),
        .info_select(cv_settings_mode),
        .edu_rgb(edu_rgb_2),
        .edu_pixel_en(edu_en_2),
        .input_offset(sw[14:5])
    );

    wire [11:0] crosshair_rgb = 12'hF0F;

    // Generate edu tabs
    wire [4:0] cv_settings_mode;
    assign cv_settings_mode = sw[4:0];

    // Generate edu tabs
    always @(posedge clk25) begin
        frame_pixel <= 12'hFFF;
        // Info tab has priority over frame pixel
        
        if (sw[15] && write_high && (overlay_pixel != 4'hF)) begin
            if (overlay_pixel == 4'h0) frame_pixel <= 12'h000;
            else if (overlay_pixel == 4'h1) frame_pixel <= 12'hFFF;
            else if (overlay_pixel == 4'h2) frame_pixel <= 12'h00F;
            else if (overlay_pixel == 4'h3) frame_pixel <= 12'h0F0;
            else if (overlay_pixel == 4'h4) frame_pixel <= 12'hF00;
            else if (overlay_pixel == 4'h5) frame_pixel <= 12'hFF0;
            else if (overlay_pixel == 4'h6) frame_pixel <= 12'hF0F;
            else if (overlay_pixel == 4'h7) frame_pixel <= 12'h0FF;
            else if (overlay_pixel == 4'h8) frame_pixel <= 12'hB75;
            else if (overlay_pixel == 4'h9) frame_pixel <= 12'hECA;
            else if (overlay_pixel == 4'hA) frame_pixel <= 12'hEDB;
            else if (overlay_pixel == 4'hB) frame_pixel <= 12'hBEE;
            else if (overlay_pixel == 4'hC) frame_pixel <= 12'hC70;
            else if (overlay_pixel == 4'hD) frame_pixel <= 12'hFB0;
            else if (overlay_pixel == 4'hE) frame_pixel <= 12'h0CF;   
            // 4'hF is transparent (ignored), anything else unmapped: do nothing
        end


        // Education tabs overwrite base pixel when active
        if (edu_en) begin
            frame_pixel <= edu_rgb;
        end

        if (edu_en_1) begin
            frame_pixel <= edu_rgb_1;
        end

        if (edu_en_2) begin
            frame_pixel <= edu_rgb_2;
        end

        if (within_cursor_vga_3x3) frame_pixel <= 12'h000;

        // if (frame_x > 100 && frame_x <= 105 && frame_y > 100 && frame_y <= 108) begin
        //     frame_pixel <= bram_bit_new ? 12'hF00 : 12'h0FF;
        //     edu_tab_addr_new <= edu_tab_addr_new + 1;
        // end
        // if (frame_x == 0 && frame_y == 0) begin
        //     edu_tab_addr_new <= 12'd0;
        // end
    end
endmodule