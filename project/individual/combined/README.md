# Combined task

Combining all 4 tasks into single bitstream

This is the naive implementation i.e. take whole module and multiplex at Jx output. Results in duplicated modules but will keep each individual tasks most untouched.

Can consider doing single OLED module, then modifying each task module to use the OLED output signals as input for a less wasteful implementation.

## Status

(Oct 4)
- Seven Seg module done, input clk, 4 hex digits (as 16-bit vector) and whether to show decimal point (4-bit vector), output [7:0]seg and [3:0]an.
- Added task R in, but had to modify it by required to add a reset input signal to propagate to the OLED screen + the timing logic