`timescale 1ns/1ps

module game_logic_demo(
	input clk,

	output reg [9:0] alien_x, alien_y,
	output reg [10:0] aliens_alive[4:0],
	output reg [9:0] alien_laser_x, alien_laser_y,

	output reg [9:0] ship_x, ship_y,
	output reg [9:0] ship_laser_x, ship_laser_y,
);

	reg [9:0] ax = 10'd0;
	reg [9:0] ay = 10'd0;
	reg [9:0] alx = 
	reg moving_left = 1'b0;

	reg [3:0] missing_alien_col = 0;
	reg [2:0] missing_alien_row = 0;
	integer set_row;

	always @(posedge clk) begin
		ax <= ax + 10'd1;
		if (ax == 10'd337) begin
			ax <= 10'd0;

			ay <= moving_left ? (ay - 10'd1) : (ay + 10'd1);
			if (ay == 10'd386) begin
				ay <= 10'd0;
				moving_left <= ~moving_left;
			end
		end
	end

	always @(*) begin
		alien_x = ax;
		alien_y = ay;
	end

	always @(posedge clk) begin
		missing_alien_col <= missing_alien_col + 4'd1;
		if (missing_alien_col == 4'd10) begin
			missing_alien_col <= 0;

			missing_alien_row <= missing_alien_row + 3'd1;
			if (missing_alien_row == 3'd4) begin
				missing_alien_row <= 0;
			end
		end

		for (set_row = 0; set_row <= 4; set_row = set_row + 1) begin
			aliens_alive[set_row] = 11'b11111111111;
		end
		aliens_alive[missing_alien_row][missing_alien_col] = 1'b0;
	end

endmodule