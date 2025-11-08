`timescale 1ns / 1ps

module Top(
    input clk, btnU,
    input btnC, btnR, btnL, btnD,

    output ov7670_pwdn, ov7670_reset, ov7670_xclk,
    input ov7670_href_pin, ov7670_pclk_pin, ov7670_vsync_pin,
    inout ov7670_siod,
    output ov7670_sioc,
    input [7:0] ov7670_d_pin,
    output reg [15:0] led,
    input [15:0] sw,

    input coin_input,

    inout mouse_clk,
    inout mouse_data,
    output servo_x_pwm,
    output servo_y_pwm,

    output [7:0] seg,
    output [3:0] an,

    // UART pins
    output uart_tx,
    input  uart_rx,

    output vga_Hsync,
    output vga_Vsync,
    output [11:0] vga_RGB    //4-bit red, 4-bit green, 4-bit blue
    );

// ----------- Overall FSM ----------- //
    
    // Overlays pixel with other graphics based on program state (background = bram_final_pixel_out when sw[15] is off)
    // current flow should be: S_MENU -> S_USER_SETTINGS -> S_MENU -> S_GAME_(MANUAL/AUTO)_MODE
    reg[2:0] state = 0;
    reg[2:0] prev_state = 0; // remember previous state
    localparam S_MENU = 0;
    localparam S_CV_SETTINGS = 1; // CV settings (right-click toggle)
    wire info_dim_en; // dim mask from CV settings overlay (info tab region)
    // localparam S_USER_SETTINGS = 2; // Display settings (btnC toggle)
    // localparam S_GAME_MANUAL_MODE = 3;
    localparam S_GAME_AUTO_MODE = 4;
    localparam S_UFDS_SETTINGS = 5; // UFDS settings page

    wire cv_settings_mode = (state == S_CV_SETTINGS);
    // wire user_settings_mode = (state == S_USER_SETTINGS);
    wire ufds_settings_mode = (state == S_UFDS_SETTINGS);

    wire menu_mode = (state == S_MENU);
    
    // Crosshair color mapping from selection
    wire [11:0] crosshair_rgb = CYAN;

    wire [10:0] convolution_cutoff_x = (Final_Out_Control == 2'b11) ? (640 - (Total_Count-1)*2) : 640 - (Pre_Count-1)*2;
    wire [9:0] convolution_cutoff_y = (Final_Out_Control == 2'b11) ? (480 - (Total_Count-1)*2) : 480 - (Pre_Count-1)*2;

    always @(posedge clk25) begin
        if (btnU) begin
            state <= S_MENU;
        end 
        else begin 
            // every pixel that is not overwritten should be the camera's output
            if (frame_y >= convolution_cutoff_y || frame_x >= convolution_cutoff_x) begin   //remove unwritten borders from convolutions
                frame_pixel <= BLACK;
            end else begin
                frame_pixel <= bram_final_pixel_out;
            end
        end
        
        // State machine for different overlays
        case (state)
            S_MENU: begin
                if (left_click_edge || right_click_edge || coin_input) begin
                    state <= S_CV_SETTINGS;
                end
                // else begin
                //     // // Display box for start game manual
                //     // if ((frame_x >= 33) && (frame_x <= 87) && (frame_y >= 123) && (frame_y <= 177)) begin
                //     //     frame_pixel <= GREEN; // green fill
                //     // end
                //     // // if (a_fill) begin
                //     // if ((frame_x >= 183) && (frame_x <= 177) && (frame_y >= 123) && (frame_y <= 177)) begin
                //     //     frame_pixel <= BLUE; // red fill
                //     // end
                // end
            end
            
            S_CV_SETTINGS: begin
                // right-click again to return to prev_state
                if (right_click_edge) begin
                    state <= S_GAME_AUTO_MODE;
                    prev_state <= S_CV_SETTINGS;
                end
                // Enter UFDS settings when UFDS box is clicked
                if (ufds_box_clicked) begin
                    state <= S_UFDS_SETTINGS;
                    prev_state <= S_UFDS_SETTINGS;
                end
                // this is the layer order:
                // bram_final_pixel_out (camera frame)
                // dim if frame_y >= 324
                // cv_settings overlay (borders, toggles, guidelines; no GB/MF/EA/EB/DA/DB fills now)
                // BRAM overlay (skips if overlay_pixel == F, so transparency works)
                // cursor


                // Dim camera feed under the settings region (rows >= 324), keep normal feed above
                if (frame_y >= convolution_cutoff_y || frame_x >= convolution_cutoff_x) begin   //remove unwritten borders from convolutions
                    frame_pixel <= BLACK;
                end
                else if (frame_y >= 9'd324) begin
                    // Per-channel dimming (RGB444 -> quarter brightness)
                    frame_pixel <= { (bram_final_pixel_out[11:8] >> 2), (bram_final_pixel_out[7:4] >> 2), (bram_final_pixel_out[3:0] >> 2) };
                end
                
                if (thr_section_active) frame_pixel <= thr_section_pixel;
                // draw CV settings overlay, then the info pixel, then draw cursor on top
                if (cv_sett_overlay_en) frame_pixel <= cv_sett_overlay;

                // Info pixel on top of overlay
                // if ((frame_x == info_pix_x) && (frame_y == info_pix_y)) frame_pixel <= info_pix_rgb;
                // BRAM overlay BACKGROUND pass: draw static assets only (mask out box interiors)
                if (write_high && (overlay_pixel != 4'hF)) begin
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

                // Use VGA-space cursor here (overlay also uses VGA coords)
                if (vga_cursor_border) frame_pixel <= 12'h000; // black outline
                else if (vga_cursor_fill) frame_pixel <= 12'hFFF; // white fill
            end

            S_UFDS_SETTINGS: begin
                // right-click or Return box to go back to CV settings
                if (right_click_edge) begin 
                    state <= S_GAME_AUTO_MODE;
                    prev_state <= S_UFDS_SETTINGS;
                end
                if (ufds_return_click) begin 
                    state <= S_CV_SETTINGS;
                    prev_state <= S_CV_SETTINGS;
                end

                // Dim camera feed under the settings region (rows >= 324)
                if (frame_y >= convolution_cutoff_y || frame_x >= convolution_cutoff_x) begin   // remove unwritten borders from convolutions
                    frame_pixel <= BLACK;
                end 
                if (info_dim_en) begin
                    // Dim only inside info tab region (to the right of GREEN barrier during animation)
                    frame_pixel <= { (bram_final_pixel_out[11:8] >> 2), (bram_final_pixel_out[7:4] >> 2), (bram_final_pixel_out[3:0] >> 2) };
                end
                if (frame_y >= 9'd324) begin
                    // Fallback: dim entire bottom settings strip
                    frame_pixel <= { (bram_final_pixel_out[11:8] >> 2), (bram_final_pixel_out[7:4] >> 2), (bram_final_pixel_out[3:0] >> 2) };
                end

                if (frame_addr == 74399) begin
                    // snapshot UFDS results once per VGA frame
                    left0_l <= left0; right0_l <= right0; cx0_l <= cx0; top0_l <= top0; bottom0_l <= bottom0; cy0_l <= cy0;
                    left1_l <= left1; right1_l <= right1; cx1_l <= cx1; top1_l <= top1; bottom1_l <= bottom1; cy1_l <= cy1;
                    left2_l <= left2; right2_l <= right2; cx2_l <= cx2; top2_l <= top2; bottom2_l <= bottom2; cy2_l <= cy2;
                    left3_l <= left3; right3_l <= right3; cx3_l <= cx3; top3_l <= top3; bottom3_l <= bottom3; cy3_l <= cy3;                end

                if (in_roi && (
                    // Comp 0
                    (
                        (frame_x[9:1]-10 == left0_l  && frame_y[9:1] >= top0_l    && frame_y[9:1] <= bottom0_l) ||
                        (frame_x[9:1]-10 == right0_l && frame_y[9:1] >= top0_l    && frame_y[9:1] <= bottom0_l) ||
                        (frame_y[9:1] == top0_l      && frame_x[9:1]-10 >= left0_l  && frame_x[9:1]-10 <= right0_l) ||
                        (frame_y[9:1] == bottom0_l   && frame_x[9:1]-10 >= left0_l  && frame_x[9:1]-10 <= right0_l) ||
                        (frame_x[9:1]-10 == cx0_l    && frame_y[9:1] >= cy0_l-2 && frame_y[9:1] <= cy0_l+2) ||
                        (frame_y[9:1] == cy0_l       && frame_x[9:1]-10 >= cx0_l-2 && frame_x[9:1]-10 <= cx0_l+2)
                    ) ||
                    // Comp 1
                    (
                        (frame_x[9:1]-10 == left1_l  && frame_y[9:1] >= top1_l    && frame_y[9:1] <= bottom1_l) ||
                        (frame_x[9:1]-10 == right1_l && frame_y[9:1] >= top1_l    && frame_y[9:1] <= bottom1_l) ||
                        (frame_y[9:1] == top1_l      && frame_x[9:1]-10 >= left1_l  && frame_x[9:1]-10 <= right1_l) ||
                        (frame_y[9:1] == bottom1_l   && frame_x[9:1]-10 >= left1_l  && frame_x[9:1]-10 <= right1_l) ||
                        (frame_x[9:1]-10 == cx1_l    && frame_y[9:1] >= cy1_l-2 && frame_y[9:1] <= cy1_l+2) ||
                        (frame_y[9:1] == cy1_l       && frame_x[9:1]-10 >= cx1_l-2 && frame_x[9:1]-10 <= cx1_l+2)
                    ) ||
                    // Comp 2
                    (
                        (frame_x[9:1]-10 == left2_l  && frame_y[9:1] >= top2_l    && frame_y[9:1] <= bottom2_l) ||
                        (frame_x[9:1]-10 == right2_l && frame_y[9:1] >= top2_l    && frame_y[9:1] <= bottom2_l) ||
                        (frame_y[9:1] == top2_l      && frame_x[9:1]-10 >= left2_l  && frame_x[9:1]-10 <= right2_l) ||
                        (frame_y[9:1] == bottom2_l   && frame_x[9:1]-10 >= left2_l  && frame_x[9:1]-10 <= right2_l) ||
                        (frame_x[9:1]-10 == cx2_l    && frame_y[9:1] >= cy2_l-2 && frame_y[9:1] <= cy2_l+2) ||
                        (frame_y[9:1] == cy2_l       && frame_x[9:1]-10 >= cx2_l-2 && frame_x[9:1]-10 <= cx2_l+2)
                    ) ||
                    // Comp 3
                    (
                        (frame_x[9:1]-10 == left3_l  && frame_y[9:1] >= top3_l    && frame_y[9:1] <= bottom3_l) ||
                        (frame_x[9:1]-10 == right3_l && frame_y[9:1] >= top3_l    && frame_y[9:1] <= bottom3_l) ||
                        (frame_y[9:1] == top3_l      && frame_x[9:1]-10 >= left3_l  && frame_x[9:1]-10 <= right3_l) ||
                        (frame_y[9:1] == bottom3_l   && frame_x[9:1]-10 >= left3_l  && frame_x[9:1]-10 <= right3_l) ||
                        (frame_x[9:1]-10 == cx3_l    && frame_y[9:1] >= cy3_l-2 && frame_y[9:1] <= cy3_l+2) ||
                        (frame_y[9:1] == cy3_l       && frame_x[9:1]-10 >= cx3_l-2 && frame_x[9:1]-10 <= cx3_l+2)
                    )
                )) begin
                    frame_pixel <= GREEN;
                end


                // Info tab overlay
                if (tab_en && frame_y < 9'd324) frame_pixel <= tab_rgb;
                    
                // UFDS overlay
                if (ufds_overlay_en) frame_pixel <= ufds_overlay_rgb;

                // Pull from BRAM
                if (write_high && (overlay_pixel != 4'hF)) begin
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

                // Cursor on top
                if (vga_cursor_border) frame_pixel <= 12'h000; // black outline
                else if (vga_cursor_fill) frame_pixel <= 12'hFFF; // white fill
            end

            S_GAME_AUTO_MODE: begin
                if (right_click_edge && prev_state == S_CV_SETTINGS) state = S_CV_SETTINGS;
                if (right_click_edge && prev_state == S_UFDS_SETTINGS) state = S_UFDS_SETTINGS;

                // Renamed manual mode
                // --- Crosshair drawing with user-selected color ---
                // === Bottom vertical arm ===
                if (frame_x[9:1]-10 == 155 && frame_y[9:1] >= 120+2 && frame_y[9:1] <= 120+5) begin
                    frame_pixel <= crosshair_rgb;
                end

                // === Top vertical arm ===
                else if (frame_x[9:1]-10 == 155 && frame_y[9:1] >= 120-5 && frame_y[9:1] <= 120-2) begin
                    frame_pixel <= crosshair_rgb;
                end

                // === Left horizontal arm ===
                else if (frame_y[9:1] == 120 && frame_x[9:1]-10 >= 155-5 && frame_x[9:1]-10 <= 155-2) begin
                    frame_pixel <= crosshair_rgb;

                end

                // === Right horizontal arm ===
                else if (frame_y[9:1] == 120 && frame_x[9:1]-10 >= 155+2 && frame_x[9:1]-10 <= 155+5) begin
                    frame_pixel <= crosshair_rgb;
                end
            end

            default: begin
                state <= state;
            end
        endcase
    end
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

    wire ov7670_href;
    wire ov7670_pclk;
    wire ov7670_vsync;
    wire [7:0] ov7670_d;
    // assign ov7670_href = sw[15] ? 1'bz : ov7670_href_pin;
    // assign ov7670_pclk = sw[15] ? 1'bz : ov7670_pclk_pin;
    // assign ov7670_vsync = sw[15] ? 1'bz : ov7670_vsync_pin;
    // assign ov7670_d = sw[15] ? 8'bzzzzzzzz : ov7670_d_pin;
    assign ov7670_href = ov7670_href_pin;
    assign ov7670_pclk = ov7670_pclk_pin;
    assign ov7670_vsync = ov7670_vsync_pin;
    assign ov7670_d = ov7670_d_pin;

// ----------- OV7670 CAMERA ----------- //
    // Generate a single-cycle resend pulse in the 24 MHz camera clock domain
    // so a button press replays the full I2C register sequence once.
    reg [2:0] btnU_sync24 = 3'b000;
    always @(posedge clk24) begin
        btnU_sync24 <= {btnU_sync24[1:0], btnU};
    end
    wire cam_resend_pulse = btnU_sync24[0] & ~btnU_sync24[1];

    OV7670_Controller ov7670(
        .clk(clk24),
        .resend(cam_resend_pulse),
        .config_finished(),
        .sioc(ov7670_sioc),
        .siod(ov7670_siod),
        .reset(ov7670_reset),
        .pwdn(ov7670_pwdn),
        .xclk(ov7670_xclk)
    );

    wire we;
    wire [16:0] addr;          // logical capture address within a frame (0..74399)
    wire [11:0] dout;          // RGB444 from capture

    // Debounce / synchronize btnU to camera pixel clock domain for capture reset
    reg [2:0] reset_sync = 3'b111;
    always @(posedge ov7670_pclk) begin
        reset_sync <= {reset_sync[1:0], btnU};
    end
    wire cap_reset = reset_sync[2];

    OV7670_Capture ov7670_capture(
        .pclk(ov7670_pclk),
        .vsync(ov7670_vsync),
        .href(ov7670_href),
        .ext_reset(cap_reset),
        .d(ov7670_d),
        .addr(addr),
        .dout(dout),
        .we(we)
    );

// ------------ CV PIPELINE ------------ //

// ----------- GAUSSIAN 3x3 via Convolution3x3 ----------- //
    // Kernel: [1 2 1; 2 4 2; 1 2 1] with SCALE=4 (divide by 16)
    wire                    pixel_valid_gauss_3x3;
    wire [11:0]             filtered_pixel_gauss_3x3;
    wire [16:0]             filtered_addr_gauss_3x3;
    Convolution_3x3_Improved #(
        .IMAGE_WIDTH(310),
        .IMAGE_HEIGHT(240),
        .PIXEL_DEPTH(12),
        .COEF_WIDTH(8),
        .k00(1), .k01(2), .k02(1),
        .k10(2), .k11(4), .k12(2),
        .k20(1), .k21(2), .k22(1),
        .BIAS(0),
        .SCALE(4)
    ) gaussian3x3 (
        .clk(ov7670_pclk),
        .reset(cap_reset),
        .frame_start(ov7670_vsync),
        .we(gaussian_pixel_we),
        .mode_rgb(1'b1),             // camera provides RGB444
        .pixel_rgb_in(gaussian_pixel_in),
        .pixel_bin_in(1'b0),
        .addr_off_col(gaussian_addr_off_col),
        .addr_off_row(gaussian_addr_off_row),
        .pixel_out(gaussian_pixel_out),
        .addr_out(gaussian_addr_out),
        .pixel_valid(gaussian_pixel_valid)
    );

//----------- MEDIAN FILTERS (3x3 and 5x5) ----------- //
    // // 3x3 instance
    Median_Filter #(
        .KERNEL_SIZE(3),
        .PIXEL_DEPTH(12),
        .IMAGE_WIDTH(310),
        .IMAGE_HEIGHT(240)
    )
    median_filter(
        .clk(ov7670_pclk),
        .reset(cap_reset),
        .frame_start(ov7670_vsync),
        .pixel_in(median_pixel_in),
        .we(median_pixel_we),
        .addr_off_col(median_addr_off_col),
        .addr_off_row(median_addr_off_row),
        .pixel_out(median_pixel_out),
        .addr_out(median_addr_out),
        .pixel_valid(median_pixel_valid)
    );

//----------- MORPHOLOGY (ERODE/DILATE) ----------- //

    Morphology_3x3 #(
        .IMAGE_WIDTH(310),
        .IMAGE_HEIGHT(240)
    ) B1 (
        .clk(ov7670_pclk),
        .reset(cap_reset),
        .frame_start(ov7670_vsync),
        .we(rgb_pixel_valid),
        .pixel_in(threshold_pixel),
        .op_dilate(Morphology_State[0]),                 // Morphology_State bit now directly 1 = DILATE
        .addr_off_col(B1_addr_off_col),
        .addr_off_row(B1_addr_off_row),
        .pixel_out(B1_pixel_out),
        .addr_out(B1_addr_out),
        .pixel_valid(B1_pixel_valid)
    );
    Morphology_3x3 #(
        .IMAGE_WIDTH(310),
        .IMAGE_HEIGHT(240)
    ) B2 (
        .clk(ov7670_pclk),
        .reset(cap_reset),
        .frame_start(ov7670_vsync),
        .we(B1_pixel_valid),
        .pixel_in(B1_pixel_out),
        .op_dilate(Morphology_State[1]),                 // 1 = DILATE
        .addr_off_col(B2_addr_off_col),
        .addr_off_row(B2_addr_off_row),
        .pixel_out(B2_pixel_out),
        .addr_out(B2_addr_out),
        .pixel_valid(B2_pixel_valid)
    );

    Morphology_3x3 #(
        .IMAGE_WIDTH(310),
        .IMAGE_HEIGHT(240)
    ) B3 (
        .clk(ov7670_pclk),
        .reset(cap_reset),
        .frame_start(ov7670_vsync),
        .we(B2_pixel_valid),
        .pixel_in(B2_pixel_out),
        .op_dilate(Morphology_State[2]),                 // 1 = DILATE
        .addr_off_col(B3_addr_off_col),
        .addr_off_row(B3_addr_off_row),
        .pixel_out(B3_pixel_out),
        .addr_out(B3_addr_out),
        .pixel_valid(B3_pixel_valid)
    );
    Morphology_3x3 #(
        .IMAGE_WIDTH(310),
        .IMAGE_HEIGHT(240)
    ) B4 (
        .clk(ov7670_pclk),
        .reset(cap_reset),
        .frame_start(ov7670_vsync),
        .we(B3_pixel_valid),
        .pixel_in(B3_pixel_out),
        .op_dilate(Morphology_State[3]),                 // 1 = DILATE
        .addr_off_col(B4_addr_off_col),
        .addr_off_row(B4_addr_off_row),
        .pixel_out(B4_pixel_out),
        .addr_out(B4_addr_out),
        .pixel_valid(B4_pixel_valid)
    );

//----------- PING PONG BUFFERS ----------- //
    //No hard guards or syncs now, both just triggering the BRAM upper/lower swap on Vsync
    //Seems to be working fine and no tears for now so f it we ball I guess
    
    //Ping-pong buffer parameters (RGB444, 12-bit):
    localparam [17:0] FRAME_PIXELS   = 18'd74400;
    localparam [17:0] TOTAL_PIXELS   = 18'd148800; // 2*74400

    //PCLK domain: toggle write buffer on rising edge of camera VSYNC
    reg vsync_d1 = 1'b0;
    reg vsync_d2 = 1'b0;
    always @(posedge ov7670_pclk) begin
        vsync_d1 <= ov7670_vsync;
        vsync_d2 <= vsync_d1;
    end
    wire cam_vsync_rise = (vsync_d1 & ~vsync_d2);

    //WRITE to top half at start (1 = TOP half, 0 = BOTTOM half)
    reg wr_sel = 1'b1; // start writing TOP
    always @(posedge ov7670_pclk) begin
        if (cap_reset) wr_sel <= 1'b1;  // reset to TOP
        else if (cam_vsync_rise) wr_sel <= ~wr_sel;
    end

    //clk25 (VGA) domain: toggle read buffer on rising edge of VGA VSYNC (technically vsync is active low but catching the posedge is fine too)
    reg [1:0] vga_rst_sync = 2'b00;
    reg vga_vsync_d1 = 1'b0, vga_vsync_d2 = 1'b0;
    always @(posedge clk25) begin
        vga_rst_sync <= {vga_rst_sync[0], btnU};
        vga_vsync_d1 <= vga_Vsync;
        vga_vsync_d2 <= vga_vsync_d1;
    end
    wire vga_reset = vga_rst_sync[1];
    wire vga_vsync_rise = (vga_vsync_d1 & ~vga_vsync_d2);

    //READ from bottom half at start (0 = BOTTOM half, 1 = TOP half)
    reg rd_sel = 1'b0; // start reading BOTTOM
    always @(posedge clk25) begin
        if (vga_reset) rd_sel <= 1'b0;  // reset to BOTTOM
        else if (vga_vsync_rise) rd_sel <= ~rd_sel;
    end

    // Compute physical addresses into 2x frame BRAM (18-bit addressing)
    // wire [17:0] wr_base = wr_sel ? FRAME_PIXELS : 18'd0;
    // wire [17:0] rd_base = rd_sel ? FRAME_PIXELS : 18'd0;
    wire [17:0] wr_base = 18'd0;
    wire [17:0] rd_base = 18'd0;
    wire [17:0] addrb18 = {1'b0, frame_addr} + rd_base;

// ----------- ADDRESSING FOR FILTER STAGES ----------- //
    // Use the filter modules' reported center addresses directly. They already
    // correspond to the window center (aligned in the source coordinate space).
    // Widen to 18 bits when mixing with frame bases.
    // assign threshold_addr_bin = sw[4]
    //                             ? (sw[5] ? threshold_addr_dilate_3x3 : threshold_addr_erode_3x3)
    //                             : {1'b0, filtered_addr_color};

    // Latch the write-base per frame so all writes for a frame (including padding flush)
    // target the same half. Arm on VSYNC rise, capture on the first incoming pixel (we==1)
    // of the new frame to avoid any overlap hazards.
    reg [17:0] wr_base_frame = FRAME_PIXELS; // consistent with wr_sel reset to 1 (TOP) on cap_reset
    reg        wrb_arm = 1'b0;
    always @(posedge ov7670_pclk) begin
        if (cap_reset) begin
            wr_base_frame <= FRAME_PIXELS;
            wrb_arm <= 1'b0;
        end else begin
            if (cam_vsync_rise) begin
                wrb_arm <= 1'b1; // prepare to latch base for the next frame
            end
            if (wrb_arm && we) begin
                // wr_sel has already toggled on cam_vsync_rise; use current wr_base
                wr_base_frame <= wr_base;
                wrb_arm <= 1'b0;
            end
        end
    end

//----------- FRAME BUFFER WRITERS ----------- //

    // Unified write controls for both RGB frame buffer and 1-bit bitmap buffer
    // Share write enable and address; keep separate data for RGB (12-bit) and bitmap (1-bit)
    // Separate write enables and addresses for RGB frame buffer and 1-bit bitmap buffer
    reg        we_rgb_w;        // write enable for image_mem
    reg        we_bmp_w;        // write enable for bitmap_mem
    reg [17:0] rgb_waddr18_r;   // write address for image_mem (absolute with base)
    reg [17:0] bmp_waddr18_r;   // write address for bitmap_mem (absolute with base)
    reg [11:0] rgb_dina_r;      // RGB data to image_mem
    reg        bmp_dina_r;      // bitmap data to Dual_Port_Buffer
    // Single pending entry for filtered overwrite (affects both memories)
    // Independent pending entries for RGB and bitmap paths (morphology stages may have different latency)
    reg        pend_rgb;            // pending filtered write (RGB)
    reg        pend_bmp;            // pending filtered write (Bitmap)
    reg [17:0] pend_addr_rgb_q;     // absolute address for filtered center (RGB)
    reg [17:0] pend_addr_bmp_q;     // absolute address for filtered center (Bitmap)
    reg [11:0] fpix_q;         // latched filtered RGB pixel
    reg        bdin_q;          // latched filtered bitmap bit

    // PCLK-domain writer:
    // - Image RGB: raw on we==1, filtered overwrite on we==0
    // - Bitmap 1-bit: raw-threshold on we==1, filtered-threshold overwrite on we==0
    always @(posedge ov7670_pclk) begin
        if (cap_reset) begin
            we_rgb_w <= 1'b0;
            we_bmp_w <= 1'b0;
            rgb_waddr18_r <= 18'd0;
            bmp_waddr18_r <= 18'd0;
            rgb_dina_r <= 12'd0;
            bmp_dina_r <= 1'b0;
            pend_rgb <= 1'b0;
            pend_bmp <= 1'b0;
            pend_addr_rgb_q <= 18'd0;
            pend_addr_bmp_q <= 18'd0;
            fpix_q <= 12'd0;
            bdin_q <= 1'b0;
        end else begin
            // default: no writes asserted this cycle until decided below
            we_rgb_w <= 1'b0;
            we_bmp_w <= 1'b0;

            // Latch pending entries when raw camera write occupies port (we==1)
            // Separate conditions for RGB and bitmap pipelines so morphology latency is respected.
            if (we) begin
                if (final_pixel_we && !pend_rgb) begin
                    pend_rgb <= 1'b1;
                    pend_addr_rgb_q <= final_addr_out;
                    fpix_q <= final_pixel_out; // latest RGB filtered pixel
                end
                if (final_bmp_pixel_we && !pend_bmp) begin
                    pend_bmp <= 1'b1;
                    pend_addr_bmp_q <= final_bmp_addr_out;
                    bdin_q <= final_bmp_pixel_out; // latest bitmap bit
                end
            end

            // On we==0 cycles, commit any pending writes first; then direct-write new valids (no need to pend).
            if (!we) begin
                // Commit pending RGB first (arbitrary order) then bitmap; both can occur same cycle
                if (pend_rgb) begin
                    rgb_waddr18_r <= pend_addr_rgb_q;
                    rgb_dina_r    <= fpix_q;
                    we_rgb_w      <= 1'b1;
                    pend_rgb      <= 1'b0;
                end else if (final_pixel_we) begin
                    // Direct write when valid arrives on an idle camera cycle
                    rgb_waddr18_r <= final_addr_out + wr_base_frame;
                    rgb_dina_r    <= final_pixel_out;
                    we_rgb_w      <= 1'b1;
                end

                if (pend_bmp) begin
                    bmp_waddr18_r <= pend_addr_bmp_q;
                    bmp_dina_r    <= bdin_q;
                    we_bmp_w      <= 1'b1;
                    pend_bmp      <= 1'b0;
                end else if (final_bmp_pixel_we) begin
                    bmp_waddr18_r <= final_bmp_addr_out + wr_base_frame;
                    bmp_dina_r    <= final_bmp_pixel_out;
                    we_bmp_w      <= 1'b1;
                end
            end
            // We intentionally do NOT write during we==1 (raw pixel cycles) to avoid port contention.
        end
    end

    wire [11:0] bram_pixel_out;
    image_mem frame_buffer( 
        .clka(ov7670_pclk),
        .wea(we_rgb_w),
        .addra(rgb_waddr18_r),
        .dina(rgb_dina_r),          // write RGB444 (raw on we cycles, filtered on alt cycles)
        .clkb(clk25),
        .addrb(addrb18),
        .doutb(bram_pixel_out)   // read RGB444
    );
    // Dual_Port_Buffer frame_buffer(
    //     .clka(ov7670_pclk),
    //     .wea(we_w),
    //     .addra(waddr18_r),
    //     .dina(rgb_dina_r),          // write RGB444 (raw on we cycles, filtered on alt cycles)
    //     .clkb(clk25),
    //     .addrb(addrb18),
    //     .doutb(bram_pixel_out)   // read RGB444
    // );

    //----------- BITMAP STREAM (1-bit, synced to VGA read) ----------- //

    // added back bitmap buffer BRAM to store 1-bit bitmap data
    wire bram_bmp_pixel_out;
    bitmap_mem bitmap_buffer(
        .clka(ov7670_pclk),
        .wea(we_bmp_w),
        .addra(bmp_waddr18_r),
        .dina(bmp_dina_r), // write bitmap pixel
        .clkb(clk25),
        .addrb(addrb18),
        .doutb(bram_bmp_pixel_out) // read bitmap pixel
    );

    // wire raw_bitmap_pixel = (
    //     (bram_pixel_out[3:0]  >= RGB_THRESHOLD[23:20]) && (bram_pixel_out[3:0]  <= RGB_THRESHOLD[19:16]) && // B in range
    //     (bram_pixel_out[7:4]  >= RGB_THRESHOLD[15:12]) && (bram_pixel_out[7:4]  <= RGB_THRESHOLD[11:8])  && // G in range
    //     (bram_pixel_out[11:8] >= RGB_THRESHOLD[7:4])   && (bram_pixel_out[11:8] <= RGB_THRESHOLD[3:0])     // R in range
    // ) ? 1'b1 : 1'b0;
    // assign bitmap_pixel = Final_Out_Control[1] ? (bram_pixel_out == 12'hFFF) : raw_bitmap_pixel;
    // Dual_Port_Buffer bitmap_buffer(
    //     .clka(ov7670_pclk),
    //     .we(we_w),
    //     .addra(waddr18_r),
    //     .dina(bmp_dina_r), // write bitmap pixel
    //     .clkb(clk25),
    //     .addrb(addrb18),
    //     .doutb(bitmap_pixel) // read bitmap pixel
    // );

    //----------- VGA FINAL OUTPUT MUX CONTROLS (FOR DEDICATED BITMAP BUFFER MODE) ----------- //
    wire [11:0] bram_final_pixel_out;
    assign bram_final_pixel_out = Final_Out_Control[1] ? (bram_bmp_pixel_out ? 12'hFFF : 12'h000) : bram_pixel_out;


// ----------- FILTER SELECTION MUX CONTROLS ----------- //
    // Wires driven by switches: do not give them constant drivers as well
    reg Gaussian_In_Control;
    reg Median_In_Control;
    reg [1:0] RGB_Out_Control;
    reg [2:0] BMP_Out_Control = 3'b000;
    reg [1:0] Final_Out_Control = 2'b00;
    reg [3:0] Preprocessing_State = 4'h0;
    reg [1:0] Last_Stage_RGB = 2'b00;   // 0 = raw, 1=gaussian, 2=median
    reg [2:0] Last_Stage = 3'b000; //0 = raw, 1=gaussian, 2=median, 3=B1, 4=B2, 5=B3, 6=B4

    wire [3:0] Morphology_State;        // From CV settings
    wire [2:0] Morph_Count;          // From CV settings
    reg [1:0] Pre_Count;
    wire [3:0] Total_Count = Morph_Count + Pre_Count;   //extra bit for bitshift operations
    

    // Runtime-adjustable address offsets for convolutions
    reg signed [3:0] gaussian_addr_off_col = 4'sd0;
    reg signed [3:0] gaussian_addr_off_row = 4'sd0;
    reg signed [3:0] median_addr_off_col = 4'sd0;
    reg signed [3:0] median_addr_off_row = 4'sd0;
    reg signed [3:0] B1_addr_off_col = 4'sd0;
    reg signed [3:0] B1_addr_off_row = 4'sd0;
    reg signed [3:0] B2_addr_off_col = 4'sd0;
    reg signed [3:0] B2_addr_off_row = 4'sd0;
    reg signed [3:0] B3_addr_off_col = 4'sd0;
    reg signed [3:0] B3_addr_off_row = 4'sd0;
    reg signed [3:0] B4_addr_off_col = 4'sd0;
    reg signed [3:0] B4_addr_off_row = 4'sd0;
    reg signed [4:0] rgb_addr_off_col = 5'sd0;
    reg signed [4:0] rgb_addr_off_row = 5'sd0;
    reg signed [4:0] bmp_addr_off_col = 5'sd0;
    reg signed [4:0] bmp_addr_off_row = 5'sd0;
    reg signed [5:0] total_addr_off_col = 6'sd0;
    reg signed [5:0] total_addr_off_row = 6'sd0;
    // Forward declarations for UI-driven control wires (declared again later where produced)
    wire [3:0] pre_order_vector;
    wire [1:0] final_out; // 00 CAM, 01 PRE, 10 MORPH, 11 BITMAP

    always @(*) begin
        //state machine for preprocessing control
        case (Preprocessing_State)
            4'b0000: begin //Raw camera
                Gaussian_In_Control <= 1'bx;
                Median_In_Control <= 1'bx;
                RGB_Out_Control <= 2'b00;
                Pre_Count <= 2'd0;
                rgb_addr_off_col = 0; rgb_addr_off_row = 0;
                Last_Stage_RGB = 3'd0;
            end
            4'b0001: begin //Gaussian only
                Gaussian_In_Control <= 1'b0;
                Median_In_Control <= 1'bx;
                RGB_Out_Control <= 2'b01;
                Pre_Count <= 2'd1;
                rgb_addr_off_col = -1; rgb_addr_off_row = 0;
                Last_Stage_RGB = 3'd1;
            end
            4'b0010: begin //Median only
                Gaussian_In_Control <= 1'bx;
                Median_In_Control <= 1'b0;
                RGB_Out_Control <= 2'b10;
                Pre_Count <= 2'd1;
                rgb_addr_off_col = 0; rgb_addr_off_row = 0;
                Last_Stage_RGB = 3'd2;
            end
            4'b1001: begin //Gaussian --> Median
                Gaussian_In_Control <= 1'b0;
                Median_In_Control <= 1'b1;
                RGB_Out_Control <= 2'b10;
                Pre_Count <= 2'd2;
                rgb_addr_off_col = -2; rgb_addr_off_row = -1;
                Last_Stage_RGB = 3'd2;
            end
            4'b0110: begin //Median --> Gaussian
                Gaussian_In_Control <= 1'b1;
                Median_In_Control <= 1'b0;
                RGB_Out_Control <= 2'b01;
                Pre_Count <= 2'd2;
                rgb_addr_off_col = -2; rgb_addr_off_row = -1;
                Last_Stage_RGB = 3'd1;
            end
            default: begin  //invalid states just shows raw camera
                Gaussian_In_Control <= 1'b0;
                Median_In_Control <= 1'b0;
                RGB_Out_Control <= 2'b00;
                Pre_Count <= 2'd0;
                rgb_addr_off_col = 0; rgb_addr_off_row = 0;
                Last_Stage_RGB = 3'd0;
            end
        endcase

        // What used to be Morphology State machine
        bmp_addr_off_col = -$signed({1'b0, Morph_Count});
        bmp_addr_off_row = -$signed({1'b0, Morph_Count});
        Last_Stage = (Morph_Count == 3'd0) ? Last_Stage_RGB : (3'd2 + Morph_Count);
        BMP_Out_Control <= Morph_Count;

        // state machine for offsets due to convolutions
        total_addr_off_col = rgb_addr_off_col + bmp_addr_off_col;
        total_addr_off_row = rgb_addr_off_row + bmp_addr_off_row;

        // zero out all offsets first
        gaussian_addr_off_col <= 0; gaussian_addr_off_row <= 0;
        median_addr_off_col <= 0; median_addr_off_row <= 0;
        B1_addr_off_col <= 0; B1_addr_off_row <= 0;
        B2_addr_off_col <= 0; B2_addr_off_row <= 0;
        B3_addr_off_col <= 0; B3_addr_off_row <= 0;
        B4_addr_off_col <= 0; B4_addr_off_row <= 0;
        if (Final_Out_Control == 2'b00) begin
            //all offsets 0
        end 
        else if (Final_Out_Control == 2'b01 || Final_Out_Control == 2'b10) begin
            //set offsets according to last stage rgb
            case (Last_Stage_RGB)
                2'd0: begin //last stage is raw
                    // do nothing all offsets 0
                end
                2'd1: begin //last stage is Gaussian
                    gaussian_addr_off_col <= rgb_addr_off_col;
                    gaussian_addr_off_row <= rgb_addr_off_row;
                end
                2'd2: begin //last stage is Median
                    median_addr_off_col <= rgb_addr_off_col;
                    median_addr_off_row <= rgb_addr_off_row;
                end
                default: begin
                    //pass
                end
            endcase
        end
        else begin
            //set offsets according to last stage morphology
            case (Last_Stage)
                3'd0: begin //last stage is raw
                    // do nothing all offsets 0
                end
                3'd1: begin //last stage is Gaussian
                    gaussian_addr_off_col <= total_addr_off_col;
                    gaussian_addr_off_row <= total_addr_off_row;
                end
                3'd2: begin //last stage is Median
                    median_addr_off_col <= total_addr_off_col;
                    median_addr_off_row <= total_addr_off_row;
                end
                3'd3: begin //last stage is B1
                    B1_addr_off_col <= total_addr_off_col;
                    B1_addr_off_row <= total_addr_off_row;
                end
                3'd4: begin //last stage is B2
                    B2_addr_off_col <= total_addr_off_col;
                    B2_addr_off_row <= total_addr_off_row;
                end
                3'd5: begin //last stage is B3
                    B3_addr_off_col <= total_addr_off_col;
                    B3_addr_off_row <= total_addr_off_row;
                end
                3'd6: begin //last stage is B4
                    B4_addr_off_col <= total_addr_off_col;
                    B4_addr_off_row <= total_addr_off_row;
                end
                default: begin
                    //pass
                end
            endcase
        end
    end

    // FROM UART
    // always @(posedge clk) begin
    //     if (sw[14]) begin
    //         Preprocessing_State <= pre_order_vector;
    //         Final_Out_Control <= final_out;
    //     end else begin
    //         Preprocessing_State <= received_prevector;
    //         Final_Out_Control <= 2'b11;
    //     end
    // end

    always @(posedge clk) begin
        Preprocessing_State <= pre_order_vector;
        Final_Out_Control <= final_out;
    end


    // input and output pixels from each convolutional block
    wire [11:0] median_pixel_in, median_pixel_out;
    wire [11:0] gaussian_pixel_in, gaussian_pixel_out;
    wire [11:0] rgb_pixel_out;
    wire threshold_pixel;
    wire B1_pixel_out, B2_pixel_out, B3_pixel_out, B4_pixel_out;

    wire bmp_pixel_out;
    wire [11:0] final_pixel_out;
    wire final_bmp_pixel_out;

    // write enables piping in pixel_valid outputs from previous convolutional blocks or camera capture block
    wire median_pixel_we, gaussian_pixel_we;
    wire final_pixel_we;
    wire final_bmp_pixel_we;

    // output address wires from each convolutional block / mux
    wire [16:0] median_addr_out, gaussian_addr_out;
    wire [16:0] rgb_addr_out;
    wire [16:0] B1_addr_out, B2_addr_out, B3_addr_out, B4_addr_out;
    wire [16:0] bmp_addr_out;
    wire [16:0] final_addr_out;
    wire [16:0] final_bmp_addr_out;

    // output flags from the convolutional blocks / mux indicating when pixel_out is valid
    wire median_pixel_valid, gaussian_pixel_valid;
    wire rgb_pixel_valid;
    wire bmp_pixel_valid;

    // preprocessing operations path control
    assign gaussian_pixel_in = Gaussian_In_Control ? median_pixel_out : dout;
    assign gaussian_pixel_we = Gaussian_In_Control ? median_pixel_valid : we;

    assign median_pixel_in = Median_In_Control ? gaussian_pixel_out : dout;
    assign median_pixel_we = Median_In_Control ? gaussian_pixel_valid : we;

    assign rgb_pixel_out = (RGB_Out_Control == 2'b00) ? dout :
                           (RGB_Out_Control == 2'b01) ? gaussian_pixel_out :
                           (RGB_Out_Control == 2'b10) ? median_pixel_out : 12'd0;
    assign rgb_addr_out = (RGB_Out_Control == 2'b00) ? addr :
                          (RGB_Out_Control == 2'b01) ? gaussian_addr_out :
                          (RGB_Out_Control == 2'b10) ? median_addr_out : 17'd0;
    assign rgb_pixel_valid = (RGB_Out_Control == 2'b00) ? we :
                             (RGB_Out_Control == 2'b01) ? gaussian_pixel_valid :
                             (RGB_Out_Control == 2'b10) ? median_pixel_valid : 1'b0;
   

    // thresholding operation (RGB path)
    // Use the currently selected RGB stream (rgb_pixel_out) against live RGB thresholds from UI.
    // This keeps thresholding consistent with preprocessing stage selection.
    // assign threshold_pixel_rgb = (
    //     (rgb_pixel_out[3:0]  >= RGB_THRESHOLD[23:20]) && (rgb_pixel_out[3:0]  <= RGB_THRESHOLD[19:16]) && // B in range
    //     (rgb_pixel_out[7:4]  >= RGB_THRESHOLD[15:12]) && (rgb_pixel_out[7:4]  <= RGB_THRESHOLD[11:8])  && // G in range
    //     (rgb_pixel_out[11:8] >= RGB_THRESHOLD[7:4])   && (rgb_pixel_out[11:8] <= RGB_THRESHOLD[3:0])     // R in range
    // ) ? 1'b1 : 1'b0;

    // bitmap morphology path control
    assign bmp_pixel_out = (BMP_Out_Control == 3'b000) ? threshold_pixel :
                           (BMP_Out_Control == 3'b001) ? B1_pixel_out :
                           (BMP_Out_Control == 3'b010) ? B2_pixel_out :
                           (BMP_Out_Control == 3'b011) ? B3_pixel_out :
                           (BMP_Out_Control == 3'b100) ? B4_pixel_out : 1'b0;
    assign bmp_addr_out = (BMP_Out_Control == 3'b000) ? rgb_addr_out :
                          (BMP_Out_Control == 3'b001) ? B1_addr_out :
                          (BMP_Out_Control == 3'b010) ? B2_addr_out :
                          (BMP_Out_Control == 3'b011) ? B3_addr_out :
                          (BMP_Out_Control == 3'b100) ? B4_addr_out : 17'd0;
    assign bmp_pixel_valid = (BMP_Out_Control == 3'b000) ? rgb_pixel_valid :
                             (BMP_Out_Control == 3'b001) ? B1_pixel_valid :
                             (BMP_Out_Control == 3'b010) ? B2_pixel_valid :
                             (BMP_Out_Control == 3'b011) ? B3_pixel_valid :
                             (BMP_Out_Control == 3'b100) ? B4_pixel_valid : 1'b0;

    // old path control for all to single RGB BRAM buffer
    // assign final_pixel_out = (Final_Out_Control == 2'b00) ? dout :
    //                          (Final_Out_Control == 2'b01) ? rgb_pixel_out :
    //                          (Final_Out_Control == 2'b10) ? (threshold_pixel ? 12'hFFF : 12'h000) :
    //                          (Final_Out_Control == 2'b11) ? (bmp_pixel_out ? 12'hFFF : 12'h000) : 12'd0;
    // assign final_pixel_we = (Final_Out_Control == 2'b00) ? we :
    //                         (Final_Out_Control == 2'b01) ? rgb_pixel_valid :
    //                         (Final_Out_Control == 2'b10) ? rgb_pixel_valid :
    //                         (Final_Out_Control == 2'b11) ? bmp_pixel_valid : 1'b0; 
    // assign final_addr_out = (Final_Out_Control == 2'b00) ? addr :
    //                         (Final_Out_Control == 2'b01) ? rgb_addr_out :
    //                         (Final_Out_Control == 2'b10) ? rgb_addr_out :
    //                         (Final_Out_Control == 2'b11) ? bmp_addr_out : 17'd0;

    // new path control for RGB BRAM and 1-bit bitmap BRAM
    // original final_xxx_xxx wires used for RGB pixels for RGB BRAM
    // new final_bmp_xxx wires used for 1-bit bitmap for bitmap BRAM
    assign final_pixel_out = (Final_Out_Control[0]) ? rgb_pixel_out : dout;
    assign final_pixel_we  = (Final_Out_Control[0]) ? rgb_pixel_valid : we;
    assign final_addr_out  = (Final_Out_Control[0]) ? rgb_addr_out : addr;

    //"HOTFIX": use raw bitmap for all modes except 2'b11 final bitmap mode
    assign final_bmp_pixel_out = (Final_Out_Control == 2'b11) ? bmp_pixel_out : threshold_pixel;
    assign final_bmp_pixel_we  = (Final_Out_Control == 2'b11) ? bmp_pixel_valid : rgb_pixel_valid;
    assign final_bmp_addr_out  = (Final_Out_Control == 2'b11) ? bmp_addr_out : rgb_addr_out;



// ----------- UFDS BRIDGE FOR OBJECT DETECTIONS ----------- //

    // Concatenated top-4 component outputs from UFDS via Bridge
    wire [39:0] comp3210_left, comp3210_right, comp3210_cx;   // 4x {valid(1) , x[8:0]}
    wire [35:0] comp3210_top,  comp3210_bottom, comp3210_cy;  // 4x {valid(1) , y[7:0]}
    wire [63:0] comp3210_area;                                 // 4x area[15:0]
    wire [2:0]  comp_count;
    wire        ready_o;
    // Only feed UFDS within the 310x240 cropped active area (x in [10,319], y in [0,239])
    wire in_roi = active_area && (frame_x[9:1] >= 10'd10) && (frame_x[9:1] < 10'd320) && (frame_y[9:1] < 10'd240);
    // Decimate the VGA-doubled raster (640x480) to source grid (320x240):
    // take only even hCounter/vCounter pixels so each source pixel is enqueued once
    wire decim_hv = (~frame_x[0]) && (~frame_y[0]);


    // wire ufds_pixel_in = Final_Out_Control[1] ? (bram_pixel_out == 12'hFFF) : 1'b0;  //for single RGB buffer mode
    wire ufds_pixel_in = bram_bmp_pixel_out; // for dedicated bitmap buffer mode

    UFDS_Bridge ufds_bridge (
        .pclk(clk25),
        .p_rst(cap_reset),
        // Gate valid to ROI AND decimate by 2x2 so UFDS sees exactly 310x240 unique pixels per frame
        .p_valid(in_roi && decim_hv),
        .p_x(frame_x[9:1] - 10),
        .p_y(frame_y[9:1]),
        .p_px(ufds_pixel_in), // use same bitmap data as vga pixel
        .clk(clk50),
        .ext_reset(cap_reset),
        // Settings from UFDS UI
        .min_area_sel(ufds_min_area_sel_r),
        // .sort_by_prox(ufds_sort_by_prox_r),
        .max_boxes_sel(ufds_max_boxes_sel_r),
        .comp3210_left(comp3210_left),
        .comp3210_right(comp3210_right),
        .comp3210_top(comp3210_top),
        .comp3210_bottom(comp3210_bottom),
        .comp3210_cx(comp3210_cx),
        .comp3210_cy(comp3210_cy),
        .comp3210_area(comp3210_area),
        .comp_count(comp_count),
        .ready_o(ready_o),
        .next_unused_label(next_unused_label)
    );

// ----------- DISPLAY PARAMS, CROSSHAIR, BOUNDING BOXES ----------- //
    localparam GREEN = 12'h1C1;
    localparam RED = 12'h00F;
    localparam BLUE = 12'hF00;
    localparam WHITE = 12'hFFF;
    localparam BLACK = 12'h000;
    localparam CYAN = 12'hFF0;
    localparam YELLOW = 12'h0FF;
    localparam MAGENTA = 12'hF0F;
    localparam GREY = 12'h888;

    // cooldown 
    localparam CROSSHAIR_HEIGHT = 11;
    // wire [7:0] fill_height = (cooldown_progress * CROSSHAIR_HEIGHT) >> 8;
    wire [7:0] green_start_y = 120 + CROSSHAIR_HEIGHT;        // bottom of the stem
    // wire [7:0] green_top_y = green_start_y - fill_height;    // current row index of green 

    // Decode concatenated outputs into per-component fields and latch once per VGA frame for display

    wire [9:0] left0 = comp3210_left[9:0];
    wire [9:0] left1 = comp3210_left[19:10];
    wire [9:0] left2 = comp3210_left[29:20];
    wire [9:0] left3 = comp3210_left[39:30];

    wire [9:0] right0 = comp3210_right[9:0];
    wire [9:0] right1 = comp3210_right[19:10];
    wire [9:0] right2 = comp3210_right[29:20];
    wire [9:0] right3 = comp3210_right[39:30];

    wire [8:0] top0 = comp3210_top[8:0];
    wire [8:0] top1 = comp3210_top[17:9];
    wire [8:0] top2 = comp3210_top[26:18];
    wire [8:0] top3 = comp3210_top[35:27];

    wire [8:0] bottom0 = comp3210_bottom[8:0];
    wire [8:0] bottom1 = comp3210_bottom[17:9];
    wire [8:0] bottom2 = comp3210_bottom[26:18];
    wire [8:0] bottom3 = comp3210_bottom[35:27];

    wire [9:0] cx0 = comp3210_cx[9:0];
    wire [9:0] cx1 = comp3210_cx[19:10];
    wire [9:0] cx2 = comp3210_cx[29:20];
    wire [9:0] cx3 = comp3210_cx[39:30];

    wire [8:0] cy0 = comp3210_cy[8:0];
    wire [8:0] cy1 = comp3210_cy[17:9];
    wire [8:0] cy2 = comp3210_cy[26:18];
    wire [8:0] cy3 = comp3210_cy[35:27];

    wire [8:0] DELETE_THIS = next_unused_label;

    //FROM UART
    // wire [9:0] left0   = received_left_boxes[9:0];
    // wire [9:0] left1   = received_left_boxes[19:10];
    // wire [9:0] left2   = received_left_boxes[29:20];
    // wire [9:0] left3   = received_left_boxes[39:30];

    // wire [9:0] right0  = received_right_boxes[9:0];
    // wire [9:0] right1  = received_right_boxes[19:10];
    // wire [9:0] right2  = received_right_boxes[29:20];
    // wire [9:0] right3  = received_right_boxes[39:30];

    // wire [8:0] top0    = received_top_boxes[8:0];
    // wire [8:0] top1    = received_top_boxes[17:9];
    // wire [8:0] top2    = received_top_boxes[26:18];
    // wire [8:0] top3    = received_top_boxes[35:27];

    // wire [8:0] bottom0 = received_bottom_boxes[8:0];
    // wire [8:0] bottom1 = received_bottom_boxes[17:9];
    // wire [8:0] bottom2 = received_bottom_boxes[26:18];
    // wire [8:0] bottom3 = received_bottom_boxes[35:27];

    // wire [9:0] cx0     = received_CX[9:0];
    // wire [9:0] cx1     = received_CX[19:10];
    // wire [9:0] cx2     = received_CX[29:20];
    // wire [9:0] cx3     = received_CX[39:30];

    // wire [8:0] cy0     = received_CY[8:0];
    // wire [8:0] cy1     = received_CY[17:9];
    // wire [8:0] cy2     = received_CY[26:18];
    // wire [8:0] cy3     = received_CY[35:27];

    // Latches for overlay drawing
    reg [9:0] left0_l, right0_l, cx0_l;
    reg [9:0] left1_l, right1_l, cx1_l;
    reg [9:0] left2_l, right2_l, cx2_l;
    reg [9:0] left3_l, right3_l, cx3_l;
    reg [8:0] top0_l, bottom0_l, cy0_l;
    reg [8:0] top1_l, bottom1_l, cy1_l;
    reg [8:0] top2_l, bottom2_l, cy2_l;
    reg [8:0] top3_l, bottom3_l, cy3_l;

    // Randomised canvas module instance (mosaic + shapes). Used with sw[15] ON.
    // wire [11:0] canvas_pixel;
    // Randomised_Canvas canvas_inst (
    //     .clk(clk25),
    //     .reset(vga_reset),
    //     .btnC(btnC),
    //     .frame_x(frame_x),
    //     .frame_y(frame_y),
    //     .in_roi(in_roi),
    //     .active_area(active_area),
    //     .pixel_out(canvas_pixel)
    // );


// ------------- CV Settings: Drag & Drop/Change View/Infotab for Preprocessing/Morphology --------------
    // Overlay is single source of truth for drop-zone geometry; receive from overlay and feed drag/drop
    wire [9:0] PRE_X_VGA;
    wire [8:0] PRE_Y_VGA;
    wire [9:0] PRE_W_VGA;
    wire [8:0] PRE_H_VGA;
    wire [9:0] MORPH_X_VGA;
    wire [8:0] MORPH_Y_VGA;
    wire [9:0] MORPH_W_VGA;
    wire [8:0] MORPH_H_VGA;

    // Wires from drag-drop module
    wire [59:0] boxes_x_vector;
    wire [53:0] boxes_y_vector;
    // Concatenated order (leftmost in LSB)
    // morph_order_vector and pre_order_vector are forward-declared above
    // wire [5:0]  box_hover;
    wire [2:0]  front_idx;
    // wire [2:0]  morph_count;
    // wire [1:0]  morph_order0, morph_order1, morph_order2, morph_order3;
    // wire [1:0]  pre_count;
    // wire [1:0]  pre_order0, pre_order1;
    // Click pulses from drag/drop for info categories
    wire gauss_click_mv, median_click_mv, erode_click_mv, dilate_click_mv;

    cv_settings_dragdrop settings_cv (
        .clk(clk25),
        .reset(vga_reset),
        .settings_active(cv_settings_mode),
        .mouse_x(mouse_x_vga),
        .mouse_y(mouse_y_vga),
        .mouse_left(left_click_deb),
        .mouse_left_edge(left_click_edge),
        .mouse_left_fall(left_click_fall),
        .pre_x(PRE_X_VGA), .pre_y(PRE_Y_VGA), .pre_w(PRE_W_VGA), .pre_h(PRE_H_VGA),
        .morph_x(MORPH_X_VGA), .morph_y(MORPH_Y_VGA), .morph_w(MORPH_W_VGA), .morph_h(MORPH_H_VGA),
        .scroll_up(scroll_up_pulse), .scroll_down(scroll_down_pulse),
        .boxes_x(boxes_x_vector), .boxes_y(boxes_y_vector),
        // .hover(box_hover),
        // .morph_count(morph_count),
        // .morph_vector(morph_vector_4),
        .morph_count(Morph_Count),
        .morph_vector(Morphology_State),
        // .morph_count(morph_count),
        // .morph_order0(morph_order0), .morph_order1(morph_order1), .morph_order2(morph_order2), .morph_order3(morph_order3),
        // .pre_count(pre_count), .pre_order0(pre_order0), .pre_order1(pre_order1),
        // .morph_order_vector(morph_order_vector), 
        .pre_order_vector(pre_order_vector),
        .front_idx(front_idx),
        // .dragging_o(led[2]),
        // .drop_reason(led[4:3]),
        .gauss_click(gauss_click_mv), .median_click(median_click_mv), .erode_click(erode_click_mv), .dilate_click(dilate_click_mv)
    );

    // Overlay pixel from settings UI (drag/drop) in VGA coordinates
    wire cv_sett_overlay_en;
    wire [11:0] cv_sett_overlay;
    // Click pulses from CV settings overlay selection boxes
    // wire cam_box_clicked;
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
        .info_tab_top_y(info_pix_y),
        .boxes_x(boxes_x_vector), .boxes_y(boxes_y_vector),
        .front_idx(front_idx),
        .overlay_en(cv_sett_overlay_en), .overlay_rgb(cv_sett_overlay),
        // .cam_box_click(cam_box_clicked), 
        .bitmap_box_click(bitmap_box_clicked), .ufds_box_click(ufds_box_clicked),
        .pre_x_o(PRE_X_VGA), .pre_y_o(PRE_Y_VGA), .pre_w_o(PRE_W_VGA), .pre_h_o(PRE_H_VGA),
        .morph_x_o(MORPH_X_VGA), .morph_y_o(MORPH_Y_VGA), .morph_w_o(MORPH_W_VGA), .morph_h_o(MORPH_H_VGA),
        .info_dim_en(info_dim_en),
        .final_out(final_out)
    );

    // === Info tab animation: moving pixel (x,y) and color ===
    wire [9:0] info_pix_x;
    wire [8:0] info_pix_y;
    wire [2:0] info_idx;
    wire [11:0] info_pix_rgb;
    cv_settings_info_tab info_tab (
        .clk(clk25), .reset(vga_reset), .settings_active(ufds_settings_mode),
        .mouse_x(mouse_x_vga), .mouse_y(mouse_y_vga), .left_edge(left_click_edge),
        // .cam_box_click(cam_box_clicked), 
        .bitmap_box_click(bitmap_box_clicked), .ufds_box_click(ufds_box_clicked),
        .gauss_click(gauss_click_mv), .median_click(median_click_mv), .erode_click(erode_click_mv), .dilate_click(dilate_click_mv),
        .pix_x(info_pix_x), .pix_y(info_pix_y), .info_idx(info_idx), .pix_rgb(info_pix_rgb)
    );


// ---------- EYEDROPPER AND THRESHOLDING ------ //
    reg [11:0] mouse_color_bram;
    reg mouse_sample_ready;

    // Sample BRAM pixel color under mouse cursor once per frame
    always @(posedge clk25) begin
        if (vga_reset) begin
            mouse_color_bram <= 12'h000;
            mouse_sample_ready <= 1'b0;
        end else begin
            // Reset ready flag at start of frame
            if (frame_addr == 17'd0) begin
                mouse_sample_ready <= 1'b0;
            end
            
            // Sample once when scan passes mouse position
            if (in_roi && !mouse_sample_ready && 
                (frame_x[9:1] - 10 == mouse_x_vga[9:1] - 10) && 
                (frame_y[9:1] == mouse_y_vga[8:1])) begin
                mouse_color_bram <= bram_final_pixel_out;
                mouse_sample_ready <= 1'b1;
            end
        end
    end


    // Sets threshold color section
    // Threshold section wires (instantiated later so we can tie enable to state)
    wire [11:0] thr_section_pixel;
    wire        thr_section_active;
    wire [3:0]  start_red_val, end_red_val;
    wire [3:0]  start_green_val, end_green_val;
    wire [3:0]  start_blue_val, end_blue_val;
    // New HSV thresholds and mode flag from threshold UI
    // wire [3:0]  start_h_val, end_h_val;
    // wire [3:0]  start_s_val, end_s_val;
    // wire [3:0]  start_v_val, end_v_val;
    // wire        mode_is_hsv;
    // Enable for threshold UI: active only when CV settings UI is visible so sliders
    // are loaded with the BRAM overlay set. This ensures the sliders are drawn with
    // other VGA-space overlays.
    wire thr_enable = (state == S_CV_SETTINGS);

    // Instantiate threshold_section now that 'state' is declared so we can pass enable
    // wire [23:0] RGB_THRESHOLD = {start_red_val, end_red_val,
    //                       start_green_val, end_green_val,
    //                       start_blue_val, end_blue_val};
    threshold_subsection thr_section_inst (
        .clk25(clk25),
        .vga_reset(vga_reset),
        .px_src(frame_x),
        .py_src(frame_y),
        .mouse_x_px(mouse_x_vga),
        .mouse_y_px(mouse_y_vga),
        .left_click(left_click_deb),
        .left_click_edge(left_click_edge),
        .left_click_fall(left_click_fall),
        .enable(thr_enable),
        .rgb_pixel_in(rgb_pixel_out),
        // .bram_pixel_out(bram_pixel_out),
        .mouse_color_bram(mouse_color_bram),
        .start_red_val(start_red_val),
        .end_red_val(end_red_val),
        .start_green_val(start_green_val),
        .end_green_val(end_green_val),
        .start_blue_val(start_blue_val),
        .end_blue_val(end_blue_val),
        // .start_h_val(start_h_val), .end_h_val(end_h_val),
        // .start_s_val(start_s_val), .end_s_val(end_s_val),
        // .start_v_val(start_v_val), .end_v_val(end_v_val),
        .threshold_pixel(threshold_pixel),
        // .mode_is_hsv(mode_is_hsv),
        .section_pixel(thr_section_pixel),
        .section_active(thr_section_active)
    );


// ---------- UFDS SETTINGS OVERLAY ---------- //
    // UFDS settings overlay (drawn when in UFDS settings state)
    wire        ufds_overlay_en;
    wire [11:0] ufds_overlay_rgb;
    wire        ufds_return_click;
    wire [2:0]  ufds_tab_idx;
    wire [1:0]  ufds_min_area_sel;
    // wire        ufds_sort_by_prox;
    wire [1:0]  ufds_max_boxes_sel;
    wire servo_en;

    ufds_settings_overlay ufds_ui (
        .clk(clk25), .reset(vga_reset), .settings_active(ufds_settings_mode),
        .px(frame_x), .py(frame_y),
        .mouse_x(mouse_x_vga), .mouse_y(mouse_y_vga), .left_edge(left_click_edge),
        .info_tab_top_y(info_pix_y),
        .overlay_en(ufds_overlay_en), .overlay_rgb(ufds_overlay_rgb),
        .return_click(ufds_return_click),
        .tab_idx(ufds_tab_idx), .min_area_sel(ufds_min_area_sel), 
        // .sort_by_prox(ufds_sort_by_prox), 
        .max_boxes_sel(ufds_max_boxes_sel),
        .servo(servo_en)
    );

    // Latch UFDS settings for UFDS pipeline (clk domain)
    reg [1:0] ufds_min_area_sel_r;
    // reg       ufds_sort_by_prox_r;
    reg [1:0] ufds_max_boxes_sel_r;
    always @(posedge clk) begin
        if (btnU) begin
            ufds_min_area_sel_r  <= 2'b00; // 4
            // ufds_sort_by_prox_r  <= 1'b0;  // area
            ufds_max_boxes_sel_r <= 2'b11; // 4 boxes
        end else begin
            ufds_min_area_sel_r  <= ufds_min_area_sel;
            // ufds_sort_by_prox_r  <= ufds_sort_by_prox;
            ufds_max_boxes_sel_r <= ufds_max_boxes_sel;
        end
    end


// ------------- USER SETTINGS UI (MOUSE SENSITIVITY, CROSSHAIR COLOR, OVERLAY) --------------
    // expose selection on LEDs for quick debug
    // assign led[9:8] = final_out;
    
    // Display Settings UI instance
    // wire        user_overlay_en;
    // wire [11:0] user_overlay_rgb;
    // wire [7:0]  user_mouse_sens;
    // wire [2:0]  user_crosshair_sel;
    // user_settings_ui user_ui (
    //     .clk(clk25), .reset(vga_reset), .active(user_settings_mode),
    //     .px(frame_x), .py(frame_y),
    //     .mouse_x(mouse_x_vga), .mouse_y(mouse_y_vga),
    //     .left(left_click_deb), .left_edge(left_click_edge),
    //     .overlay_en(user_overlay_en), .overlay_rgb(user_overlay_rgb),
    //     .mouse_sensitivity(user_mouse_sens), .crosshair_color_sel(user_crosshair_sel)
    // );


// ----------- BRAM OVERLAY ----------- //
    // reg [59:0] move_x = 60'h5018A751FE8A252;
    // reg [53:0] move_y = 54'h2C160B0582C160;
    wire write_high;
    wire [3:0] overlay_pixel;
    generate_bram_overlay gen_ovrly (
        .clk(clk),        // 100MHz clock (used for position updates)
        .clk25(clk25),    // 25MHz VGA clock for BRAM reads
        .en(1'b1),          // Always enabled
        .x(boxes_x_vector),
        .y(boxes_y_vector),
        .gauss_t_x(info_pix_x),
        .gauss_t_y(info_pix_y),
        .frame_x(frame_x),
        .frame_y(frame_y),
        .front_idx(front_idx),
        .final_out(final_out),
        .ufds_settings_mode(ufds_settings_mode),
        .menu_mode(menu_mode),
        .morph_state(Morphology_State),
        .info_idx(ufds_tab_idx),
        .to_write(write_high),
        .image_pixel(overlay_pixel),
        .gauss_sq(gauss_sq),
        .med_sq(med_sq),
        .erode1_sq(erode1_sq),
        .erode2_sq(erode2_sq),
        .dilate1_sq(dilate1_sq),
        .dilate2_sq(dilate2_sq)
    );


// ----------- INFORMATION TABS ----------- //
    wire tab_en;
    wire [11:0] tab_rgb;
    Education_Tabs tabs (
        .clk(clk),
        .clk25(clk25),
        .rst(btnU),
        .frame_x(frame_x),
        .frame_y(frame_y),
        .change_x(info_pix_x),
        .change_y(info_pix_y),
        .info_select(ufds_tab_idx),
        .edu_rgb(tab_rgb),
        .edu_pixel_en(tab_en)
    );

// ----------- VGA CONTROLLER ----------- //
    // Wire for BRAM address from VGA controller
    wire [16:0] frame_addr;             // logical 0..(310*240-1)
    wire [11:0] bram_final_pixel_out;            // 12-bit RGB444 from BRAM
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




// ----------- MOUSE CONTROLLER AND SERVO ----------- //

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
    // VGA-space 3x3 logical cursor region retained (for any logic that still expects it)
    // wire [9:0] vga_dx = (frame_x > mouse_x_vga) ? (frame_x - mouse_x_vga) : (mouse_x_vga - frame_x);
    // wire [8:0] vga_dy = (frame_y > mouse_y_vga) ? (frame_y - mouse_y_vga) : (mouse_y_vga - frame_y);
    // wire       within_cursor_vga_3x3 = (vga_dx <= 10'd1) && (vga_dy <= 9'd1);

    // Cursor: right-angled triangle with right angle at (mouse_x_vga, mouse_y_vga) (top-left corner)
    // Vertices: tip (0,0), (CUR_W,0) to the right, (0,CUR_H) downward.
    // localparam integer CUR_W = 10; // horizontal leg length
    // localparam integer CUR_H = 10; // vertical leg length
    // wire signed [10:0] cdx = frame_x - mouse_x_vga; // x offset from tip
    // wire signed [10:0] cdy = frame_y - mouse_y_vga; // y offset from tip
    // wire        cursor_in_bounds = (cdx >= 0 && cdx <= CUR_W && cdy >= 0 && cdy <= CUR_H);
    // // Point inside triangle if scaled sum within overall area: cdx/CUR_W + cdy/CUR_H <= 1
    // // Avoid division: cdx*CUR_H + cdy*CUR_W <= CUR_W*CUR_H
    // wire [21:0] tri_lhs = (cdx * CUR_H) + (cdy * CUR_W);
    // wire [21:0] tri_rhs = (CUR_W * CUR_H);
    // wire        cursor_inside_tri = cursor_in_bounds && (tri_lhs <= tri_rhs);
    // wire at_tip = (cdx == 0 && cdy == 0);
    // wire on_left_leg = (cdx == 0) && (cdy >= 0) && (cdy <= CUR_H);
    // wire on_top_leg  = (cdy == 0) && (cdx >= 0) && (cdx <= CUR_W);
    // wire on_hyp      = cursor_inside_tri && (tri_lhs == tri_rhs);
    // wire corner_right = (cdx == CUR_W) && (cdy == 0);
    // wire corner_bottom = (cdx == 0) && (cdy == CUR_H);
    // wire cursor_outline = cursor_inside_tri && (at_tip || on_left_leg || on_top_leg || on_hyp || corner_right || corner_bottom);
    // wire cursor_fill    = cursor_inside_tri && !cursor_outline;

    // VGA-space arrowhead cursor (for settings overlays)
    localparam VGA_CUR_SIZE = 7; // arrow height and width 
    localparam VGA_BORDER   = 1;  // outline thickness in VGA pixels
    localparam diagonal_from_left = 5; // tail starts here (unused)
    localparam signed [11:0] VGA_TAIL_WIDTH  = 12'sd3;   // tail width (doubled from 2)
    localparam signed [11:0] VGA_TAIL_LENGTH = 12'sd3;   // tail length (doubled from 3)

    wire signed [10:0] dx_s = $signed({1'b0, frame_x}) - $signed({1'b0, mouse_x_vga});
    wire signed [10:0] dy_s = $signed({1'b0, frame_y}) - $signed({1'b0, mouse_y_vga});

    // Arrow fill (isosceles right triangle with 45° hypotenuse)
    wire arrow_fill = (dx_s >= 0) && (dy_s >= 0) &&
                      (dy_s <= VGA_CUR_SIZE) && (dx_s <= dy_s);

    // Eroded inner triangle to create an outline of thickness VGA_BORDER
    wire arrow_inner = (dx_s >= VGA_BORDER) && (dy_s >= VGA_BORDER) &&
                       (dy_s <= (VGA_CUR_SIZE - VGA_BORDER)) &&
                       (dx_s <= (dy_s - VGA_BORDER));

    wire arrow_border = arrow_fill & ~arrow_inner;

    // Tail rectangle directly beneath the arrow base
    wire arrow_tail_vga = (dx_s >= 2) && (dx_s < VGA_TAIL_WIDTH + 3) &&
                          (dy_s >= VGA_CUR_SIZE) && (dy_s < (VGA_CUR_SIZE + VGA_TAIL_LENGTH));
    // Erode tail to form a 1px outline (same VGA_BORDER thickness)
    wire tail_inner = (dx_s >= VGA_BORDER) && (dx_s < (VGA_TAIL_WIDTH - VGA_BORDER)) &&
                      (dy_s >= (VGA_CUR_SIZE + VGA_BORDER)) && (dy_s < (VGA_CUR_SIZE + VGA_TAIL_LENGTH - VGA_BORDER));
    wire tail_border = arrow_tail_vga & ~tail_inner;

    // Final shape signals
    wire vga_cursor_fill   = arrow_fill | arrow_tail_vga;             // white area
    wire vga_cursor_border = arrow_border | tail_border;              // black outline (head + tail)

    // Dynamic cursor color for contrast: draw black on bright backgrounds, white otherwise
    // wire [5:0]  cursor_luma = {2'b00, bram_pixel_out[11:8]} + {2'b00, bram_pixel_out[7:4]} + {2'b00, bram_pixel_out[3:0]};
    // wire [11:0] cursor_rgb_dyn = (cursor_luma > 6'd24) ? 12'h000 : 12'hFFF;


// ----------- SERVO CONTROLLER ----------- //
    // Servo PWM outputs that are one bit, toggled high/low depending on pwm signal
    wire signed [31:0] servo_x_angle;
    wire signed [31:0] servo_y_angle;

    // reg [9:0] btn_counter [4:0]; //loops around every 1024 counts --> ~ 1 sec to get 100_000 steps
    // initial begin
    //     btn_counter[0] = 10'd1;
    //     btn_counter[1] = 10'd1;
    //     btn_counter[2] = 10'd1;
    //     btn_counter[3] = 10'd1;
    // end

    // // Simple button-controlled servo angle adjuster for testing
    // always @(posedge clk) begin
    //     if (btnU) begin
    //         servo_x_angle <= 18'd100_000;
    //         servo_y_angle <= 18'd100_000;
    //         btn_counter[0] <= 10'd1;
    //         btn_counter[1] <= 10'd1;
    //         btn_counter[2] <= 10'd1;
    //         btn_counter[3] <= 10'd1;
    //     end

    //     if(btnC) btn_counter[0] <= btn_counter[0] + 1;
    //     else btn_counter[0] <= btn_counter[0];

    //     if (btn_counter[0] == 10'd0) begin 
    //         btn_counter[0] <= 10'd1;
    //         servo_y_angle <= (servo_y_angle < 200_000) ? servo_y_angle + 1 : 200_000;
    //     end

    //     if(btnD) btn_counter[1] <= btn_counter[1] + 1;
    //     else btn_counter[1] <= btn_counter[1];

    //     if (btn_counter[1] == 10'd0) begin
    //         btn_counter[1] <= 10'd1;
    //         servo_y_angle <= (servo_y_angle > 0) ? servo_y_angle - 1 : 0;
    //     end

    //     if(btnL) btn_counter[2] <= btn_counter[2] + 1;
    //     else btn_counter[2] <= btn_counter[2];

    //     if (btn_counter[2] == 10'd0) begin
    //         btn_counter[2] <= 10'd1;
    //         servo_x_angle <= (servo_x_angle > 0) ? servo_x_angle - 1 : 0;
    //     end

    //     if(btnR) btn_counter[3] <= btn_counter[3] + 1;
    //     else btn_counter[3] <= btn_counter[3];

    //     if (btn_counter[3] == 10'd0) begin
    //         btn_counter[3] <= 10'd1;
    //         servo_x_angle <= (servo_x_angle < 200_000) ? servo_x_angle + 1 : 200_000;
    //     end
    // end

    Servo_Controller servo_controller(
        .clk(clk),
        .reset(btnU),
        .servo_en(servo_en),
        .servo_x_angle(servo_x_angle),
        .servo_y_angle(servo_y_angle),
        .servo_x_pwm(servo_x_pwm),
        .servo_y_pwm(servo_y_pwm)
    );

//----------- PID CONTROLLER ----------- //
    //Actual PID stuff
    wire pid_enable = (comp_count != 0); //enable PID only when at least one object is detected and switch is on
    reg [7:0] pan_kp = 8'd0;
    reg [7:0] pan_kd = 8'd0;

    reg [7:0] tilt_kp = 8'd0;
    reg [7:0] tilt_kd = 8'd0;

    PID_Controller #(
        .KP_BITSHIFT_LEFT(32'd0),   //bitshift values chosen to have good starting values at 6 out of 16
        .KI_BITSHIFT_RIGHT(32'd0),
        .KD_BITSHIFT_RIGHT(32'd6),
        .INTEGRAL_LIMIT(32'd50_000)
    )
    pan_pid_controller(
        .clk(clk),
        .reset(btnU),
        .enable(pid_enable),
        .setpoint(32'sd155), //center of frame
        .measurement(cx0_l), //current x position of object
        .invert_error(1'b1), //invert error for pan axis
        .control_output(servo_x_angle),
        .KP(pan_kp),
        .KI(31'b0),
        .KD(pan_kd),
        .SERVO_MAX(32'sd200_000),
        .SERVO_MIN(32'sd0)
    );

    PID_Controller #(
        .KP_BITSHIFT_LEFT(32'd0),   //bitshift values chosen to have good starting values at 6 out of 16
        .KI_BITSHIFT_RIGHT(32'd0),
        .KD_BITSHIFT_RIGHT(32'd6),
        .INTEGRAL_LIMIT(32'd50_000)
    )
    tilt_pid_controller(
        .clk(clk),
        .reset(btnU),
        .enable(pid_enable),
        .setpoint(32'sd120), //center of frame
        .measurement(cy0_l), //current y position of object
        .invert_error(1'b1), //invert error for tilt axis
        .control_output(servo_y_angle),
        .KP(tilt_kp),
        .KI(31'b0),
        .KD(tilt_kd),
        .SERVO_MAX(32'sd133_333),
        .SERVO_MIN(32'sd50_000)
    );

    //Simple state machine for PID pan and tilt tuning
    reg [1:0] PID_Tuning_State = 2'b00; //0 for pan, 1 for tilt
    reg [15:0] ss_output = 16'd0; //seven seg output for kp and kd
    always @(*) begin
        case (PID_Tuning_State)
            2'b00: begin
                led[15:14] <= 2'b00;    //indicate idle state
                ss_output <= 16'd0;
            end
            2'b01: begin
                pan_kp <= sw[15:8];
                pan_kd <= sw[7:0];
                led[15:14] <= 2'b10;    //indicate tuning pan
                ss_output <= {pan_kp, pan_kd};
            end
            2'b10: begin
                tilt_kp <= sw[15:8];
                tilt_kd <= sw[7:0];
                led[15:14] <= 2'b01;    //indicate tuning tilt
                ss_output <= {tilt_kp, tilt_kd};
            end
        endcase
    end

    //debounced btnL,C,R to switch between pan and tilt tuning
    reg [2:0] btnR_sync = 3'b000;
    reg [2:0] btnC_sync = 3'b000;
    reg [2:0] btnL_sync = 3'b000;
    always @(posedge clk25) begin
        btnR_sync <= {btnR_sync[1:0], btnR};
        btnC_sync <= {btnC_sync[1:0], btnC};
        btnL_sync <= {btnL_sync[1:0], btnL};
        if (btnL_sync == 3'b001) begin
            PID_Tuning_State <= 2'b01; //tune pan
        end
        else if (btnR_sync == 3'b001) begin
            PID_Tuning_State <= 2'b10; //tune tilt
        end
        else if (btnC_sync == 3'b001) begin
            PID_Tuning_State <= 2'b00; //idle
        end
    end


// ----------- UART CONTROLLER ----------- //
    // Controller encapsulates TX/RX UARTs with 10-byte FIFOs
    // reg  [79:0] tx_fifo_payload = 80'h09080706050403020100; // initial pattern (MSB..LSB = 09..00)
    // reg         tx_fifo_wr_en   = 1'b0;                     // 1-cycle strobe to enqueue a 10-byte burst
    // wire [79:0] rx_fifo_payload;
    // reg [79:0] rx_fifo_payload_buf;
    // wire        rx_fifo_rd_en;                               // 1-cycle strobe when 10 bytes received

    // UART_Controller u_uart (
    //     .clk(clk50),
    //     .rst(btnU),
    //     .tx_fifo(tx_fifo_payload),
    //     .tx_fifo_wr_en(tx_fifo_wr_en),
    //     .tx_pin(uart_tx),
    //     .rx_fifo(rx_fifo_payload),
    //     .rx_fifo_rd_en(rx_fifo_rd_en),
    //     .rx_pin(uart_rx)
    // );

    // // Generate a new 10-byte sequence once per second and trigger a TX burst.
    // // Sequence is base..base+9 in LSB..MSB, so the hex prints as (base+9 ... base)
    // reg [26:0] one_sec_counter = 27'd0;
    // reg [7:0]  base_byte = 8'd0;
    // always @(posedge clk50) begin
    //     tx_fifo_wr_en <= 1'b0; // default low
    //     one_sec_counter <= one_sec_counter + 1;
    //     if (one_sec_counter == 27'd50_000_000) begin
    //         one_sec_counter <= 27'd0;
    //         base_byte <= base_byte + 8'd1;
    //         // Pack bytes: [7:0]=base, [15:8]=base+1, ... [79:72]=base+9
    //         tx_fifo_payload[7:0]    <= base_byte;
    //         tx_fifo_payload[15:8]   <= base_byte + 8'd1;
    //         tx_fifo_payload[23:16]  <= base_byte + 8'd2;
    //         tx_fifo_payload[31:24]  <= base_byte + 8'd3;
    //         tx_fifo_payload[39:32]  <= base_byte + 8'd4;
    //         tx_fifo_payload[47:40]  <= base_byte + 8'd5;
    //         tx_fifo_payload[55:48]  <= base_byte + 8'd6;
    //         tx_fifo_payload[63:56]  <= base_byte + 8'd7;
    //         tx_fifo_payload[71:64]  <= base_byte + 8'd8;
    //         tx_fifo_payload[79:72]  <= base_byte + 8'd9;
    //         tx_fifo_wr_en <= 1'b1; // strobe send
    //     end
    // end


    // // <------- UART CONTROLLER FOR BOUNDING BOX -------->
    // // one bit = 434clks/bit * 1/50Mhz = 8.68 microseconds/bit
    // // to pass all four bounding boxes = 8.68 * 248 = 0.00215s
    // // each bit to pass in = 40 nanosecond
    // // delay = 0.00215s / (40 nanoseconds) = 53750 bits delay, which is roughly one frame worth of delay
    // // thus need to ensure that each TX waits for 0.00215s before sending


    // // wait 30000 ms to allow package to finish
    // reg [14:0] wait_counter = 15'd0;
    // // Controller encapsulates TX/RX UARTs with 10-byte FIFOs
    // reg  [247:0] tx_fifo_payload = 0; // initial pattern (MSB..LSB = 09..00)
    // reg         tx_fifo_wr_en   = 1'b0;                     // 1-cycle strobe to enqueue a 10-byte burst
    // wire [247:0] rx_fifo_payload;
    // reg  [247:0] rx_fifo_payload_buf;
    // wire        rx_fifo_rd_en;           // 1-cycle strobe when 10 bytes received

    // UART_Controller u_uart (
    //     .clk(clk50),
    //     .rst(btnU),
    //     .tx_fifo(tx_fifo_payload),
    //     .tx_fifo_wr_en(tx_fifo_wr_en),
    //     .tx_pin(uart_tx),
    //     .rx_fifo(rx_fifo_payload),
    //     .rx_fifo_rd_en(rx_fifo_rd_en),
    //     .rx_pin(uart_rx)
    // );

    // // localparam CMD_BBOX = 1'd0;
    // // localparam CMD_SETTINGS = 1'd1;


    // // <--- Transmit BBOX Areas --->
    // // Temporary transmit fields (values come from UFDS top component outputs)
    // reg [39:0] left_coords;
    // reg [39:0] right_coords;
    // reg [35:0] top_coords;
    // reg [35:0] bottom_coords;
    // reg [39:0] cx0_coords;
    // reg [35:0] cy0_coords;
    // reg [3:0] pre_vector;
    // reg [3:0] morph_vector;
    // reg [1:0] udfs_min_area;
    // reg ufds_prio;
    // reg [1:0] ufds_max_box_no;

    // // Send BBOX packet once per second when UFDS has fresh results.
    // // Note: UART controller emits rx_fifo_rd_en only after MESSAGE_BITCOUNT/8 bytes (here 31) are received.
    // // This is the transmit block.
    // always @(posedge clk50) begin
    //     tx_fifo_wr_en <= 1'b0; // default low
    //     // Periodic BBOX transmit (once per second) when UFDS has fresh results
    //     // wait_counter <= wait_counter + 1;
    //     // if (wait_counter == 15'd30_000 && ready_o) begin
    //     //     wait_counter <= 15'd0;
    //     if (sw[14]) begin
    //         // main sends user inputs to secondary
    //         pre_vector <= pre_order_vector;   // 4 bits (two ops)
    //         morph_vector <= Morphology_State;     // 4 bits (1=DILATE)
    //         udfs_min_area <= ufds_min_area_sel;
    //         ufds_prio <= ufds_sort_by_prox;
    //         ufds_max_box_no <= ufds_max_boxes_sel;
        
    //         tx_fifo_payload[3:0] <= pre_vector;
    //         tx_fifo_payload[7:4] <= morph_vector;              
    //         tx_fifo_payload[13:12] <= udfs_min_area;
    //         tx_fifo_payload[14] <= ufds_prio;   
    //         tx_fifo_payload[16:15] <= ufds_max_box_no;     
    //         tx_fifo_payload[239:17] <= 0;
    //     end else begin
    //         // temporarily store 40-bits for all 4 BBox in its left, right, top, bottom, cx and cy
    //         // secondary sends BB to main
    //         left_coords <= comp3210_left;   // 40-bit
    //         right_coords <= comp3210_right;   
    //         top_coords <= comp3210_top;
    //         bottom_coords <= comp3210_bottom;
    //         cx0_coords <= comp3210_cx;   // 10-bit
    //         cy0_coords <= comp3210_cy;   // 10-bit
         
    //         tx_fifo_payload[39:0] <= left_coords;
    //         tx_fifo_payload[79:40] <= right_coords;              
    //         tx_fifo_payload[119:80] <= {4'd0, top_coords};
    //         tx_fifo_payload[159:120] <= {4'd0, bottom_coords};   
    //         tx_fifo_payload[199:160] <= cx0_coords;          
    //         tx_fifo_payload[239:200] <= {4'd0, cy0_coords};
           
    //     end
    //      tx_fifo_wr_en <= 1'b1; // one-cycle strobe to enqueue the packet
    // end


    // // <--- Transmit Settings ---> e.g. prevector, morph vector, ufds_max_area, ufds_sort_by_prox, ufds_max_box_sel
    // reg [3:0] received_prevector;
    // reg [3:0] received_morph;
    // reg [1:0] received_ufds_min_area;
    // reg received_ufds_sort_by_prox;
    // reg [1:0] received_ufds_max_box_sel;


    // reg [39:0] received_left_boxes = 0;
    // reg [39:0] received_right_boxes = 0;
    // reg [35:0] received_top_boxes = 0;
    // reg [35:0] received_bottom_boxes = 0;
    // reg [39:0] received_CX = 0;
    // reg [35:0] received_CY = 0;


    //  // Receive Block.
    // always @(posedge clk50) begin
    //     // UART PACKAGE
    //     if (rx_fifo_rd_en) begin
    //         // snapshot the payload buffer for use elsewhere
    //             // Checks if message received is bounding boxes
    //         if (sw[14]) begin
    //             received_left_boxes = rx_fifo_payload[39:0];
    //             received_right_boxes = rx_fifo_payload[79:40];
    //             received_top_boxes = rx_fifo_payload[115:80];
    //             received_bottom_boxes = rx_fifo_payload[155:120];
    //             received_CX = rx_fifo_payload[199:160];
    //             received_CY = rx_fifo_payload[235:200]; 
    //         end else begin 
    //             received_prevector <= tx_fifo_payload[3:0];
    //             received_morph <= tx_fifo_payload[7:4];            
    //             received_ufds_min_area <= tx_fifo_payload[13:12];
    //             received_ufds_sort_by_prox <= tx_fifo_payload[14];   
    //             received_ufds_max_box_sel <= tx_fifo_payload[16:15];   
    //         end
    //     end
    // end

    // // always @(posedge rx_fifo_rd_en) begin
    // //     rx_fifo_payload_buf <= rx_fifo_payload;
    // // end
    


// ----------- DEBUG: SEVEN-SEG DISPLAY AND LEDS ----------- //
    // 7-seg display selection: choose 16-bit window from either TX or RX payload
    // wire [79:0] uart_dbg = sw[15] ? rx_fifo_payload_buf : tx_fifo_payload;
    // wire [15:0] ss_output =
    //     (sw[11]) ? uart_dbg[79:64] :
    //     (sw[12]) ? uart_dbg[63:48] :
    //     (sw[13]) ? uart_dbg[47:32] :
    //     (sw[14]) ? uart_dbg[31:16] :
    //                uart_dbg[15:0];

    // Optional LEDs for quick UART debug
    // assign led[0] = tx_fifo_wr_en;     // TX trigger
    // assign led[1] = rx_fifo_rd_en;     // RX 10-byte ready
    // Drag-drop debug LEDs
    // assign led[5] = cv_settings_mode;  // settings screen active
    // assign led[6] = left_click_deb;    // debounced left level

    // Show middle pixel value on LEDs for debugging
    // always @(posedge clk25) begin
    //     if (active_area && (frame_addr == 36567)) begin
    //         ss_output[11:0] <= bram_pixel_out;
    //     end else begin
    //         ss_output[11:0] <= ss_output[11:0];
    //     end
    // end
    
    // assign led[0] = pid_enable;
    // assign led[3:1] = comp_count;
    // assign led[15:0] = servo_x_angle[15:0];



    // reg [31:0] ssd_slow_cnt = 32'd0;
    // reg        ssd_slow_en = 1'b0;
    // always @(posedge clk) begin
    //     ssd_slow_cnt <= ssd_slow_cnt + 1;
    //     if (ssd_slow_cnt >= 32'd1) begin
    //         ssd_slow_cnt <= 32'd0;
    //         ssd_slow_en <= 1'b1;
    //     end else begin
    //         ssd_slow_en <= 1'b0;
    //     end
    // end
    // reg [15:0] ss_output;
    // always @(*) begin
    //     if (ssd_slow_en) begin
    //         ss_output <= {7'd0, DELETE_THIS};
    //     end else begin
    //         ss_output <= ss_output;
    //     end
    // end
    Seven_Seg ssd (
        .clk(clk),
        .num(ss_output),
        .dd(4'b0000),
        .seg(seg),
        .an(an)
    );
endmodule