`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Converted from VHDL code here: https://lauri.xn--vsandi-pxa.com/hdl/zynq/zybo-ov7670-to-vga.html
// Send commands over SCCB (I2C-like interface)
// For configuring the OV7670 camera module
//////////////////////////////////////////////////////////////////////////////////


module I2C_Controller(
    input clk,
    inout siod,
    output reg sioc,
    output reg taken,
    input send,
    input [7:0] id,
    input [7:0] reg_,
    input [7:0] value
);

    reg [7:0] divider = 8'b00000001;    //gives 254 cycle pause before first frame is sent
    reg [31:0] busy_sr = 32'h00000000;
    reg [31:0] data_sr = 32'hFFFFFFFF;

    // Tri-state driver for SIOD line
    assign siod = ( busy_sr[11:10] == 2'b10 || 
                    busy_sr[20:19] == 2'b10 ||
                    busy_sr[29:28] == 2'b10) ? 1'bz : data_sr[31];

    // Sequential logic
    always @(posedge clk) begin
        taken <= 1'b0; // default

        if (busy_sr[31] == 1'b0) begin
            sioc <= 1'b1;
            if (send == 1'b1) begin
                if (divider == 8'b00000000) begin
                    data_sr <= {3'b100, id, 1'b0, reg_, 1'b0, value, 1'b0, 2'b01};
                    busy_sr <= {3'b111, 9'b111111111, 9'b111111111, 9'b111111111, 2'b11};
                    taken <= 1'b1;
                end else begin
                    divider <= divider + 8'd1; // increment only on power-up
                end
            end
        end else begin
            case ({busy_sr[31:29], busy_sr[2:0]})
                6'b111111: begin // start seq #1
                    case (divider[7:6])
                        2'b00, 2'b01, 2'b10, 2'b11: sioc <= 1'b1;
                    endcase
                end
                6'b111110: begin // start seq #2
                    case (divider[7:6])
                        2'b00, 2'b01, 2'b10, 2'b11: sioc <= 1'b1;
                    endcase
                end
                6'b111100: begin // start seq #3
                    case (divider[7:6])
                        2'b00, 2'b01, 2'b10, 2'b11: sioc <= 1'b0;
                    endcase
                end
                6'b110000: begin // end seq #1
                    case (divider[7:6])
                        2'b00: sioc <= 1'b0;
                        2'b01, 2'b10, 2'b11: sioc <= 1'b1;
                    endcase
                end
                6'b100000: begin // end seq #2
                    case (divider[7:6])
                        2'b00, 2'b01, 2'b10, 2'b11: sioc <= 1'b1;
                    endcase
                end
                6'b000000: begin // Idle
                    case (divider[7:6])
                        2'b00, 2'b01, 2'b10, 2'b11: sioc <= 1'b1;
                    endcase
                end
                default: begin
                    case (divider[7:6])
                        2'b00: sioc <= 1'b0;
                        2'b01, 2'b10: sioc <= 1'b1;
                        default: sioc <= 1'b0;
                    endcase
                end
            endcase

            // shifting and divider increment
            if (divider == 8'hFF) begin
                busy_sr <= {busy_sr[30:0], 1'b0};
                data_sr <= {data_sr[30:0], 1'b1};
                divider <= 8'b0;
            end else begin
                divider <= divider + 8'd1;
            end
        end
    end

endmodule
