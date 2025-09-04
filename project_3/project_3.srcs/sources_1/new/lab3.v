`timescale 1ns / 1ps

//number: A0309057A
//1st rightmost value: 7
//2rd rightmost value: 5
//5 rightmost values: 0, 5, 7, 9


module Clock_Enable(    //use enable pulse instead of clock divider for synthesisability
    input clk,
    input [2:0] sw,   //sw[0]: 1Hz, sw[1]: 10Hz, sw[2]: 100Hz
    output reg enable
    );

    reg [31:0] threshold_1hz = 50000000;    //2hz since 0.5s ON, 0.5s OFF
    reg [31:0] threshold_10hz = 5000000;
    reg [31:0] threshold_100hz = 500000;

    reg [31:0] counter;
    
    initial begin
        counter <= 0;
        enable <= 0;
    end

    always @(posedge clk) begin
        if (sw[2] == 1'b1) begin
            counter = (counter >= threshold_100hz ? 0: counter + 1);
        end
        else if (sw[1] == 1'b1) begin
            counter = (counter >= threshold_10hz ? 0: counter + 1);
        end
        else begin  //default 1hz pulse rate, can ignore in main module
            counter = (counter >= threshold_1hz ? 0: counter + 1);
        end;

        enable <= (counter == 0) ? 1'b1 : 1'b0;
    end
endmodule

module lab3(
    input clk,
    input btnU, btnL, btnR,
    input [15:0] sw,
    output reg [15:0] led,
    output reg [7:0] seg,
    output reg [3:0] an
    );

    wire enable;
    reg led_enable;
    reg [31:0] startup_counter;
    reg [2:0] display_state;
    reg unlocked;
    reg [1:0] unlocked_step_counter;
    reg [31:0] ld15_counter;

    initial begin
        led <= 16'b0000000000000000;    //shut all LED off
        seg <= 8'b11111111; //0
        an <= 4'b1111; // shut all display off

        led_enable <= 1'b0;
        startup_counter <= 32'b0;
        display_state <= 3'b0;
        unlocked <= 1'b0;
        unlocked_step_counter <= 2'b0;
        ld15_counter <= 32'b0;
    end

    Clock_Enable CE(clk, sw[2:0], enable);

    always @(posedge clk) begin //flipping value for led blinking
        if (enable) begin
            led_enable <= ~led_enable;
        end
    end

    always @(posedge clk) begin
        if (startup_counter < 32'd100000000) begin  //wait for TIME_COUNT before turning on
            startup_counter <= startup_counter + 1;
        end
        else begin
            //led and switches tasks
            led[14:3] <= 12'b000000011111;  //don't change LD15
            if (sw[2] == 1'b1) begin
                led[2:0] <= {led_enable, 2'b11};
            end
            else if (sw[1] == 1'b1) begin
                led[2:0] <= {1'b1, led_enable, 1'b1};
            end
            else if (sw[0] == 1'b1) begin
                led[2:0] <= {2'b11, led_enable};
            end
            else begin
                led[2:0] <= 3'b111;
            end

            //display and pushbutton tasks
            //piggyback off same code for cycling by button and by clocks
            case (display_state)
                3'd0: begin
                    seg <= 8'b10101111; //display 'r'
                    an <= 4'b1110;
                    display_state <= unlocked ? ((enable && |sw[2:0]==1'b1) ? display_state + 1 : display_state) :
                                    btnR ? display_state + 1 : display_state;
                end
                3'd1: begin
                    seg <= 8'b11100011; //display 'u'
                    an <= 4'b1101;
                    display_state <= unlocked ? ((enable && |sw[2:0]==1'b1) ? display_state + 1 : display_state) :
                                    btnU ? display_state + 1 : display_state;
                end
                3'd2: begin
                    seg <= 8'b11001111; //display 'l'
                    an <= 4'b1011;
                    display_state <= unlocked ? ((enable && |sw[2:0]==1'b1) ? 3'b0 : display_state) :   //loop back to step 1 in unlocked mode
                                    btnL ? display_state + 1 : display_state;
                end
                3'd3: begin
                    seg <= 8'b11100011; //display 'u'
                    an <= 4'b0111;
                    display_state <= btnU ? display_state + 1 : display_state;
                end
                3'd4: begin   //newly entered unlocked mode
                    unlocked <= 1'b1;
                    led[15] <= 1'b1;
                    display_state <= 3'b0;
                end
            endcase

            //subtask D
            //non-blocking assignments used throughout so these values will overwrite everything before in this always block
            if (sw[15]) begin
                if (ld15_counter == 32'd300000000) begin
                    seg <= 8'b10001000;
                    an <= 4'b0000;
                    led <= 16'b00000001010100001;   //LD 0,5,7,9
                end
                else begin
                    ld15_counter <= ld15_counter + 1;
                end
            end
            else begin
                ld15_counter <= 0;  //reset counter
                led[15] <= unlocked ? 1'b1 : 1'b0;
            end
        end
    end

endmodule
