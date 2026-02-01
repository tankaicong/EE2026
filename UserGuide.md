# Create Your Own Object Tracker User Guide

An educational object tracking system that allows users to interactively build an image processing pipeline (preprocessing → threshold → morphology) and change views to see the effects, learn about the object detection algorithm and tune its parameters to see the bounding boxes, before running a servo with PD control for autonomous object tracking of objects within user’s desired colour range.

User Interfaces: 
A USB mouse is the primary device to left click or scroll using scroll wheel to switch between and interact with on-screen GUIs (Image Processing Settings and Object Detection Settings). Users can right click to enter full screen mode and right click again to enter the settings they were in previously. Servo PD control coefficients are tuned using FGPA switches (btnL: tune pan Kp & Kd using sw[15:0] ; btnR: tune tilt Kp & Kd using sw[15:0]) and the values are displayed through the 7segment display. Users will visualize live through VGA adaptor to a 640x480px resolution display.

This system integrates the following hardware: 1x Basys3 FPGA, 1x OV7670 Camera, 2x MG90 Servo, 1x USB Mouse and 1x 640x480px VGA display.

## Screens and Modes
- Menu: entry screen with title and prompt to start by inserting a coin or left/right cliking your mouse.
- Image Processing Settings: build your processing pipeline via drag-and-drop blocks, set thresholds, and switch live views.
- Object Detection Settings: explain the UFDS (connected components) algorithm and set detection constraints (min area, number of boxes), and toggle servo-follow.
- Fullscreen Mode: clears settings overlays and adds a crosshair to indicate center of screen.

You’ll switch between the 2 settings page and fullscreen mode via on-screen GUI or mouse inputs, depending on current state:
- If you are under Image Processing Settings, click "UFDS" button to enter Object Detection Settings.
- If you are under Object Detection Settings, click "Post Feed" to enter Image Processing Settings.
- Fullscreen mode can be entered anytime using mouse right click. Return to the settings page you were in previously by right clicking again.

### Image Processing Settings
This GUI is a live hardware configurator for the streaming pipeline:

Camera Capture → (0–2 Preprocessing in chosen order) → RGB Threshold → (0–4 Morphology steps in chosen order/types) → UFDS Detection

Only ordering and presence of optional stages change; pixel rate stays 1 pixel/clock.

#### Visual Overlay & Dimming
Modules `cv_settings_overlay` and `generate_bram_overlay` blend GUI layers after the selected image stage and before VGA timing outputs. They draw:
* Home (selection) bar for six movable blocks at y=352.
* Two drop zones (preprocessing & morphology) with hover outlines.
* Four “eye” view buttons (camera, preprocessing result, bitmap, morphology result).
* Threshold slider bars & eyedropper region.
* UFDS navigation button.

#### Drag & Drop Implementation (`cv_settings_dragdrop.v`)
State and positions:
* Each block has (xN,yN) registers; initial x positions: 320,394,468,510,552,594.
* Drag begins on a clean left-edge while hovering; `drag_idx` captures which block.
* During drag: block top-left aligned so block centers follow cursor (using half-width subtraction).
* Drop filtering: release must be sustained low ≥ 2,000,000 cycles @25MHz ≈ 80ms (`DRAG_RELEASE_TH`) preventing bounce.
* Valid placement determined by center-point inclusion inside corresponding drop box rectangle. Wrong-zone attempts revert to initial coordinates.

Layout reflow:
* After placement flags update (`placed*_pre`, `placed*_morph`), module recomputes centralized positions using left margins calculated from zone width and number of items.
* Horizontal order for morphology uses rank variables `r2..r5` counting how many placed morph blocks lie strictly to the left; this produces deterministic order even if X ties occur (index tie-break).

Ordering outputs:
* Preprocessing: `pre_order_vector[3:0]` with two 2-bit codes (01 GAUSS, 10 MEDIAN).
* Morphology: `morph_order_vector[11:0]` packs up to four 2-bit codes (01 ERODE, 10 DILATE).
* Type toggles: Scroll wheel pulses modify `is_erode2..5` (NOTE: design inversion—scroll down selects ERODE, scroll up selects DILATE).
* Derived convenience vectors: `morph_vector` (ordered dilate bits), `box_morph_vector` (raw physical box types), `morph_count` (0–4).
* Positions for drawing: `boxes_x`, `boxes_y` (concatenated 10-bit / 9-bit per block).
* Interaction pulses: `gauss_click`, `median_click`, `erode_click`, `dilate_click` feed education/info color selection.
* Foreground block: `front_idx` chosen at drag start for correct z-order rendering.

Real-time effect: The top-level pipeline taps these order codes to choose which module outputs cascade. Newly placed or toggled blocks affect subsequent pixels with no frame flush.

#### View Selection
Clicking an eye icon sets a small mux select (in `Top.v`) to route one of four pixel streams into the compositor:
1. Camera (raw RGB444 depth-reduced & cropped)
2. Post-preprocessing (GAUSS/MEDIAN chain — pass-through if none placed)
3. Bitmap (threshold classification expanded to RGB for visibility)
4. Post-morphology result (after sequential erosion/dilation steps)

GUI overlays draw on top so interactive elements remain visible across all views.

#### RGB Thresholding (`threshold_subsection.v`)
* Keeps min/max registers for R,G,B.
* Slider manipulation logic updates bounds per channel.
* Eyedropper: samples hovered pixel, sets ranges around captured color (implementation: read pixel value, write to min/max with margin or direct copy—exact margin defined in module code).
* Classification: `threshold_pixel = (R in [Rmin,Rmax]) & (G in ...) & (B in ...)`.
* HSV path currently commented; enabling requires finishing conversion and adding a mode toggle.
* Result written into bitmap BRAM; viewed through Bitmap and Morphology outputs.

#### Morphology (`Morphology_3x3.v`)
For each active ordered slot:
* Accepts streaming bitmap (1 bit/pixel) plus 3×3 window from line buffers.
* ERODE: AND across 9 window bits.
* DILATE: OR across 9 window bits.
* Edge handling: top/left replication & controlled flush segments so output aligns with frame coordinates.
* Latency: minimal; maintains one-pixel-per-cycle throughput.

#### Timing & Domains
* UI + drag-drop operate on 25 MHz VGA clock.
* Camera capture uses 24 MHz xclk; data written into frame BRAM, later read on VGA clock.
* No cross-domain hazards in ordering signals; they reside entirely in the VGA/UI clock domain.

#### Performance & Determinism
* Throughput constant; modifying order only changes small control nets.
* No pipeline stalls: hardware stages always present, gating selects active subset.
* Multi-step morphology accumulates effects sequentially; four erosions or dilations are valid edge-case use.

#### Edge Cases & Safeguards
| Scenario | Handling |
|----------|----------|
| Wrong-zone drop | Block resets to home position; placed flag cleared |
| Fast click-release | Ignored as drop (needs sustained low) preventing misplacement |
| Drag while scrolling | Scroll ignored; preserves current type |
| Overlapping X coords | Rank logic with index tie-break ensures stable order |
| No preprocessing placed | Preprocessing view identical to camera |
| No morphology placed | Morphology view identical to bitmap |

#### Extensibility
* Add filters: widen `pre_order_vector`; assign new opcodes.
* Add morphology types: introduce more boxes + extend rank & sorting network.
* Enable HSV: reintroduce conversion + UI toggle; feed same bitmap path.
* Dynamic parameter tuning: expose kernel coefficients / median enable bits via new GUI registers.

#### Quick Signal Reference
`pre_order_vector`, `morph_order_vector`, `morph_vector`, `box_morph_vector`, `morph_count`, `boxes_x`, `boxes_y`, `gauss_click`, `median_click`, `erode_click`, `dilate_click`, `front_idx`, `threshold_pixel`.

#### Summary
The Image Processing Settings GUI maps intuitive user gestures (drag, scroll, click) into compact register updates. These drive a pre-synthesized streaming hardware pipeline, achieving immediate visual feedback without reconfiguration or frame latency penalties.


### Object Detection Settings:
This page configures and explains the streaming Union‑Find Disjoint Set (UFDS) connected‑component detector. It visualizes algorithm states, lets you filter components by size and limit how many bounding boxes are drawn, and optionally enables servo auto‑tracking.

#### 1. High-Level Goal
Transform the live 1‑bit morphology output (bitmap) into a set of labeled connected components and maintain a top‑N leaderboard of "interesting" objects each frame — all while sustaining one pixel per cycle throughput.

#### 2. Streaming Model
Rather than buffering a whole frame, the UFDS core processes each bitmap pixel as it arrives (after the 25 MHz → UFDS clock domain bridge). For every pixel:
1. Sample 4 prior neighbor labels (Left, Up‑Left, Up, Up‑Right) via two rolling line buffers.
2. Decide a provisional label for the current foreground pixel.
3. Apply union operations to merge equivalence classes if neighbor labels differ.
4. Update per‑root statistics (area, sum_x, sum_y, min/max x,y).
5. Update the real‑time leaderboard (top components by configurable criteria).

Foreground = bitmap bit = 1. Background pixels are skipped except for housekeeping.

#### 3. Bridge: `UFDS_Bridge`
Operates between pixel clock (25 MHz) and UFDS logic domain (higher frequency, e.g. 50/100 MHz):
* Packs per‑pixel meta signals: frame start, line start, frame end, pixel bit.
* Small FIFO decouples clock domains; read side asserts "ready" when UFDS core can accept next pixel.
* Ensures strict ordering — no pixel reordering or loss.

#### 4. Internal Data Structures (Conceptual)
| Structure | Purpose | Notes |
|-----------|---------|-------|
| Parent array | Union‑Find parent links | Rank heuristic used for shallow trees |
| Rank array | Balances unions | Increments on tie merges |
| Stats arrays (area, sum_x, sum_y) | Component metrics | Centroid = (sum_x/area, sum_y/area) |
| Bounds arrays (min_x, max_x, min_y, max_y) | Bounding boxes | Updated on every foreground pixel attach |
| Leaderboard slots (0..3) | Track best up to 4 components | Each slot stores root ID & cached stats |
| Line buffers (row0, row1) | Previous row neighbor labels | Scroll vertically with incoming lines |

All arrays are sized for max simultaneous labels required by frame resolution; label reuse after merges avoids exhaustion.

#### 5. Label Allocation Logic
Decision workflow per foreground pixel:
1. Read 4 neighbor labels. Ignore zeros (background).
2. If no foreground neighbors → allocate new label (next free ID) and init stats.
3. Else choose one neighbor label as the provisional representative (priority order: Left, Up, Up‑Left, Up‑Right).
4. For each remaining distinct neighbor label → perform union with the chosen representative root.
5. After union, attach pixel stats to the canonical root (path compression and/or root chasing performed over multi‑cycle FSM states).

#### 6. Union Operation (Weighted Quick Union)
* Compare ranks; lower rank root points to higher.
* On rank tie, increment rank of new parent.
* Merge stats: area += area_other; sum_x += sum_x_other; etc.
* Update global bounds: new min_x = min(min_x_a, min_x_b) likewise for max_x / y.
* Clear merged child’s stats (or mark as forwarded) to avoid double counting.

#### 7. Per‑Root Statistics
Updated when pixel attaches to a root:
* area++
* sum_x += current_x; sum_y += current_y
* min_x = min(min_x, current_x)
* max_x = max(max_x, current_x)
* min_y / max_y similarly

Centroid later computed as integer divisions; bounding box readily available.

#### 8. Leaderboard Maintenance
At defined hook points (often after pixel classification or merge completion):
1. If component area ≥ min_area_sel (user setting), consider for insertion.
2. If root already in slots → update cached stats.
3. Else if slot free → insert.
4. Else if component "better" than current worst slot → replace that slot.

“Better” criterion can be area or (in extended design) proximity; current active path uses area only (proximity toggle code commented out). Worst slot tracked by maintaining min‑area index.

#### 9. User Settings (`ufds_settings_overlay`)
* Min Area: Buttons set `min_area_sel` (00=4, 01=16, 10=32, 11=64). Filter applied before leaderboard insertion.
* Max Boxes: `max_boxes_sel` (00=1..11=4). Limits how many leaderboard slots are drawn / forwarded to servo logic.
* Servo Toggle: `servo` enables auto‑tracking (PID consumes centroids of primary component).
* Tab Selection: `tab_idx` chooses which explanatory state visual to highlight and which education text is dimmed.

#### 10. Output Packing
UFDS core (with bridge) produces packed vectors (example conceptual fields per component):
* area (pixel count)
* centroid_x, centroid_y (integer divisions)
* bbox_min_x, bbox_max_x, bbox_min_y, bbox_max_y
* root_id (optional for debug)
These are concatenated for slots 0..N-1 then truncated according to `max_boxes_sel` before overlay rendering and servo feed.

#### 11. Frame & Line Boundaries
Special marker bits in bridge words signal:
* Frame Start: reset temporary per‑frame accumulators; leaderboard cleared.
* Line Start: advance row buffer pointers; swap active row storage.
* Frame End: finalize any pending unions and freeze leaderboard snapshot for display & servo.

#### 12. Timing & Throughput
* Pixel ingestion: one per UFDS core clock cycle (faster than VGA clock; FIFO prevents stalls).
* Union operations may span multiple cycles (FSM states: SAMPLE, CHOOSE, ALLOC, UNION_ATTACH, MERGE, LABEL_WRITE, COMP0..COMP3, COMPS_DONE). Pipeline ensures aggregate throughput ≈ 1 pixel/cycle average.
* No frame buffering; memory footprint proportional to number of active labels + stats arrays.

#### 13. Complexity
Worst‑case per pixel: O(k α(n)) where k ≤ 4 neighbor unions, α(n) inverse Ackermann (nearly constant). Streaming design shifts union cost across cycles so ingestion rate stays constant.

#### 14. Visualization
Overlay draws:
* Bounding boxes using stored min/max bounds.
* Optional center marker from centroid.
* Distinct colors per slot (handled in overlay LUT) for education clarity.
Filtering ensures only components meeting size threshold and within top‑N appear.

#### 15. Servo Integration (Auto‑Tracking)
When `servo` enabled:
1. Select primary component (slot 0 after ordering by area).
2. Compute error = (centroid_x - frame_center_x, centroid_y - frame_center_y).
3. Feed errors into PID controllers (pan/tilt). Gains applied with shift arithmetic.
4. Servo PWM updates at 50 Hz; integral clamp prevents windup when target absent (no valid component → hold previous target or recenter). 

#### 16. Edge Cases & Safeguards
| Case | Handling |
|------|----------|
| All pixels background | Leaderboard remains empty; no boxes drawn; servo holds last | 
| Single large blob | One component fills frame; unions minimal, stats scale safely | 
| Rapid appearance/disappearance | Leaderboard resets each frame; transient flicker minimized by stable overlay draw path |
| Label exhaustion (rare) | Design sized for frame resolution; merges free labels quickly |
| Tiny noise speckles | Filtered out if area < min_area_sel |

#### 17. Extensibility
* Proximity sorting: re‑enable `sort_by_prox` and add distance metric to ranking.
* Multi‑criteria: track both area and aspect ratio; add weighting function.
* More boxes: expand packed vectors and overlay color map; widen `max_boxes_sel`.
* Temporal smoothing: add per‑root motion history (exponential moving average for centroid) for steadier servo input.

#### 18. Quick Signal Reference
* Settings: `min_area_sel`, `max_boxes_sel`, `servo`, `tab_idx`
* Bridge pixel meta: frame_start, line_start, frame_end bits (packed)
* Leaderboard packed outputs: comp0..comp3 stats (area, sums, bounds) concatenated
* Valid count: component counter (clamped to max_boxes_sel)
* Servo error source: centroid of slot 0

#### 19. Summary
UFDS provides real-time connected component labeling with constant throughput by interleaving labeling, union consolidation, and statistics updates in a finely staged FSM. User controls directly gate insertion and display, enabling immediate experimentation with filtering thresholds and tracking behavior.

### Fullscreen Mode: 
- Clears settings overlays and adds a crosshair to indicate centre of screen. 
- Retains configurations from Image Processing and Object Detection (e.g. no. of bounding boxes). 
- Right click in any state to enter full screen. Return to the settings page users were in previously by right clicking again.

## Image Processing pipeline
The pipeline is fixed in structure but configurable by which steps are active and in what order:

1. Camera (always present)

2. Preprocessing (0–2 steps, in any order)
- Gaussian Blur (GAUSS)
- Median Filter (MEDIAN)

3. Threshold to Bitmap (RGB sliders)

4. Morphology (0–4 steps, any order)
- ERODE/DILATE (up to 4 boxes, each can be toggled independently between either via scroll)

4. UFDS: streaming object detection (connected components)

# Control and Interactions
## Mouse move: 
moves on-screen cursor; used to hover blocks and buttons.

## Left-click (debounced edge): 
select tabs, drop zones, buttons; start dragging blocks.

### Drag-and-drop:
Click-hold a block to drag; it follows your cursor.
Drop only happens after the mouse button has been low for ~80 ms to avoid accidental releases.
If you release outside a valid drop zone, the block snaps back home.

### Scroll wheel:
When hovering a morphology block, scroll sets that block’s type:
Scroll down → set to ERODE
Scroll up → set to DILATE

Tip: 
Hover highlights and button/border colors help confirm what you'll activate with a click.

## Education Tabs
Info Tab animation:
Animates vertically to open/close an info panel.
Clicking different UI elements updates the info category and its representative color.
Education_Tabs module:
Renders explanatory text (neighbors, union, stats, filter, building) using a glyph BRAM.
The content is aligned to the info tab area; text selection is driven by an index from the top-level wiring.
What you’ll see:
When the info tab is open, a green vertical barrier and a light background provide contrast.
Text appears in the right portion; borders/hover fills highlight controls.

## mouse, scroll, and events
MouseCtl (PS/2, VHDL) decodes:
Position: 12-bit x/y (top-level uses lower bits for 640×480)
Buttons: left/middle/right
Scroll: 4-bit signed z (Top creates up/down pulses for drag/drop scroll actions)
Top-level logic debounces left-clicks and generates single-cycle edges for UI modules.
Drag-drop uses a sustained-low release filter (~80 ms) to classify a drop (prevents spurious releases).


## seven-segment display
Displays a 4-hex-digit number with optional decimal points.
Multiplexed at ~381 Hz (internal divider), standard active-low segment coding.
Used for debug/telemetry (what it shows is bound in Top-level; e.g., counters or status).


## data outputs and what they mean (advanced)
From cv_settings_dragdrop:

Preprocessing
pre_order_vector[3:0]: Two 2-bit fields LSB→MSB for left→right order
01 = GAUSS, 10 = MEDIAN, 00 = empty
Morphology
morph_count[2:0]: number of morph blocks placed (0–4)
morph_order_vector[11:0]: four 2-bit steps (LSB = leftmost), 01 = ERODE, 10 = DILATE, 00 = empty
morph_vector[3:0]: mirrors order with 1 = DILATE, 0 = ERODE or empty (quick read)
box_morph_vector[3:0]: box 2..5 types (1 = DILATE, 0 = ERODE) regardless of placement/order
placed_morph_vector[3:0]: which morph boxes are currently placed
Positions (for overlays):
boxes_x[59:0], boxes_y[53:0]: concatenated top-left x,y of GAUSS, MEDIAN, and 4 morph boxes
Click pulses:
gauss_click, median_click, erode_click, dilate_click: one-cycle pulses when clicking those blocks
Z-order:
front_idx: index of the block that should render on top during drag (0=GAUSS, 1=MED, 2..5 = morph A/B/C/D)
From ufds_settings_overlay:

Tab selection: tab_idx (0 = return, 1..5 = other panels)
Min-area: min_area_sel (00=4, 01=16, 10=32, 11=64)
Max boxes: max_boxes_sel (00=1, 01=2, 10=3, 11=4)
Servo enabled: servo (toggle)
Overlay pixel: overlay_en, overlay_rgb
Info dimming mask: info_dim_en (mask for info panel background)
From cv_settings_info_tab / Education_Tabs:

Moving pixel: pix_x, pix_y, pix_rgb (for animation)
Info category: top-level maps clicks to an info_select index that chooses which text (neighbors, union, stats, filter, building, or a block topic) is displayed by Education_Tabs.
Education text pixels: edu_rgb and edu_pixel_en are overlaid when active.
UFDS outputs (from detector/bridge, summarized):

Packed component metrics for top N (up to 4): area, centroid sums, bounds, etc., plus a count of valid components.
Top-level uses these to draw boxes and compute servo targets.