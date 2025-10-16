`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.10.2025 10:50:09
// Design Name: 
// Module Name: mouse_movement
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// `define SIMULATION

module mouse_movement(
    input clk,
    input btnU, // reset
    inout Mouse_Clk,  //PS2 mouse clock
    inout Mouse_Data,  //PS2 data packets
`ifdef SIMULATION
    input left_sim, // simulation-only input to simulate left clicks
`endif
    output reg [15:0] led,  //Bullet counts
    output reg [11:0] vga_RGB
    );
    
    wire [11:0] xpos;
    wire [11:0] ypos;
    wire [3:0] zpos;

// for simulation purposes
`ifdef SIMULATION
    wire left = left_sim;
    wire right = 1'b0;
    wire middle = 1'b0;
    wire new_event = 1'b0;
`else
    wire left, right, middle, new_event;
    
    MouseCtl mouse_instance (
        .clk(clk),
        .rst(btnU),
        .ps2_clk(Mouse_Clk),
        .ps2_data(Mouse_Data),
        .xpos(xpos),
        .ypos(ypos),
        .zpos(zpos),
        .left(left),
        .middle(middle),
        .right(right),
        .new_event(new_event),
        .setx(1'b0),
        .sety(1'b0),
        .setmax_x(10'd640),
        .setmax_y(9'd480),
        .value(12'd1024)
    );
`endif
    
   
    // Screen parameters
    localparam WIDTH  = 640;
    localparam HEIGHT = 480;
    localparam CENTER_X = WIDTH / 2;  // 320
    localparam CENTER_Y = HEIGHT / 2;  // 240
    
    // Crosshair parameters
    localparam CH_HEIGHT = 20;
    localparam CH_WIDTH  = 20;
    localparam CH_THICKNESS = 3;
    localparam CH_CENTER_DOT_THICKNESS = 4;
   
    localparam GAP_FROM_CENTER_DOT = 5;
    
    // COLOR OUTPUT
    localparam GREEN = 12'h070;
    localparam RED   = 12'hF00;
    
    // Pixel coordinates for VGA output
    wire [9:0] x_coord;
    wire [8:0] y_coord;

    
    // Add 2 seconds cooldown on each shot
    reg [27:0] cooldown_timer = 0;
    reg shot_enabled = 1;
    reg [4:0] bullet_count = 5'd16;

`ifdef SIMULATION
    localparam COOLDOWN = 10; // very short cooldown for simulation
`else
    localparam COOLDOWN = 100_000_000; // 1s
`endif


    always @(posedge clk) begin
        // Reset game 
        if (btnU) begin
            cooldown_timer <= 0;
            shot_enabled <= 1;
            bullet_count <= 16;
            led <= 16'hFFFF;
        end
        else begin
            // Decrement cooldown timer if not zero
            if (cooldown_timer > 0)
                cooldown_timer <= cooldown_timer - 1;

            if (cooldown_timer == 0)
                shot_enabled <= 1;

            // Fire if left is held, bullets remain, and cooldown expired
            if (left && bullet_count > 0 && shot_enabled) begin
                cooldown_timer <= COOLDOWN;   // reset cooldown
                bullet_count <= bullet_count - 1;
                led <= led >> 1; // shift LED to the right to indicate ONE bullet used
                shot_enabled <= 0; // disable shooting until cooldown expires
            end            
        end
    end
   
   wire crosshair_pixel;
   // Crosshair horizontal and vertical arms centered on screen
   assign crosshair_pixel = (
       // left horizontal crosshair
       (y_coord >= CENTER_Y - CH_THICKNESS/2 && y_coord <= CENTER_Y + CH_THICKNESS/2 &&
        x_coord >= CENTER_X - GAP_FROM_CENTER_DOT - CH_WIDTH && x_coord <= CENTER_X - GAP_FROM_CENTER_DOT) ||
         
       // right horizontal crosshair
        (y_coord >= CENTER_Y - CH_THICKNESS/2 && y_coord <= CENTER_Y + CH_THICKNESS/2 &&
         x_coord >= CENTER_X + GAP_FROM_CENTER_DOT && x_coord <= CENTER_X + GAP_FROM_CENTER_DOT + CH_WIDTH) ||
   
       // top vertical crosshair
       (x_coord >= CENTER_X - CH_THICKNESS/2 && x_coord <= CENTER_X + CH_THICKNESS/2 &&
        y_coord >= CENTER_Y - GAP_FROM_CENTER_DOT - CH_HEIGHT && y_coord <= CENTER_Y - GAP_FROM_CENTER_DOT) ||
         
       // bottom vertical crosshair
        (x_coord >= CENTER_X - CH_THICKNESS/2 && x_coord <= CENTER_X + CH_THICKNESS/2 &&
         y_coord >= CENTER_Y + GAP_FROM_CENTER_DOT && y_coord <= CENTER_Y + GAP_FROM_CENTER_DOT + CH_HEIGHT) ||
   
       // Center dot
       (x_coord >= CENTER_X - CH_CENTER_DOT_THICKNESS/2 && x_coord <= CENTER_X + CH_CENTER_DOT_THICKNESS/2 &&
        y_coord >= CENTER_Y - CH_CENTER_DOT_THICKNESS/2 && y_coord <= CENTER_Y + CH_CENTER_DOT_THICKNESS/2)
   );
   
   
   always @(*) begin
    if (shot_enabled)
       vga_RGB = GREEN;
    else
       vga_RGB = RED; // or BLACK if you want no color when shot disabled
    end



endmodule






//     // click latch logic
//   reg [25:0] timer_left   = 0;
//   reg [25:0] timer_middle = 0;
//   reg [25:0] timer_right  = 0;
//   reg led_left   = 0;
//   reg led_middle = 0;
//   reg led_right  = 0;

//   always @(posedge clk) begin
//       if (btnU) begin
//           // reset all LEDs and timers
//           led_left   <= 0;
//           led_middle <= 0;
//           led_right  <= 0;
//           timer_left <= 0;
//           timer_middle <= 0;
//           timer_right <= 0;
//       end else begin
//           // LEFT click logic
//           if (left) begin
//               led_left <= 1;
//               timer_left <= 50_000_000 / 2;  // 0.5 second
//           end else if (timer_left > 0) begin
//               timer_left <= timer_left - 1;
//               if (timer_left == 1)
//                   led_left <= 0;
//           end

//           // MIDDLE click logic
//           if (middle) begin
//               led_middle <= 1;
//               timer_middle <= 50_000_000 / 2;
//           end else if (timer_middle > 0) begin
//               timer_middle <= timer_middle - 1;
//               if (timer_middle == 1)
//                   led_middle <= 0;
//           end

//           // RIGHT click logic
//           if (right) begin
//               led_right <= 1;
//               timer_right <= 50_000_000 / 2;
//           end else if (timer_right > 0) begin
//               timer_right <= timer_right - 1;
//               if (timer_right == 1)
//                   led_right <= 0;
//           end
//       end
//   end
   
   
//      // assign LEDs
//   assign led[15] = led_left;
//   assign led[14] = led_middle;
//   assign led[13] = led_right;
   