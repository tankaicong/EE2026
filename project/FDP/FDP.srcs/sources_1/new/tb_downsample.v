`timescale 1ns/1ps
// Simple testbench to sanity-check OV7670_Capture addressing logic.
// Synth-style behavioral stimulus: we model href producing 640 pixels per line
// and vsync between frames. We feed an incrementing pattern so orientation
// issues can be caught by offline waveform inspection.

module tb_downsample;
    reg pclk = 0;
    always #5 pclk = ~pclk; // 100 MHz / 10 = 100 MHz? Actually 100MHz period=10ns -> this is 100MHz

    reg vsync = 0;
    reg href = 0;
    reg [7:0] d = 0;

    wire [17:0] addr;
    wire [15:0] dout;
    wire we;
    reg avg_enable = 1'b1;

    OV7670_Capture dut(
        .pclk(pclk),
        .vsync(vsync),
        .href(href),
        .avg_enable(avg_enable),
        .d(d),
        .addr(addr),
        .dout(dout),
        .we(we)
    );

    integer writes = 0;
    always @(posedge we) begin
        writes = writes + 1;
    end

    integer x,y;
    initial begin
        // produce one frame 640x480
        vsync = 1; repeat(4) @(negedge pclk); vsync = 0; // reset pulse
        for (y=0; y<480; y=y+1) begin
            href = 1;
            for (x=0; x<640; x=x+1) begin
                // two bytes per pixel; generate pseudo color
                // Lower byte then upper byte (RGB565-like ordering)
                d = x[7:0]; @(negedge pclk);
                d = y[7:0]; @(negedge pclk);
            end
            href = 0; @(negedge pclk); // porch
        end
        // end of frame
        vsync = 1; repeat(4) @(negedge pclk); vsync = 0;
        #1000;
        $display("Total writes (should be 76800) = %0d", writes);
        $finish;
    end
endmodule
