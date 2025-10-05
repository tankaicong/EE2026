# EE2026 Individual Basic Task S

Done by Kenneth Wong Cun Wi

## Task Description

4.S1 (Initial Display):
  - Solid red circle (RGB565 F800) near screen center, radius between 9–15 px.
  - Hollow white square (FFFF) near bottom-left, side 20–28 px, border thickness exactly 3 px.
  - The 2nd rightmost digit of student number appears inside the square in bright green (07E0), height 12–16 px, width 6–9 px, stroke 3 px.

4.S2 (Movement):
  - One-tap pushbuttons start continuous movement in Up/Down/Left/Right.
  - Speed ≈ 35–55 px/s, smooth single-pixel steps, no diagonal motion.
  - Stops at screen edges and when touching the hollow square (perform collision avoidance).


## Implementation
- Circle: radius `R=12` (customisable), center initialized at (48,32).
- Square: top-left (`X0=4`, `Y0=38`), side `S=25`, thickness `T=3`.
- Digit: “2nd rightmost number” rendered as a rectangular-stroke glyph.
  - For my student number, this is 0, drawn as a ring: height 12, width 8, stroke 3, centered inside the square’s inner area.

> Note: Constants and submodules are fully parameterised for easy customisation. See [Parameters and tuning]

Color priority (front to back): Circle (red) → Digit (green) → Square border (white) → Background (black).

## How pixels are generated
- Handshake from the OLED driver:
  - sample_pixel=1 requests a color for pixel_index ∈ [0..6143].
  - `x = pixel_index % 96`, `y = pixel_index / 96`.
- Primitives:
  - `inside_circle`: (x−cx)^2 + (y−cy)^2 ≤ R^2, to paint a solid red circle.
  - `identify_square_boundary`: union of 4 axis-aligned rectangles (left/right/top/bottom bands) each T=3 pixels thick.
  - `identify_rect_border`: generic rectangular “ring” used to draw the digit’s 3-pixel strokes.
- Compositing:
  - If `inside_circle` → RED
  - else if `inside_digit0` → GREEN
  - else if `inside_square_boundary` → WHITE
  - else BLACK

## Movement and controls (4.S2)
- Input: `btnR/btnL/btnU/btnD` are edge-detected; a single press latches the direction.
- FSM: idle or moving in one of four directions. Direction can change while moving; only one axis at a time.
- Speed: parameterized move rate using a boolean `move_now`.
    `move_now` is set every `MOVE_EVERY_FRAMES` tick of `frame_count`, where the former acts as the clock divider.
- Smoothness: updates the circle center by 1 pixel per `clk` tick; no teleporting/skipping.

## Collision and stopping behavior
- Screen bounds: the circle center is clamped so the disk stays fully on-screen (`R ≤ cx ≤ 95−R`, `R ≤ cy ≤ 63−R`).
- Square collision (“exact touch, no gap”):
  - Model the hollow square border as four rectangles (bands) with thickness 3.
  - Compute distance² from the circle center to each band; compare min distance² to R².
  - First-contact rule: movement is allowed if (next does not hit). This allows exact 1-pixel contact so one red pixel touches, then blocks further penetration.
- This satisfies the “four points” requirement (and is stricter/cleaner with no overlapping into the square), while ensuring no false early stops and no visible gap.

## Parameters and tuning
- Circle radius: `CIRCLE_RADIUS=12` (9-15)
- Square geometry: `SQUARE_TOP_LEFT_X`, `SQUARE_TOP_LEFT_Y`, `SQUARE_SIDE_LENGTH=25`(20-28), `LINE_THICKNESS=3`(only 3).
- Digit geometry: `CHAR_WIDTH = 8` (6–9), `CHAR_HEIGHT=12` (12–16), `LINE_THICKNESS=3`(only 3).
- Speed: `MOVE_EVERY_FRAMES`.
- Colors (RGB565): `RED=F800`, `GREEN=07E0`, `WHITE=FFFF`, `BLACK=0000`.


## Notes
- Debouncing is optional; presses are sampled at ~1 ms and treated as edges.
