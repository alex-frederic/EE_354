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
    input btnA,
    input btnB,

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

    output reg [15:0] score
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

    reg [23:0] div_cnt;
    reg slow_tick;

    // alien group movement
    reg alien_dir_right; // 1 => moving right

    // ship laser vertical speed in pixels per slow tick
    localparam LASER_SPEED = 8; 

    // ship movement speed in pixels per slow tick
    localparam SHIP_SPEED = 4;

    integer i;
    integer j;
    reg alloc_done;

    // multiple lasers: size of the laser buffer (simple pool)
    localparam NUM_LASERS = 8;

    // laser pool storage
    reg [9:0] laser_x [0:NUM_LASERS-1];
    reg [9:0] laser_y [0:NUM_LASERS-1];
    reg laser_active [0:NUM_LASERS-1];

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

        div_cnt = 0;
        slow_tick = 0;
    end

    // divide clock to create slow_tick
    always @(posedge clk) begin
        if (div_cnt >= TICK_DIV) begin
            div_cnt <= 0;
            slow_tick <= ~slow_tick;
        end else begin
            div_cnt <= div_cnt + 1;
        end
    end

    // Main slow-state updates
    always @(posedge slow_tick) begin : GAME_LOGIC
        // Ship movement
        if (btnA && !btnB) begin
            if (ship_x > H_MIN + 1)
                ship_x <= ship_x - SHIP_SPEED;
        end else if (!btnA && btnB) begin
            if (ship_x + SHIP_WIDTH + SHIP_SPEED < H_MAX)
                ship_x <= ship_x + SHIP_SPEED;
        end

        // Fire: both buttons pressed -> allocate a laser from pool
        if (btnA && btnB) begin
            alloc_done = 1'b0;
            for (i = 0; i < NUM_LASERS; i = i + 1) begin
                if (!alloc_done && !laser_active[i]) begin
                    laser_active[i] <= 1'b1;
                    laser_x[i] <= ship_x + (SHIP_WIDTH >> 1);
                    laser_y[i] <= ship_y - 1;
                    alloc_done = 1'b1;
                end
            end
        end

        // Move ship lasers and clear ones that leave the screen
        for (j = 0; j < NUM_LASERS; j = j + 1) begin
            if (laser_active[j]) begin
                if (laser_y[j] > 0) begin
                    laser_y[j] <= laser_y[j] - LASER_SPEED;
                end else begin
                    laser_active[j] <= 1'b0; // remove laser leaving screen
                end
            end
        end

        // update ship_laser_* outputs to reflect first active laser (for compatibility)
        ship_laser_active <= 1'b0;
        ship_laser_x <= 10'd0;
        ship_laser_y <= 10'd0;
        for (j = 0; j < NUM_LASERS; j = j + 1) begin
            if (laser_active[j] && !ship_laser_active) begin
                ship_laser_active <= 1'b1;
                ship_laser_x <= laser_x[j];
                ship_laser_y <= laser_y[j];
            end
        end

        // Move alien group horizontally, reverse and drop when hitting edges
        begin
            if (alien_dir_right) begin
                if (alien_x + GROUP_WIDTH + 1 < H_MAX) begin
                    alien_x <= alien_x + 1;
                end else begin
                    alien_dir_right <= 1'b0;
                    alien_y <= alien_y + (ALIEN_HEIGHT + Y_SPACING); // drop
                end
            end else begin
                if (alien_x > H_MIN + 1) begin
                    alien_x <= alien_x - 1;
                end else begin
                    alien_dir_right <= 1'b1;
                    alien_y <= alien_y + (ALIEN_HEIGHT + Y_SPACING);
                end
            end
        end

        // for collision detection, we check against the (hCount==alien_laser_x)&&(vCount==alien_laser_y) to see if there is a collision

        // Clear collision marker at start of tick
        alien_laser_x <= 10'd0;
        alien_laser_y <= 10'd0;

        // Check collisions for each active laser using renderer-aligned logic
        for (j = 0; j < NUM_LASERS; j = j + 1) begin
            if (laser_active[j]) begin
                // in-range checks
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

                in_x_range = (laser_x[j] >= alien_x) && (laser_x[j] < alien_x + GROUP_WIDTH);
                in_y_range = (laser_y[j] >= alien_y) && (laser_y[j] < alien_y + GROUP_HEIGHT);
                in_block = in_x_range && in_y_range;

                if (in_block) begin
                    wrapped_x = (laser_x[j] - alien_x) % (ALIEN_WIDTH + X_SPACING);
                    wrapped_y = (laser_y[j] - alien_y) % (ALIEN_HEIGHT + Y_SPACING);

                    alien_overlap_x = wrapped_x < ALIEN_WIDTH;
                    alien_overlap_y = wrapped_y < ALIEN_HEIGHT;
                    alien_overlap = alien_overlap_x && alien_overlap_y;

                    alien_col = (laser_x[j] - alien_x) / (ALIEN_WIDTH + X_SPACING);
                    alien_row = (laser_y[j] - alien_y) / (ALIEN_HEIGHT + Y_SPACING);

                    if (alien_col >= 0 && alien_col < 11 && alien_row >= 0 && alien_row < 5 && alien_overlap) begin
                        integer idx;
                        idx = alien_row*11 + alien_col;
                        live_alien = aliens_alive_flat[idx];
                        if (live_alien) begin
                            // kill alien
                            aliens_alive_flat[idx] <= 1'b0;
                            // per-row scoring: rows 0,1 => 10; rows 2,4 => 20; row 3 => 10
                            if (alien_row == 2 || alien_row == 4) begin
                                score <= score + 16'd20;
                            end else begin
                                score <= score + 16'd10;
                            end
                            // mark collision pixel and remove laser
                            alien_laser_x <= laser_x[j];
                            alien_laser_y <= laser_y[j];
                            laser_active[j] <= 1'b0;
                        end
                    end
                end
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
