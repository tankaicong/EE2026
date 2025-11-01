`timescale 1ns / 1ps

module Top(
    input clk, btnU, btnC,

    output ov7670_pwdn, ov7670_reset, ov7670_xclk,
    input ov7670_href_pin, ov7670_pclk_pin, ov7670_vsync_pin,
    inout ov7670_siod,
    output ov7670_sioc,
    input [7:0] ov7670_d_pin,
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

    wire ov7670_href;
    wire ov7670_pclk;
    wire ov7670_vsync;
    wire [7:0] ov7670_d;
    assign ov7670_href = sw[10] ? 1'bz : ov7670_href_pin;
    assign ov7670_pclk = sw[10] ? 1'bz : ov7670_pclk_pin;
    assign ov7670_vsync = sw[10] ? 1'bz : ov7670_vsync_pin;
    assign ov7670_d = sw[10] ? 8'bzzzzzzzz : ov7670_d_pin;

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
    wire [16:0] frame_addr;             // logical 0..(310*240-1)
    wire [11:0] bram_pixel_out;            // 12-bit RGB444 from BRAM
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

    // ----------- FILTER SELECTION MUX CONTROLS ----------- //
    // Wires driven by switches: do not give them constant drivers as well
    reg Gaussian_In_Control;
    reg Median_In_Control;
    reg [1:0] RGB_Out_Control;
    reg [1:0] Erode_1_In_Control = 2'b00;
    reg [1:0] Erode_2_In_Control = 2'b00;
    reg [1:0] Dilate_1_In_Control = 2'b00;
    reg [1:0] Dilate_2_In_Control = 2'b00;
    reg [2:0] BMP_Out_Control = 3'b000;
    reg [1:0] Final_Out_Control;
    reg [3:0] Preprocessing_State = 4'h0;
    reg [7:0] Morphology_State = 8'h00;

    always @(*) begin
        //state machine for preprocessing control
        case (Preprocessing_State)
            4'b0000: begin //Raw camera
                Gaussian_In_Control <= 1'bx;
                Median_In_Control <= 1'bx;
                RGB_Out_Control <= 2'b00;
            end
            4'b0001: begin //Gaussian only
                Gaussian_In_Control <= 1'b0;
                Median_In_Control <= 1'bx;
                RGB_Out_Control <= 2'b01;
            end
            4'b0010: begin //Median only
                Gaussian_In_Control <= 1'bx;
                Median_In_Control <= 1'b0;
                RGB_Out_Control <= 2'b10;
            end
            4'b1001: begin //Gaussian --> Median
                Gaussian_In_Control <= 1'b0;
                Median_In_Control <= 1'b1;
                RGB_Out_Control <= 2'b10;
            end
            4'b0110: begin //Median --> Gaussian
                Gaussian_In_Control <= 1'b1;
                Median_In_Control <= 1'b0;
                RGB_Out_Control <= 2'b01;
            end
            default: begin  //invalid states just shows raw camera
                Gaussian_In_Control <= 1'b0;
                Median_In_Control <= 1'b0;
                RGB_Out_Control <= 2'b00;
            end
        endcase
    end

    always @(*) begin
        case(Morphology_State)
            8'b00000000: begin //no morphology ops
                Erode_1_In_Control <= 2'bxx; Erode_2_In_Control <= 2'bxx;
                Dilate_1_In_Control <= 2'bxx; Dilate_2_In_Control <= 2'bxx;
                BMP_Out_Control <= 3'b000;
            end
            8'b00000001: begin //Erode
                Erode_1_In_Control <= 2'b00; Erode_2_In_Control <= 2'bxx;
                Dilate_1_In_Control <= 2'bxx; Dilate_2_In_Control <= 2'bxx;
                BMP_Out_Control <= 3'b001;
            end
            8'b00000010: begin //Dilate
                Erode_1_In_Control <= 2'bxx; Erode_2_In_Control <= 2'bxx;
                Dilate_1_In_Control <= 2'b00; Dilate_2_In_Control <= 2'bxx;
                BMP_Out_Control <= 3'b011;
            end
            8'b00000101: begin //Erode -> Erode
                Erode_1_In_Control <= 2'b00; Erode_2_In_Control <= 2'b00;
                Dilate_1_In_Control <= 2'bxx; Dilate_2_In_Control <= 2'bxx;
                BMP_Out_Control <= 3'b010;
            end
            8'b00001010: begin //Dilate -> Dilate
                Erode_1_In_Control <= 2'bxx; Erode_2_In_Control <= 2'bxx;
                Dilate_1_In_Control <= 2'b00; Dilate_2_In_Control <= 2'b00;
                BMP_Out_Control <= 3'b100;
            end
            8'b00001001: begin //Erode -> Dilate
                Erode_1_In_Control <= 2'b00; Erode_2_In_Control <= 2'bxx;
                Dilate_1_In_Control <= 2'b01; Dilate_2_In_Control <= 2'bxx;
                BMP_Out_Control <= 3'b011;
            end
            8'b00000110: begin //Dilate -> Erode
                Erode_1_In_Control <= 2'b01; Erode_2_In_Control <= 2'bxx;
                Dilate_1_In_Control <= 2'b00; Dilate_2_In_Control <= 2'bxx;
                BMP_Out_Control <= 3'b001;
            end
            8'b00100101: begin //Erode -> Erode -> Dilate
                Erode_1_In_Control <= 2'b00; Erode_2_In_Control <= 2'b00;
                Dilate_1_In_Control <= 2'b10; Dilate_2_In_Control <= 2'bxx;
                BMP_Out_Control <= 3'b011;
            end
            8'b00011001: begin //Erode -> Dilate -> Erode
                Erode_1_In_Control <= 2'b00; Erode_2_In_Control <= 2'b01;
                Dilate_1_In_Control <= 2'b01; Dilate_2_In_Control <= 2'bxx;
                BMP_Out_Control <= 3'b010;
            end
            8'b00010110: begin //Dilate -> Erode -> Erode
                Erode_1_In_Control <= 2'b01; Erode_2_In_Control <= 2'b00;
                Dilate_1_In_Control <= 2'b00; Dilate_2_In_Control <= 2'bxx;
                BMP_Out_Control <= 3'b010;
            end
            8'b00011010: begin //Dilate -> Dilate -> Erode
                Erode_1_In_Control <= 2'b10; Erode_2_In_Control <= 2'bxx;
                Dilate_1_In_Control <= 2'b00; Dilate_2_In_Control <= 2'b00;
                BMP_Out_Control <= 3'b001;
            end
            8'b00100110: begin //Dilate -> Erode -> Dilate
                Erode_1_In_Control <= 2'b01; Erode_2_In_Control <= 2'bxx;
                Dilate_1_In_Control <= 2'b00; Dilate_2_In_Control <= 2'b01;
                BMP_Out_Control <= 3'b100;
            end
            8'b00101001: begin //Erode -> Dilate -> Dilate
                Erode_1_In_Control <= 2'b00; Erode_2_In_Control <= 2'bxx;
                Dilate_1_In_Control <= 2'b01; Dilate_2_In_Control <= 2'b00;
                BMP_Out_Control <= 3'b100;
            end
            8'b10100101: begin //Erode -> Erode -> Dilate -> Dilate
                Erode_1_In_Control <= 2'b00; Erode_2_In_Control <= 2'b00;
                Dilate_1_In_Control <= 2'b10; Dilate_2_In_Control <= 2'b00;
                BMP_Out_Control <= 3'b100;
            end
            8'b01101001: begin //Erode -> Dilate -> Dilate -> Erode
                Erode_1_In_Control <= 2'b00; Erode_2_In_Control <= 2'b01;
                Dilate_1_In_Control <= 2'b00; Dilate_2_In_Control <= 2'b10;
                BMP_Out_Control <= 3'b010;
            end
            8'b01011010: begin //Dilate -> Dilate -> Erode -> Erode
                Erode_1_In_Control <= 2'b10; Erode_2_In_Control <= 2'b00;
                Dilate_1_In_Control <= 2'b00; Dilate_2_In_Control <= 2'b00;
                BMP_Out_Control <= 3'b010;
            end
            8'b10010110: begin //Dilate -> Erode -> Erode -> Dilate
                Erode_1_In_Control <= 2'b01; Erode_2_In_Control <= 2'b00;
                Dilate_1_In_Control <= 2'b00; Dilate_2_In_Control <= 2'b10;
                BMP_Out_Control <= 3'b100;
            end
            8'b10011001: begin //Erode -> Dilate -> Erode -> Dilate
                Erode_1_In_Control <= 2'b00; Erode_2_In_Control <= 2'b01;
                Dilate_1_In_Control <= 2'b01; Dilate_2_In_Control <= 2'b10;
                BMP_Out_Control <= 3'b100;
            end
            8'b01100110: begin //Dilate -> Erode -> Dilate -> Erode
                Erode_1_In_Control <= 2'b01; Erode_2_In_Control <= 2'b10;
                Dilate_1_In_Control <= 2'b00; Dilate_2_In_Control <= 2'b01;
                BMP_Out_Control <= 3'b010;
            end
            default: begin  //invalid states just shows no morphology ops
                Erode_1_In_Control <= 2'b00; Erode_2_In_Control <= 2'b00;
                Dilate_1_In_Control <= 2'b00; Dilate_2_In_Control <= 2'b00;
                BMP_Out_Control <= 3'b000;
            end
        endcase
    end

    always @(posedge clk) begin
        Preprocessing_State <= pre_order_vector;
        Morphology_State <= morph_order_vector;
        Final_Out_Control <= sw[1:0];
    end

    // input and output pixels from each convolutional block
    wire [11:0] median_pixel_in, median_pixel_out;
    wire [11:0] gaussian_pixel_in, gaussian_pixel_out;
    wire [11:0] rgb_pixel_out;
    wire threshold_pixel;
    wire erode_1_pixel_in, erode_1_pixel_out;
    wire erode_2_pixel_in, erode_2_pixel_out;
    wire dilate_1_pixel_in, dilate_1_pixel_out;
    wire dilate_2_pixel_in, dilate_2_pixel_out;
    wire bmp_pixel_out;
    wire [11:0] final_pixel_out;

    // write enables piping in pixel_valid outputs from previous convolutional blocks or camera capture block
    wire median_pixel_we, gaussian_pixel_we;
    wire rgb_pixel_we;
    wire erode_1_pixel_we, erode_2_pixel_we;
    wire dilate_1_pixel_we, dilate_2_pixel_we;

    // output address wires from each convolutional block / mux
    wire [16:0] median_addr_out, gaussian_addr_out;
    wire [16:0] rgb_addr_out;
    wire [16:0] erode_1_addr_out, erode_2_addr_out;
    wire [16:0] dilate_1_addr_out, dilate_2_addr_out;
    wire [16:0] bmp_addr_out;
    wire [16:0] final_addr_out;

    // output flags from the convolutional blocks / mux indicating when pixel_out is valid
    wire median_pixel_valid, gaussian_pixel_valid;
    wire rgb_pixel_valid;
    wire erode_1_pixel_valid, erode_2_pixel_valid;
    wire dilate_1_pixel_valid, dilate_2_pixel_valid;
    wire bmp_pixel_valid;
    wire final_pixel_valid;

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

    assign threshold_pixel = (((rgb_pixel_out[3:0] >= RGB_THRESHOLD[23:20]) && (rgb_pixel_out[3:0] <= RGB_THRESHOLD[19:16]) &&
                             (rgb_pixel_out[7:4] >= RGB_THRESHOLD[15:12]) && (rgb_pixel_out[7:4] <= RGB_THRESHOLD[11:8]) &&
                             (rgb_pixel_out[11:8] >= RGB_THRESHOLD[7:4]) && (rgb_pixel_out[11:8] <= RGB_THRESHOLD[3:0])) ? 1'b1 : 1'b0);
    wire threshold_pixel_dout = (((dout[3:0] >= RGB_THRESHOLD[23:20]) && (dout[3:0] <= RGB_THRESHOLD[19:16]) &&
                             (dout[7:4] >= RGB_THRESHOLD[15:12]) && (dout[7:4] <= RGB_THRESHOLD[11:8]) &&
                             (dout[11:8] >= RGB_THRESHOLD[7:4]) && (dout[11:8] <= RGB_THRESHOLD[3:0])) ? 1'b1 : 1'b0);

    // morphological operations path control
    assign erode_1_pixel_in = (Erode_1_In_Control == 2'b00) ? threshold_pixel :
                              (Erode_1_In_Control == 2'b01) ? dilate_1_pixel_out :
                              (Erode_1_In_Control == 2'b10) ? dilate_2_pixel_out : 1'b0;
    assign erode_1_pixel_we = (Erode_1_In_Control == 2'b00) ? rgb_pixel_valid :
                              (Erode_1_In_Control == 2'b01) ? dilate_1_pixel_valid :
                              (Erode_1_In_Control == 2'b10) ? dilate_2_pixel_valid : 1'b0;    

    assign erode_2_pixel_in = (Erode_2_In_Control == 2'b00) ? erode_1_pixel_out :
                              (Erode_2_In_Control == 2'b01) ? dilate_1_pixel_out :
                              (Erode_2_In_Control == 2'b10) ? dilate_2_pixel_out : 1'b0;
    assign erode_2_pixel_we = (Erode_2_In_Control == 2'b00) ? erode_1_pixel_valid :
                              (Erode_2_In_Control == 2'b01) ? dilate_1_pixel_valid :
                              (Erode_2_In_Control == 2'b10) ? dilate_2_pixel_valid : 1'b0;

    assign dilate_1_pixel_in = (Dilate_1_In_Control == 2'b00) ? threshold_pixel :
                               (Dilate_1_In_Control == 2'b01) ? erode_1_pixel_out :
                               (Dilate_1_In_Control == 2'b10) ? erode_2_pixel_out : 1'b0;
    assign dilate_1_pixel_we = (Dilate_1_In_Control == 2'b00) ? rgb_pixel_valid :
                               (Dilate_1_In_Control == 2'b01) ? erode_1_pixel_valid :
                               (Dilate_1_In_Control == 2'b10) ? erode_2_pixel_valid : 1'b0;

    assign dilate_2_pixel_in = (Dilate_2_In_Control == 2'b00) ? dilate_1_pixel_out :
                               (Dilate_2_In_Control == 2'b01) ? erode_1_pixel_out :
                               (Dilate_2_In_Control == 2'b10) ? erode_2_pixel_out : 1'b0;
    assign dilate_2_pixel_we = (Dilate_2_In_Control == 2'b00) ? dilate_1_pixel_valid :
                               (Dilate_2_In_Control == 2'b01) ? erode_1_pixel_valid :
                               (Dilate_2_In_Control == 2'b10) ? erode_2_pixel_valid : 1'b0;

    assign bmp_pixel_out = (BMP_Out_Control == 3'b000) ? threshold_pixel :
                           (BMP_Out_Control == 3'b001) ? erode_1_pixel_out :
                           (BMP_Out_Control == 3'b010) ? erode_2_pixel_out :
                           (BMP_Out_Control == 3'b011) ? dilate_1_pixel_out :
                           (BMP_Out_Control == 3'b100) ? dilate_2_pixel_out : 1'b0;
    assign bmp_addr_out = (BMP_Out_Control == 3'b000) ? rgb_addr_out :
                          (BMP_Out_Control == 3'b001) ? erode_1_addr_out :
                          (BMP_Out_Control == 3'b010) ? erode_2_addr_out :
                          (BMP_Out_Control == 3'b011) ? dilate_1_addr_out :
                          (BMP_Out_Control == 3'b100) ? dilate_2_addr_out : 17'd0;
    assign bmp_pixel_valid = (BMP_Out_Control == 3'b000) ? rgb_pixel_valid :
                             (BMP_Out_Control == 3'b001) ? erode_1_pixel_valid :
                             (BMP_Out_Control == 3'b010) ? erode_2_pixel_valid :
                             (BMP_Out_Control == 3'b011) ? dilate_1_pixel_valid :
                             (BMP_Out_Control == 3'b100) ? dilate_2_pixel_valid : 1'b0;

    assign final_pixel_out = (Final_Out_Control == 2'b00) ? dout :
                             (Final_Out_Control == 2'b01) ? rgb_pixel_out :
                             (Final_Out_Control == 2'b10) ? (threshold_pixel ? 12'hFFF : 12'h000) :
                             (Final_Out_Control == 2'b11) ? (bmp_pixel_out ? 12'hFFF : 12'h000) : 12'd0;
    assign final_pixel_we = (Final_Out_Control == 2'b00) ? we :
                            (Final_Out_Control == 2'b01) ? rgb_pixel_valid :
                            (Final_Out_Control == 2'b10) ? rgb_pixel_valid :
                            (Final_Out_Control == 2'b11) ? bmp_pixel_valid : 1'b0; 
    assign final_addr_out = (Final_Out_Control == 2'b00) ? addr :
                            (Final_Out_Control == 2'b01) ? rgb_addr_out :
                            (Final_Out_Control == 2'b10) ? rgb_addr_out :
                            (Final_Out_Control == 2'b11) ? bmp_addr_out : 17'd0;

    
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
        .pixel_out(median_pixel_out),
        .addr_out(median_addr_out),
        .pixel_valid(median_pixel_valid)
    );

    //----------- GAUSSIAN 3x3 via Convolution3x3 ----------- //
    // Kernel: [1 2 1; 2 4 2; 1 2 1] with SCALE=4 (divide by 16)
    wire                    pixel_valid_gauss_3x3;
    wire [11:0]             filtered_pixel_gauss_3x3;
    wire [16:0]             filtered_addr_gauss_3x3;
    Convolution_3x3 #(
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
        .pixel_out(gaussian_pixel_out),
        .addr_out(gaussian_addr_out),
        .pixel_valid(gaussian_pixel_valid)
    );

    // MUX to send to VGA display
    // wire [11:0] display_pixel_color = sw[2] ? (sw[3] ? filtered_pixel_median_3x3 : filtered_pixel_gauss_3x3) : dout;
    // wire [16:0] display_addr_color = sw[2] ? (sw[3] ? filtered_addr_median_3x3 : filtered_addr_gauss_3x3) : addr;
    // wire pixel_valid_display = sw[2] ? (sw[3] ? pixel_valid_median_3x3 : pixel_valid_gauss_3x3) : we;

    //----------- MORPHOLOGY (ERODE/DILATE) ----------- //
    // Explicit binary thresholds (reuse for writer and morphology)
    Morphology_3x3 #(
        .IMAGE_WIDTH(310),
        .IMAGE_HEIGHT(240)
    ) erode3x3_1 (
        .clk(ov7670_pclk),
        .reset(cap_reset),
        .frame_start(ov7670_vsync),
        .we(erode_1_pixel_we),
        .pixel_in(erode_1_pixel_in),
        .op_dilate(1'b0),
        .pixel_out(erode_1_pixel_out),
        .addr_out(erode_1_addr_out),
        .pixel_valid(erode_1_pixel_valid)
    );
    Morphology_3x3 #(
        .IMAGE_WIDTH(310),
        .IMAGE_HEIGHT(240)
    ) erode3x3_2 (
        .clk(ov7670_pclk),
        .reset(cap_reset),
        .frame_start(ov7670_vsync),
        .we(erode_2_pixel_we),
        .pixel_in(erode_2_pixel_in),
        .op_dilate(1'b0),
        .pixel_out(erode_2_pixel_out),
        .addr_out(erode_2_addr_out),
        .pixel_valid(erode_2_pixel_valid)
    );

    Morphology_3x3 #(
        .IMAGE_WIDTH(310),
        .IMAGE_HEIGHT(240)
    ) dilate3x3_1 (
        .clk(ov7670_pclk),
        .reset(cap_reset),
        .frame_start(ov7670_vsync),
        .we(dilate_1_pixel_we),
        .pixel_in(dilate_1_pixel_in),
        .op_dilate(1'b1),
        .pixel_out(dilate_1_pixel_out),
        .addr_out(dilate_1_addr_out),
        .pixel_valid(dilate_1_pixel_valid)
    );
    Morphology_3x3 #(
        .IMAGE_WIDTH(310),
        .IMAGE_HEIGHT(240)
    ) dilate3x3_2 (
        .clk(ov7670_pclk),
        .reset(cap_reset),
        .frame_start(ov7670_vsync),
        .we(dilate_2_pixel_we),
        .pixel_in(dilate_2_pixel_in),
        .op_dilate(1'b1),
        .pixel_out(dilate_2_pixel_out),
        .addr_out(dilate_2_addr_out),
        .pixel_valid(dilate_2_pixel_valid)
    );

    // Select which binary pipeline to write into the buffer:
    // wire threshold_pixel_bin = sw[4] ? (sw[5] ? threshold_pixel_dilate_3x3 : threshold_pixel_erode_3x3)
    //                                   : threshold_pixel;
    // Pixel valid for bitmap path must align with the address source used for bitmap writes:
    // - If morphology is enabled (sw[4]=1), use the corresponding morphology valid
    // - Else, use gaussian valid (provides padding flush so right/bottom borders are covered)
    // wire pixel_valid_bin = sw[4] ? (sw[5] ? pixel_valid_dilate_3x3 : pixel_valid_erode_3x3)
    //                                   : pixel_valid_color;
    // centered write address (defined below after FRAME_PIXELS parameter)
    // wire [17:0] threshold_addr_bin;

    // wire pixel_valid_final = sw[6] ? pixel_valid_bin : pixel_valid_display;
    // wire [11:0] final_pixel = sw[6] ? (threshold_pixel_bin ? 12'hFFF : 12'h000) : display_pixel_color;
    // wire [17:0] final_addr = sw[6] ? threshold_addr_bin : display_addr_color;

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
    reg        we_w;            // common write enable for both memories
    reg [17:0] waddr18_r;       // common write address for both memories (absolute with base)
    reg [11:0] rgb_dina_r;      // RGB data to image_mem
    reg        bmp_dina_r;      // bitmap data to Dual_Port_Buffer
    // Single pending entry for filtered overwrite (affects both memories)
    reg        pend;            // pending filtered write
    reg [17:0] pend_addr_q;     // absolute address for filtered center
    reg [11:0] fpix_q;         // latched filtered RGB pixel
    // reg        bdin_q;          // latched filtered bitmap bit

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
            // bdin_q <= 1'b0;
        end else begin
            we_w <= 1'b0; // default no write; assert exactly once per cycle below

            // Latch a pending filtered write only when we==1 (raw write occupies the port).
            if (we && final_pixel_we && !pend) begin
                pend <= 1'b1;
                pend_addr_q <= final_addr_out + wr_base_frame; // absolute address in the latched frame half
                // bitmap bit from selected filtered pipeline (same address as RGB)
                fpix_q <= final_pixel_out;
                // bdin_q <= threshold_pixel_mux;
            end

            // On the non-pixel cycles (we==0):
            //  1) If a pending entry exists (from a prior we==1), commit it first to preserve order.
            //  2) Else, if a current filtered pixel is valid, write it immediately (padding flush support).
            if (!we) begin
                if (pend) begin
                    waddr18_r  <= pend_addr_q;
                    rgb_dina_r <= fpix_q;    // choose not to overwrite rgb frame
                    // bmp_dina_r <= bdin_q;
                    we_w <= 1'b1;
                    pend <= 1'b0;
                end
                else if (final_pixel_we) begin
                    waddr18_r  <= final_addr_out + wr_base_frame;
                    rgb_dina_r <= final_pixel_out;
                    // bmp_dina_r <= threshold_pixel_bin;
                    we_w <= 1'b1;
                end
            end

            // On pixel-complete cycles (we==1):
            //  - If sw[6]=1 (bitmap mode), write immediate threshold(dout) so the frame never shows RGB
            //  - Else, write RAW RGB as usual
            if (we) begin
                waddr18_r  <= {1'b0, addr} + wr_base_frame;
                rgb_dina_r <= Final_Out_Control[1] ? (threshold_pixel_dout ? 12'hFFF : 12'h000) : dout;
                // bmp_dina_r <= threshold_pixel;
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
    // Eliminate the dedicated bitmap BRAM; derive the bitmap bit on-the-fly
    // by thresholding the RGB pixel read from the frame buffer (bram_pixel_out).
    // This keeps p_px aligned with addrb18/clk25 and removes the large 1-bit double buffer.
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

    // ----------- UFDS BRIDGE FOR FIND CONTOURS ----------- //

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
    wire ufds_pixel_in = Final_Out_Control[1] ? (bram_pixel_out == 12'hFFF) : 12'h000;
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
    // wire [79:0] uart_dbg = sw[15] ? rx_fifo_payload_buf : tx_fifo_payload;
    // wire [15:0] ss_output =
    //     (sw[11]) ? uart_dbg[79:64] :
    //     (sw[12]) ? uart_dbg[63:48] :
    //     (sw[13]) ? uart_dbg[47:32] :
    //     (sw[14]) ? uart_dbg[31:16] :
    //                uart_dbg[15:0];

    // Optional LEDs for quick UART debug
    assign led[0] = tx_fifo_wr_en;     // TX trigger
    assign led[1] = rx_fifo_rd_en;     // RX 10-byte ready
    // Drag-drop debug LEDs
    assign led[5] = cv_settings_mode;  // settings screen active
    assign led[6] = left_click_deb;    // debounced left level

    // Show middle pixel value on LEDs for debugging
    // always @(posedge clk25) begin
    //     if (active_area && (frame_addr == 36567)) begin
    //         ss_output[11:0] <= bram_pixel_out;
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

    // Randomised canvas module instance (mosaic + shapes). Used with sw[15] ON.
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




    // ----------- MOUSE CONTROLLER ----------- //

    // Synchronize reset to mouse controller clock domain
    reg [2:0] mouse_rst_sync = 3'b111;
    always @(posedge clk) begin
        mouse_rst_sync <= {mouse_rst_sync[1:0], btnU};
    end
    wire mouse_reset = mouse_rst_sync[2];


    wire left_click, right_click, new_event;
    wire [11:0] mouse_x_raw, mouse_y_raw;
    
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
        // .setmax_x(10'd640),
        // .setmax_y(9'd480),
        .setx(),
        .sety(),
        .setmax_x(),
        .setmax_y(),
        // .value(12'd1024)
        .value()
    );


    wire [15:0] mouse_led;
    wire [11:0] mouse_vga_color;

    // Servo PWM outputs that are one bit, toggled high/low depending on pwm signal
    wire servo_x_pwm;
    wire servo_y_pwm;

    // Cooldown progress from mouse controller
    // wire [7:0] cooldown_progress;
    localparam COOLDOWN = 200_000_000;

    // mouse controller module
    mouse_movement mouse_ctrl (
        .clk(clk),
        .btnU(mouse_reset),
        .left(left_click),
        .right(right_click),
        .new_event(new_event),
        .xpos(mouse_x_raw),
        .ypos(mouse_y_raw),
        .mouse_clk(mouse_clk),
        .mouse_data(mouse_data),
        .servo_x_pwm(servo_x_pwm),
        .servo_y_pwm(servo_y_pwm),
        .led(mouse_led)
        // .cooldown_progress(cooldown_progress)
    );

    // always @(*) begin
    //     led = mouse_led;
    // end



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

    // Source-grid (320x240) mouse for legacy/menu logic
    wire [8:0] mouse_x_px = (mouse_x_sync[11:1] >= 11'd320) ? 9'd319 : mouse_x_sync[9:1];
    wire [7:0] mouse_y_px = (mouse_y_sync[10:1] >= 10'd240) ? 8'd239 : mouse_y_sync[8:1];

    // Source-grid coords for current pixel
    wire [8:0] px_src = frame_x[9:1] - 10; // 0..309
    wire [7:0] py_src = frame_y[9:1];      // 0..239

    // Create a 3x3 cursor in source-grid (appears doubled in VGA)
    wire within_cursor_3x3;
    wire [11:0] cursor_colour;

    assign within_cursor_3x3 =
        (px_src >= mouse_x_px - 1) && (px_src <= mouse_x_px + 1) &&
        (py_src >= mouse_y_px - 1) && (py_src <= mouse_y_px + 1);

    assign cursor_colour = within_cursor_3x3 ? 12'hFFF : 12'h000;


    // Parameters for overlay boxes
    // begin shooting game box
    localparam BOX_X0 = 30;
    localparam BOX_Y0 = 120;
    localparam WIDTH0 = 60;
    localparam HEIGHT0 = 60;

    // right menu box
    localparam BOX_X1 = 180;
    localparam BOX_Y1 = 120;
    localparam WIDTH1 = 60;
    localparam HEIGHT1 = 60;

    // <------ Settings box ------->
    localparam BOX_X2 = 50;
    localparam BOX_Y2 = 50;
    localparam WIDTH2 = 160;
    localparam HEIGHT2 = 120;


    // Instances of layered boxes for display, currently have: menu's manual box and menu's auto box
    // each box has 3 layers of border, can change colour if you want: (black) outer - bo, (white) mid - wm, (black) inner - bi`   
    // in-fill is the boolean for whether a pixel is fully inside the box's border
    wire m_bo, m_wm, m_bi, m_fill, m_any;
    layered_box #(
        .TOP_LEFT_X(BOX_X0), .TOP_LEFT_Y(BOX_Y0), .WIDTH(WIDTH0), .HEIGHT(HEIGHT0),
        .OUTER_THICK(3), .MID_THICK(3), .INNER_THICK(3)
    ) menu_box_manual (
        .x(px_src), .y(py_src),
        .in_black_outer(m_bo), .in_white_mid(m_wm), .in_black_inner(m_bi),
        .in_fill(m_fill), .in_any_border(m_any)
    );

    wire a_bo, a_wm, a_bi, a_fill, a_any;
    layered_box #(
        .TOP_LEFT_X(BOX_X1), .TOP_LEFT_Y(BOX_Y1), .WIDTH(WIDTH1), .HEIGHT(HEIGHT1),
        .OUTER_THICK(3), .MID_THICK(3), .INNER_THICK(3)
    ) menu_box_auto (
        .x(px_src), .y(py_src),
        .in_black_outer(a_bo), .in_white_mid(a_wm), .in_black_inner(a_bi),
        .in_fill(a_fill), .in_any_border(a_any)
    );

 
    // VGA mouse - clamp to screen bounds
    wire [9:0] mouse_x_vga = (mouse_x_sync >= 12'd639) ? 10'd639 : mouse_x_sync[9:0];
    wire [8:0] mouse_y_vga = (mouse_y_sync >= 12'd479) ? 9'd479 : mouse_y_sync[8:0];
    // VGA-space 3x3 cursor for VGA-based UIs (e.g., settings overlays) to avoid source-grid offset
    wire [9:0] vga_dx = (frame_x > mouse_x_vga) ? (frame_x - mouse_x_vga) : (mouse_x_vga - frame_x);
    wire [8:0] vga_dy = (frame_y > mouse_y_vga) ? (frame_y - mouse_y_vga) : (mouse_y_vga - frame_y);
    wire       within_cursor_vga_3x3 = (vga_dx <= 10'd1) && (vga_dy <= 9'd1);

    // ------------- CV Settings: Drag & Drop for Preprocessing/Morphology --------------
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
    wire [7:0]  morph_order_vector;
    wire [3:0]  pre_order_vector;
    wire [5:0]  box_hover;
    wire [2:0]  front_idx;
    wire [2:0]  morph_count;
    wire [1:0]  morph_order0, morph_order1, morph_order2, morph_order3;
    wire [1:0]  pre_count;
    wire [1:0]  pre_order0, pre_order1;

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
        .boxes_x(boxes_x_vector), .boxes_y(boxes_y_vector),
        .hover(box_hover),
        .morph_count(morph_count),
        .morph_order0(morph_order0), .morph_order1(morph_order1), .morph_order2(morph_order2), .morph_order3(morph_order3),
        .pre_count(pre_count), .pre_order0(pre_order0), .pre_order1(pre_order1),
        .morph_order_vector(morph_order_vector), .pre_order_vector(pre_order_vector),
        .front_idx(front_idx),
        .dragging_o(led[2]),
        .drop_reason(led[4:3])
    );

    // Overlay pixel from settings UI (drag/drop) in VGA coordinates
    wire cv_sett_overlay_en;
    wire [11:0] cv_sett_overlay;
    // Click pulses from CV settings overlay selection boxes
    wire cam_box_clicked;
    wire bitmap_box_clicked;
    wire ufds_box_clicked;
    cv_settings_overlay settings_cv_overlay (
        .settings_active(cv_settings_mode),
        .px(frame_x), .py(frame_y),
        .mouse_x(mouse_x_vga), .mouse_y(mouse_y_vga), .left_edge(left_click_edge),
        .boxes_x(boxes_x_vector), .boxes_y(boxes_y_vector),
        .front_idx(front_idx),
        .overlay_en(cv_sett_overlay_en), .overlay_rgb(cv_sett_overlay),
        .cam_box_click(cam_box_clicked), .bitmap_box_click(bitmap_box_clicked), .ufds_box_click(ufds_box_clicked),
        .pre_x_o(PRE_X_VGA), .pre_y_o(PRE_Y_VGA), .pre_w_o(PRE_W_VGA), .pre_h_o(PRE_H_VGA),
        .morph_x_o(MORPH_X_VGA), .morph_y_o(MORPH_Y_VGA), .morph_w_o(MORPH_W_VGA), .morph_h_o(MORPH_H_VGA)
    );


    // Display Settings UI instance
    wire        user_overlay_en;
    wire [11:0] user_overlay_rgb;
    wire [7:0]  user_mouse_sens;
    wire [2:0]  user_crosshair_sel;
    user_settings_ui user_ui (
        .clk(clk25), .reset(vga_reset), .active(user_settings_mode),
        .px(frame_x), .py(frame_y),
        .mouse_x(mouse_x_vga), .mouse_y(mouse_y_vga),
        .left(left_click_deb), .left_edge(left_click_edge),
        .overlay_en(user_overlay_en), .overlay_rgb(user_overlay_rgb),
        .mouse_sensitivity(user_mouse_sens), .crosshair_color_sel(user_crosshair_sel)
    );

    // Crosshair color mapping from selection
    wire [11:0] crosshair_rgb =
        (user_crosshair_sel == 3'd0) ? WHITE   :
        (user_crosshair_sel == 3'd1) ? RED     :
        (user_crosshair_sel == 3'd2) ? GREEN   :
        (user_crosshair_sel == 3'd3) ? BLUE    :
        (user_crosshair_sel == 3'd4) ? YELLOW  :
        (user_crosshair_sel == 3'd5) ? CYAN    :
                                       MAGENTA ;


    // Cursor over boxes (click detection uses mouse_x/y in source grid)
    wire cursor_on_manual_box = (mouse_x_px >= BOX_X0 && mouse_x_px < BOX_X0 + WIDTH0 && mouse_y_px >= BOX_Y0 && mouse_y_px < BOX_Y0 + HEIGHT0);
    wire cursor_on_auto_box   = (mouse_x_px >= BOX_X1 && mouse_x_px < BOX_X1 + WIDTH1 && mouse_y_px >= BOX_Y1 && mouse_y_px < BOX_Y1 + HEIGHT1);


    // Overlays pixel with other graphics based on program state (background = bram_pixel_out when sw[15] is off)
    // current flow should be: S_MENU -> S_USER_SETTINGS -> S_MENU -> S_GAME_(MANUAL/AUTO)_MODE
    reg[2:0] state = 0;
    reg[2:0] prev_state = 0; // remember previous state
    localparam S_MENU = 0;
    localparam S_CV_SETTINGS = 1; // CV settings (right-click toggle)
    localparam S_USER_SETTINGS = 2; // Display settings (btnC toggle)
    localparam S_GAME_MANUAL_MODE = 3;
    localparam S_GAME_AUTO_MODE = 4;

    wire cv_settings_mode = (state == S_CV_SETTINGS);
    wire user_settings_mode = (state == S_USER_SETTINGS);

    // address debouncing for state change settings 
    reg [23:0] state_change_cooldown = 0;
    localparam STATE_COOLDOWN = 24'd5_000_000;

    // btnC: synchronize then debounce in clk25 domain (same scheme as mouse clicks)
    reg [2:0] btnC_sync = 3'b000;
    always @(posedge clk25) begin
        btnC_sync <= {btnC_sync[1:0], btnC};
    end

    // Debouncer: immediate latch on press, release only after continuous low for RELEASE_TH cycles
    reg [19:0] c_rel_cnt = 19'd0;
    reg        btnC_deb  = 1'b0; // debounced level
    always @(posedge clk25) begin
        if (vga_reset) begin
            btnC_deb  <= 1'b0;
            c_rel_cnt <= 19'd0;
        end else begin
            if (btnC_sync[1]) begin
                // immediate latch on press
                btnC_deb  <= 1'b1;
                c_rel_cnt <= 19'd0;
            end else if (btnC_deb) begin
                // count continuous lows before releasing
                if (c_rel_cnt >= RELEASE_R) begin
                    btnC_deb  <= 1'b0;
                    c_rel_cnt <= 19'd0;
                end else begin
                    c_rel_cnt <= c_rel_cnt + 1'b1;
                end
            end else begin
                c_rel_cnt <= 19'd0;
            end
        end
    end
    reg btnC_deb_q = 1'b0;
    always @(posedge clk25) begin
        if (vga_reset) btnC_deb_q <= 1'b0; else btnC_deb_q <= btnC_deb;
    end
    wire btnC_edge = btnC_deb & ~btnC_deb_q; // 1-cycle pulse on debounced rising edge
    wire btnC_debounced = btnC_deb;          // stable debounced level if needed elsewhere

    always @(posedge clk25) begin
        if (vga_reset) begin
            state <= S_MENU;
            prev_state <= S_MENU;
        end else if (sw[15]) begin
            // Output random canvas of colours by separate FPGA using sw[15]
            frame_pixel <= canvas_pixel;
        end else begin 
            // debouncing for right click / btnC
            if (state_change_cooldown > 0) begin
                state_change_cooldown <= state_change_cooldown - 1;
            end
            else if (right_click_edge) begin
                prev_state <= state;
                state <= S_CV_SETTINGS;
                state_change_cooldown <= STATE_COOLDOWN;
            end else if (btnC_edge) begin
                prev_state <= state;
                state <= S_USER_SETTINGS;
                state_change_cooldown <= STATE_COOLDOWN;
            end

            // every pixel that is not overwritten should be the camera's output
            frame_pixel <= bram_pixel_out;
            
            // if (right_click) begin
            //     prev_state <= state;
            //     state <= S_USER_SETTINGS;
            // end
            // TODO: have a small corner that perm displays "right-click to enter settings"

            // State machine for different overlays
            case (state)
                S_MENU: begin
                    if (left_click_edge && cursor_on_manual_box) begin
                        state <= S_GAME_MANUAL_MODE;
                    end else if (left_click_edge && cursor_on_auto_box) begin
                        state <= S_GAME_AUTO_MODE;
                    end 
                    
                    if (within_cursor_3x3) begin
                        frame_pixel <= cursor_colour;
                    end else begin
                        // TODO: Display title and authors (our names)
                        // TODO: 1/2 liner welcome sentences

                        // Display box for start game manual
                        if (m_fill) begin
                            frame_pixel <= GREEN; // green fill
                        end else if (m_bi) begin
                            frame_pixel <= BLACK; // black inner border
                        end else if (m_wm) begin
                            frame_pixel <= WHITE; // white mid border
                        end else if (m_bo) begin
                            frame_pixel <= BLACK; // black outer border
                        end

                        // TODO: Display box for start game auto
                        if (a_fill) begin
                            frame_pixel <= RED; // red fill
                        end else if (a_bi) begin
                            frame_pixel <= BLACK; // black inner border
                        end else if (a_wm) begin
                            frame_pixel <= WHITE; // white mid border
                        end else if (a_bo) begin
                            frame_pixel <= BLACK; // black outer border
                        end
                    end
                end
                
                S_CV_SETTINGS: begin
                    // right-click again to return to prev_state
                    if (right_click_edge) begin
                        state <= prev_state;
                    end

                    // Dim camera feed under the settings region (rows >= 324), keep normal feed above
                    if (frame_y >= 9'd324) begin
                        // Per-channel dimming (RGB444 -> halve brightness)
                        frame_pixel <= { (bram_pixel_out[11:8] >> 1), (bram_pixel_out[7:4] >> 1), (bram_pixel_out[3:0] >> 1) };
                    end else begin
                        frame_pixel <= bram_pixel_out;
                    end

                    // draw CV settings overlay, then draw cursor on top
                    if (cv_sett_overlay_en) frame_pixel <= cv_sett_overlay;
                    // Use VGA-space cursor here (overlay also uses VGA coords)
                    if (within_cursor_vga_3x3) frame_pixel <= 12'hFFF;
                end

                S_USER_SETTINGS: begin
                    // btnC again to return
                    if (btnC_edge) begin
                        state <= prev_state;
                    end
                    // draw user settings overlay, then draw cursor on top
                    if (user_overlay_en) frame_pixel <= user_overlay_rgb;
                    // Use VGA-space cursor here as well (UI drawn in VGA coords)
                    if (within_cursor_vga_3x3) frame_pixel <= 12'hFFF;
                end

                S_GAME_MANUAL_MODE: begin
                    if (frame_addr == 74399) begin
                        // snapshot UFDS results once per VGA frame
                        left0_l <= left0; right0_l <= right0; cx0_l <= cx0; top0_l <= top0; bottom0_l <= bottom0; cy0_l <= cy0;
                        left1_l <= left1; right1_l <= right1; cx1_l <= cx1; top1_l <= top1; bottom1_l <= bottom1; cy1_l <= cy1;
                        left2_l <= left2; right2_l <= right2; cx2_l <= cx2; top2_l <= top2; bottom2_l <= bottom2; cy2_l <= cy2;
                        left3_l <= left3; right3_l <= right3; cx3_l <= cx3; top3_l <= top3; bottom3_l <= bottom3; cy3_l <= cy3;
                    end else begin
                        // --- Crosshair drawing with user-selected color ---
                        // === Bottom vertical arm ===
                        if (frame_x[9:1]-10 == 155 &&
                            frame_y[9:1] >= 120+2 && frame_y[9:1] <= 120+11) begin

                            // Green portion rises upward from bottom
                            // if (frame_y[9:1] >= green_top_y)
                                frame_pixel <= crosshair_rgb;
                            // else
                            //     frame_pixel <= RED;
                        end

                        // === Top vertical arm ===
            else if (frame_x[9:1]-10 == 155 &&
                                frame_y[9:1] >= 120-11 && frame_y[9:1] <= 120-2) begin

                            // Mirror the same cooldown progress upward
                            // if (frame_y[9:1] <= (120 - CROSSHAIR_HEIGHT + fill_height))
                                frame_pixel <= crosshair_rgb;
                            // else
                            //     frame_pixel <= RED;
                        end

                        // === Left horizontal arm ===
            else if (frame_y[9:1] == 120 &&
                frame_x[9:1]-10 >= 155-11 && frame_x[9:1]-10 <= 155-2) begin

                            // Turn green once cooldown crosses midpoint
                            // if (fill_height >= CROSSHAIR_HEIGHT / 2)
                                frame_pixel <= crosshair_rgb;
                            // else
                            //     frame_pixel <= RED;
                        end

                        // === Right horizontal arm ===
            else if (frame_y[9:1] == 120 &&
                frame_x[9:1]-10 >= 155+2 && frame_x[9:1]-10 <= 155+11) begin

                            // if (fill_height >= CROSSHAIR_HEIGHT / 2)
                                frame_pixel <= crosshair_rgb;
                            // else
                            //     frame_pixel <= RED;
                        end
                        else if (in_roi && (
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
                            frame_pixel <= 12'h00F;
                        end
                    end
                end

                S_GAME_AUTO_MODE: begin
                    // TODO: Algo for auto-mode
                end

                default: begin
                    state <= state;
                end
            endcase
            
        end
    end

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