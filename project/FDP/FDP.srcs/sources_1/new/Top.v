`timescale 1ns / 1ps

module Top(
    input clk, btnU, btnC,

    output ov7670_pwdn, ov7670_reset, ov7670_xclk,
    input ov7670_href, ov7670_pclk, ov7670_vsync,
    inout ov7670_siod,
    output ov7670_sioc,
    input [7:0] ov7670_d,
    output [15:0] led,
    input [15:0] sw,

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

    localparam [23:0] RGB_THRESHOLD = {
        4'hF, 4'hF, //B_MIN, B_MAX
        4'hF, 4'hF, //G_MIN, G_MAX
        4'hF, 4'hF  //R_MIN, R_MAX
    };

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
    wire [16:0] frame_addr;             // logical 0..(306*240-1)
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

    // ----------- OV7670 CAMERA CONTROLLER ----------- //
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
    wire [16:0] addr;          // logical capture address within a frame (0..73439)
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

    //----------- MEDIAN FILTERS (3x3 and 5x5) ----------- //
    // // 3x3 instance
    // wire pixel_valid_3x3;
    // wire [11:0] filtered_pixel_3x3;
    // wire [17:0] filtered_addr_3x3;
    // Median_Filter #(
    //     .KERNEL_SIZE(3),
    //     .PIXEL_DEPTH(12),
    //     .IMAGE_WIDTH(306),
    //     .IMAGE_HEIGHT(240)
    // )
    // median_filter(
    //     .clk(ov7670_pclk),
    //     .reset(cap_reset),
    //     .frame_start(ov7670_vsync),
    //     .pixel_in(dout),
    //     .we(we),
    //     .pixel_out(filtered_pixel_3x3),
    //     .addr_out(filtered_addr_3x3),
    //     .pixel_valid(pixel_valid_3x3)
    // );
    
    // 5x5 instance (stub for A/B testing)
    // wire pixel_valid_5x5;
    // wire [11:0] filtered_pixel_5x5;
    // wire [17:0] filtered_addr_5x5;
    // Median_Filter_5x5 #(
    //     .PIXEL_DEPTH(12),
    //     .IMAGE_WIDTH(306),
    //     .IMAGE_HEIGHT(240)
    // )
    // median_filter_5x5(
    //     .clk(ov7670_pclk),
    //     .reset(cap_reset),
    //     .frame_start(ov7670_vsync),
    //     .pixel_in(dout),
    //     .we(we),
    //     .pixel_out(filtered_pixel_5x5),
    //     .addr_out(filtered_addr_5x5),
    //     .pixel_valid(pixel_valid_5x5)
    // );

    //----------- GAUSSIAN 3x3 via Convolution3x3 ----------- //
    // Kernel: [1 2 1; 2 4 2; 1 2 1] with SCALE=4 (divide by 16)
    wire                    pixel_valid_gauss_3x3;
    wire [11:0]             filtered_pixel_gauss_3x3;
    wire [17:0]             filtered_addr_gauss_3x3;
    Convolution_3x3 #(
        .IMAGE_WIDTH(306),
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
        .we(we),
        .mode_rgb(1'b1),             // camera provides RGB444
        .pixel_rgb_in(dout),
        .pixel_bin_in(1'b0),
        .pixel_out(filtered_pixel_gauss_3x3),
        .addr_out(filtered_addr_gauss_3x3),
        .pixel_valid(pixel_valid_gauss_3x3)
    );

    //----------- MORPHOLOGY (ERODE/DILATE) ----------- //
    // Explicit binary thresholds (reuse for writer and morphology)
    wire threshold_bin_gauss = (((filtered_pixel_gauss_3x3[3:0] >= RGB_THRESHOLD[23:20]) && (filtered_pixel_gauss_3x3[3:0] <= RGB_THRESHOLD[19:16]) &&
                                 (filtered_pixel_gauss_3x3[7:4] >= RGB_THRESHOLD[15:12]) && (filtered_pixel_gauss_3x3[7:4] <= RGB_THRESHOLD[11:8]) &&
                                 (filtered_pixel_gauss_3x3[11:8] >= RGB_THRESHOLD[7:4]) && (filtered_pixel_gauss_3x3[11:8] <= RGB_THRESHOLD[3:0])) ? 1'b1 : 1'b0);
    wire threshold_bin_raw   = (((dout[3:0]  >= RGB_THRESHOLD[23:20]) && (dout[3:0]  <= RGB_THRESHOLD[19:16]) &&
                                 (dout[7:4]  >= RGB_THRESHOLD[15:12]) && (dout[7:4]  <= RGB_THRESHOLD[11:8]) &&
                                 (dout[11:8] >= RGB_THRESHOLD[7:4]) && (dout[11:8] <= RGB_THRESHOLD[3:0])) ? 1'b1 : 1'b0);

    wire pixel_valid_erode_3x3;
    wire filtered_pixel_erode_3x3;
    wire [17:0] filtered_addr_erode_3x3;
    Morphology_3x3 #(
        .IMAGE_WIDTH(306),
        .IMAGE_HEIGHT(240)
    ) erode3x3 (
        .clk(ov7670_pclk),
        .reset(cap_reset),
        .frame_start(ov7670_vsync),
        .we(pixel_valid_gauss_3x3),
        // morphology operates on gaussian-thresholded pixels
        .pixel_in(threshold_bin_gauss),
        .op_dilate(1'b0),
        .pixel_out(filtered_pixel_erode_3x3),
        .addr_out(filtered_addr_erode_3x3),
        .pixel_valid(pixel_valid_erode_3x3)
    );

    wire pixel_valid_dilate_3x3;
    wire filtered_pixel_dilate_3x3;
    wire [17:0] filtered_addr_dilate_3x3;
    Morphology_3x3 #(
        .IMAGE_WIDTH(306),
        .IMAGE_HEIGHT(240)
    ) dilate3x3 (
        .clk(ov7670_pclk),
        .reset(cap_reset),
        .frame_start(ov7670_vsync),
        .we(pixel_valid_erode_3x3),
        .pixel_in(filtered_pixel_erode_3x3),
        .op_dilate(1'b1),
        .pixel_out(filtered_pixel_dilate_3x3),
        .addr_out(filtered_addr_dilate_3x3),
        .pixel_valid(pixel_valid_dilate_3x3)
    );

    // Select which binary pipeline to write into the bitmap buffer:
    // sw[1] enables filtered pipeline in writer; sw[2] selects morphology; sw[3] chooses dilate(1)/erode(0)
    wire bin_filtered_valid = (sw[2]) ? (sw[3] ? pixel_valid_dilate_3x3 : pixel_valid_erode_3x3)
                                      : pixel_valid_gauss_3x3;
    // centered write address (defined below after FRAME_PIXELS parameter)
    wire [17:0] bin_filtered_addr;

    wire bin_filtered_bit   = (sw[2]) ? (sw[3] ? filtered_pixel_dilate_3x3 : filtered_pixel_erode_3x3)
                                      : threshold_bin_gauss;


    //----------- PING PONG BUFFERS ----------- //
    //No hard guards or syncs now, both just triggering the BRAM upper/lower swap on Vsync
    //Seems to be working fine and no tears for now so f it we ball I guess
    
    //Ping-pong buffer parameters (RGB444, 12-bit):
    localparam [17:0] FRAME_PIXELS   = 18'd73440;
    localparam [17:0] TOTAL_PIXELS   = 18'd146880; // 2*73440

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
    wire [17:0] wr_base = wr_sel ? FRAME_PIXELS : 18'd0;
    wire [17:0] rd_base = rd_sel ? FRAME_PIXELS : 18'd0;
    wire [17:0] addrb18 = {1'b0, frame_addr} + rd_base;

    // ----------- ADDRESS RECENTERING FOR 3x3 STAGES ----------- //
    // Cancel the inherent (-1,-1) window-center shift per stage by adding
    // (+1 row, +1 col) = +307 addresses for a 306x240 frame. Apply per-stage:
    //   Gaussian: +307; Erode(after Gauss): +614; Dilate(after Erode): +921
    localparam [17:0] ADDR_SHIFT1 = 18'd307;
    localparam [17:0] ADDR_SHIFT2 = 18'd614;
    localparam [17:0] ADDR_SHIFT3 = 18'd921;

    // Add shift and clamp to the last pixel to avoid OOB at bottom/right borders
    wire [18:0] gauss_tmp  = {1'b0, filtered_addr_gauss_3x3}  + ADDR_SHIFT1;
    wire [18:0] erode_tmp  = {1'b0, filtered_addr_erode_3x3}  + ADDR_SHIFT2;
    wire [18:0] dilate_tmp = {1'b0, filtered_addr_dilate_3x3} + ADDR_SHIFT3;

    wire [17:0] addr_gauss_centered  = (gauss_tmp  >= FRAME_PIXELS) ? (FRAME_PIXELS - 1) : gauss_tmp[17:0];
    wire [17:0] addr_erode_centered  = (erode_tmp  >= FRAME_PIXELS) ? (FRAME_PIXELS - 1) : erode_tmp[17:0];
    wire [17:0] addr_dilate_centered = (dilate_tmp >= FRAME_PIXELS) ? (FRAME_PIXELS - 1) : dilate_tmp[17:0];

    assign bin_filtered_addr = (sw[2]) ? (sw[3] ? addr_dilate_centered : addr_erode_centered)
                                       : addr_gauss_centered;

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
    reg        we_w;            // common write enable for both memories
    reg [17:0] waddr18_r;       // common write address for both memories (absolute with base)
    reg [11:0] rgb_dina_r;      // RGB data to image_mem
    reg        bmp_dina_r;      // bitmap data to Dual_Port_Buffer
    // Single pending entry for filtered overwrite (affects both memories)
    reg        pend;            // pending filtered write
    reg [17:0] pend_addr_q;     // absolute address for filtered center
    reg        bdin_q;          // latched filtered bitmap bit

    // PCLK-domain writer:
    // - Image RGB: raw on we==1, filtered overwrite on we==0
    // - Bitmap 1-bit: raw-threshold on we==1, filtered-threshold overwrite on we==0
    always @(posedge ov7670_pclk) begin
        if (cap_reset) begin
            we_w <= 1'b0;
            waddr18_r <= 18'd0;
            rgb_dina_r <= 12'd0;
            bmp_dina_r <= 1'b0;
            pend <= 1'b0;
            pend_addr_q <= 18'd0;
            bdin_q <= 1'b0;
        end else begin
            we_w <= 1'b0; // default no write; assert exactly once per cycle below

            // Latch a pending filtered write only when we==1 (raw write occupies the port).
            if (we && sw[1] && bin_filtered_valid && !pend) begin
                pend <= 1'b1;
                pend_addr_q <= bin_filtered_addr + wr_base_frame; // absolute address in the latched frame half
                // bitmap bit from selected filtered pipeline (same address as RGB)
                bdin_q <= bin_filtered_bit;
            end

            // On the non-pixel cycles (we==0):
            //  1) If a pending entry exists (from a prior we==1), commit it first to preserve order.
            //  2) Else, if a current filtered pixel is valid, write it immediately (padding flush support).
            if (!we) begin
                if (pend) begin
                    waddr18_r  <= pend_addr_q;
                    // rgb_dina_r <= fpix_q;    // choose not to overwrite rgb frame
                    bmp_dina_r <= bdin_q;
                    we_w <= 1'b1;
                    pend <= 1'b0;
                end else if (sw[1] && bin_filtered_valid) begin
                    waddr18_r  <= bin_filtered_addr + wr_base_frame;
                    // rgb_dina_r <= filtered_pixel;    // choose not to overwrite rgb frame
                    bmp_dina_r <= bin_filtered_bit;
                    we_w <= 1'b1;
                end
            end

            // On pixel-complete cycles (we==1), always write the RAW pixel to its address
            if (we) begin
                waddr18_r  <= {1'b0, addr} + wr_base_frame;
                rgb_dina_r <= dout;
                bmp_dina_r <= threshold_bin_raw;
                we_w <= 1'b1;
            end
        end
    end

    image_mem frame_buffer( 
        .clka(ov7670_pclk),
        .wea(we_w),
        .addra(waddr18_r),
        .dina(rgb_dina_r),          // write RGB444 (raw on we cycles, filtered on alt cycles)
        .clkb(clk25),
        .addrb(addrb18),
        .doutb(image_pixel)   // read RGB444
    );

    //----------- BITMAP STREAM (1-bit, synced to VGA read) ----------- //
    // Eliminate the dedicated bitmap BRAM; derive the bitmap bit on-the-fly
    // by thresholding the RGB pixel read from the frame buffer (image_pixel).
    // This keeps p_px aligned with addrb18/clk25 and removes the large 1-bit double buffer.
    wire bitmap_pixel;
    assign bitmap_pixel = (
        (image_pixel[3:0]  >= RGB_THRESHOLD[23:20]) && (image_pixel[3:0]  <= RGB_THRESHOLD[19:16]) && // B in range
        (image_pixel[7:4]  >= RGB_THRESHOLD[15:12]) && (image_pixel[7:4]  <= RGB_THRESHOLD[11:8])  && // G in range
        (image_pixel[11:8] >= RGB_THRESHOLD[7:4])   && (image_pixel[11:8] <= RGB_THRESHOLD[3:0])     // R in range
    ) ? 1'b1 : 1'b0;

    // Dual_Port_Buffer bitmap_buffer(
    //     .clka(ov7670_pclk),
    //     .we(we_w),
    //     .addra(waddr18_r),
    //     .dina(bmp_dina_r), // write bitmap pixel
    //     .clkb(clk25),
    //     .addrb(addrb18),
    //     .doutb(bitmap_pixel) // read bitmap pixel
    // );

    // ----------- UFDS BRIDGE FOR FIND CONTOURS ----------- //

    // Concatenated top-4 component outputs from UFDS via Bridge
    wire [39:0] comp3210_left, comp3210_right, comp3210_cx;   // 4x {valid(1) , x[8:0]}
    wire [35:0] comp3210_top,  comp3210_bottom, comp3210_cy;  // 4x {valid(1) , y[7:0]}
    wire [63:0] comp3210_area;                                 // 4x area[15:0]
    wire [2:0]  comp_count;
    wire        ready_o;
    // Only feed UFDS within the 306x240 cropped active area (x in [14,319], y in [0,239])
    wire in_roi = active_area && (frame_x[9:1] >= 10'd14) && (frame_x[9:1] < 10'd320) && (frame_y[9:1] < 10'd240);
    // Decimate the VGA-doubled raster (640x480) to source grid (320x240):
    // take only even hCounter/vCounter pixels so each source pixel is enqueued once
    wire decim_hv = (~frame_x[0]) && (~frame_y[0]);
    UFDS_Bridge ufds_bridge (
        .pclk(clk25),
        .p_rst(cap_reset),
    // Gate valid to ROI AND decimate by 2x2 so UFDS sees exactly 306x240 unique pixels per frame
    .p_valid(in_roi && decim_hv),
        .p_x(frame_x[9:1] - 14),
        .p_y(frame_y[9:1]),
        .p_px(bitmap_pixel), // use same bitmap data as pixel input
        .clk(clk50),
        .ext_reset(cap_reset),
        .comp3210_left(comp3210_left),
        .comp3210_right(comp3210_right),
        .comp3210_top(comp3210_top),
        .comp3210_bottom(comp3210_bottom),
        .comp3210_cx(comp3210_cx),
        .comp3210_cy(comp3210_cy),
        .comp3210_area(comp3210_area),
        .comp_count(comp_count),
        .ready_o(ready_o)
    );

    // ----------- MOUSE CONTROLLER ----------- //
    wire [15:0] mouse_led;
    wire [11:0] mouse_vga_color;

    // Servo PWM outputs that are one bit, toggled high/low depending on pwm signal
    wire servo_x_pwm;
    wire servo_y_pwm;

    // temporary holder for screen pixel coordinates (to be replaced)
    wire [13:0] x_coord;
    wire [13:0] y_coord;

    // Cooldown progress from mouse controller
    wire [7:0] cooldown_progress;

    // mouse controller module
    mouse_movement mouse_ctrl (
        .clk(clk),
        .btnU(btnU),
        .x_coord(x_coord),
        .y_coord(y_coord),
        .mouse_clk(mouse_clk),
        .mouse_data(mouse_data),
        .servo_x_pwm(servo_x_pwm),
        .servo_y_pwm(servo_y_pwm),
        .led(mouse_led),
        .cooldown_progress(cooldown_progress)
    );

    // always @(*) begin
    //     led = mouse_led;
    // end

    // ----------- UART CONTROLLER ----------- //
    // Controller encapsulates TX/RX UARTs with 10-byte FIFOs
    reg  [79:0] tx_fifo_payload = 80'h09080706050403020100; // initial pattern (MSB..LSB = 09..00)
    reg         tx_fifo_wr_en   = 1'b0;                     // 1-cycle strobe to enqueue a 10-byte burst
    wire [79:0] rx_fifo_payload;
    reg [79:0] rx_fifo_payload_buf;
    wire        rx_fifo_rd_en;                               // 1-cycle strobe when 10 bytes received

    UART_Controller u_uart (
        .clk(clk50),
        .rst(btnU),
        .tx_fifo(tx_fifo_payload),
        .tx_fifo_wr_en(tx_fifo_wr_en),
        .tx_pin(uart_tx),
        .rx_fifo(rx_fifo_payload),
        .rx_fifo_rd_en(rx_fifo_rd_en),
        .rx_pin(uart_rx)
    );

    // Generate a new 10-byte sequence once per second and trigger a TX burst.
    // Sequence is base..base+9 in LSB..MSB, so the hex prints as (base+9 ... base)
    reg [26:0] one_sec_counter = 27'd0;
    reg [7:0]  base_byte = 8'd0;
    always @(posedge clk50) begin
        tx_fifo_wr_en <= 1'b0; // default low
        one_sec_counter <= one_sec_counter + 1;
        if (one_sec_counter == 27'd50_000_000) begin
            one_sec_counter <= 27'd0;
            base_byte <= base_byte + 8'd1;
            // Pack bytes: [7:0]=base, [15:8]=base+1, ... [79:72]=base+9
            tx_fifo_payload[7:0]    <= base_byte;
            tx_fifo_payload[15:8]   <= base_byte + 8'd1;
            tx_fifo_payload[23:16]  <= base_byte + 8'd2;
            tx_fifo_payload[31:24]  <= base_byte + 8'd3;
            tx_fifo_payload[39:32]  <= base_byte + 8'd4;
            tx_fifo_payload[47:40]  <= base_byte + 8'd5;
            tx_fifo_payload[55:48]  <= base_byte + 8'd6;
            tx_fifo_payload[63:56]  <= base_byte + 8'd7;
            tx_fifo_payload[71:64]  <= base_byte + 8'd8;
            tx_fifo_payload[79:72]  <= base_byte + 8'd9;
            tx_fifo_wr_en <= 1'b1; // strobe send
        end
    end

    always @(posedge rx_fifo_rd_en) begin
        rx_fifo_payload_buf <= rx_fifo_payload;
    end

    // 7-seg display selection: choose 16-bit window from either TX or RX payload
    wire [79:0] uart_dbg = sw[15] ? rx_fifo_payload_buf : tx_fifo_payload;
    wire [15:0] ss_output =
        (sw[11]) ? uart_dbg[79:64] :
        (sw[12]) ? uart_dbg[63:48] :
        (sw[13]) ? uart_dbg[47:32] :
        (sw[14]) ? uart_dbg[31:16] :
                   uart_dbg[15:0];

    // Optional LEDs for quick UART debug
    assign led[0] = tx_fifo_wr_en;     // TX trigger
    assign led[1] = rx_fifo_rd_en;     // RX 10-byte ready

    // Show middle pixel value on LEDs for debugging
    // always @(posedge clk25) begin
    //     if (active_area && (frame_addr == 36567)) begin
    //         ss_output[11:0] <= image_pixel;
    //     end else begin
    //         ss_output[11:0] <= ss_output[11:0];
    //     end
    // end
    Seven_Seg ssd (
        .clk(clk),
        .num(ss_output),
        .dd(4'b0000),
        .seg(seg),
        .an(an)
    );

    // ----------- DISPLAY OUTPUTS ----------- //
    localparam GREEN = 12'h0F0;
    localparam RED = 12'h00F;
    localparam COOLDOWN = 200_000_000;


    localparam CROSSHAIR_HEIGHT = 11;
    wire [7:0] fill_height = (cooldown_progress * CROSSHAIR_HEIGHT) / 255;
    wire [7:0] green_start_y = 120 + CROSSHAIR_HEIGHT;        // bottom of the stem
    wire [7:0] green_top_y = green_start_y - fill_height;    // current row index of green 

    // Decode concatenated outputs into per-component fields and latch once per VGA frame
    wire [9:0] left0   = comp3210_left[9:0];
    wire [9:0] left1   = comp3210_left[19:10];
    wire [9:0] left2   = comp3210_left[29:20];
    wire [9:0] left3   = comp3210_left[39:30];

    wire [9:0] right0  = comp3210_right[9:0];
    wire [9:0] right1  = comp3210_right[19:10];
    wire [9:0] right2  = comp3210_right[29:20];
    wire [9:0] right3  = comp3210_right[39:30];

    wire [8:0] top0    = comp3210_top[8:0];
    wire [8:0] top1    = comp3210_top[17:9];
    wire [8:0] top2    = comp3210_top[26:18];
    wire [8:0] top3    = comp3210_top[35:27];

    wire [8:0] bottom0 = comp3210_bottom[8:0];
    wire [8:0] bottom1 = comp3210_bottom[17:9];
    wire [8:0] bottom2 = comp3210_bottom[26:18];
    wire [8:0] bottom3 = comp3210_bottom[35:27];

    wire [9:0] cx0     = comp3210_cx[9:0];
    wire [9:0] cx1     = comp3210_cx[19:10];
    wire [9:0] cx2     = comp3210_cx[29:20];
    wire [9:0] cx3     = comp3210_cx[39:30];

    wire [8:0] cy0     = comp3210_cy[8:0];
    wire [8:0] cy1     = comp3210_cy[17:9];
    wire [8:0] cy2     = comp3210_cy[26:18];
    wire [8:0] cy3     = comp3210_cy[35:27];

    // Latches for overlay drawing
    reg [9:0] left0_l, right0_l, cx0_l;
    reg [9:0] left1_l, right1_l, cx1_l;
    reg [9:0] left2_l, right2_l, cx2_l;
    reg [9:0] left3_l, right3_l, cx3_l;
    reg [8:0] top0_l, bottom0_l, cy0_l;
    reg [8:0] top1_l, bottom1_l, cy1_l;
    reg [8:0] top2_l, bottom2_l, cy2_l;
    reg [8:0] top3_l, bottom3_l, cy3_l;


    // --- Detect mouse click inside box ---
    wire inside_play_box = (mouse_x >= BOX_X0 && mouse_x < BOX_X0 + WIDTH0 &&
                       mouse_y >= BOX_Y0 && mouse_y < BOX_Y0 + HEIGHT0);

    wire inside_exit_box = (mouse_x >= BOX_X1 && mouse_x < BOX_X1 + WIDTH1 &&
                       mouse_y >= BOX_Y1 && mouse_y < BOX_Y1 + HEIGHT1);


    reg MENU_MODE = 1;
    localparam BOX_X0 = 30;
    localparam BOX_Y0 = 120;
    localparam WIDTH0 = 60;
    localparam HEIGHT0 = 60;

    localparam BOX_X1 = 180;
    localparam BOX_Y1 = 120;
    localparam WIDTH1 = 60;
    localparam HEIGHT1 = 60;


    wire left_click, right_click;
    wire [13:0] mouse_x, mouse_y;
    localparam mouse_maxCount_X = 8191;
    localparam mouse_maxCount_Y = 8191;

    MouseCtl mouse_inst (
        .clk(clk),
        .rst(btnU),
        .ps2_clk(mouse_clk),
        .ps2_data(mouse_data),
        .left(left_click),
        .right(right_click),
        .xpos(mouse_x),
        .ypos(mouse_y)
    );


    // wire [9:0] mouse_x_trimmed = (mouse_x * 306) / 8191;
    // wire [9:0] mouse_y_trimmed = (mouse_y * 240) / 8191;

    // Create a 9 x 9 cursor
    wire within_cursor; 
    wire [15:0] cursor_color;

    assign within_cursor = ((frame_x[9:1]-14 == mouse_x) || ((frame_x[9:1]-14 - mouse_x) == 1) || ((mouse_x - frame_x[9:1]-14) == 1)) && ((frame_y[9:1] == mouse_y) || ((frame_y[9:1] - mouse_y) == 1) || ((mouse_y - frame_y[9:1]) == 1));

    assign cursor_color = within_cursor ? 12'hFFF : 0;


    always @(posedge clk25) begin
        
        if (MENU_MODE) begin
            if(within_cursor) begin
                frame_pixel <= cursor_color;
            end else 
            if (frame_x[9:1]-14 >= BOX_X0 && frame_x[9:1]-14 <= BOX_X0 + WIDTH0 &&
                frame_y[9:1] >= BOX_Y0 && frame_y[9:1] <= BOX_Y0 + HEIGHT1 || 
                frame_x[9:1]-14 >= BOX_X1 && frame_x[9:1]-14 <= BOX_X1 + WIDTH1 &&
                frame_y[9:1] >= BOX_Y1 && frame_y[9:1] <= BOX_Y1 + HEIGHT1) begin
                    frame_pixel <= GREEN;
                end else begin
                    frame_pixel <= RED;
                end

            // if (inside_play_box && left_click)
            //     MENU_MODE <= 0;
            // end 
            // else begin
            //     if (frame_x[9:1]-14 >= BOX_X1 && frame_x[9:1]-14 < BOX_X1 + WIDTH1 &&
            //         frame_y[9:1] >= BOX_Y1 && frame_y[9:1] < BOX_Y1 + HEIGHT1) begin
            //         frame_pixel <= RED;
            //     end 

            //     if (inside_exit_box && left_click)
            //         MENU_MODE <= 1;
            // end
        end else if (sw[4]) begin
            frame_pixel <= canvas_pixel;
        end else begin
            if (frame_addr == 73439) begin
                // snapshot UFDS results once per VGA frame
                left0_l <= left0; right0_l <= right0; cx0_l <= cx0; top0_l <= top0; bottom0_l <= bottom0; cy0_l <= cy0;
                left1_l <= left1; right1_l <= right1; cx1_l <= cx1; top1_l <= top1; bottom1_l <= bottom1; cy1_l <= cy1;
                left2_l <= left2; right2_l <= right2; cx2_l <= cx2; top2_l <= top2; bottom2_l <= bottom2; cy2_l <= cy2;
                left3_l <= left3; right3_l <= right3; cx3_l <= cx3; top3_l <= top3; bottom3_l <= bottom3; cy3_l <= cy3;
            end else begin
                // --- Crosshair drawing with cooldown-based bottom fill ---
                // === Bottom vertical arm ===
                if (frame_x[9:1]-14 == 153 &&
                    frame_y[9:1] >= 120+2 && frame_y[9:1] <= 120+11) begin

                    // Green portion rises upward from bottom
                    if (frame_y[9:1] >= green_top_y)
                        frame_pixel <= GREEN;
                    else
                        frame_pixel <= RED;
                end

                // === Top vertical arm ===
                else if (frame_x[9:1]-14 == 153 &&
                        frame_y[9:1] >= 120-11 && frame_y[9:1] <= 120-2) begin

                    // Mirror the same cooldown progress upward
                    if (frame_y[9:1] <= (120 - CROSSHAIR_HEIGHT + fill_height))
                        frame_pixel <= GREEN;
                    else
                        frame_pixel <= RED;
                end

                // === Left horizontal arm ===
                else if (frame_y[9:1] == 120 &&
                        frame_x[9:1]-14 >= 153-11 && frame_x[9:1]-14 <= 153-2) begin

                    // Turn green once cooldown crosses midpoint
                    if (fill_height >= CROSSHAIR_HEIGHT / 2)
                        frame_pixel <= GREEN;
                    else
                        frame_pixel <= RED;
                end

                // === Right horizontal arm ===
                else if (frame_y[9:1] == 120 &&
                        frame_x[9:1]-14 >= 153+2 && frame_x[9:1]-14 <= 153+11) begin

                    if (fill_height >= CROSSHAIR_HEIGHT / 2)
                        frame_pixel <= GREEN;
                    else
                        frame_pixel <= RED;
                end
                else if (in_roi && (
                    // Comp 0
                    (
                        (frame_x[9:1]-14 == left0_l  && frame_y[9:1] >= top0_l    && frame_y[9:1] <= bottom0_l) ||
                        (frame_x[9:1]-14 == right0_l && frame_y[9:1] >= top0_l    && frame_y[9:1] <= bottom0_l) ||
                        (frame_y[9:1] == top0_l      && frame_x[9:1]-14 >= left0_l  && frame_x[9:1]-14 <= right0_l) ||
                        (frame_y[9:1] == bottom0_l   && frame_x[9:1]-14 >= left0_l  && frame_x[9:1]-14 <= right0_l) ||
                        (frame_x[9:1]-14 == cx0_l    && frame_y[9:1] >= cy0_l-2 && frame_y[9:1] <= cy0_l+2) ||
                        (frame_y[9:1] == cy0_l       && frame_x[9:1]-14 >= cx0_l-2 && frame_x[9:1]-14 <= cx0_l+2)
                    ) ||
                    // Comp 1
                    (
                        (frame_x[9:1]-14 == left1_l  && frame_y[9:1] >= top1_l    && frame_y[9:1] <= bottom1_l) ||
                        (frame_x[9:1]-14 == right1_l && frame_y[9:1] >= top1_l    && frame_y[9:1] <= bottom1_l) ||
                        (frame_y[9:1] == top1_l      && frame_x[9:1]-14 >= left1_l  && frame_x[9:1]-14 <= right1_l) ||
                        (frame_y[9:1] == bottom1_l   && frame_x[9:1]-14 >= left1_l  && frame_x[9:1]-14 <= right1_l) ||
                        (frame_x[9:1]-14 == cx1_l    && frame_y[9:1] >= cy1_l-2 && frame_y[9:1] <= cy1_l+2) ||
                        (frame_y[9:1] == cy1_l       && frame_x[9:1]-14 >= cx1_l-2 && frame_x[9:1]-14 <= cx1_l+2)
                    ) ||
                    // Comp 2
                    (
                        (frame_x[9:1]-14 == left2_l  && frame_y[9:1] >= top2_l    && frame_y[9:1] <= bottom2_l) ||
                        (frame_x[9:1]-14 == right2_l && frame_y[9:1] >= top2_l    && frame_y[9:1] <= bottom2_l) ||
                        (frame_y[9:1] == top2_l      && frame_x[9:1]-14 >= left2_l  && frame_x[9:1]-14 <= right2_l) ||
                        (frame_y[9:1] == bottom2_l   && frame_x[9:1]-14 >= left2_l  && frame_x[9:1]-14 <= right2_l) ||
                        (frame_x[9:1]-14 == cx2_l    && frame_y[9:1] >= cy2_l-2 && frame_y[9:1] <= cy2_l+2) ||
                        (frame_y[9:1] == cy2_l       && frame_x[9:1]-14 >= cx2_l-2 && frame_x[9:1]-14 <= cx2_l+2)
                    ) ||
                    // Comp 3
                    (
                        (frame_x[9:1]-14 == left3_l  && frame_y[9:1] >= top3_l    && frame_y[9:1] <= bottom3_l) ||
                        (frame_x[9:1]-14 == right3_l && frame_y[9:1] >= top3_l    && frame_y[9:1] <= bottom3_l) ||
                        (frame_y[9:1] == top3_l      && frame_x[9:1]-14 >= left3_l  && frame_x[9:1]-14 <= right3_l) ||
                        (frame_y[9:1] == bottom3_l   && frame_x[9:1]-14 >= left3_l  && frame_x[9:1]-14 <= right3_l) ||
                        (frame_x[9:1]-14 == cx3_l    && frame_y[9:1] >= cy3_l-2 && frame_y[9:1] <= cy3_l+2) ||
                        (frame_y[9:1] == cy3_l       && frame_x[9:1]-14 >= cx3_l-2 && frame_x[9:1]-14 <= cx3_l+2)
                    )
                )) begin
                    frame_pixel <= 12'h00F;
                end
                else begin
                    if (sw[0]) frame_pixel <= (bitmap_pixel ? 12'hFFF : 12'h000);
                    else frame_pixel <= image_pixel;
                end
            end
        end
    end 


    // Randomised canvas module instance (mosaic + shapes). Used with sw[4] ON.
    wire [11:0] canvas_pixel;
    Randomised_Canvas canvas_inst (
        .clk(clk25),
        .reset(vga_reset),
        .btnC(btnC),
        .frame_x(frame_x),
        .frame_y(frame_y),
        .in_roi(in_roi),
        .active_area(active_area),
        .pixel_out(canvas_pixel)
    );




    // Sets timer
    // Time_Countdown timer_inst (
    //     .clk(clk),
    //     .sw(sw[3:0]),
    //     .btnC(btnC),
    //     .btnU(btnU),
    //     .seg(seg[7:0]),
    //     .an(an[3:0])
    // );


endmodule