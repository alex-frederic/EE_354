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
    localparam LASER_SPEED = 1;

    // ship movement speed in pixels per slow tick
    localparam SHIP_SPEED = 2;

    integer i;

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
    always @(posedge slow_tick) begin
        // Ship movement
        if (btnA && !btnB) begin
            if (ship_x > H_MIN + 1)
                ship_x <= ship_x - SHIP_SPEED;
        end else if (!btnA && btnB) begin
            if (ship_x + SHIP_WIDTH + SHIP_SPEED < H_MAX)
                ship_x <= ship_x + SHIP_SPEED;
        end

        // use either the middle button or the top button to fire, don't require both
        // Fire: both pressed simultaneously => fire
        if (btnA && btnB && !ship_laser_active) begin
            ship_laser_active <= 1'b1;
            ship_laser_x <= ship_x + (SHIP_WIDTH>>1);
            // start the laser just above the ship
            ship_laser_y <= ship_y - 1;
        end

        // Move ship laser
        if (ship_laser_active) begin
            if (ship_laser_y > 0) begin
                ship_laser_y <= ship_laser_y - LASER_SPEED;
            end else begin
                ship_laser_active <= 0;
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

        // If ship laser active, check collision with alive aliens
        if (ship_laser_active) begin
            // Check if laser intersects the alien group's bounding box
            if ((ship_laser_x >= alien_x) && (ship_laser_x < alien_x + GROUP_WIDTH) &&
                (ship_laser_y >= alien_y) && (ship_laser_y < alien_y + GROUP_HEIGHT)) begin

                // determine column and row
                integer col, row;
                integer local_x, local_y;
                local_x = ship_laser_x - alien_x;
                local_y = ship_laser_y - alien_y;
                col = local_x / (ALIEN_WIDTH + X_SPACING);
                row = local_y / (ALIEN_HEIGHT + Y_SPACING);
                if (col >= 0 && col < 11 && row >= 0 && row < 5) begin
                    integer idx;
                    idx = row*11 + col;
                    if (aliens_alive_flat[idx]) begin
                        // kill alien
                        aliens_alive_flat[idx] <= 1'b0;
                        score <= score + 1;
                        // mark a single collision pixel for the renderer to pick up
                        alien_laser_x <= ship_laser_x;
                        alien_laser_y <= ship_laser_y;
                    end
                    // remove laser
                    ship_laser_active <= 1'b0;
                end
            end
        end
    end

endmodule
