`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Combined UART transmitter and receiver module with simple 10-byte FIFOs
// - TX: Latch 10 bytes on tx_fifo_wr_en and send sequentially via UART_Transmitter
// - RX: Accumulate 10 bytes from UART_Receiver, then raise rx_fifo_rd_en for 1 clk
// TX and RX operate fully in parallel
//////////////////////////////////////////////////////////////////////////////////

module UART_Controller 
#(
    parameter UART_CLKS_PER_BIT = 434  // for 50 MHz clock, 115200 baud
)
(
    input clk,
    input rst,

    // Transmit side (host provides 10 bytes packed into tx_fifo and pulses tx_fifo_wr_en)
    input [239:0] tx_fifo,
    input  tx_fifo_wr_en,
    output tx_pin,

    // Receive side (controller outputs 10 bytes and pulses rx_fifo_rd_en)
    output reg [239:0] rx_fifo,
    output reg rx_fifo_rd_en,
    input rx_pin
);

    // ---------------- UART core instances ---------------- //
    // TX core handshake
    reg uart_tx_valid = 1'b0;   // 1-cycle send strobe
    reg [7:0] uart_tx_byte  = 8'h00;  // byte to send
    wire uart_tx_active;         // high while sending a frame
    wire uart_tx_done;           // 1-cycle pulse at end of stop bit

    UART_Transmitter #(.CLKS_PER_BIT(UART_CLKS_PER_BIT)) uart_transmit (
        .i_Clock(clk),
        .i_Tx_DV(uart_tx_valid),    // tx send enable (1-cycle)
        .i_Tx_Byte(uart_tx_byte),   // tx byte data
        .o_Tx_Active(uart_tx_active),
        .o_Tx_Serial(tx_pin),
        .o_Tx_Done(uart_tx_done)
    );

    // RX core handshake
    wire uart_rx_valid;         // 1-cycle when a new byte is ready
    wire [7:0] uart_rx_byte;          // received byte

    UART_Receiver   #(.CLKS_PER_BIT(UART_CLKS_PER_BIT)) uart_receive (
        .i_Clock(clk),
        .i_Rx_Serial(rx_pin),
        .o_Rx_DV(uart_rx_valid),
        .o_Rx_Byte(uart_rx_byte)
    );

    // ---------------- TX FIFO controller (10 bytes) ---------------- //
    reg [239:0] tx_buf;          // latched 10-byte payload
    reg [4:0] tx_idx = 4'd0;   // 0..9 byte index
    reg tx_busy = 1'b0;  // currently processing a 10-byte burst

    localparam TX_IDLE = 1'b0, TX_SEND = 1'b1;
    reg tx_state = TX_IDLE;

    always @(posedge clk) begin
        if (rst) begin
            tx_state <= TX_IDLE;
            tx_busy <= 1'b0;
            tx_idx <= 5'd0;
            uart_tx_valid <= 1'b0;
            uart_tx_byte <= 8'h00;
        end else begin
            // default: strobe low unless we kick a new byte this cycle
            uart_tx_valid <= 1'b0;

            case (tx_state)
                TX_IDLE: begin
                    tx_busy <= 1'b0;
                    tx_idx <= 4'd0;
                    if (tx_fifo_wr_en) begin
                        // Latch all 10 bytes and start sending
                        tx_buf <= tx_fifo;
                        tx_busy <= 1'b1;
                        tx_state <= TX_SEND;
                    end
                end

                TX_SEND: begin
                    // Advance to next byte on done
                    if (uart_tx_done) begin
                        if (tx_idx == 4'd9) begin
                            tx_state = TX_IDLE;
                        end
                        tx_idx = tx_idx + 1'b1;
                    end

                    // When UART is idle, kick the next byte (single-cycle DV)
                    if (!uart_tx_active && (tx_idx < 4'd10)) begin
                        uart_tx_byte <= tx_buf[8*tx_idx +: 8];
                        uart_tx_valid <= 1'b1;
                    end
                    
                end
            endcase
        end
    end

    // ---------------- RX FIFO controller (10 bytes) ---------------- //
    reg [239:0] rx_buf;          // accumulating 10 bytes
    reg [4:0] rx_idx = 4'd0;   // 0..9 index
    reg rx_done_pend = 1'b0;  // delay flag to assert rd_en one cycle after last byte is written

    always @(posedge clk) begin
        if (rst) begin
            rx_idx <= 5'd0;
            rx_buf <= 240'd0;
            rx_fifo <= 240'd0;
            rx_fifo_rd_en <= 1'b0;
            rx_done_pend <= 1'b0;
        end else begin
            // default: no read enable unless a full burst just completed
            rx_fifo_rd_en <= 1'b0;

            // Capture bytes as they arrive
            if (uart_rx_valid) begin
                rx_buf[8*rx_idx +: 8] <= uart_rx_byte;
                // The UFDS transfers 30 bytes while SETTINGS transfers 5 bytes
                if (rx_idx == 4'd29) begin
                    rx_idx <= 4'd0;
                    rx_done_pend <= 1'b1; // on next cycle, publish rx_fifo and pulse rd_en
                end else begin
                    rx_idx <= rx_idx + 1'b1;
                end
            end

            // Publish full 10-byte packet one cycle after last byte latched,
            // so rx_fifo reflects all 10 bytes including the 10th.
            if (rx_done_pend) begin
                rx_fifo <= rx_buf;
                rx_fifo_rd_en <= 1'b1;  // 1-cycle pulse to indicate "ready to read"
                rx_done_pend  <= 1'b0;
            end
        end
    end

endmodule
