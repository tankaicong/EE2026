`timescale 1ns / 1ps
// Single-word per-cycle line delay using block RAM (true dual-port)
// - On each enabled cycle, writes din to address wptr and reads dout from address rptr
// - Depth should equal IMAGE_WIDTH for a 1-line delay
// - Synchronous read (1-cycle latency)
// - Reset clears pointers; memory contents are not cleared (not required)

module LineDelayBRAM #(
    parameter DATA_W = 8,
    parameter DEPTH  = 640,
    parameter ADDR_W = $clog2(DEPTH)
) (
    input  wire                 clk,
    input  wire                 reset,
    input  wire                 en,      // advance pointers, perform read+write
    input  wire [DATA_W-1:0]    din,
    output reg  [DATA_W-1:0]    dout
);
    // True dual-port block RAM inference
    (* ram_style = "block" *) reg [DATA_W-1:0] mem [0:DEPTH-1];

    reg [ADDR_W-1:0] wptr;
    reg [ADDR_W-1:0] rptr;

    // Port A: write
    always @(posedge clk) begin
        if (en) begin
            mem[wptr] <= din;
        end
    end

    // Port B: read (synchronous) with reset
    always @(posedge clk) begin
        if (reset) begin
            dout <= {DATA_W{1'b0}};
        end else if (en) begin
            dout <= mem[rptr];
        end
    end

    // Pointers
    always @(posedge clk) begin
        if (reset) begin
            wptr <= {ADDR_W{1'b0}};
            rptr <= {ADDR_W{1'b0}};
        end else if (en) begin
            // increment pointers modulo DEPTH
            wptr <= (wptr == DEPTH-1) ? {ADDR_W{1'b0}} : (wptr + 1'b1);
            rptr <= (rptr == DEPTH-1) ? {ADDR_W{1'b0}} : (rptr + 1'b1);
        end
    end

endmodule
