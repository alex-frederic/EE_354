`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Simple game logic for Space Invaders (minimal, synthesizable)
// - Inputs: clk, btnA (move left), btnB (move right)
// - Outputs: alien group x/y, flattened aliens_alive mask (5 rows x 11 cols = 55 bits),
//   ship x/y, ship laser x/y and active flag, score
//
// Notes/assumptions:
// - BtnA moves ship left while held. BtnB moves ship right while held.
// - If both buttons are pressed simultaneously a shot is fired.
// - Laser/alien movement uses a slow tick derived from `clk`.
//////////////////////////////////////////////////////////////////////////////////
module game_logic(
    input clk,
    input right_button,
    input left_button,
    input fire_button,
    // additional buttons for start/reset handling
    input top_button,
    input mid_button,

    output reg [9:0] alien_x,
    output reg [9:0] alien_y,
    output reg [54:0] aliens_alive_flat, // 5 rows * 11 cols = 55 bits

    output reg [9:0] ship_x,
    output reg [9:0] ship_y,

    output reg [9:0] ship_laser_x,
    output reg [9:0] ship_laser_y,
    output reg ship_laser_active,

    // expose a single collision coordinate so the renderer can check
    // (hCount == alien_laser_x) && (vCount == alien_laser_y)
    output reg [9:0] alien_laser_x,
    output reg [9:0] alien_laser_y,

    output reg [15:0] score,

    // flattened ship laser pool outputs: 8 lasers * 10 bits = 80 bits each vector
    output reg [79:0] ship_laser_x_flat,
    output reg [79:0] ship_laser_y_flat,
    output reg [7:0] ship_laser_active_flat,

    // flattened alien laser pool outputs
    output reg [79:0] alien_laser_x_flat,
    output reg [79:0] alien_laser_y_flat,
    output reg [7:0] alien_laser_active_flat,

    // damage counters
    output reg [7:0] shield_damage,
    output reg [7:0] ship_damage
    ,
    // game state outputs
    output reg game_over,
    output reg game_win
);

    // Parameters must match renderer constants
    localparam ALIEN_WIDTH = 36;
    localparam ALIEN_HEIGHT = 24;
    localparam X_SPACING = 5;
    localparam Y_SPACING = 2;
    localparam GROUP_WIDTH = (11*ALIEN_WIDTH + 10*X_SPACING);
    localparam GROUP_HEIGHT = (5*ALIEN_HEIGHT + 4*Y_SPACING);

    localparam SHIP_WIDTH = 20;
    localparam SHIP_HEIGHT = 5;

    // playable area (matching renderer bright window)
    localparam H_MIN = 10'd144;
    localparam H_MAX = 10'd783;

    // slow tick divider (adjustable). This value is conservative to be synthesizable.
    // If clk is 50MHz, 25_000_000 -> ~0.5s per tick. We use a smaller divider for responsiveness.
    localparam integer TICK_DIV = 24'd3_000_000; // tune if needed
    // separate laser tick for smoother laser motion (tune to get ~60Hz updates)
    // Default below assumes a 100 MHz board clock: 100_000_000 / 60 ≈ 1_666_666
    localparam integer LASER_TICK_DIV = 24'd1666666; // ~60 Hz at 100 MHz

    reg [23:0] div_cnt;
    reg slow_tick_en;

    // alien group movement
    reg alien_dir_right; // 1 => moving right

    // ship laser vertical speed in pixels per laser tick
    localparam LASER_SPEED = 1;

    // ship movement speed in pixels per slow tick
    localparam SHIP_SPEED = 4;

    integer i;
    integer j;
    reg alloc_done;
    // hoisted temporaries (declared at module scope for synthesis)
    reg in_x_range;
    reg in_y_range;
    reg in_block;
    reg [9:0] wrapped_x;
    reg [9:0] wrapped_y;
    reg alien_overlap_x;
    reg alien_overlap_y;
    reg alien_overlap;
    reg [3:0] alien_col;
    reg [2:0] alien_row;
    reg live_alien;
    integer col_idx;
    integer row_idx;
    integer idx;
    integer ii;
    integer jj;
    integer rc;
    integer cc;
    integer found;
    integer leftmost_col;
    integer rightmost_col;
    integer left_edge_px;
    integer right_edge_px;
    reg col_has_alive;

    // multiple lasers: size of the laser buffer (simple pool)
    localparam NUM_LASERS = 8;
    localparam NUM_ALIEN_LASERS = 8;

    // firing cooldown (in laser ticks) to limit fire rate when using the same buttons
    localparam integer FIRE_COOLDOWN = 8;
    reg [7:0] fire_cooldown;

    // laser pool storage
    reg [9:0] laser_x [0:NUM_LASERS-1];
    reg [9:0] laser_y [0:NUM_LASERS-1];
    reg laser_active [0:NUM_LASERS-1];
    // alien laser pool
    reg [9:0] alien_lx [0:NUM_ALIEN_LASERS-1];
    reg [9:0] alien_ly [0:NUM_ALIEN_LASERS-1];
    reg alien_lactive [0:NUM_ALIEN_LASERS-1];

    // reset / start detection
    // default assumes 100 MHz board clock; adjust RESET_HOLD_CLKS if your board is 50MHz
    localparam integer RESET_HOLD_CLKS = 28'd200000000; // 2 seconds @ 100MHz
    localparam integer START_HOLD_TICKS = 8'd30; // hold count on slow_tick to start (tunable)
    reg [27:0] reset_hold_cnt;
    reg reset_request;
    reg reset_done_laser;
    reg reset_done_slow;
    reg [7:0] start_hold_cnt;
    // simple FSM for game state
    reg [1:0] state;
    localparam S_START = 2'd0;
    localparam S_RUNNING = 2'd1;
    localparam S_GAMEOVER = 2'd2;
    localparam S_WIN = 2'd3;

    // flattened outputs are declared in the module port list above

    // We can pass down module parameters from bitchange to game logic to avoid hardcoding
    

    // produce a score signal based off the rows (10 for 1st and 2nd, 20 for 3rd and 5th))
    // send as a unsigned integer -> 4 SSDs allowed
    // change the buttons to be left and right
    // the laser needs the disappear after collision or leaving the screen
    // multiple lasers need to be included, may implement using a fifo
    // the laser isn't moving when the aliens are at the bottom of the screen, might be because we are only check the alien width and height as a giant rectangle and not looking at the empty space



    initial begin
        // Initialize positions to match previous constants
        alien_x = 10'd224;
        alien_y = 10'd85;
        alien_dir_right = 1'b1;

        // all aliens alive
        for (i = 0; i < 55; i = i + 1)
            aliens_alive_flat[i] = 1'b1;

        ship_x = 10'd300;
        ship_y = 10'd465;

        ship_laser_active = 0;
        ship_laser_x = 0;
        ship_laser_y = 0;
        alien_laser_x = 10'd0;
        alien_laser_y = 10'd0;

        // initialize laser pool
        for (i = 0; i < NUM_LASERS; i = i + 1) begin
            laser_active[i] = 1'b0;
            laser_x[i] = 10'd0;
            laser_y[i] = 10'd0;
        end

        score = 16'd0;

        // initialize alien laser pool
        for (i = 0; i < NUM_ALIEN_LASERS; i = i + 1) begin
            alien_lactive[i] = 1'b0;
            alien_lx[i] = 10'd0;
            alien_ly[i] = 10'd0;
        end

        // damage counters
        shield_damage = 8'd0;
        ship_damage = 8'd0;

    div_cnt = 0;
    slow_tick_en = 0;
    laser_div_cnt = 0;
    laser_tick_en = 0;
    lfsr = 16'hACE1; // non-zero seed
    // reset/start state init
    reset_hold_cnt = 0;
    reset_request = 0;
    reset_done_laser = 0;
    reset_done_slow = 0;
    start_hold_cnt = 0;
    state = S_START;
    game_over = 1'b0;
    game_win = 1'b0;
    end

    // Laser update block - runs at a faster rate to improve smoothness
    always @(posedge clk) begin : LASER_UPDATE
    	localparam s_y = 395;
    	localparam s_h = 40;
    	localparam s1x = 232;
    	localparam s2x = 360;
    	localparam s3x = 488;
    	localparam s4x = 615;
    	localparam s_w = 80;
    	
    	integer ii;
    	integer jj;
    
        if (!laser_tick_en) begin
            // nothing
        end else begin
            // Move ship lasers and clear ones that leave the screen
            for (ii = 0; ii < NUM_LASERS; ii = ii + 1) begin
                if (laser_active[ii]) begin
                    if (laser_y[ii] > 0) begin
                        laser_y[ii] <= laser_y[ii] - LASER_SPEED;
                    end else begin
                        laser_active[ii] <= 1'b0;
                    end
                end
            end

            // Fire allocation: if both buttons pressed, try to allocate into first free slot
            if (fire_button) begin
                if (fire_cooldown == 0) begin
                    found = 0;
                    for (ii = 0; ii < NUM_LASERS; ii = ii + 1) begin
                        if (!found && !laser_active[ii]) begin
                            laser_active[ii] <= 1'b1;
                            laser_x[ii] <= ship_x + (SHIP_WIDTH >> 1);
                            laser_y[ii] <= ship_y - 1;
                            found = 1;
                        end
                    end
                    if (found) fire_cooldown <= FIRE_COOLDOWN;
                end
            end

            // decrement cooldown if active
            if (fire_cooldown != 0) fire_cooldown <= fire_cooldown - 1;

            // Alien random firing (LFSR-driven): occasional chance to spawn a laser
            // Choose a candidate column from low LFSR bits and spawn from the bottom-most alive alien
            if (lfsr[0]) begin
                // pick a column from low nibble
                col_idx = lfsr[3:0];
                    if (col_idx < 11) begin
                        // find bottom-most alive alien in this column
                        found = -1;
                        for (row_idx = 4; row_idx >= 0; row_idx = row_idx - 1) begin
                            if (aliens_alive_flat[row_idx*11 + col_idx]) begin
                                found = row_idx;
                            end
                        end
                    end
            end

            // fallback: implement column search without 'disable' (portable)
            if (lfsr[0]) begin
                col_idx = lfsr[3:0];
                if (col_idx < 11) begin
                    found = -1;
                    for (row_idx = 4; row_idx >= 0; row_idx = row_idx - 1) begin
                        if (aliens_alive_flat[row_idx*11 + col_idx]) begin
                            found = row_idx;
                        end
                    end
                    if (found != -1) begin
                        // allocate into first free alien laser slot
                        reg allocated;
                        allocated = 1'b0;
                        for (free_idx = 0; free_idx < NUM_ALIEN_LASERS; free_idx = free_idx + 1) begin
                            if (!allocated && !alien_lactive[free_idx]) begin
                                // compute spawn coordinates (mid-bottom of alien sprite)
                                alien_lactive[free_idx] <= 1'b1;
                                alien_lx[free_idx] <= alien_x + col_idx*(ALIEN_WIDTH + X_SPACING) + (ALIEN_WIDTH >> 1);
                                alien_ly[free_idx] <= alien_y + found*(ALIEN_HEIGHT + Y_SPACING) + ALIEN_HEIGHT;
                                allocated = 1'b1;
                            end
                        end
                    end
                end
            end

            // Move alien lasers
            for (ii = 0; ii < NUM_ALIEN_LASERS; ii = ii + 1) begin
                if (alien_lactive[ii]) begin
                    if (alien_ly[ii] < 10'd514) begin
                        alien_ly[ii] <= alien_ly[ii] + 1; // downward
                    end else begin
                        alien_lactive[ii] <= 1'b0;
                    end
                end
            end

            // Reset detection (hold top + mid buttons for RESET_HOLD_CLKS cycles)
            if (top_button && mid_button) begin
                if (reset_hold_cnt < RESET_HOLD_CLKS) reset_hold_cnt <= reset_hold_cnt + 1;
                if (reset_hold_cnt >= RESET_HOLD_CLKS) reset_request <= 1'b1;
            end else begin
                reset_hold_cnt <= 0;
                reset_request <= 1'b0;
            end

            if (reset_request) begin
                // perform reset: clear aliens, lasers, score, damage
                for (ii = 0; ii < 55; ii = ii + 1) aliens_alive_flat[ii] <= 1'b1;
                for (ii = 0; ii < NUM_LASERS; ii = ii + 1) begin
                    laser_active[ii] <= 1'b0;
                    laser_x[ii] <= 10'd0;
                    laser_y[ii] <= 10'd0;
                end
                for (ii = 0; ii < NUM_ALIEN_LASERS; ii = ii + 1) begin
                    alien_lactive[ii] <= 1'b0;
                    alien_lx[ii] <= 10'd0;
                    alien_ly[ii] <= 10'd0;
                end
                score <= 16'd0;
                shield_damage <= 8'd0;
                ship_damage <= 8'd0;
                // alien_x/alien_y and alien_dir_right are owned by GAME_LOGIC - reset handled there
                fire_cooldown <= 0;
                reset_done_laser <= 1'b1;
                // state/game_over/game_win are owned by GAME_LOGIC - reset handled in slow tick
            end

            // Ship laser collisions and kills (moved here to centralize laser updates)
            // Clear collision marker at start of laser tick
            alien_laser_x <= 10'd0;
            alien_laser_y <= 10'd0;

            for (jj = 0; jj < NUM_LASERS; jj = jj + 1) begin
                if (laser_active[jj]) begin
                    // in-range checks using hoisted temporaries
                    in_x_range = (laser_x[jj] >= alien_x) && (laser_x[jj] < alien_x + GROUP_WIDTH);
                    in_y_range = (laser_y[jj] >= alien_y) && (laser_y[jj] < alien_y + GROUP_HEIGHT);
                    in_block = in_x_range && in_y_range;

                    if (in_block) begin
                        wrapped_x = (laser_x[jj] - alien_x) % (ALIEN_WIDTH + X_SPACING);
                        wrapped_y = (laser_y[jj] - alien_y) % (ALIEN_HEIGHT + Y_SPACING);

                        alien_overlap_x = wrapped_x < ALIEN_WIDTH;
                        alien_overlap_y = wrapped_y < ALIEN_HEIGHT;
                        alien_overlap = alien_overlap_x && alien_overlap_y;

                        alien_col = (laser_x[jj] - alien_x) / (ALIEN_WIDTH + X_SPACING);
                        alien_row = (laser_y[jj] - alien_y) / (ALIEN_HEIGHT + Y_SPACING);

                        if (alien_col >= 0 && alien_col < 11 && alien_row >= 0 && alien_row < 5 && alien_overlap) begin
                            idx = alien_row*11 + alien_col;
                            live_alien = aliens_alive_flat[idx];
                            if (live_alien) begin
                                // kill alien (only driven here)
                                aliens_alive_flat[idx] <= 1'b0;
                                // per-row scoring
                                if (alien_row == 2 || alien_row == 4) begin
                                    score <= score + 16'd20;
                                end else begin
                                    score <= score + 16'd10;
                                end
                                // mark collision pixel and remove laser
                                alien_laser_x <= laser_x[jj];
                                alien_laser_y <= laser_y[jj];
                                laser_active[jj] <= 1'b0;
                            end
                        end
                    end
                end
            end

            // Alien lasers collisions with shields and ship
            for (jj = 0; jj < NUM_ALIEN_LASERS; jj = jj + 1) begin
                if (alien_lactive[jj]) begin
                    // shield collision

                    if ((alien_ly[jj] >= s_y) && (alien_ly[jj] < s_y + s_h)) begin
                        if ((alien_lx[jj] >= s1x && alien_lx[jj] < s1x + s_w) ||
                            (alien_lx[jj] >= s2x && alien_lx[jj] < s2x + s_w) ||
                            (alien_lx[jj] >= s3x && alien_lx[jj] < s3x + s_w) ||
                            (alien_lx[jj] >= s4x && alien_lx[jj] < s4x + s_w)) begin
                            shield_damage <= shield_damage + 1;
                            alien_lactive[jj] <= 1'b0;
                        end
                    end

                    // ship collision
                    if ((alien_lx[jj] >= ship_x) && (alien_lx[jj] < ship_x + SHIP_WIDTH) &&
                        (alien_ly[jj] >= ship_y) && (alien_ly[jj] < ship_y + SHIP_HEIGHT)) begin
                        ship_damage <= ship_damage + 1;
                        alien_lactive[jj] <= 1'b0;
                    end
                end
            end

            // pack flat outputs for renderer
            ship_laser_x_flat = {80{1'b0}};
            ship_laser_y_flat = {80{1'b0}};
            ship_laser_active_flat = 8'd0;
            // also expose the first active laser as ship_laser_* for backwards compatibility
            ship_laser_active = 1'b0;
            ship_laser_x = 10'd0;
            ship_laser_y = 10'd0;
            for (ii = 0; ii < NUM_LASERS; ii = ii + 1) begin
                ship_laser_x_flat[ii*10 +: 10] = laser_x[ii];
                ship_laser_y_flat[ii*10 +: 10] = laser_y[ii];
                ship_laser_active_flat[ii] = laser_active[ii];
                if (!ship_laser_active && laser_active[ii]) begin
                    ship_laser_active = 1'b1;
                    ship_laser_x = laser_x[ii];
                    ship_laser_y = laser_y[ii];
                end
            end

            alien_laser_x_flat = {80{1'b0}};
            alien_laser_y_flat = {80{1'b0}};
            alien_laser_active_flat = 8'd0;
            for (ii = 0; ii < NUM_ALIEN_LASERS; ii = ii + 1) begin
                alien_laser_x_flat[ii*10 +: 10] = alien_lx[ii];
                alien_laser_y_flat[ii*10 +: 10] = alien_ly[ii];
                alien_laser_active_flat[ii] = alien_lactive[ii];
            end
        end
    end

    // divide clock to create a one-cycle enable (slow_tick_en)
    always @(posedge clk) begin
        if (div_cnt >= TICK_DIV) begin
            div_cnt <= 0;
            slow_tick_en <= 1'b1;
        end else begin
            div_cnt <= div_cnt + 1;
            slow_tick_en <= 1'b0;
        end
    end
    
        // simple LFSR for pseudo-random alien firing
        reg [15:0] lfsr;
        wire lfsr_bit = lfsr[0] ^ lfsr[2] ^ lfsr[3] ^ lfsr[5];
        always @(posedge clk) begin
            lfsr <= {lfsr[14:0], lfsr_bit};
        end

        // laser tick divider
        reg [23:0] laser_div_cnt;
        reg laser_tick_en;
        always @(posedge clk) begin
            if (laser_div_cnt >= LASER_TICK_DIV) begin
                laser_div_cnt <= 0;
                laser_tick_en <= 1'b1;
            end else begin
                laser_div_cnt <= laser_div_cnt + 1;
                laser_tick_en <= 1'b0;
            end
        end


    // Main slow-state updates (gated by slow_tick_en to avoid creating derived clocks)
    always @(posedge clk) begin : GAME_LOGIC
        if (!slow_tick_en) begin
            // do nothing until the enable pulse
        end else begin
        // If a reset_request was raised by the laser tick, clear slow-tick-owned state here
        if (reset_request) begin
            alien_dir_right <= 1'b1;
            alien_x <= 10'd224;
            alien_y <= 10'd85;
            ship_x <= 10'd300;
            ship_y <= 10'd465;
            state <= S_START;
            game_over <= 1'b0;
            game_win <= 1'b0;
        end else begin
        // Ship movement
        if (left_button && !right_button) begin
            if (ship_x > H_MIN + 1)
                ship_x <= ship_x - SHIP_SPEED;
        end else if (!left_button && right_button) begin
            if (ship_x + SHIP_WIDTH + SHIP_SPEED < H_MAX)
                ship_x <= ship_x + SHIP_SPEED;
        end

        // Fire allocation moved to the laser-tick block so laser pool
        // registers are driven from a single always block (laser_tick).

    // Move alien group horizontally, reverse and drop when hitting edges
        begin
            // determine leftmost and rightmost alive columns
            leftmost_col = -1;
            rightmost_col = -1;
            for (col_idx = 0; col_idx < 11; col_idx = col_idx + 1) begin
                col_has_alive = 0;
                for (row_idx = 0; row_idx < 5; row_idx = row_idx + 1) begin
                    if (aliens_alive_flat[row_idx*11 + col_idx]) begin
                        col_has_alive = 1;
                    end
                end
                if (col_has_alive && leftmost_col == -1) leftmost_col = col_idx;
                if (col_has_alive) rightmost_col = col_idx;
            end

            // if no aliens alive, do nothing
            if (leftmost_col == -1) begin
                // all dead
            end else begin
                // compute edges of the occupied region
                left_edge_px = alien_x + leftmost_col*(ALIEN_WIDTH + X_SPACING);
                right_edge_px = alien_x + rightmost_col*(ALIEN_WIDTH + X_SPACING) + ALIEN_WIDTH;

                if (alien_dir_right) begin
                    if (right_edge_px + 1 < H_MAX) begin
                        alien_x <= alien_x + 1;
                    end else begin
                        alien_dir_right <= 1'b0;
                        alien_y <= alien_y + (ALIEN_HEIGHT + Y_SPACING); // drop
                    end
                end else begin
                    if (left_edge_px > H_MIN + 1) begin
                        alien_x <= alien_x - 1;
                    end else begin
                        alien_dir_right <= 1'b1;
                        alien_y <= alien_y + (ALIEN_HEIGHT + Y_SPACING);
                    end
                end
            end
        end

        // Start handling: if we're in start screen, require holding top_button for START_HOLD_TICKS slow ticks
        if (state == S_START) begin
            if (top_button) begin
                if (start_hold_cnt < START_HOLD_TICKS) start_hold_cnt <= start_hold_cnt + 1;
                if (start_hold_cnt >= START_HOLD_TICKS) begin
                    state <= S_RUNNING;
                    start_hold_cnt <= 0;
                end
            end else begin
                start_hold_cnt <= 0;
            end
        end

        // Game over detection: aliens reached ship level or ship has been shot 3 times
        if (state == S_RUNNING) begin
            // check if any alien has dropped to ship_y or beyond
            if (alien_y + GROUP_HEIGHT >= ship_y) begin
                state <= S_GAMEOVER;
                game_over <= 1'b1;
            end
            if (ship_damage >= 8'd3) begin
                state <= S_GAMEOVER;
                game_over <= 1'b1;
            end
            // win detection: no aliens alive
            found = 0;
            for (i = 0; i < 55; i = i + 1) begin
                if (aliens_alive_flat[i]) found = 1;
            end
            if (!found) begin
                state <= S_WIN;
                game_win <= 1'b1;
            end
        end

        // for collision detection, we check against the (hCount==alien_laser_x)&&(vCount==alien_laser_y) to see if there is a collision

        // Laser collision/movement/kill handling moved to the faster laser-tick block
        // to avoid multiple always-block drivers for the same registers.
        end
    end
    end

endmodule

// TODO for other files
// - In `vga_top.v`: the button mapping currently forwards BtnU and BtnC to this module.
//   If you prefer left/right/fire with separate buttons, re-map inputs there and forward
//   them as `btnA` (left), `btnB` (right), and add a `btnFire` if you want a dedicated
//   fire button. The current code uses both pressed as fire for backward compatibility.
//
// - In `vga_bitchange.v`: the renderer reads `ship_laser_x`, `ship_laser_y`, and
//   `alien_laser_x`/`alien_laser_y`. `ship_laser_*` are kept updated to the first active
//   laser for compatibility; you may want to update the renderer to draw all active lasers
//   by iterating over the laser pool (requires exposing laser_x/laser_y/laser_active or
//   adding a small wrapper that provides up to N lasers to the renderer).
//
// - SSD / score display: `score` is produced as an unsigned 16-bit number. To show it on
//   the 4 seven-segment displays handled by `counter.v`, ensure `counter` is wired to
//   accept the 16-bit `score` (it already expects a 16-bit `displayNumber` in `vga_top.v`).
//
// - Performance / timing: `TICK_DIV` and `LASER_SPEED` are currently conservative. Tune
//   them for your FPGA clock to get desirable gameplay speed. For consistent frame-accurate
//   visual effects, consider generating a `frame_pulse` from `display_controller` and
//   synchronizing collision markers to frames rather than slow ticks.
//
// - Debounce buttons in the top-level or using a small debouncer module to avoid multiple
//   allocations per press.
//
// - Future enhancements: add alien firing logic, shield damage that modifies shield bitmap,
//   explosion animation per alien, and a simple finite-state machine for game states
//   (start, running, game over).



// TODOs
// add start condition (hold top button during start page), reset button (game logic an the top 
// file), and end condition (show end game sprite if lose [aliens reach the ship or if ship is 
// shot 3 times] and win sprite if all aliens are killed).