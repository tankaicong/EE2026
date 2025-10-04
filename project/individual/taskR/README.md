# Task R

Done by Kai Cong

## Task Description

Initial:
- Spawn 3rd rightmost digit in orange at the top middle of screen
- Spawn 1st rightmost digit in blue (cyan) at the left middle of screen

During operation:
- If SW1 is ON, blue digit moves from left to right (and back) on the screen in 3s. If SW1 goes to OFF at any moment, blue digit must stop moving and resume moving in its last direction when SW1 goes to ON again.
- Same as above for SW3 with the orange digit, which has to go from top to bottom (and back) in 5s

## Status

(oct 4)
- ACTUALLY DONE DONE!
- 6.25 mhz clock was wrong set at 3.125 instead, fixed
- fixed all the imprecision and screen tearing issues by updating a set of buffer offset values, then only passing the updates on oled_frame_begin signal

(oct 3)
- All done but since update rate is tied to 30 hz frame_begin signal, imprecision from dividing only 30 hz causes the blue digit to travel in 2.7s (still within tolerance but abit sus)
- Can consider doing interpolation of stepping (i.e. step aft 1 cycle, then step aft 2 cycles, then step aft 1 again etc etc)
- Alternatively, modify oled verilog block for higher update rates