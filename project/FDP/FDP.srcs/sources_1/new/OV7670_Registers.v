`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Converted from VHDL code here: https://lauri.xn--vsandi-pxa.com/hdl/zynq/zybo-ov7670-to-vga.html
// Registers for OV7670 camera
//////////////////////////////////////////////////////////////////////////////////

module OV7670_Registers(
    input clk,
    input resend,
    input advance,
    output reg [15:0] command,
    output finished
);

    reg [15:0] sreg;
    reg [7:0] address = 8'd0;

    assign finished = (sreg == 16'hFFFF) ? 1'b1 : 1'b0;

    always @(posedge clk) begin
        if (resend) begin
            address <= 8'd0;
        end else if (advance) begin
            address <= address + 8'd1;
        end

        case (address)
            8'h00: sreg <= 16'h1280; // COM7   Reset
            8'h01: sreg <= 16'h1280; // COM7   Reset
            8'h02: sreg <= 16'h1204; // COM7   Size & RGB output
            8'h03: sreg <= 16'h1100; // CLKRC  Prescaler - Fin/(1+1)
            8'h04: sreg <= 16'h0C00; // COM3   Enable scaling
            8'h05: sreg <= 16'h3E00; // COM14  PCLK scaling off
            8'h06: sreg <= 16'h8C00; // RGB444 Set RGB format
            8'h07: sreg <= 16'h0400; // COM1   no CCIR601
            8'h08: sreg <= 16'h40D0; // COM15  Full 0-255 output, RGB 565
            8'h09: sreg <= 16'h3A04; // TSLB   UV ordering
            8'h0A: sreg <= 16'h1438; // COM9   AGC ceiling
            8'h0B: sreg <= 16'h4F40; // MTX1   colour conversion matrix
            8'h0C: sreg <= 16'h5034; // MTX2
            8'h0D: sreg <= 16'h510C; // MTX3
            8'h0E: sreg <= 16'h5217; // MTX4
            8'h0F: sreg <= 16'h5329; // MTX5
            8'h10: sreg <= 16'h5440; // MTX6
            8'h11: sreg <= 16'h581E; // MTXS
            8'h12: sreg <= 16'h3DC0; // COM13  Turn on GAMMA and UV Auto adjust
            8'h13: sreg <= 16'h1100; // CLKRC
            8'h14: sreg <= 16'h1711; // HSTART
            8'h15: sreg <= 16'h1861; // HSTOP
            8'h16: sreg <= 16'h32A4; // HREF
            8'h17: sreg <= 16'h1903; // VSTART
            8'h18: sreg <= 16'h1A7B; // VSTOP
            8'h19: sreg <= 16'h030A; // VREF
            8'h1A: sreg <= 16'h0E61; // COM5
            8'h1B: sreg <= 16'h0F4B; // COM6
            8'h1C: sreg <= 16'h1602;
            8'h1D: sreg <= 16'h1E37; // MVFP  flip and mirror
            8'h1E: sreg <= 16'h2102;
            8'h1F: sreg <= 16'h2291;
            8'h20: sreg <= 16'h2907;
            8'h21: sreg <= 16'h330B;
            8'h22: sreg <= 16'h350B;
            8'h23: sreg <= 16'h371D;
            8'h24: sreg <= 16'h3871;
            8'h25: sreg <= 16'h392A;
            8'h26: sreg <= 16'h3C78; // COM12
            8'h27: sreg <= 16'h4D40;
            8'h28: sreg <= 16'h4E20;
            8'h29: sreg <= 16'h6900; // GFIX
            8'h2A: sreg <= 16'h6B4A;
            8'h2B: sreg <= 16'h7410;
            8'h2C: sreg <= 16'h8D4F;
            8'h2D: sreg <= 16'h8E00;
            8'h2E: sreg <= 16'h8F00;
            8'h2F: sreg <= 16'h9000;
            8'h30: sreg <= 16'h9100;
            8'h31: sreg <= 16'h9600;
            8'h32: sreg <= 16'h9A00;
            8'h33: sreg <= 16'hB084;
            8'h34: sreg <= 16'hB10C;
            8'h35: sreg <= 16'hB20E;
            8'h36: sreg <= 16'hB382;
            8'h37: sreg <= 16'hB80A;
            8'h38: sreg <= 16'h410A;    //auto WB enable and double colour matrix coefficients
            8'h39: sreg <= 16'h3B12;    //default 00, this sets banding filter on, and chooses 60hz banding filter
            8'h3A: sreg <= 16'h13EC;    //default 8F, activates AGC,AWB,AEC, added banding filter and unlimited step size for AEC
            8'h3B: sreg <= 16'h01E0;    //default 80, blue WB gain
            8'h3C: sreg <= 16'h0280;    //default 80, red WB gain
            8'h3D: sreg <= 16'h6A80;    //default 00, green WB gain?
            8'h3E: sreg <= 16'h6900;    //default 00, fix gain control
            8'h3F: sreg <= 16'h10F0;    //default 40, middle 7 bits of AEC
            8'h40: sreg <= 16'h0700;    //default 00, upper 5 bits of AEC
            8'h41: sreg <= 16'h3F00;    //default 00, edge enhancement??

            // Add missing scaling registers for QVGA (320x240) - From datasheet
            // 8'h40: sreg <= 16'h1214; // COM7   Size & RGB output
            // 8'h40: sreg <= 16'h7035; // SCALING_XSC - Horizontal scale factor
            // 8'h41: sreg <= 16'h7135; // SCALING_YSC - Vertical scale factor
            // 8'h42: sreg <= 16'h7211; // SCALING_DCWCTR - Down sample by 2
            // 8'h43: sreg <= 16'h7300; // SCALING_PCLK_DIV - Divide by 2
            // 8'h44: sreg <= 16'hA202; // SCALING_PCLK_DELAY - Scaling delay

            default: sreg <= 16'hFFFF;
        endcase

        command <= sreg;
    end
endmodule