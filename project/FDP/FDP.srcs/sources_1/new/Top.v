`timescale 1ns / 1ps

module Top(
    input clk, btnU,

    output ov7670_pwdn, ov7670_reset, ov7670_xclk,
    input ov7670_href, ov7670_pclk_raw, ov7670_vsync,
    inout ov7670_siod,
    output ov7670_sioc,
    input [7:0] ov7670_d,
    output [15:0] led,
    input sw0,

    output vga_Hsync,
    output vga_Vsync,
    output [11:0] vga_RGB    //4-bit red, 4-bit green, 4-bit blue
    );

    // Generate 25MHz clock for VGA from 100MHz system clock
    // reg clk_div = 0;
    // reg clk25 = 0;
    // always @(posedge clk) begin
    //     clk_div <= clk_div + 1;
    //     if (clk_div == 1'b1) begin
    //         clk25 <= ~clk25;  // Toggle every 2 cycles = 25MHz
    //     end
    // end

    wire clk_status;
    display_clocks disp_clocks(
        .clk_in1(clk),
        .clk_out1(clk25),
        .reset(btnU),
        .locked(clk_status)
    );

    // Wire for BRAM address from VGA controller
    wire [17:0] frame_addr;
    wire [15:0] frame_pixel_raw; // 16-bit RGB565 from BRAM
    wire [11:0] frame_pixel;     // Down-converted RGB444 to VGA
    wire active_area;
    
    //global clock buffer for camera pixel clock
    wire ov7670_pclk;
    BUFG pclk_bufg (
        .I(ov7670_pclk_raw),
        .O(ov7670_pclk)
    );

    VGA_Controller vga(
        .clk25(clk25),
        .vga_red(vga_RGB[11:8]),
        .vga_green(vga_RGB[7:4]), 
        .vga_blue(vga_RGB[3:0]),
        .vga_hsync(vga_Hsync),
        .vga_vsync(vga_Vsync),
        .frame_addr(frame_addr),
        .frame_pixel(frame_pixel),
        .active_area(active_area)
    );
    OV7670_Controller ov7670(
        .clk(clk25),
        .resend(btnU),
        .config_finished(led[0]),
        .sioc(ov7670_sioc),
        .siod(ov7670_siod),
        .reset(ov7670_reset),
        .pwdn(ov7670_pwdn),
        .xclk(ov7670_xclk)
    );

    wire we;
    wire [17:0] addr;
    wire [15:0] dout; // RGB565 from capture

    // Debounce / synchronize btnU to camera pixel clock domain for capture reset
    reg [2:0] reset_sync = 3'b111;
    always @(posedge ov7670_pclk) begin
        reset_sync <= {reset_sync[1:0], btnU};
    end
    wire cap_reset = reset_sync[2];

    // First frame skip after reset to avoid color misalignment artefacts
    reg skip_frame = 1'b0;
    reg saw_vsync_low = 1'b0;
    always @(posedge ov7670_pclk) begin
        if (cap_reset) begin
            skip_frame <= 1'b1;
            saw_vsync_low <= 1'b0;
        end else begin
            if (!ov7670_vsync) saw_vsync_low <= 1'b1; // detect low period
            // When vsync rises after having been low, clear skip
            if (ov7670_vsync && saw_vsync_low) skip_frame <= 1'b0;
        end
    end
    
    OV7670_Capture ov7670_capture(
        .pclk(ov7670_pclk),
        .vsync(ov7670_vsync),
        .href(ov7670_href),
        .ext_reset(cap_reset),
        .avg_enable(sw0),
        .d(ov7670_d),
        .addr(addr),
        .dout(dout),
        .we(we_internal)
    );

    // Gate write enable during skip_frame to discard first (possibly misaligned) frame
    wire we_internal;
    wire we = we_internal & ~skip_frame;
    
    image_mem frame_buffer(
        .clka(ov7670_pclk),
        .wea(we),
        .addra(addr),
        .dina(dout),          // write RGB565
        .clkb(clk25),
        .addrb(frame_addr),
        .doutb(frame_pixel_raw) // read RGB565
    );

    // RGB565 -> RGB444 with simple LSB rounding (improves brightness balance)
    wire [4:0] r5 = frame_pixel_raw[15:11];
    wire [5:0] g6 = frame_pixel_raw[10:5];
    wire [4:0] b5 = frame_pixel_raw[4:0];

    wire [3:0] r4 = (r5[4:1] == 4'hF) ? 4'hF : (r5[4:1] + r5[0]);
    wire [3:0] g4 = (g6[5:2] == 4'hF) ? 4'hF : (g6[5:2] + g6[1]);
    wire [3:0] b4 = (b5[4:1] == 4'hF) ? 4'hF : (b5[4:1] + b5[0]);
    assign frame_pixel = { r4, g4, b4 };

    // VGA controller now handles display directly from BRAM
    // No manual RGB assignment needed - VGA controller outputs directly

endmodule
