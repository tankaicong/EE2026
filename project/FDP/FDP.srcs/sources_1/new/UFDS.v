`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Inspirations taken from AprilTagv1.0, AprilTagv2.0, Suzuki-Abe
// AND from CS2040C for the Union Find Disjoint Set algorithm and use of rank.
// I have decided to use weighted quick-union (use rank of the root, refer to Augmented Balanced BSTs) for space and time complexity
// - find: follow parent "pointers" to the root. same root == same ID
// - Union: Attach the smaller tree to the larger (by rank of root) and merge the stats we stored
// quick-find didnt seem right coz we need to scan and rewrite the entire componentID array every union() call == slow and resource heavy 
// made it weighted so that find is faster (shorter tree height) - O(log n) for both find and union
// path compression i give up and idt we need for now?
//
// Given a bitmap of size 320 x 240, but there is a limit to vertical traversal speed.
// Use reduced neighbour set: check if left, up-left, up, up-right are part of a component
// Search from left to right, top to bottom
// Every component found given an ID, then use minDistBtnBlobs to merge smaller blobs close together
//
// 1. Grouping: Use UFDS to find connected components from bitmap and assign IDs
// 2. Merging: Merge small components into larger ones based on bounding box overlap
// 3. Output: All final bounding boxes which are top bottom left right coordinates
//
// Personal implementation of a connceted-component labelling using UFDS
// labels here refers to the component ID that we know (shorter name lol)
//
// all variables i used registers
// these reg are now always accessible so dont need to pass as args to functions
// logic of the whole union-find is implemented as a whole FSM style
// Using each state to mimic a function in C++
//////////////////////////////////////////////////////////////////////////////////


module UFDS_Detector(
    input clk,
    input ext_reset,

    // since image comes in serially, one pixel per clock. I put these as some sort of
    // handshake in signals to know when a new frame starts and ends
    // and also when a new line starts and when each pixel is valid
    input  wire in_valid,      // 1 during active pixels
    input  wire frame_start,   // pulse at first active pixel
    input  wire line_start,    // pulse at first pixel of each line
    input  wire frame_end,     // pulse after last active pixel
    input  wire curr_pix,      // every pixel that is coming in

    // output reg [9:0] bbox_left, 
    // output reg [9:0] bbox_right,
    // output reg [8:0] bbox_top, 
    // output reg [8:0] bbox_bottom,
    // output reg [9:0] centroid_x,
    // output reg [8:0] centroid_y,

    // 4 component output (it will be the 4 largest components detected), lower bits is for component 0 - largest
    input  wire [1:0] min_area_sel,   // 00=4,01=16,10=32,11=64
    // input  wire       sort_by_prox,   // 0=area, 1=proximity among current top-4
    input  wire [1:0] max_boxes_sel,  // 00=1,01=2,10=3,11=4

    // 4 component output (it will be the 4 largest components detected), lower bits is for component 0 - by chosen order
    output reg  [2:0] comp_count, // numer of valid components
    output reg  [39:0] comp3210_left ,
    output reg  [39:0] comp3210_right ,
    output reg  [35:0] comp3210_top,
    output reg  [35:0] comp3210_bottom,
    output reg  [39:0] comp3210_cx,
    output reg  [35:0] comp3210_cy,
    output reg  [63:0] comp3210_area,
    output wire ready_to_read

    );

localparam integer WIDTH = 310;
localparam integer HEIGHT = 240;
localparam integer x_bitsize = 9;
localparam integer y_bitsize = 8;
localparam integer label_bits = 9; // rmb label == 0 is the background and supports up to 4095 labels (can reduce if dont need this many labels)
// runtime-configurable min area (from UI)
reg [16:0] MIN_AREA_RT;
always @(*) begin
    case (min_area_sel)
        2'b00: MIN_AREA_RT = 17'd4;
        2'b01: MIN_AREA_RT = 17'd16;
        2'b10: MIN_AREA_RT = 17'd32;
        default: MIN_AREA_RT = 17'd64;
    endcase
end

// current pixel coordinates (increment x each pixel, on line_start x=0 and y increment by 1)
reg [x_bitsize-1:0] x;
reg [y_bitsize-1:0] y;

/* 
 *UFDS need to check neighbours' labels, we use 2 lines of buffer (reduced neighbours) 
 * to store labels temporarily for comparison
 * get away using only two (inspiration from mergesort haha to reduce space complexity)
 * just swap the roles of these two after every row (using toggle_line 0: prev=buff0, curr=buff1; 1: prev=buff1, curr=buff0)
 * each entry stores the component ID
*/
(* ram_style = "block" *) reg [label_bits-1:0] row0_labels[0:WIDTH-1];
(* ram_style = "block" *) reg [label_bits-1:0] row1_labels[0:WIDTH-1];
reg toggle_line; // 0: prev=buff0, curr=buff1; 1: prev=buff1, curr=buff0

/*
 * Quick-Union Disjoint Set ADT implementation (specifically weighted union) 
 * and the stats to store for each label
 */
localparam integer MAX_LABELS = 512; // can reduce if dont need this many labels
localparam integer FIND_MAX_ITERATIONS = 8; // to prevent infinite loop in find, since loops in functions are combinational. Height of tree is O(log n) = 4

(* ram_style = "block" *) reg [label_bits-1:0] parent [0:MAX_LABELS-1]; // C++ eq: vector<int> parent (MAX_LABELS);
(* ram_style = "block" *) reg [3:0] rank [0:MAX_LABELS-1]; // C++ eq: vector<int> rank (MAX_LABELS); 
(* ram_style = "block" *) reg active_root [0:MAX_LABELS-1]; // boolean array marking whether a component ID is in use as a root
(* ram_style = "block" *) reg [label_bits-1:0] next_label; // next unused label n0.

// stats for each component (hence only store for root pixel, where parent[label] == label)
// centroid_x = sum_x / area ; centroid_y = sum_y / area
(* ram_style = "block" *) reg [16:0] area [0:MAX_LABELS-1]; // number of pixels in this component
(* ram_style = "block" *) reg [15:0] sum_x [0:MAX_LABELS-1]; // sum of x coordinates of pixels in this component
(* ram_style = "block" *) reg [15:0] sum_y [0:MAX_LABELS-1]; // sum of y coordinates of pixels in this component
(* ram_style = "block" *) reg [x_bitsize-1:0] min_x [0:MAX_LABELS-1]; 
(* ram_style = "block" *) reg [x_bitsize-1:0] max_x [0:MAX_LABELS-1]; 
(* ram_style = "block" *) reg [y_bitsize-1:0] min_y [0:MAX_LABELS-1]; 
(* ram_style = "block" *) reg [y_bitsize-1:0] max_y [0:MAX_LABELS-1]; 


// retrieve the reduced neighbour pixel's labels 
wire [label_bits-1:0] left_label = (x == 0) ? 0 : 
                                   (toggle_line == 0) ? row1_labels[x-1] : row0_labels[x-1];
wire [label_bits-1:0] up_label = (y == 0) ? 0 : 
                                   (toggle_line == 0) ? row0_labels[x] : row1_labels[x];
wire [label_bits-1:0] upleft_label = (x == 0 || y == 0) ? 0 : 
                                   (toggle_line == 0) ? row0_labels[x-1] : row1_labels[x-1];
wire [label_bits-1:0] upright_label = (x == WIDTH-1 || y == 0) ? 0 : 
                                   (toggle_line == 0) ? row0_labels[x+1] : row1_labels[x+1];

// temporary registers to read and write neighbour labels
reg [label_bits-1:0] left;
reg [label_bits-1:0] up;
reg [label_bits-1:0] upleft;
reg [label_bits-1:0] upright;
reg [label_bits-1:0] root_left;
reg [label_bits-1:0] root_up;
reg [label_bits-1:0] root_upleft;
reg [label_bits-1:0] root_upright;
reg [label_bits-1:0] R; // final root label for current pixel
reg [label_bits-1:0] R_next; // temp to get next smallest root

// temporary counters to help me walk along the width and labels during a sweep, to not touch global ref for x coord 
reg [x_bitsize-1:0] init_width_idx;
reg [label_bits-1:0] init_label_idx;

// temporary registers to help in find() aka the find engine
// reg [label_bits-1:0] find_curr; // used in S_FIND_* states to follow parents to find root of component iteratively

// temporary registers to help in union() aka the union engine (which uses find engine twice, then attach and merge stats)
reg [label_bits-1:0] ua, ub; // inputs
reg [label_bits-1:0] ra, rb; // roots

// wire [label_bits-1:0] parent_curr = parent[find_curr];
// wire [label_bits-1:0] rootR_now = (parent[R]==R) ? R : parent[R]; // root of R now (after a union)

reg [label_bits-1:0] tmp;
reg curr_pix_q;

// output stuff
reg [16:0] ua_area_new; // next area when adding a pixel, caching the area for the label that is growing    
// reg [16:0] best_area; // running largest area
// reg [label_bits-1:0] best_lbl; // label of current best

// leaderboard for top-4 components
reg [label_bits-1:0] slot0, slot1, slot2, slot3; // to hold the best 4 labels
reg [16:0] slot0_area, slot1_area, slot2_area, slot3_area; // since we are comparing based on area
reg [16:0] min_area_tmp; // temp
reg [1:0] min_idx_tmp; // temp

// Proximity ordering helpers (among current 4 slots)
// reg [label_bits-1:0] v0, v1, v2, v3;
// reg [9:0]  prox_cx0, prox_cx1, prox_cx2, prox_cx3;
// reg [8:0]  prox_cy0, prox_cy1, prox_cy2, prox_cy3;
// // Temp deltas for distance calculation (widen y to 10 bits during math)
// reg [9:0]  dx0, dx1, dx2, dx3;
// reg [9:0]  dy0, dy1, dy2, dy3;
// reg [19:0] d0, d1, d2, d3, curr_min_d;
// reg [1:0]  ord0, ord1, ord2, ord3, curr_sel;
// reg [2:0]  allowed_n, prox_valid_n;

// reg frame_end_accepted_pixel; 

// FSM encoding
reg [4:0] state;
localparam S_RESET = 0;
localparam S_INIT_LINES = 1;
localparam S_INIT_UFDS = 2;
localparam S_READY = 3;
localparam S_SAMPLE = 4;
// localparam S_FIND_L = 5;
// localparam S_FIND_L_RD = 6;
// localparam S_FIND_U = 7;
// localparam S_FIND_U_RD = 8;
// localparam S_FIND_UL = 9;
// localparam S_FIND_UL_RD = 10;
// localparam S_FIND_UR = 11;
// localparam S_FIND_UR_RD = 12;
localparam S_CHOOSE = 13;
localparam S_ALLOC = 14;
localparam S_UNION_DECIDE = 15;
localparam S_UNION_FIND_A = 16;
// localparam S_UNION_FIND_A_RD = 17;
localparam S_UNION_FIND_B = 18;
// localparam S_UNION_FIND_B_RD = 19;
localparam S_UNION_ATTACH = 20;
localparam S_UNION_MERGE_0 = 21;
localparam S_UNION_MERGE_1 = 22;
localparam S_UNION_MERGE_2 = 23;
localparam S_UNION_MERGE_3 = 24;
localparam S_LABEL_WRITE = 25;
localparam S_ADVANCE = 26;
localparam S_COMP0 = 27;
localparam S_COMP1 = 28;
localparam S_COMP2 = 29;
localparam S_COMP3 = 30;
localparam S_COMPS_DONE = 31;

assign ready_to_read = (state == S_READY);

/*
 * main FSM by per-pixel UFDS sequence
 */
always @(posedge clk) begin
    if (ext_reset) begin
        x <= 0; y <= 0; toggle_line <= 0;
        // bbox_left <= 0; bbox_right <= 0; bbox_top <= 0; bbox_bottom <= 0; centroid_x <= 0; centroid_y <= 0;
        
        init_width_idx <= 0;
        init_label_idx <= 0;
        next_label <= 1;

        // find_curr <= 0;
        ua<=0; ub<=0; 
        // ra<=0; rb<=0;

        // best_area <= 0; best_lbl <= 0;

        // multi-output resets
        slot0 <= 0; slot1 <= 0; slot2 <= 0; slot3 <= 0;
        slot0_area <= 0; slot1_area <= 0; slot2_area <= 0; slot3_area <= 0;
        comp_count <= 0;
        comp3210_left  <= 0;
        comp3210_right  <= 0;
        comp3210_top <= 0;
        comp3210_bottom <= 0;
        comp3210_cx <= 0;
        comp3210_cy <= 0;
        comp3210_area <= 0;
        // frame_end_accepted_pixel <= 1'b0;

        state <= S_INIT_LINES; // and later S_INIT_UFDS

    end else begin
        // Handle external frame/line strobes for coordinates and toggling
        if (frame_start) begin
            x <= 0;
            y <= 0;
            toggle_line <= 1'b0;
            // restart init on new frame
            // state <= S_INIT_LINES;
            // init_width_idx <= 0;
            // init_label_idx <= 0;
            next_label <= 1;

            // bbox_left <= 0; bbox_right <= 0; bbox_top <= 0; bbox_bottom <= 0; centroid_x <= 0; centroid_y <= 0;
            // best_area <= 0; best_lbl <= 0;

            // clear leaderboard for new frame
            slot0 <= 0; slot1 <= 0; slot2 <= 0; slot3 <= 0;
            slot0_area <= 0; slot1_area <= 0; slot2_area <= 0; slot3_area <= 0;
            comp_count <= 0;
            comp3210_left  <= 0;
            comp3210_right  <= 0;
            comp3210_top <= 0;
            comp3210_bottom <= 0;
            comp3210_cx <= 0;
            comp3210_cy <= 0;
            comp3210_area <= 0;

            state <= S_READY;

        end else if (line_start && state==S_READY) begin
            x <= 0;
            y <= y + 1;
            toggle_line <= ~toggle_line;
        end

        case (state)
            // clear the two line buffers (// for (i = 0; i < WIDTH; i = i + 1) begin
                                           //             row0_labels[i] <= 0;
                                           //             row1_labels[i] <= 0;
                                           //         end)
            S_INIT_LINES: begin
                row0_labels[init_width_idx] <= 0;
                row1_labels[init_width_idx] <= 0;
                if (init_width_idx == WIDTH-1) begin
                    init_width_idx <= 0;
                    state <= S_INIT_UFDS; // clear UFDS values next
                end else begin
                    init_width_idx <= init_width_idx + 1;
                end
            end

            // clear UFDS related stats
            S_INIT_UFDS: begin
                parent[init_label_idx] <= init_label_idx[label_bits-1:0];
                rank[init_label_idx] <= 0;
                active_root[init_label_idx] <= 0;
                area[init_label_idx] <= 0;
                sum_x[init_label_idx] <= 0;
                sum_y[init_label_idx] <= 0;
                min_x[init_label_idx] <= {x_bitsize{1'b1}}; // mins high
                min_y[init_label_idx] <= {y_bitsize{1'b1}};
                max_x[init_label_idx] <= 0; // max low
                max_y[init_label_idx] <= 0;
                if (init_label_idx == MAX_LABELS-1) begin
                    init_label_idx <= 0;
                    state <= S_READY;
                end else begin
                    init_label_idx <= init_label_idx + 1;
                end
            end

            // ready to accept a new pixel and start the whole UFDS process
            S_READY: begin
                if (in_valid) begin
                    // sample provisional neighbor labels
                    curr_pix_q <= curr_pix;
                    // On the very first pixel of each line, force west-side neighbors to 0
                    // to avoid accidental wrap unions caused by x/toggle_line updates
                    // occurring in the same cycle as line_start.
                    left   <= (line_start) ? {label_bits{1'b0}} : left_label;
                    upleft <= (line_start) ? {label_bits{1'b0}} : upleft_label;
                    // north neighbors remain valid at line start (refer to previous line)
                    up     <= up_label;
                    upright<= upright_label;

                    state <= S_SAMPLE;
                end
            end

            S_SAMPLE: begin
                if (!curr_pix_q) begin
                    // 0 means label 0 which rep background
                    case (toggle_line)
                        0: row1_labels[x] <= 0;
                        1: row0_labels[x] <= 0;
                    endcase
                    state <= S_ADVANCE;
                end else begin
                    // immediately get their roots
                    root_left <= left;
                    root_up <= up;
                    root_upleft <= upleft;
                    root_upright <= upright;
                    state <= S_CHOOSE;
                    // if (x == 0) begin
                    //     if (y == 0) begin
                    //         state <= S_CHOOSE; // first pixel of whole frame
                    //     end else begin
                    //         state <= S_FIND_U; // no left neighbour
                    //     end
                    // end else begin
                    //     state <= S_FIND_L; // begin find on left neighbor
                    // end
                end
            end
            
            /*
            // find(L)
            S_FIND_L: begin
                if (left != 0) begin
                    find_curr <= left; 
                    state <= S_FIND_L_RD;
                end else begin
                    root_left <= 0;
                    state <= S_FIND_U; // skip to next neighbor
                end
            end
            S_FIND_L_RD: begin
                // one hop per cycle
                if (parent_curr == find_curr) begin // root iff parent[curr] == curr
                    root_left <= find_curr;
                    state <= S_FIND_U; // go to next neighbor
                end else begin
                    find_curr <= parent_curr;
                end
            end

            // find(U)
            S_FIND_U: begin
                if (up != 0) begin
                    find_curr <= up;
                    state <= S_FIND_U_RD;
                end else begin
                    root_up <= 0;
                    state <= S_FIND_UL; // skip to next neighbour
                end
            end
            S_FIND_U_RD: begin
                if (parent_curr == find_curr) begin
                    root_up <= find_curr;
                    state <= S_FIND_UL;
                end else begin
                    find_curr <= parent_curr;
                end
            end

            // find(UL)
            S_FIND_UL: begin
                if (upleft != 0) begin
                    find_curr <= upleft;
                    state <= S_FIND_UL_RD;
                end else begin
                    root_upleft <= 0;
                    state <= S_FIND_UR;
                end
            end
            S_FIND_UL_RD: begin
                if (parent_curr == find_curr) begin
                    root_upleft <= find_curr;
                    state <= S_FIND_UR;
                end else begin
                    find_curr <= parent_curr;
                end
            end

            // find(UR)
            S_FIND_UR: begin
                if (upright != 0) begin
                    find_curr <= upright;
                    state <= S_FIND_UR_RD;
                end else begin
                    root_upright <= 0;
                    state <= S_CHOOSE;
                end
            end
            S_FIND_UR_RD: begin
                if (parent_curr == find_curr) begin
                    root_upright <= find_curr;
                    state <= S_CHOOSE;
                end else begin
                    find_curr <= parent_curr;
                end
            end
            */

            // choose representative for current pixel (smallest non-zero root of all 4 neighbours)
            S_CHOOSE: begin
                R_next = 0;
                if (root_left != 0 && (R_next == 0 || root_left < R_next)) begin
                    R_next = root_left;
                end
                if (root_up != 0 && (R_next == 0 || root_up < R_next)) begin
                    R_next = root_up;
                end
                if (root_upleft != 0 && (R_next == 0 || root_upleft < R_next)) begin
                    R_next = root_upleft;
                end
                if (root_upright != 0 && (R_next == 0 || root_upright < R_next)) begin
                    R_next = root_upright;
                end

                R <= R_next;
                if (R_next == 0) begin
                    state <= S_ALLOC;
                end else begin
                    state <= S_UNION_DECIDE;
                    
                end

                // if (root_left != 0) begin
                //     R <= root_left;
                // end
                // if (root_up != 0 && (R == 0 || root_up < R)) begin
                //     R <= root_up;
                // end
                // if (root_upleft != 0 && (R == 0 || root_upleft < R)) begin
                //     R <= root_upleft;
                // end
                // if (root_upright != 0 && (R == 0 || root_upright < R)) begin
                //     R <= root_upright;
                // end
                // if ((root_left | root_up | root_upleft | root_upright) == 0) begin
                //     state <= S_ALLOC;
                // end else begin
                //     state <= S_UNION_DECIDE;
                // end
            end

            // allocate new label if all 4 neighbours are background (new component found)
            S_ALLOC: begin
                R <= next_label;
                ua <= next_label; // ensure use this temp pointer to update stats

                // update the stats of this root of a new component to that of only 1 pixel in component
                parent[next_label] <= next_label;
                rank[next_label] <= 0;
                active_root[next_label] <= 1; // this new componentID/label is now used
                area[next_label] <= 0;
                sum_x[next_label] <= 0;
                sum_y[next_label] <= 0;
                min_x[next_label] <= {x_bitsize{1'b1}};
                min_y[next_label] <= {y_bitsize{1'b1}};
                max_x[next_label] <= {x_bitsize{1'b0}};
                max_y[next_label] <= {y_bitsize{1'b0}};

                if (next_label != MAX_LABELS-1)
                    next_label <= next_label + 1;

                state <= S_LABEL_WRITE;
            end

            // pick at most one neighbor to union with (priority L > U > UL > UR)
            // now operands are already roots, no need to find roots.
            S_UNION_DECIDE: begin
                ua <= R;
                if (root_left != 0 && root_left != R) begin 
                    ub <= root_left; 
                    // state <= S_UNION_FIND_A; 
                    state <= S_UNION_ATTACH;
                end
                else if (root_up != 0 && root_up != R) begin 
                    ub <= root_up; 
                    // state <= S_UNION_FIND_A; 
                    state <= S_UNION_ATTACH;
                end
                else if (root_upleft != 0 && root_upleft != R) begin 
                    ub <= root_upleft; 
                    // state <= S_UNION_FIND_A; 
                    state <= S_UNION_ATTACH;
                end
                else if (root_upright != 0 && root_upright != R) begin 
                    ub <= root_upright; 
                    // state <= S_UNION_FIND_A; 
                    state <= S_UNION_ATTACH;
                end else begin
                    state <= S_LABEL_WRITE; // nothing to union
                end
            end

            /*
             * union(int p, int q) {
             *     while (parent[p] !=p) p = parent[p]; // WEIGHTED UNION part 1
             *     while (parent[q] !=q) q = parent[q]; // WEIGHTED UNION part 2
             *     // WEIGHTED UNION part 3: attach lower-size under higher-size
             *     if (size[p] > size[q] {
             *         parent[q] = p;   // Link q to p
             *         size[p] = size[p] + size[q];
             *     } else {
             *         parent[p] = q; // Link p to q
             *         size[q] = size[p] + size[q];
             *     }
             * }
             */
             
             /*
            // WEIGHTED UNION part 1: find(ua) - find root of ua
            S_UNION_FIND_A: begin
                if (parent[ua] == ua) begin
                    ra <= ua;
                    state <= S_UNION_FIND_B;
                end else begin
                    ua <= parent[ua];
                end
            end

            // WEIGHTED UNION part 2: find(ub) - find root of ub
            S_UNION_FIND_B: begin
                if (parent[ub] == ub) begin
                    rb <= ub;
                    state <= S_UNION_ATTACH;
                end else begin
                    ub <= parent[ub];
                end
            end
            */
            
            // WEIGHTED UNION part 3: attach lower-rank under higher-rank (and bump rank on tie)
            S_UNION_ATTACH: begin
                if (ua == ub) begin // assert to be unreachable but defensive measure
                    state <= S_LABEL_WRITE; // nothing to do
                end else if (rank[ua] >= rank[ub]) begin
                    parent[ub] <= ua; // attach ub -> ua
                    if (rank[ua] == rank[ub]) begin
                        rank[ua] <= rank[ua] + 1;
                    end
                    state <= S_UNION_MERGE_0;
                end else begin
                    parent[ua] <= ub; // attach ua -> ub
                    // swap ua and ub so that ua is always the winner (the root that remains)
                    ua <= ub;
                    ub <= ua;
                    state <= S_UNION_MERGE_0;
                end
                // if (ra == rb) begin // i can assert this is unreachable but i will leave it in for explicity
                //     state <= S_LABEL_WRITE; // nothing to do
                // end else if (rank[ra] < rank[rb]) begin
                //     parent[ra] <= rb; // attach ra -> rb
                //     // merge stats ra -> rb in next states
                //     ua <= rb; ub <= ra; // reuse ua = winner, ub = loser
                //     state <= S_UNION_MERGE_0;
                // end else if (rank[ra] > rank[rb]) begin
                //     parent[rb] <= ra; // attach rb -> ra
                //     ua <= ra; ub <= rb;
                //     state <= S_UNION_MERGE_0;
                // end else begin
                //     parent[rb] <= ra; // attach rb -> ra and bump rank
                //     rank[ra] <= rank[ra] + 1;
                //     ua <= ra; ub <= rb;
                //     state <= S_UNION_MERGE_0;
                // end
            end

            // UNION: merge stats ub -> ua (spread across clock cycles as now so that 
            // can finish within 1 clock cycle. May be a problem need to test)
            S_UNION_MERGE_0: begin
                // pre-compute new area for leaderboard
                ua_area_new = area[ua] + area[ub];
                area[ua] <= ua_area_new;
                sum_x[ua] <= sum_x[ua] + sum_x[ub];
                sum_y[ua] <= sum_y[ua] + sum_y[ub];
                active_root[ub] <= 0; // ub is no longer a root (independent component) after union-ed

                // remove ub from leaderboard
                if (slot0 == ub) begin slot0 <= 0; slot0_area <= 0; end
                if (slot1 == ub) begin slot1 <= 0; slot1_area <= 0; end
                if (slot2 == ub) begin slot2 <= 0; slot2_area <= 0; end
                if (slot3 == ub) begin slot3 <= 0; slot3_area <= 0; end

                // refresh/insert ua with new area (area increased by area[ub], need to update leaderboard)
                // if (ua_area_new >= MIN_AREA) begin
                //     if (slot0 == ua) slot0_area <= ua_area_new;
                //     else if (slot1 == ua) slot1_area <= ua_area_new;
                //     else if (slot2 == ua) slot2_area <= ua_area_new;
                //     else if (slot3 == ua) slot3_area <= ua_area_new;
                //     else if (slot0 == 0) begin slot0 <= ua; slot0_area <= ua_area_new; end
                //     else if (slot1 == 0) begin slot1 <= ua; slot1_area <= ua_area_new; end
                //     else if (slot2 == 0) begin slot2 <= ua; slot2_area <= ua_area_new; end
                //     else if (slot3 == 0) begin slot3 <= ua; slot3_area <= ua_area_new; end
                //     else begin
                //         // replace current min if ua is bigger
                //         min_area_tmp = slot0_area; 
                //         min_idx_tmp = 0;
                //         if (slot1_area < min_area_tmp) begin min_area_tmp = slot1_area; min_idx_tmp = 1; end
                //         if (slot2_area < min_area_tmp) begin min_area_tmp = slot2_area; min_idx_tmp = 2; end
                //         if (slot3_area < min_area_tmp) begin min_area_tmp = slot3_area; min_idx_tmp = 3; end
                //         if (ua_area_new > min_area_tmp) begin
                //             case (min_idx_tmp)
                //                 0: begin slot0 <= ua; slot0_area <= ua_area_new; end
                //                 1: begin slot1 <= ua; slot1_area <= ua_area_new; end
                //                 2: begin slot2 <= ua; slot2_area <= ua_area_new; end
                //                 default: begin slot3 <= ua; slot3_area <= ua_area_new; end
                //             endcase
                //         end
                //     end
                // end
                state <= S_UNION_MERGE_1;
            end
            S_UNION_MERGE_1: begin
                if (min_x[ub] < min_x[ua]) begin
                    min_x[ua] <= min_x[ub];
                end
                if (min_y[ub] < min_y[ua]) begin
                    min_y[ua] <= min_y[ub];
                end
                state <= S_UNION_MERGE_2;
            end
            S_UNION_MERGE_2: begin
                if (max_x[ub] > max_x[ua]) begin
                    max_x[ua] <= max_x[ub];
                end
                if (max_y[ub] > max_y[ua]) begin
                    max_y[ua] <= max_y[ub];
                end
                state <= S_UNION_MERGE_3;
            end
            S_UNION_MERGE_3: begin
                // clear loser root's stats
                area[ub] <= 0; 
                sum_x[ub] <= 0; 
                sum_y[ub] <= 0;
                min_x[ub] <= {x_bitsize{1'b1}}; 
                min_y[ub] <= {y_bitsize{1'b1}};
                max_x[ub] <= 0; 
                max_y[ub] <= 0;

                // Update "best" after merge is fully reflected
                // If previous best was ub, point to ua now
                // if (best_lbl == ub) begin
                //     best_lbl <= ua;
                // end

                state <= S_LABEL_WRITE;
            end

            // Write not the label but the root directly to current pixel and add current pixel to stats
            S_LABEL_WRITE: begin
                // Write label
                case (toggle_line)
                    // 0: row1_labels[x] <= R;
                    // 1: row0_labels[x] <= R;
                    0: row1_labels[x] <= ua;
                    1: row0_labels[x] <= ua;
                endcase

                // Add pixel to stats of ua
                ua_area_new = area[ua] + 1;
                area[ua] <= ua_area_new;
                sum_x[ua] <= sum_x[ua] + x;
                sum_y[ua] <= sum_y[ua] + y;
                if (x < min_x[ua]) begin
                    min_x[ua] <= x;
                end
                if (x > max_x[ua]) begin
                    max_x[ua] <= x;
                end
                if (y < min_y[ua]) begin
                    min_y[ua] <= y;
                end
                if (y > max_y[ua]) begin
                    max_y[ua] <= y;
                end

                // if (ua_area_new > best_area) begin
                //     best_area <= ua_area_new;
                //     best_lbl <= ua;
                //     bbox_left = (x < min_x[ua]) ? x : min_x[ua];
                //     bbox_right = (x > max_x[ua]) ? x : max_x[ua];
                //     bbox_top = (y < min_y[ua]) ? y : min_y[ua];
                //     bbox_bottom = (y > max_y[ua]) ? y : max_y[ua];
                //     centroid_x <= (bbox_left + bbox_right) >> 1;
                //     centroid_y <= (bbox_top + bbox_bottom) >> 1;
                // end

                // leaderboard update for ua (post +1 pixel)
                if (ua_area_new >= MIN_AREA_RT) begin
                    if (slot0 == ua) slot0_area <= ua_area_new;
                    else if (slot1 == ua) slot1_area <= ua_area_new;
                    else if (slot2 == ua) slot2_area <= ua_area_new;
                    else if (slot3 == ua) slot3_area <= ua_area_new;
                    else if (slot0 == 0) begin slot0 <= ua; slot0_area <= ua_area_new; end
                    else if (slot1 == 0) begin slot1 <= ua; slot1_area <= ua_area_new; end
                    else if (slot2 == 0) begin slot2 <= ua; slot2_area <= ua_area_new; end
                    else if (slot3 == 0) begin slot3 <= ua; slot3_area <= ua_area_new; end
                    else begin
                        min_area_tmp = slot0_area; 
                        min_idx_tmp = 0;
                        if (slot1_area < min_area_tmp) begin min_area_tmp = slot1_area; min_idx_tmp = 1; end
                        if (slot2_area < min_area_tmp) begin min_area_tmp = slot2_area; min_idx_tmp = 2; end
                        if (slot3_area < min_area_tmp) begin min_area_tmp = slot3_area; min_idx_tmp = 3; end
                        if (ua_area_new > min_area_tmp) begin
                            case (min_idx_tmp)
                                0: begin slot0 <= ua; slot0_area <= ua_area_new; end
                                1: begin slot1 <= ua; slot1_area <= ua_area_new; end
                                2: begin slot2 <= ua; slot2_area <= ua_area_new; end
                                default: begin slot3 <= ua; slot3_area <= ua_area_new; end
                            endcase
                        end
                    end
                end

                state <= S_ADVANCE;
            end

            // Advance x; y/toggle handled by external line_start (already toggled in READY)
            S_ADVANCE: begin
                x <= x + 1;
                // if (frame_end_accepted_pixel) begin
                //     frame_end_accepted_pixel <= 1'b0;
                    state <= S_COMP0;
                // end else begin
                //     state <= S_READY;
                // end
            end

            // snapshot one component per cycle to ease timing
            S_COMP0: begin
                // (LSB chunk)
                if (slot0!=0 && active_root[slot0] && area[slot0] >= MIN_AREA) begin
                    comp3210_left[9:0] = min_x[slot0];
                    comp3210_right[9:0] = max_x[slot0];
                    comp3210_top[8:0] = min_y[slot0];
                    comp3210_bottom[8:0] = max_y[slot0];
                    comp3210_cx[9:0] <= (min_x[slot0] + max_x[slot0]) >> 1;
                    comp3210_cy[8:0] <= (min_y[slot0] + max_y[slot0]) >> 1;
                    comp3210_area[15:0] <= area[slot0][15:0];

            //     if (!sort_by_prox) begin
            //         if (slot0!=0 && active_root[slot0] && area[slot0] >= MIN_AREA_RT) begin
            //             comp3210_left[9:0] = min_x[slot0];
            //             comp3210_right[9:0] = max_x[slot0];
            //             comp3210_top[8:0] = min_y[slot0];
            //             comp3210_bottom[8:0] = max_y[slot0];
            //             comp3210_cx[9:0] <= (min_x[slot0] + max_x[slot0]) >> 1;
            //             comp3210_cy[8:0] <= (min_y[slot0] + max_y[slot0]) >> 1;
            //             comp3210_area[15:0] <= area[slot0][15:0];
            //         end
            //         state <= S_COMP1;
            //     end else begin
            //         // Compute validity and distances
            //         v0 <= (slot0!=0) && active_root[slot0] && (area[slot0] >= MIN_AREA_RT);
            //         v1 <= (slot1!=0) && active_root[slot1] && (area[slot1] >= MIN_AREA_RT);
            //         v2 <= (slot2!=0) && active_root[slot2] && (area[slot2] >= MIN_AREA_RT);
            //         v3 <= (slot3!=0) && active_root[slot3] && (area[slot3] >= MIN_AREA_RT);
            //         prox_cx0 <= (min_x[slot0] + max_x[slot0]) >> 1; prox_cy0 <= (min_y[slot0] + max_y[slot0]) >> 1;
            //         prox_cx1 <= (min_x[slot1] + max_x[slot1]) >> 1; prox_cy1 <= (min_y[slot1] + max_y[slot1]) >> 1;
            //         prox_cx2 <= (min_x[slot2] + max_x[slot2]) >> 1; prox_cy2 <= (min_y[slot2] + max_y[slot2]) >> 1;
            //         prox_cx3 <= (min_x[slot3] + max_x[slot3]) >> 1; prox_cy3 <= (min_y[slot3] + max_y[slot3]) >> 1;
            //   // Compute absolute deltas (blocking assigns for intra-cycle math)
            //   dx0 = (prox_cx0 >= 155) ? (prox_cx0 - 155) : (155 - prox_cx0);
            //   dy0 = ({1'b0,prox_cy0} >= 120) ? ({1'b0,prox_cy0} - 120) : (120 - {1'b0,prox_cy0});
            //   dx1 = (prox_cx1 >= 155) ? (prox_cx1 - 155) : (155 - prox_cx1);
            //   dy1 = ({1'b0,prox_cy1} >= 120) ? ({1'b0,prox_cy1} - 120) : (120 - {1'b0,prox_cy1});
            //   dx2 = (prox_cx2 >= 155) ? (prox_cx2 - 155) : (155 - prox_cx2);
            //   dy2 = ({1'b0,prox_cy2} >= 120) ? ({1'b0,prox_cy2} - 120) : (120 - {1'b0,prox_cy2});
            //   dx3 = (prox_cx3 >= 155) ? (prox_cx3 - 155) : (155 - prox_cx3);
            //   dy3 = ({1'b0,prox_cy3} >= 120) ? ({1'b0,prox_cy3} - 120) : (120 - {1'b0,prox_cy3});
            //         // Manhattan distance (no multiplies) as proximity metric
            //         d0 <= dx0 + dy0;
            //         d1 <= dx1 + dy1;
            //         d2 <= dx2 + dy2;
            //         d3 <= dx3 + dy3;
            //         // Compute order indices by simple selection
            //         // Pick ord0
            //         curr_min_d <= 20'hFFFFF; curr_sel <= 2'd0;
            //         if (v0 && d0 < curr_min_d) begin curr_min_d <= d0; curr_sel <= 2'd0; end
            //         if (v1 && d1 < curr_min_d) begin curr_min_d <= d1; curr_sel <= 2'd1; end
            //         if (v2 && d2 < curr_min_d) begin curr_min_d <= d2; curr_sel <= 2'd2; end
            //         if (v3 && d3 < curr_min_d) begin curr_min_d <= d3; curr_sel <= 2'd3; end
            //         ord0 <= curr_sel;
            //         // For ord1..ord3, a coarse approach: fixed precedence if equal; recompute masks
            //         // Mask out chosen and select next
            //         // Compute prox_valid_n and allowed_n
            //         prox_valid_n <= v0 + v1 + v2 + v3;
            //         allowed_n <= {1'b0, max_boxes_sel} + 3'd1;

            //         // Write first output if within allowed range
            //         if (allowed_n >= 3'd1) begin
            //             case (curr_sel)
            //                 2'd0: begin
            //                     comp3210_left[9:0] = min_x[slot0]; comp3210_right[9:0] = max_x[slot0];
            //                     comp3210_top[8:0] = min_y[slot0];  comp3210_bottom[8:0] = max_y[slot0];
            //                     comp3210_cx[9:0] <= prox_cx0;      comp3210_cy[8:0] <= prox_cy0;
            //                     comp3210_area[15:0] <= area[slot0][15:0];
            //                     v0 <= 1'b0;
            //                 end
            //                 2'd1: begin
            //                     comp3210_left[9:0] = min_x[slot1]; comp3210_right[9:0] = max_x[slot1];
            //                     comp3210_top[8:0] = min_y[slot1];  comp3210_bottom[8:0] = max_y[slot1];
            //                     comp3210_cx[9:0] <= prox_cx1;      comp3210_cy[8:0] <= prox_cy1;
            //                     comp3210_area[15:0] <= area[slot1][15:0];
            //                     v1 <= 1'b0;
            //                 end
            //                 2'd2: begin
            //                     comp3210_left[9:0] = min_x[slot2]; comp3210_right[9:0] = max_x[slot2];
            //                     comp3210_top[8:0] = min_y[slot2];  comp3210_bottom[8:0] = max_y[slot2];
            //                     comp3210_cx[9:0] <= prox_cx2;      comp3210_cy[8:0] <= prox_cy2;
            //                     comp3210_area[15:0] <= area[slot2][15:0];
            //                     v2 <= 1'b0;
            //                 end
            //                 default: begin
            //                     comp3210_left[9:0] = min_x[slot3]; comp3210_right[9:0] = max_x[slot3];
            //                     comp3210_top[8:0] = min_y[slot3];  comp3210_bottom[8:0] = max_y[slot3];
            //                     comp3210_cx[9:0] <= prox_cx3;      comp3210_cy[8:0] <= prox_cy3;
            //                     comp3210_area[15:0] <= area[slot3][15:0];
            //                     v3 <= 1'b0;
            //                 end
            //             endcase
            //         end
            //         // Move on
            //         state <= S_COMP1;
                end
                state <= S_COMP1;
            end
            S_COMP1: begin
                 if (slot1!=0 && active_root[slot1] && area[slot1] >= MIN_AREA) begin
                    comp3210_left[19:10] = min_x[slot1];
                    comp3210_right[19:10] = max_x[slot1];
                    comp3210_top[17:9] = min_y[slot1];
                    comp3210_bottom[17:9] = max_y[slot1];
                    comp3210_cx[19:10] <= (min_x[slot1] + max_x[slot1]) >> 1;
                    comp3210_cy[17:9] <= (min_y[slot1] + max_y[slot1]) >> 1;
                    comp3210_area[31:16] <= area[slot1][15:0];
                // if (!sort_by_prox) begin
                //     if (slot1!=0 && active_root[slot1] && area[slot1] >= MIN_AREA_RT) begin
                //         comp3210_left[19:10] = min_x[slot1];
                //         comp3210_right[19:10] = max_x[slot1];
                //         comp3210_top[17:9] = min_y[slot1];
                //         comp3210_bottom[17:9] = max_y[slot1];
                //         comp3210_cx[19:10] <= (min_x[slot1] + max_x[slot1]) >> 1;
                //         comp3210_cy[17:9] <= (min_y[slot1] + max_y[slot1]) >> 1;
                //         comp3210_area[31:16] <= area[slot1][15:0];
                //     end
                // end else begin
                //     if (allowed_n >= 3'd2) begin
                //         // Pick next among remaining v*
                //         curr_min_d <= 20'hFFFFF; curr_sel <= 2'd0;
                //         if (v0 && d0 < curr_min_d) begin curr_min_d <= d0; curr_sel <= 2'd0; end
                //         if (v1 && d1 < curr_min_d) begin curr_min_d <= d1; curr_sel <= 2'd1; end
                //         if (v2 && d2 < curr_min_d) begin curr_min_d <= d2; curr_sel <= 2'd2; end
                //         if (v3 && d3 < curr_min_d) begin curr_min_d <= d3; curr_sel <= 2'd3; end
                //         ord1 <= curr_sel;
                //         case (curr_sel)
                //             2'd0: begin
                //                 comp3210_left[19:10] = min_x[slot0]; comp3210_right[19:10] = max_x[slot0];
                //                 comp3210_top[17:9] = min_y[slot0];  comp3210_bottom[17:9] = max_y[slot0];
                //                 comp3210_cx[19:10] <= prox_cx0;     comp3210_cy[17:9] <= prox_cy0;
                //                 comp3210_area[31:16] <= area[slot0][15:0];
                //                 v0 <= 1'b0;
                //             end
                //             2'd1: begin
                //                 comp3210_left[19:10] = min_x[slot1]; comp3210_right[19:10] = max_x[slot1];
                //                 comp3210_top[17:9] = min_y[slot1];  comp3210_bottom[17:9] = max_y[slot1];
                //                 comp3210_cx[19:10] <= prox_cx1;     comp3210_cy[17:9] <= prox_cy1;
                //                 comp3210_area[31:16] <= area[slot1][15:0];
                //                 v1 <= 1'b0;
                //             end
                //             2'd2: begin
                //                 comp3210_left[19:10] = min_x[slot2]; comp3210_right[19:10] = max_x[slot2];
                //                 comp3210_top[17:9] = min_y[slot2];  comp3210_bottom[17:9] = max_y[slot2];
                //                 comp3210_cx[19:10] <= prox_cx2;     comp3210_cy[17:9] <= prox_cy2;
                //                 comp3210_area[31:16] <= area[slot2][15:0];
                //                 v2 <= 1'b0;
                //             end
                //             default: begin
                //                 comp3210_left[19:10] = min_x[slot3]; comp3210_right[19:10] = max_x[slot3];
                //                 comp3210_top[17:9] = min_y[slot3];  comp3210_bottom[17:9] = max_y[slot3];
                //                 comp3210_cx[19:10] <= prox_cx3;     comp3210_cy[17:9] <= prox_cy3;
                //                 comp3210_area[31:16] <= area[slot3][15:0];
                //                 v3 <= 1'b0;
                //             end
                //         endcase
                //     end
                end
                state <= S_COMP2;
            end
            S_COMP2: begin
                if (slot2!=0 && active_root[slot2] && area[slot2] >= MIN_AREA) begin
                    comp3210_left[29:20] = min_x[slot2];
                    comp3210_right[29:20] = max_x[slot2];
                    comp3210_top[26:18] = min_y[slot2];
                    comp3210_bottom[26:18] = max_y[slot2];
                    comp3210_cx[29:20] <= (min_x[slot2] + max_x[slot2]) >> 1;
                    comp3210_cy[26:18] <= (min_y[slot2] + max_y[slot2]) >> 1;
                    comp3210_area[47:32] <= area[slot2][15:0];
                // if (!sort_by_prox) begin
                //     if (slot2!=0 && active_root[slot2] && area[slot2] >= MIN_AREA_RT) begin
                //         comp3210_left[29:20] = min_x[slot2];
                //         comp3210_right[29:20] = max_x[slot2];
                //         comp3210_top[26:18] = min_y[slot2];
                //         comp3210_bottom[26:18] = max_y[slot2];
                //         comp3210_cx[29:20] <= (min_x[slot2] + max_x[slot2]) >> 1;
                //         comp3210_cy[26:18] <= (min_y[slot2] + max_y[slot2]) >> 1;
                //         comp3210_area[47:32] <= area[slot2][15:0];
                //     end
                // end else begin
                //     if (allowed_n >= 3'd3) begin
                //         curr_min_d <= 20'hFFFFF; curr_sel <= 2'd0;
                //         if (v0 && d0 < curr_min_d) begin curr_min_d <= d0; curr_sel <= 2'd0; end
                //         if (v1 && d1 < curr_min_d) begin curr_min_d <= d1; curr_sel <= 2'd1; end
                //         if (v2 && d2 < curr_min_d) begin curr_min_d <= d2; curr_sel <= 2'd2; end
                //         if (v3 && d3 < curr_min_d) begin curr_min_d <= d3; curr_sel <= 2'd3; end
                //         ord2 <= curr_sel;
                //         case (curr_sel)
                //             2'd0: begin
                //                 comp3210_left[29:20] = min_x[slot0]; comp3210_right[29:20] = max_x[slot0];
                //                 comp3210_top[26:18] = min_y[slot0];  comp3210_bottom[26:18] = max_y[slot0];
                //                 comp3210_cx[29:20] <= prox_cx0;     comp3210_cy[26:18] <= prox_cy0;
                //                 comp3210_area[47:32] <= area[slot0][15:0];
                //                 v0 <= 1'b0;
                //             end
                //             2'd1: begin
                //                 comp3210_left[29:20] = min_x[slot1]; comp3210_right[29:20] = max_x[slot1];
                //                 comp3210_top[26:18] = min_y[slot1];  comp3210_bottom[26:18] = max_y[slot1];
                //                 comp3210_cx[29:20] <= prox_cx1;     comp3210_cy[26:18] <= prox_cy1;
                //                 comp3210_area[47:32] <= area[slot1][15:0];
                //                 v1 <= 1'b0;
                //             end
                //             2'd2: begin
                //                 comp3210_left[29:20] = min_x[slot2]; comp3210_right[29:20] = max_x[slot2];
                //                 comp3210_top[26:18] = min_y[slot2];  comp3210_bottom[26:18] = max_y[slot2];
                //                 comp3210_cx[29:20] <= prox_cx2;     comp3210_cy[26:18] <= prox_cy2;
                //                 comp3210_area[47:32] <= area[slot2][15:0];
                //                 v2 <= 1'b0;
                //             end
                //             default: begin
                //                 comp3210_left[29:20] = min_x[slot3]; comp3210_right[29:20] = max_x[slot3];
                //                 comp3210_top[26:18] = min_y[slot3];  comp3210_bottom[26:18] = max_y[slot3];
                //                 comp3210_cx[29:20] <= prox_cx3;     comp3210_cy[26:18] <= prox_cy3;
                //                 comp3210_area[47:32] <= area[slot3][15:0];
                //                 v3 <= 1'b0;
                //             end
                //         endcase
                //     end
                end
                state <= S_COMP3;
            end
            S_COMP3: begin
                // (MSB chunk)
                if (slot2!=0 && active_root[slot2] && area[slot2] >= MIN_AREA) begin
                    comp3210_left[29:20] = min_x[slot2];
                    comp3210_right[29:20] = max_x[slot2];
                    comp3210_top[26:18] = min_y[slot2];
                    comp3210_bottom[26:18] = max_y[slot2];
                    comp3210_cx[29:20] <= (min_x[slot2] + max_x[slot2]) >> 1;
                    comp3210_cy[26:18] <= (min_y[slot2] + max_y[slot2]) >> 1;
                    comp3210_area[47:32] <= area[slot2][15:0];
                // if (!sort_by_prox) begin
                //     if (slot3!=0 && active_root[slot3] && area[slot3] >= MIN_AREA_RT) begin
                //         comp3210_left [39:30] = min_x[slot3];
                //         comp3210_right [39:30] = max_x[slot3];
                //         comp3210_top[35:27] = min_y[slot3];
                //         comp3210_bottom[35:27] = max_y[slot3];
                //         comp3210_cx[39:30] <= (min_x[slot3] + max_x[slot3]) >> 1;
                //         comp3210_cy[35:27] <= (min_y[slot3] + max_y[slot3]) >> 1;
                //         comp3210_area[63:48] <= area[slot3][15:0];
                //     end
                // end else begin
                //     if (allowed_n >= 3'd4) begin
                //         curr_min_d <= 20'hFFFFF; curr_sel <= 2'd0;
                //         if (v0 && d0 < curr_min_d) begin curr_min_d <= d0; curr_sel <= 2'd0; end
                //         if (v1 && d1 < curr_min_d) begin curr_min_d <= d1; curr_sel <= 2'd1; end
                //         if (v2 && d2 < curr_min_d) begin curr_min_d <= d2; curr_sel <= 2'd2; end
                //         if (v3 && d3 < curr_min_d) begin curr_min_d <= d3; curr_sel <= 2'd3; end
                //         ord3 <= curr_sel;
                //         case (curr_sel)
                //             2'd0: begin
                //                 comp3210_left[39:30] = min_x[slot0]; comp3210_right[39:30] = max_x[slot0];
                //                 comp3210_top[35:27] = min_y[slot0];  comp3210_bottom[35:27] = max_y[slot0];
                //                 comp3210_cx[39:30] <= prox_cx0;     comp3210_cy[35:27] <= prox_cy0;
                //                 comp3210_area[63:48] <= area[slot0][15:0];
                //             end
                //             2'd1: begin
                //                 comp3210_left[39:30] = min_x[slot1]; comp3210_right[39:30] = max_x[slot1];
                //                 comp3210_top[35:27] = min_y[slot1];  comp3210_bottom[35:27] = max_y[slot1];
                //                 comp3210_cx[39:30] <= prox_cx1;     comp3210_cy[35:27] <= prox_cy1;
                //                 comp3210_area[63:48] <= area[slot1][15:0];
                //             end
                //             2'd2: begin
                //                 comp3210_left[39:30] = min_x[slot2]; comp3210_right[39:30] = max_x[slot2];
                //                 comp3210_top[35:27] = min_y[slot2];  comp3210_bottom[35:27] = max_y[slot2];
                //                 comp3210_cx[39:30] <= prox_cx2;     comp3210_cy[35:27] <= prox_cy2;
                //                 comp3210_area[63:48] <= area[slot2][15:0];
                //             end
                //             default: begin
                //                 comp3210_left[39:30] = min_x[slot3]; comp3210_right[39:30] = max_x[slot3];
                //                 comp3210_top[35:27] = min_y[slot3];  comp3210_bottom[35:27] = max_y[slot3];
                //                 comp3210_cx[39:30] <= prox_cx3;     comp3210_cy[35:27] <= prox_cy3;
                //                 comp3210_area[63:48] <= area[slot3][15:0];
                //             end
                //         endcase
                //     end
                end
                state <= S_COMPS_DONE;
            end
            S_COMPS_DONE: begin
                // compute comp_count
                // if (!sort_by_prox) begin
                    comp_count <=
                        ((slot0!=0) && active_root[slot0] && (area[slot0] >= MIN_AREA_RT)) +
                        ((slot1!=0) && active_root[slot1] && (area[slot1] >= MIN_AREA_RT)) +
                        ((slot2!=0) && active_root[slot2] && (area[slot2] >= MIN_AREA_RT)) +
                        ((slot3!=0) && active_root[slot3] && (area[slot3] >= MIN_AREA_RT));
                // end else begin
                //     // clamp by allowed_n in proximity mode
                //     comp_count <= (prox_valid_n > allowed_n) ? allowed_n : prox_valid_n;
                // end
                state <= S_READY;
            end

            default: state <= S_READY;
            endcase
        end
    end
endmodule



// // module UFDS_Detector(
//     input clk,
//     input ext_reset,

//     // since image comes in serially, one pixel per clock. I put these as some sort of
//     // handshake in signals to know when a new frame starts and ends
//     // and also when a new line starts and when each pixel is valid
//     input  wire in_valid,      // 1 during active pixels
//     input  wire frame_start,   // pulse at first active pixel
//     input  wire line_start,    // pulse at first pixel of each line
//     input  wire frame_end,     // pulse after last active pixel
//     input  wire curr_pix,      // every pixel that is coming in

//     // output reg [8:0] bbox_left,
//     // output reg [8:0] bbox_right,
//     // output reg [7:0] bbox_top,
//     // output reg [7:0] bbox_bottom,
//     // output reg [8:0] centroid_x,
//     // output reg [7:0] centroid_y,

//     output wire ready_to_read,

//     // 4 component output (it will be the 4 largest components detected)
//     output reg  [2:0]  comp_count, // numer of valid components
//     output reg  [8:0]  comp0_left, comp1_left, comp2_left, comp3_left,
//     output reg  [8:0]  comp0_right, comp1_right, comp2_right, comp3_right,
//     output reg  [7:0]  comp0_top, comp1_top, comp2_top, comp3_top,
//     output reg  [7:0]  comp0_bottom,comp1_bottom,comp2_bottom,comp3_bottom,
//     output reg  [8:0]  comp0_cx, comp1_cx, comp2_cx, comp3_cx,
//     output reg  [7:0]  comp0_cy, comp1_cy, comp2_cy, comp3_cy,
//     output reg  [15:0] comp0_area, comp1_area, comp2_area, comp3_area

// );

// localparam integer MAX_OUT = 4;
// localparam integer MIN_AREA = 4; // to filter out components with area less than this

// localparam integer WIDTH = 320;
// localparam integer HEIGHT = 240;
// localparam integer x_bitsize = 9;
// localparam integer y_bitsize = 8;
// localparam integer label_bits = 12; // rmb label == 0 is the background and supports up to 4095 labels (can reduce if dont need this many labels)

// // current pixel coordinates (increment x each pixel, on line_start x=0 and y increment by 1)
// reg [x_bitsize-1:0] x;
// reg [y_bitsize-1:0] y;

// /* 
//  *UFDS need to check neighbours' labels, we use 2 lines of buffer (reduced neighbours) 
//  * to store labels temporarily for comparison
//  * get away using only two (inspiration from mergesort haha to reduce space complexity)
//  * just swap the roles of these two after every row (using toggle_line 0: prev=buff0, curr=buff1; 1: prev=buff1, curr=buff0)
//  * each entry stores the component ID
// */
// reg [label_bits-1:0] row0_labels[0:WIDTH-1];
// reg [label_bits-1:0] row1_labels[0:WIDTH-1];
// reg toggle_line; // 0: prev=buff0, curr=buff1; 1: prev=buff1, curr=buff0

// /*
//  * Quick-Union Disjoint Set ADT implementation (specifically weighted union) 
//  * and the stats to store for each label
//  */
// localparam integer MAX_LABELS = 1024; // can reduce if dont need this many labels
// localparam integer FIND_MAX_ITERATIONS = 8; // to prevent infinite loop in find, since loops in functions are combinational. Height of tree is O(log n) = 4

// reg [label_bits-1:0] parent [0:MAX_LABELS-1]; // C++ eq: vector<int> parent (MAX_LABELS);
// reg [3:0] rank [0:MAX_LABELS-1]; // C++ eq: vector<int> rank (MAX_LABELS); 
// reg active_root [0:MAX_LABELS-1]; // boolean array marking whether a component ID is in use as a root
// reg [label_bits-1:0] next_label; // next unused label n0.

// // stats for each component (hence only store for root pixel, where parent[label] == label)
// // centroid_x = sum_x / area ; centroid_y = sum_y / area
// reg [23:0] area [0:MAX_LABELS-1]; // number of pixels in this component
// reg [31:0] sum_x [0:MAX_LABELS-1]; // sum of x coordinates of pixels in this component
// reg [31:0] sum_y [0:MAX_LABELS-1]; // sum of y coordinates of pixels in this component
// reg [x_bitsize-1:0] min_x [0:MAX_LABELS-1]; 
// reg [x_bitsize-1:0] max_x [0:MAX_LABELS-1]; 
// reg [y_bitsize-1:0] min_y [0:MAX_LABELS-1]; 
// reg [y_bitsize-1:0] max_y [0:MAX_LABELS-1]; 


// // retrieve the reduced neighbour pixel's labels 
// wire [label_bits-1:0] left_label = (x == 0) ? 0 : 
//                                    (toggle_line == 0) ? row1_labels[x-1] : row0_labels[x-1];
// wire [label_bits-1:0] up_label = (y == 0) ? 0 : 
//                                    (toggle_line == 0) ? row0_labels[x] : row1_labels[x];
// wire [label_bits-1:0] upleft_label = (x == 0 || y == 0) ? 0 : 
//                                    (toggle_line == 0) ? row0_labels[x-1] : row1_labels[x-1];
// wire [label_bits-1:0] upright_label = (x == WIDTH-1 || y == 0) ? 0 : 
//                                    (toggle_line == 0) ? row0_labels[x+1] : row1_labels[x+1];

// // temporary registers to read and write neighbour labels
// reg [label_bits-1:0] left;
// reg [label_bits-1:0] up;
// reg [label_bits-1:0] upleft;
// reg [label_bits-1:0] upright;
// reg [label_bits-1:0] root_left;
// reg [label_bits-1:0] root_up;
// reg [label_bits-1:0] root_upleft;
// reg [label_bits-1:0] root_upright;
// reg [label_bits-1:0] R; // final root label for current pixel
// reg [label_bits-1:0] R_next; // temp to get next smallest root

// // temporary counters to help me walk along the width and labels during a sweep, to not touch global ref for x coord 
// reg [x_bitsize-1:0] init_width_idx;
// reg [label_bits-1:0] init_label_idx;

// // temporary registers to help in find() aka the find engine
// // reg [label_bits-1:0] find_curr; // used in S_FIND_* states to follow parents to find root of component iteratively

// // temporary registers to help in union() aka the union engine (which uses find engine twice, then attach and merge stats)
// reg [label_bits-1:0] ua, ub; // inputs
// reg [label_bits-1:0] ra, rb; // roots

// // wire [label_bits-1:0] parent_curr = parent[find_curr];
// // wire [label_bits-1:0] rootR_now = (parent[R]==R) ? R : parent[R]; // root of R now (after a union)

// reg [label_bits-1:0] tmp;
// reg curr_pix_q;
// reg frame_end_accepted_pixel; // latch frame_end with accepted pixel

// // Post-frame selection registers
// reg [label_bits-1:0] slot0, slot1, slot2, slot3; // to hold the best 4 labels
// reg [23:0] slot0_area, slot1_area, slot2_area, slot3_area; // since we are comparing based on area
// reg [23:0] ua_area_new; // temp
// reg [23:0] min_area_tmp; // temp
// reg [1:0] min_idx_tmp; // temp
 
// // FSM encoding
// reg [4:0] state;
// localparam S_RESET = 0;
// localparam S_INIT_LINES = 1;
// localparam S_INIT_UFDS = 2;
// localparam S_READY = 3;
// localparam S_SAMPLE = 4;
// localparam S_FIND_L = 5;
// localparam S_FIND_L_RD = 6;
// localparam S_FIND_U = 7;
// localparam S_FIND_U_RD = 8;
// localparam S_FIND_UL = 9;
// localparam S_FIND_UL_RD = 10;
// localparam S_FIND_UR = 11;
// localparam S_FIND_UR_RD = 12;
// localparam S_CHOOSE = 13;
// localparam S_ALLOC = 14;
// localparam S_UNION_DECIDE = 15;
// localparam S_UNION_FIND_A = 16;
// localparam S_UNION_FIND_A_RD = 17;
// localparam S_UNION_FIND_B = 18;
// localparam S_UNION_FIND_B_RD = 19;
// localparam S_UNION_ATTACH = 20;
// localparam S_UNION_MERGE_0 = 21;
// localparam S_UNION_MERGE_1 = 22;
// localparam S_UNION_MERGE_2 = 23;
// localparam S_UNION_MERGE_3 = 24;
// localparam S_LABEL_WRITE = 25;
// localparam S_ADVANCE = 26;
// localparam S_REDUCE_INIT = 27;
// localparam S_REDUCE_SCAN = 28;
// localparam S_REDUCE_OUTPUT = 29;

// // FIFO
// assign ready_to_read = (state == S_READY) ? 1'b1 : 1'b0;

// /*
//  * main FSM by per-pixel UFDS sequence
//  */
// always @(posedge clk) begin
//     if (ext_reset) begin
//         x <= 0; y <= 0; toggle_line <= 0;
//         // bbox_left <= 0; bbox_right <= 0; bbox_top <= 0; bbox_bottom <= 0; centroid_x <= 0; centroid_y <= 0;
//         init_width_idx <= 0;
//         init_label_idx <= 0;
//         next_label <= 1;
//         // find_curr <= 0;
//         ua<=0; ub<=0; 
//         // ra<=0; rb<=0;
//         frame_end_accepted_pixel <= 0;
//         slot0 <= 0; slot1 <= 0; slot2 <= 0; slot3 <= 0;
//         slot0_area <= 0; slot1_area <= 0; slot2_area <= 0; slot3_area <= 0;

//         comp_count <= 0;
//         comp0_left <= 0; comp1_left <= 0; comp2_left <= 0; comp3_left <= 0;
//         comp0_right <= 0; comp1_right <= 0; comp2_right <= 0; comp3_right <= 0;
//         comp0_top <= 0; comp1_top <= 0; comp2_top <= 0; comp3_top <= 0;
//         comp0_bottom <= 0; comp1_bottom <= 0; comp2_bottom <= 0; comp3_bottom <= 0;
//         comp0_cx <= 0; comp1_cx <= 0; comp2_cx <= 0; comp3_cx <= 0;
//         comp0_cy <= 0; comp1_cy <= 0; comp2_cy <= 0; comp3_cy <= 0;
//         comp0_area <= 0; comp1_area <= 0; comp2_area <= 0; comp3_area <= 0;

//         state <= S_INIT_LINES; // and later S_INIT_UFDS

//     end else begin
//         // Handle external frame/line strobes for coordinates and toggling
//         if (frame_start) begin
//             x <= 0;
//             y <= 0;
//             toggle_line <= 1'b0;
//             // restart init on new frame
//             // state <= S_INIT_LINES;
//             // init_width_idx <= 0;
//             // init_label_idx <= 0;
//             next_label <= 1;

//             slot0 <= 0; slot1 <= 0; slot2 <= 0; slot3 <= 0;
//             slot0_area <= 0; slot1_area <= 0; slot2_area <= 0; slot3_area <= 0;
//             comp_count <= 0;

//             state <= S_READY;

//         end else if (line_start && state==S_READY) begin
//             x <= 0;
//             y <= y + 1;
//             toggle_line <= ~toggle_line;
//         end

//         case (state)
//             // clear the two line buffers (// for (i = 0; i < WIDTH; i = i + 1) begin
//                                            //             row0_labels[i] <= 0;
//                                            //             row1_labels[i] <= 0;
//                                            //         end)
//             S_INIT_LINES: begin
//                 row0_labels[init_width_idx] <= 0;
//                 row1_labels[init_width_idx] <= 0;
//                 if (init_width_idx == WIDTH-1) begin
//                     init_width_idx <= 0;
//                     state <= S_INIT_UFDS; // clear UFDS values next
//                 end else begin
//                     init_width_idx <= init_width_idx + 1;
//                 end
//             end

//             // clear UFDS related stats
//             S_INIT_UFDS: begin
//                 parent[init_label_idx] <= init_label_idx[label_bits-1:0];
//                 rank[init_label_idx] <= 0;
//                 active_root[init_label_idx] <= 0;
//                 area[init_label_idx] <= 0;
//                 sum_x[init_label_idx] <= 0;
//                 sum_y[init_label_idx] <= 0;
//                 min_x[init_label_idx] <= {x_bitsize{1'b1}}; // mins high
//                 min_y[init_label_idx] <= {y_bitsize{1'b1}};
//                 max_x[init_label_idx] <= 0; // max low
//                 max_y[init_label_idx] <= 0;
//                 if (init_label_idx == MAX_LABELS-1) begin
//                     init_label_idx <= 0;
//                     state <= S_READY;
//                 end else begin
//                     init_label_idx <= init_label_idx + 1;
//                 end
//             end

//             // ready to accept a new pixel and start the whole UFDS process
//             S_READY: begin
//                 if (in_valid) begin
//                     // sample provisional neighbor labels
//                     curr_pix_q <= curr_pix;
//                     frame_end_accepted_pixel <= frame_end;


//                     state <= S_SAMPLE;
//                 end
//             end

//             S_SAMPLE: begin
//                                     left <= left_label;
//                     up <= up_label;
//                     upleft <= upleft_label;
//                     upright <= upright_label;
//                 if (!curr_pix_q) begin
//                     // 0 means label 0 which rep background
//                     case (toggle_line)
//                         0: row1_labels[x] <= 0;
//                         1: row0_labels[x] <= 0;
//                     endcase
//                     state <= S_ADVANCE;
//                 end else begin
//                     // immediately get their roots
//                     root_left <= left;
//                     root_up <= up;
//                     root_upleft <= upleft;
//                     root_upright <= upright;
//                     state <= S_CHOOSE;
//                     // if (x == 0) begin
//                     //     if (y == 0) begin
//                     //         state <= S_CHOOSE; // first pixel of whole frame
//                     //     end else begin
//                     //         state <= S_FIND_U; // no left neighbour
//                     //     end
//                     // end else begin
//                     //     state <= S_FIND_L; // begin find on left neighbor
//                     // end
//                 end
//             end
            
//             /*
//             // find(L)
//             S_FIND_L: begin
//                 if (left != 0) begin
//                     find_curr <= left; 
//                     state <= S_FIND_L_RD;
//                 end else begin
//                     root_left <= 0;
//                     state <= S_FIND_U; // skip to next neighbor
//                 end
//             end
//             S_FIND_L_RD: begin
//                 // one hop per cycle
//                 if (parent_curr == find_curr) begin // root iff parent[curr] == curr
//                     root_left <= find_curr;
//                     state <= S_FIND_U; // go to next neighbor
//                 end else begin
//                     find_curr <= parent_curr;
//                 end
//             end

//             // find(U)
//             S_FIND_U: begin
//                 if (up != 0) begin
//                     find_curr <= up;
//                     state <= S_FIND_U_RD;
//                 end else begin
//                     root_up <= 0;
//                     state <= S_FIND_UL; // skip to next neighbour
//                 end
//             end
//             S_FIND_U_RD: begin
//                 if (parent_curr == find_curr) begin
//                     root_up <= find_curr;
//                     state <= S_FIND_UL;
//                 end else begin
//                     find_curr <= parent_curr;
//                 end
//             end

//             // find(UL)
//             S_FIND_UL: begin
//                 if (upleft != 0) begin
//                     find_curr <= upleft;
//                     state <= S_FIND_UL_RD;
//                 end else begin
//                     root_upleft <= 0;
//                     state <= S_FIND_UR;
//                 end
//             end
//             S_FIND_UL_RD: begin
//                 if (parent_curr == find_curr) begin
//                     root_upleft <= find_curr;
//                     state <= S_FIND_UR;
//                 end else begin
//                     find_curr <= parent_curr;
//                 end
//             end

//             // find(UR)
//             S_FIND_UR: begin
//                 if (upright != 0) begin
//                     find_curr <= upright;
//                     state <= S_FIND_UR_RD;
//                 end else begin
//                     root_upright <= 0;
//                     state <= S_CHOOSE;
//                 end
//             end
//             S_FIND_UR_RD: begin
//                 if (parent_curr == find_curr) begin
//                     root_upright <= find_curr;
//                     state <= S_CHOOSE;
//                 end else begin
//                     find_curr <= parent_curr;
//                 end
//             end
//             */

//             // choose representative for current pixel (smallest non-zero root of all 4 neighbours)
//             S_CHOOSE: begin
//                 R_next = 0;
//                 if (root_left != 0 && (R_next == 0 || root_left < R_next)) begin
//                     R_next = root_left;
//                 end
//                 if (root_up != 0 && (R_next == 0 || root_up < R_next)) begin
//                     R_next = root_up;
//                 end
//                 if (root_upleft != 0 && (R_next == 0 || root_upleft < R_next)) begin
//                     R_next = root_upleft;
//                 end
//                 if (root_upright != 0 && (R_next == 0 || root_upright < R_next)) begin
//                     R_next = root_upright;
//                 end

//                 R <= R_next;
//                 if (R_next == 0) begin
//                     state <= S_ALLOC;
//                 end else begin
//                     state <= S_UNION_DECIDE;
//                 end

//                 // if (root_left != 0) begin
//                 //     R <= root_left;
//                 // end
//                 // if (root_up != 0 && (R == 0 || root_up < R)) begin
//                 //     R <= root_up;
//                 // end
//                 // if (root_upleft != 0 && (R == 0 || root_upleft < R)) begin
//                 //     R <= root_upleft;
//                 // end
//                 // if (root_upright != 0 && (R == 0 || root_upright < R)) begin
//                 //     R <= root_upright;
//                 // end
//                 // if ((root_left | root_up | root_upleft | root_upright) == 0) begin
//                 //     state <= S_ALLOC;
//                 // end else begin
//                 //     state <= S_UNION_DECIDE;
//                 // end
//             end

//             // allocate new label if all 4 neighbours are background (new component found)
//             S_ALLOC: begin
//                 R <= next_label;
//                 ua <= next_label; // ensure use this temp pointer to update stats

//                 // update the stats of this root of a new component to that of only 1 pixel in component
//                 parent[next_label] <= next_label;
//                 rank[next_label] <= 0;
//                 active_root[next_label] <= 1; // this new componentID/label is now used
//                 area[next_label] <= 0;
//                 sum_x[next_label] <= 0;
//                 sum_y[next_label] <= 0;
//                 min_x[next_label] <= {x_bitsize{1'b1}};
//                 min_y[next_label] <= {y_bitsize{1'b1}};
//                 max_x[next_label] <= {x_bitsize{1'b0}};
//                 max_y[next_label] <= {y_bitsize{1'b0}};

//                 if (next_label != MAX_LABELS-1)
//                     next_label <= next_label + 1;

//                 state <= S_LABEL_WRITE;
//             end

//             // pick at most one neighbor to union with (priority L > U > UL > UR)
//             // now operands are already roots, no need to find roots.
//             S_UNION_DECIDE: begin
//                 ua <= R;
//                 if (root_left != 0 && root_left != R) begin 
//                     ub <= root_left; 
//                     // state <= S_UNION_FIND_A; 
//                     state <= S_UNION_ATTACH;
//                 end
//                 else if (root_up != 0 && root_up != R) begin 
//                     ub <= root_up; 
//                     // state <= S_UNION_FIND_A; 
//                     state <= S_UNION_ATTACH;
//                 end
//                 else if (root_upleft != 0 && root_upleft != R) begin 
//                     ub <= root_upleft; 
//                     // state <= S_UNION_FIND_A; 
//                     state <= S_UNION_ATTACH;
//                 end
//                 else if (root_upright != 0 && root_upright != R) begin 
//                     ub <= root_upright; 
//                     // state <= S_UNION_FIND_A; 
//                     state <= S_UNION_ATTACH;
//                 end else begin
//                     state <= S_LABEL_WRITE; // nothing to union
//                 end
//             end

//             /*
//              * union(int p, int q) {
//              *     while (parent[p] !=p) p = parent[p]; // WEIGHTED UNION part 1
//              *     while (parent[q] !=q) q = parent[q]; // WEIGHTED UNION part 2
//              *     // WEIGHTED UNION part 3: attach lower-size under higher-size
//              *     if (size[p] > size[q] {
//              *         parent[q] = p;   // Link q to p
//              *         size[p] = size[p] + size[q];
//              *     } else {
//              *         parent[p] = q; // Link p to q
//              *         size[q] = size[p] + size[q];
//              *     }
//              * }
//              */
             
//              /*
//             // WEIGHTED UNION part 1: find(ua) - find root of ua
//             S_UNION_FIND_A: begin
//                 if (parent[ua] == ua) begin
//                     ra <= ua;
//                     state <= S_UNION_FIND_B;
//                 end else begin
//                     ua <= parent[ua];
//                 end
//             end

//             // WEIGHTED UNION part 2: find(ub) - find root of ub
//             S_UNION_FIND_B: begin
//                 if (parent[ub] == ub) begin
//                     rb <= ub;
//                     state <= S_UNION_ATTACH;
//                 end else begin
//                     ub <= parent[ub];
//                 end
//             end
//             */
            
//             // WEIGHTED UNION part 3: attach lower-rank under higher-rank (and bump rank on tie)
//             S_UNION_ATTACH: begin
//                 if (ua == ub) begin // assert to be unreachable but defensive measure
//                     state <= S_LABEL_WRITE; // nothing to do
//                 end else if (rank[ua] >= rank[ub]) begin
//                     parent[ub] <= ua; // attach ub -> ua
//                     if (rank[ua] == rank[ub]) begin
//                         rank[ua] <= rank[ua] + 1;
//                     end
//                     state <= S_UNION_MERGE_0;
//                 end else begin
//                     parent[ua] <= ub; // attach ua -> ub
//                     // swap ua and ub so that ua is always the winner (the root that remains)
//                     {ua, ub} <= {ub, ua};
//                     // ua <= ub;
//                     // ub <= ua;
//                     state <= S_UNION_MERGE_0;
//                 end
//                 // if (ra == rb) begin // i can assert this is unreachable but i will leave it in for explicity
//                 //     state <= S_LABEL_WRITE; // nothing to do
//                 // end else if (rank[ra] < rank[rb]) begin
//                 //     parent[ra] <= rb; // attach ra -> rb
//                 //     // merge stats ra -> rb in next states
//                 //     ua <= rb; ub <= ra; // reuse ua = winner, ub = loser
//                 //     state <= S_UNION_MERGE_0;
//                 // end else if (rank[ra] > rank[rb]) begin
//                 //     parent[rb] <= ra; // attach rb -> ra
//                 //     ua <= ra; ub <= rb;
//                 //     state <= S_UNION_MERGE_0;
//                 // end else begin
//                 //     parent[rb] <= ra; // attach rb -> ra and bump rank
//                 //     rank[ra] <= rank[ra] + 1;
//                 //     ua <= ra; ub <= rb;
//                 //     state <= S_UNION_MERGE_0;
//                 // end
//             end

//             // UNION: merge stats ub -> ua (spread across clock cycles as now so that 
//             // can finish within 1 clock cycle. May be a problem need to test)
//             S_UNION_MERGE_0: begin
//                                 // merged area (use this value for leaderboard immediately)
//                 ua_area_new = area[ua] + area[ub];

//                 // stats merge
//                 area[ua]   <= ua_area_new;
//                 sum_x[ua]  <= sum_x[ua] + sum_x[ub];
//                 sum_y[ua]  <= sum_y[ua] + sum_y[ub];
//                 active_root[ub] <= 1'b0;

//                 // bbox merge continues in next states
//                 // remove ub from leaderboard if present (do NOT touch comp_count mid-frame)
//                 if (slot0 == ub) begin slot0 <= 0; slot0_area <= 0; end
//                 if (slot1 == ub) begin slot1 <= 0; slot1_area <= 0; end
//                 if (slot2 == ub) begin slot2 <= 0; slot2_area <= 0; end
//                 if (slot3 == ub) begin slot3 <= 0; slot3_area <= 0; end

//                 // refresh/insert ua into leaderboard with new (larger) area
//                 if (ua_area_new >= MIN_AREA) begin
//                     if      (slot0 == ua) slot0_area <= ua_area_new;
//                     else if (slot1 == ua) slot1_area <= ua_area_new;
//                     else if (slot2 == ua) slot2_area <= ua_area_new;
//                     else if (slot3 == ua) slot3_area <= ua_area_new;
//                     else if (slot0 == 0)  begin slot0 <= ua; slot0_area <= ua_area_new; end
//                     else if (slot1 == 0)  begin slot1 <= ua; slot1_area <= ua_area_new; end
//                     else if (slot2 == 0)  begin slot2 <= ua; slot2_area <= ua_area_new; end
//                     else if (slot3 == 0)  begin slot3 <= ua; slot3_area <= ua_area_new; end
//                     else begin
//                         // replace current min if ua is bigger
//                         min_area_tmp = slot0_area; min_idx_tmp = 0;
//                         if (slot1_area < min_area_tmp) begin min_area_tmp = slot1_area; min_idx_tmp = 1; end
//                         if (slot2_area < min_area_tmp) begin min_area_tmp = slot2_area; min_idx_tmp = 2; end
//                         if (slot3_area < min_area_tmp) begin min_area_tmp = slot3_area; min_idx_tmp = 3; end
//                         if (ua_area_new > min_area_tmp) begin
//                             case (min_idx_tmp)
//                                 0: begin slot0 <= ua; slot0_area <= ua_area_new; end
//                                 1: begin slot1 <= ua; slot1_area <= ua_area_new; end
//                                 2: begin slot2 <= ua; slot2_area <= ua_area_new; end
//                                 default: begin slot3 <= ua; slot3_area <= ua_area_new; end
//                             endcase
//                         end
//                     end
//                 end

//                 // area[ua] <= area[ua] + area[ub];
//                 // sum_x[ua] <= sum_x[ua] + sum_x[ub];
//                 // sum_y[ua] <= sum_y[ua] + sum_y[ub];
//                 // active_root[ub] <= 0; // ub is no longer a root after union-ed
//                 // // remove ub from leaderboard if present
//                 // if (slot0 == ub) begin 
//                 //     slot0 <= 0; slot0_area <= 0; 
//                 //     if (comp_count!=0) begin
//                 //         comp_count <= comp_count - 1'b1;
//                 //     end
//                 // end
//                 // if (slot1 == ub) begin 
//                 //     slot1 <= 0; slot1_area <= 0; 
//                 //     if (comp_count!=0) begin
//                 //         comp_count <= comp_count - 1'b1;
//                 //     end
//                 // end
//                 // if (slot2 == ub) begin
//                 //     slot2 <= 0; slot2_area <= 0;
//                 //     if (comp_count!=0) begin
//                 //         comp_count <= comp_count - 1'b1;
//                 //     end
//                 // end
//                 // if (slot3 == ub) begin
//                 //     slot3 <= 0; slot3_area <= 0;
//                 //     if (comp_count!=0) begin
//                 //         comp_count <= comp_count - 1'b1;
//                 //     end
//                 // end
//                 state <= S_UNION_MERGE_1;
//             end
//             S_UNION_MERGE_1: begin
//                 if (min_x[ub] < min_x[ua]) begin
//                     min_x[ua] <= min_x[ub];
//                 end
//                 if (min_y[ub] < min_y[ua]) begin
//                     min_y[ua] <= min_y[ub];
//                 end
//                 state <= S_UNION_MERGE_2;
//             end
//             S_UNION_MERGE_2: begin
//                 if (max_x[ub] > max_x[ua]) begin
//                     max_x[ua] <= max_x[ub];
//                 end
//                 if (max_y[ub] > max_y[ua]) begin
//                     max_y[ua] <= max_y[ub];
//                 end
//                 state <= S_UNION_MERGE_3;
//             end
//             S_UNION_MERGE_3: begin
//                 // clear loser root's stats
//                 area[ub] <= 0; 
//                 sum_x[ub] <= 0; 
//                 sum_y[ub] <= 0;
//                 min_x[ub] <= {x_bitsize{1'b1}}; 
//                 min_y[ub] <= {y_bitsize{1'b1}};
//                 max_x[ub] <= 0; 
//                 max_y[ub] <= 0;
//                 state <= S_LABEL_WRITE;
//             end

//             // write not the label but the root directly to current pixel and add current pixel to stats
//             S_LABEL_WRITE: begin
//                 // Write label
//                 case (toggle_line)
//                     // 0: row1_labels[x] <= R;
//                     // 1: row0_labels[x] <= R;
//                     0: row1_labels[x] <= ua;
//                     1: row0_labels[x] <= ua;
//                 endcase

//                 ua_area_new = area[ua] + 1;

//                 // add pixel to stats of ua
//                 area[ua] <= ua_area_new;
//                 sum_x[ua] <= sum_x[ua] + x;
//                 sum_y[ua] <= sum_y[ua] + y;
//                 if (x < min_x[ua]) begin
//                     min_x[ua] <= x;
//                 end
//                 if (x > max_x[ua]) begin
//                     max_x[ua] <= x;
//                 end
//                 if (y < min_y[ua]) begin
//                     min_y[ua] <= y;
//                 end
//                 if (y > max_y[ua]) begin
//                     max_y[ua] <= y;
//                 end

//                 // update leaderboard and filter out
//                 if (ua_area_new >= MIN_AREA) begin
//                     if      (slot0 == ua) slot0_area <= ua_area_new;
//                     else if (slot1 == ua) slot1_area <= ua_area_new;
//                     else if (slot2 == ua) slot2_area <= ua_area_new;
//                     else if (slot3 == ua) slot3_area <= ua_area_new;
//                     else if (slot0 == 0)  begin slot0 <= ua; slot0_area <= ua_area_new; end
//                     else if (slot1 == 0)  begin slot1 <= ua; slot1_area <= ua_area_new; end
//                     else if (slot2 == 0)  begin slot2 <= ua; slot2_area <= ua_area_new; end
//                     else if (slot3 == 0)  begin slot3 <= ua; slot3_area <= ua_area_new; end
//                     else begin
//                         min_area_tmp = slot0_area; min_idx_tmp = 0;
//                         if (slot1_area < min_area_tmp) begin min_area_tmp = slot1_area; min_idx_tmp = 1; end
//                         if (slot2_area < min_area_tmp) begin min_area_tmp = slot2_area; min_idx_tmp = 2; end
//                         if (slot3_area < min_area_tmp) begin min_area_tmp = slot3_area; min_idx_tmp = 3; end
//                         if (ua_area_new > min_area_tmp) begin
//                             case (min_idx_tmp)
//                                 0: begin slot0 <= ua; slot0_area <= ua_area_new; end
//                                 1: begin slot1 <= ua; slot1_area <= ua_area_new; end
//                                 2: begin slot2 <= ua; slot2_area <= ua_area_new; end
//                                 default: begin slot3 <= ua; slot3_area <= ua_area_new; end
//                             endcase
//                         end
//                     end
//                 end
//                 // if (ua_area_new >= MIN_AREA) begin
//                 //     if (slot0 == ua) begin
//                 //         slot0_area <= ua_area_new;
//                 //     end else if (slot1 == ua) begin
//                 //         slot1_area <= ua_area_new;
//                 //     end else if (slot2 == ua) begin
//                 //         slot2_area <= ua_area_new;
//                 //     end else if (slot3 == ua) begin
//                 //         slot3_area <= ua_area_new;
//                 //     end else begin
//                 //         // not in leaderboard yet, try to insert
//                 //         if (slot0 == 0) begin 
//                 //             slot0 <= ua; slot0_area <= ua_area_new; 
//                 //             comp_count <= comp_count + 1'b1; 
//                 //         end else if (slot1 == 0) begin 
//                 //             slot1 <= ua; slot1_area <= ua_area_new; 
//                 //             comp_count <= comp_count + 1'b1; 
//                 //         end else if (slot2 == 0) begin 
//                 //             slot2 <= ua; slot2_area <= ua_area_new; 
//                 //             comp_count <= comp_count + 1'b1; 
//                 //         end else if (slot3 == 0) begin 
//                 //             slot3 <= ua; slot3_area <= ua_area_new; 
//                 //             comp_count <= comp_count + 1'b1; 
//                 //         end else begin
//                 //             // Replace the current minimum if ua is bigger
//                 //             min_area_tmp = slot0_area; 
//                 //             min_idx_tmp = 0;
//                 //             if (slot1_area < min_area_tmp) begin 
//                 //                 min_area_tmp = slot1_area; 
//                 //                 min_idx_tmp = 1; 
//                 //             end
//                 //             if (slot2_area < min_area_tmp) begin 
//                 //                 min_area_tmp = slot2_area; 
//                 //                 min_idx_tmp = 2; 
//                 //             end
//                 //             if (slot3_area < min_area_tmp) begin 
//                 //                 min_area_tmp = slot3_area; 
//                 //                 min_idx_tmp = 3; 
//                 //             end
//                 //             if (ua_area_new > min_area_tmp) begin
//                 //                 case (min_idx_tmp)
//                 //                     0: begin slot0 <= ua; slot0_area <= ua_area_new; end
//                 //                     1: begin slot1 <= ua; slot1_area <= ua_area_new; end
//                 //                     2: begin slot2 <= ua; slot2_area <= ua_area_new; end
//                 //                     default: begin slot3 <= ua; slot3_area <= ua_area_new; end
//                 //                 endcase
//                 //             end
//                 //         end
//                 //     end
//                 // end
//                 state <= S_ADVANCE;
//             end

//             // advance x; y/toggle handled by external line_start (already toggled in READY)
//             // if last pixel, output
//             S_ADVANCE: begin
//                 x <= x + 1;

//                 if (frame_end_accepted_pixel) begin
//                     frame_end_accepted_pixel <= 0;

//                     // Snapshot outputs from slots; filter inactive/small entries
//                     // slot 0
//                     if (slot0 != 0 && active_root[slot0] && area[slot0] >= MIN_AREA) begin
//                         comp0_left   <= min_x[slot0];
//                         comp0_right  <= max_x[slot0];
//                         comp0_top    <= min_y[slot0];
//                         comp0_bottom <= max_y[slot0];
//                         comp0_cx     <= (area[slot0]!=0) ? (sum_x[slot0] / area[slot0]) : 0;
//                         comp0_cy     <= (area[slot0]!=0) ? (sum_y[slot0] / area[slot0]) : 0;
//                         comp0_area   <= area[slot0];
//                     end else begin
//                         comp0_left<=0; comp0_right<=0; comp0_top<=0; comp0_bottom<=0; comp0_cx<=0; comp0_cy<=0; comp0_area<=0;
//                     end
//                     // slot 1
//                     if (slot1 != 0 && active_root[slot1] && area[slot1] >= MIN_AREA) begin
//                         comp1_left   <= min_x[slot1];
//                         comp1_right  <= max_x[slot1];
//                         comp1_top    <= min_y[slot1];
//                         comp1_bottom <= max_y[slot1];
//                         comp1_cx     <= (area[slot1]!=0) ? (sum_x[slot1] / area[slot1]) : 0;
//                         comp1_cy     <= (area[slot1]!=0) ? (sum_y[slot1] / area[slot1]) : 0;
//                         comp1_area   <= area[slot1];
//                     end else begin
//                         comp1_left<=0; comp1_right<=0; comp1_top<=0; comp1_bottom<=0; comp1_cx<=0; comp1_cy<=0; comp1_area<=0;
//                     end
//                     // slot 2
//                     if (slot2 != 0 && active_root[slot2] && area[slot2] >= MIN_AREA) begin
//                         comp2_left   <= min_x[slot2];
//                         comp2_right  <= max_x[slot2];
//                         comp2_top    <= min_y[slot2];
//                         comp2_bottom <= max_y[slot2];
//                         comp2_cx     <= (area[slot2]!=0) ? (sum_x[slot2] / area[slot2]) : 0;
//                         comp2_cy     <= (area[slot2]!=0) ? (sum_y[slot2] / area[slot2]) : 0;
//                         comp2_area   <= area[slot2];
//                     end else begin
//                         comp2_left<=0; comp2_right<=0; comp2_top<=0; comp2_bottom<=0; comp2_cx<=0; comp2_cy<=0; comp2_area<=0;
//                     end
//                     // slot 3
//                     if (slot3 != 0 && active_root[slot3] && area[slot3] >= MIN_AREA) begin
//                         comp3_left   <= min_x[slot3];
//                         comp3_right  <= max_x[slot3];
//                         comp3_top    <= min_y[slot3];
//                         comp3_bottom <= max_y[slot3];
//                         comp3_cx     <= (area[slot3]!=0) ? (sum_x[slot3] / area[slot3]) : 0;
//                         comp3_cy     <= (area[slot3]!=0) ? (sum_y[slot3] / area[slot3]) : 0;
//                         comp3_area   <= area[slot3];
//                     end else begin
//                         comp3_left<=0; comp3_right<=0; comp3_top<=0; comp3_bottom<=0; comp3_cx<=0; comp3_cy<=0; comp3_area<=0;
//                     end

//                     comp_count <=
//                         ((slot0!=0) && active_root[slot0] && (area[slot0] >= MIN_AREA)) +
//                         ((slot1!=0) && active_root[slot1] && (area[slot1] >= MIN_AREA)) +
//                         ((slot2!=0) && active_root[slot2] && (area[slot2] >= MIN_AREA)) +
//                         ((slot3!=0) && active_root[slot3] && (area[slot3] >= MIN_AREA));
                    
//                 end

//                 state <= S_READY;
//             end
            
//             default: state <= S_READY;
//         endcase
//     end
// end
// endmodule



            // // post-frame: initialize reduction scan
            // S_REDUCE_INIT: begin
            //     if (sel_scan < next_label) begin
            //         if (active_root[sel_scan] && 
            //             area[sel_scan] >= MIN_AREA &&
            //             sel_scan != chosen0 && sel_scan != chosen1 &&
            //             sel_scan != chosen2 && sel_scan != chosen3) begin
            //             if (area[sel_scan] > best_area_pass) begin
            //                 best_area_pass <= area[sel_scan];
            //                 best_lbl_pass <= sel_scan;
            //             end
            //         end
            //         sel_scan <= sel_scan + 1;
            //         state <= S_REDUCE_INIT; // continue scanning
            //     end else begin
            //         state <= S_REDUCE_OUTPUT; // done scanning all labels
            //     end
            // end

            // // post-frame: output the 4 largest
            // S_REDUCE_COMMIT: begin
            //     if (best_lbl_pass != 0 && pass_idx < MAX_OUT) begin

            //         case (pass_idx)
            //             0: begin
            //                 chosen0 <= best_lbl_pass;
            //                 // output stats to comp0_*
            //                 comp0_left <= min_x[best_lbl_pass];
            //                 comp0_right <= max_x[best_lbl_pass];
            //                 comp0_top <= min_y[best_lbl_pass];
            //                 comp0_bottom <= max_y[best_lbl_pass];
            //                 comp0_cx <= sum_x[best_lbl_pass] / area[best_lbl_pass];
            //                 comp0_cy <= sum_y[best_lbl_pass] / area[best_lbl_pass];
            //                 comp0_area <= area[best_lbl_pass];
            //             end
            //             1: begin
            //                 chosen1 <= best_lbl_pass;
            //                 // output stats to comp1_*
            //                 comp1_left <= min_x[best_lbl_pass];
            //                 comp1_right <= max_x[best_lbl_pass];
            //                 comp1_top <= min_y[best_lbl_pass];
            //                 comp1_bottom <= max_y[best_lbl_pass];
            //                 comp1_cx <= sum_x[best_lbl_pass] / area[best_lbl_pass];
            //                 comp1_cy <= sum_y[best_lbl_pass] / area[best_lbl_pass];
            //                 comp1_area <= area[best_lbl_pass];
            //             end
            //             2: begin
            //                 chosen2 <= best_lbl_pass;
            //                 // output stats to comp2_*
            //                 comp2_left <= min_x[best_lbl_pass];
            //                 comp2_right <= max_x[best_lbl_pass];
            //                 comp2_top <= min_y[best_lbl_pass];
            //                 comp2_bottom <= max_y[best_lbl_pass];
            //                 comp2_cx <= sum_x[best_lbl_pass] / area[best_lbl_pass];
            //                 comp2_cy <= sum_y[best_lbl_pass] / area[best_lbl_pass];
            //                 comp2_area <= area[best_lbl_pass];
            //             end
            //             3: begin
            //                 chosen3 <= best_lbl_pass;
            //                 // output stats to comp3_*
            //                 comp3_left <= min_x[best_lbl_pass];
            //                 comp3_right <= max_x[best_lbl_pass];
            //                 comp3_top <= min_y[best_lbl_pass];
            //                 comp3_bottom <= max_y[best_lbl_pass];
            //                 comp3_cx <= sum_x[best_lbl_pass] / area[best_lbl_pass];
            //                 comp3_cy <= sum_y[best_lbl_pass] / area[best_lbl_pass];
            //                 comp3_area <= area[best_lbl_pass];
            //             end
            //     endcase



// function [label_bits-1:0] label_top(input [x_bitsize-1:0] x);
//     if (y == 0) begin
//         label_top = 0; // first line has no previous line
//     end else begin
//         label_top = toggle_line ? row1_labels[x] : row0_labels[x];
//     end
// endfunction

// function [label_bits-1:0] label_top_left(input [x_bitsize-1:0] x);
//     if (y == 0 || x == 0) begin
//         label_top_left = 0; // first line or first pixel has no previous line or left pixel
//     end else begin
//         label_top_left = toggle_line ? row1_labels[x-1] : row0_labels[x-1];
//     end
// endfunction

// function [label_bits-1:0] label_top_right(input [x_bitsize-1:0] x);
//     if (y == 0 || x == WIDTH-1) begin
//         label_top_right = 0; // first line or last pixel has no previous line or right pixel
//     end else begin
//         label_top_right = toggle_line ? row1_labels[x+1] : row0_labels[x+1];
//     end
// endfunction
  
// function [label_bits-1:0] label_curr_left(input [x_bitsize-1:0] x);
//     if (y == 0 || x == 0) begin
//         label_curr_left = 0; // first line or first pixel has no previous line or left pixel
//     end else begin
//         label_curr_left = toggle_line ? row0_labels[x-1] : row1_labels[x-1];
//     end
// endfunction

// // helper union() which is to replace sets containing p and q with their union
// task set_curr_label(input [x_bitsize-1:0] x, input [label_bits-1:0] L);
//     begin
//         if (toggle_line) begin
//             row0_labels[x] <= L;
//         end else begin
//             row1_labels[x] <= L;
//         end
//     end
// endtask

// // C++ eq: follow parents to find root of component
// function [label_bits-1:0] uf_find(input [label_bits-1:0] a);
//     reg [label_bits-1:0] r;
//     integer k;
//     begin
//         r = a;
//         if (r == 0) begin uf_find = 0; end
//         else begin
//             for (k = 0; k < FIND_MAX_ITERS; k = k + 1) begin
//                 if (parent[r] == r) begin uf_find = r; end
//                 r = parent[r];
//             end
//             uf_find = r; // fallback if loop cap hit
//         end
//     end
// endfunction


// // C++: union by rank; attach smaller tree, update rank, merge stats rb -> ra
// task merge_stats(input [label_bits-1:0] ra, input [label_bits-1:0] rb);
//     begin
//         area[ra] <= area[ra] + area[rb];
//         sumx[ra] <= sumx[ra] + sumx[rb];
//         sumy[ra] <= sumy[ra] + sumy[rb];
//         if (minx[rb] < minx[ra]) minx[ra] <= minx[rb];
//         if (miny[rb] < miny[ra]) miny[ra] <= miny[rb];
//         if (maxx[rb] > maxx[ra]) maxx[ra] <= maxx[rb];
//         if (maxy[rb] > maxy[ra]) maxy[ra] <= maxy[rb];
//         active[rb] <= 1'b0;
//         area[rb] <= 0; sumx[rb] <= 0; sumy[rb] <= 0;
//         minx[rb] <= {x_bitsize{1'b1}}; miny[rb] <= {y_bitsize{1'b1}};
//         maxx[rb] <= 0; maxy[rb] <= 0;
//     end
// endtask

// task uf_union(input [label_bits-1:0] a, input [label_bits-1:0] b);

//     reg [label_bits-1:0] ra, rb;
//     begin
//         if (a==0 || b==0) disable uf_union;
//         ra = uf_find(a); rb = uf_find(b);
//         if (ra == rb) disable uf_union;
//         if (rank_[ra] < rank_[rb]) begin
//             parent[ra] <= rb; merge_stats(rb, ra);
//         end else if (rank_[ra] > rank_[rb]) begin
//             parent[rb] <= ra; merge_stats(ra, rb);
//         end else begin
//             parent[rb] <= ra; rank_[ra] <= rank_[ra] + 1'b1; merge_stats(ra, rb);
//         end
//     end
// endtask

// task init_label(input [label_bits-1:0] L);
//     begin
//         parent[L] <= L; rank_[L] <= 0; active[L] <= 1'b1;
//         area[L] <= 0; sumx[L] <= 0; sumy[L] <= 0;
//         minx[L] <= {x_bitsize{1'b1}}; miny[L] <= {y_bitsize{1'b1}};
//         maxx[L] <= 0; maxy[L] <= 0;
//     end
// endtask

// task add_pixel_to_root(input [label_bits-1:0] R);
//     begin
//         area[R] <= area[R] + 1;
//         sumx[R] <= sumx[R] + x;
//         sumy[R] <= sumy[R] + y;
//         if (x < minx[R]) minx[R] <= x; if (x > maxx[R]) maxx[R] <= x;
//         if (y < miny[R]) miny[R] <= y; if (y > maxy[R]) maxy[R] <= y;
//     end
// endtask


// C++ eq: follow parents to find root of component
// function [label_bits-1:0] uf_find(input [label_bits-1:0] a);
//     reg [label_bits-1:0] r;
//     integer k;
//     begin
//         r = a;
//         if (r == 0) begin uf_find = 0; end
//         else begin
//             for (k = 0; k < FIND_MAX_ITERS; k = k + 1) begin
//                 if (parent[r] == r) begin uf_find = r; end
//                 r = parent[r];
//             end
//             uf_find = r; // fallback if loop cap hit
//         end
//     end
// endfunction

// // C++: union by rank; attach smaller tree, update rank, merge stats rb -> ra
// task merge_stats(input [label_bits-1:0] ra, input [label_bits-1:0] rb);
//     begin
//         area[ra] <= area[ra] + area[rb];
//         sumx[ra] <= sumx[ra] + sumx[rb];
//         sumy[ra] <= sumy[ra] + sumy[rb];
//         if (minx[rb] < minx[ra]) minx[ra] <= minx[rb];
//         if (miny[rb] < miny[ra]) miny[ra] <= miny[rb];
//         if (maxx[rb] > maxx[ra]) maxx[ra] <= maxx[rb];
//         if (maxy[rb] > maxy[ra]) maxy[ra] <= maxy[rb];
//         active[rb] <= 1'b0;
//         area[rb] <= 0; sumx[rb] <= 0; sumy[rb] <= 0;
//         minx[rb] <= {x_bitsize{1'b1}}; miny[rb] <= {y_bitsize{1'b1}};
//         maxx[rb] <= 0; maxy[rb] <= 0;
//     end
// endtask

// task uf_union(input [label_bits-1:0] a, input [label_bits-1:0] b);
//     reg [label_bits-1:0] ra, rb;
//     begin
//         if (a==0 || b==0) disable uf_union;
//         ra = uf_find(a); rb = uf_find(b);
//         if (ra == rb) disable uf_union;
//         if (rank_[ra] < rank_[rb]) begin
//             parent[ra] <= rb; merge_stats(rb, ra);
//         end else if (rank_[ra] > rank_[rb]) begin
//             parent[rb] <= ra; merge_stats(ra, rb);
//         end else begin
//             parent[rb] <= ra; rank_[ra] <= rank_[ra] + 1'b1; merge_stats(ra, rb);
//         end
//     end
// endtask

// task init_label(input [label_bits-1:0] L);
//     begin
//         parent[L] <= L; rank_[L] <= 0; active[L] <= 1'b1;
//         area[L] <= 0; sumx[L] <= 0; sumy[L] <= 0;
//         minx[L] <= {x_bitsize{1'b1}}; miny[L] <= {y_bitsize{1'b1}};
//         maxx[L] <= 0; maxy[L] <= 0;
//     end
// endtask

// task add_pixel_to_root(input [label_bits-1:0] R);
//     begin
//         area[R] <= area[R] + 1;
//         sumx[R] <= sumx[R] + x;
//         sumy[R] <= sumy[R] + y;
//         if (x < minx[R]) minx[R] <= x; if (x > maxx[R]) maxx[R] <= x;
//         if (y < miny[R]) miny[R] <= y; if (y > maxy[R]) maxy[R] <= y;
//     end
// endtask


// always @(posedge clk) begin
//     if (ext_reset) begin
//         x <= 0; y <= 0; toggle_line <= 0;
//         bbox_left <= 0; bbox_right <= 0; bbox_top <= 0; bbox_bottom <= 0; centroid_x <= 0; centroid_y <= 0;
//         for (i = 0; i < WIDTH; i = i + 1) begin
//             row0_labels[i] <= 0;
//             row1_labels[i] <= 0;
//         end
//         //out_valid <= 1'b0;
//     end else begin
//         // new frame: reset coordinates and clear both line buffers
//         if (frame_start) begin
//             x <= 0; y <= 0; toggle_line <= 0;
//             for (i = 0; i < WIDTH; i = i + 1) begin
//                 row0_labels[i] <= 0;
//                 row1_labels[i] <= 0;
//             end
//         end 
        
//         // new line except first pixel of a frame
//         if (line_start && !frame_start) begin
//             // reset x, increment y, toggle line buffers
//             x <= 0;
//             y <= y + 1;
//             toggle_line <= ~toggle_line;
//         end 
        
//         if (in_valid) begin
//             // during active pixels
//             if (!curr_pix) begin
//                 // this is a background pixel
//                 case (toggle_line)
//                     0: row1_labels[x] <= 0;
//                     1: row0_labels[x] <= 0;
//                 endcase
//             end else begin
//                 // 1. map neighbours to current roots
//                 root_left = (L  != 0) ? uf_find(L)  : 0;
//                 root_up   = (U  != 0) ? uf_find(U)  : 0;
//                 root_ul   = (UL != 0) ? uf_find(UL) : 0;
//                 root_ur   = (UR != 0) ? uf_find(UR) : 0;

//                 /// 2. Choose representative: smallest non-zero root label
//                 R = 0;
//                 if (root_left) begin
//                     R = root_left;
//                 end
//                 if (root_up && (R == 0 || root_up < R)) begin
//                     R = root_up;
//                 end
//                 if (root_ul && (R == 0 || root_ul < R)) begin
//                     R = root_ul;
//                 end
//                 if (root_ur && (R == 0 || root_ur < R)) begin
//                     R = root_ur;
//                 end

//                 // 3. If no neighbours, new label
//                 if (R == 0) begin
//                     R <= next_label;
//                     init_label(next_label);
//                     active[next_label] <= 1'b1;
//                     parent[next_label] <= next_label;
//                     if (next_label != MAX_LABELS - 1) begin
//                         next_label <= next_label + 1'b1;
//                     end
//                 end

//                 // 4. Union with any neighbour roots that are different
//                 if (R_left != 0 && R_left != R) begin
//                     uf_union(R, R_left);
//                 end
//                 if (R_up != 0 && R_up != R) begin
//                     uf_union(R, R_up);
//                 end
//                 if (R_ul != 0 && R_ul != R) begin
//                     uf_union(R, R_ul);
//                 end
//                 if (R_ur != 0 && R_ur != R) begin
//                     uf_union(R, R_ur);
//                 end

//                 // 5. Final root and update
//                 R = uf_find(R);
//                 set_curr_label(x, R);
//                 add_pixel_to_root(R);
//             end

//             // increment x within the line (reminder y is handled at the start)
//             x <= x + 1;
//         end

//         // frame_end here: outputs to be computed
//         // if (frame_end) out_valid <= 1;
//     end
// end
    
// endmodule