`timescale 1ps / 1ps

module lab3_sim(

    );

    reg clk;
    reg btnU, btnL, btnR;
    reg [15:0] sw;
    wire [15:0] led;
    wire [7:0] seg;
    wire [3:0] an;
    lab3 sim(clk, btnU, btnL, btnR, sw, led, seg, an);

    initial begin
        btnU = 0; btnL = 0; btnR = 0;
        sw[15:3] = 13'b0;
        sw[2:0] = 3'b000; #1000000000;
        sw[2:0] = 3'b001; #1000000000;
        sw[2:0] = 3'b010; #1000000000;
        sw[2:0] = 3'b100; #1000000000;
    end

    always #(5) begin
        clk = ~clk;
    end
endmodule
