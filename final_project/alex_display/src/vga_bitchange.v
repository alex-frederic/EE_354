`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:15:38 12/14/2017 
// Design Name: 
// Module Name:    vgaBitChange 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
// Date: 04/04/2020
// Author: Yue (Julien) Niu
// Description: Port from NEXYS3 to NEXYS4
//////////////////////////////////////////////////////////////////////////////////
module vga_bitchange(
	input clk,
	input bright,
	input [9:0] hCount, vCount,
	output reg [11:0] rgb,
	output reg [15:0] score
);
	
	localparam BLACK = 12'b0000_0000_0000;
	localparam WHITE = 12'b1111_1111_1111;
	localparam RED   = 12'b1111_0000_0000;
	localparam GREEN = 12'b0000_1111_0000;
	localparam BLUE  = 12'b0000_0000_1111;

	localparam ALIEN_WIDTH = 36;
	localparam ALIEN_HEIGHT = 24;
	localparam X_SPACING = 5;
	localparam Y_SPACING = 2;
	localparam GROUP_WIDTH = (11*ALIEN_WIDTH + 10*X_SPACING);
	localparam GROUP_HEIGHT = (5*ALIEN_HEIGHT + 4*Y_SPACING);

	localparam SHIP_WIDTH = 20;
	localparam SHIP_HEIGHT = 5;

	localparam LASER_X_BOUND = 2; // For a LASER_WIDTH of 2*LASER_X_BOUND + 1
	localparam LASER_HEIGHT = 10;



	wire [9:0] alien_x;
	wire [9:0] alien_y;
	wire [10:0] aliens_alive[4:0];
	wire [9:0] alien_laser_x;
	wire [9:0] aliend_laser_y;

	wire [9:0] ship_x;
	wire [9:0] ship_y;
	wire [9:0] ship_laser_x;
	wire [9:0] ship_laser_y;


	reg alien_present;
	reg shield_present;
	reg ship_present;
	reg laser_present;


	assign alien_x = 10'd224;
	assign alien_y = 10'd85;
	assign alien_laser_x = 10'd345;
	assign alien_laser_y = 10'd365;
	assign ship_x = 10'd300;
	assign ship_y = 10'd465;
	assign ship_laser_x = 10'd330;
	assign ship_laser_y = 10'd420;

	assign aliens_alive[0] = 11'b01111111111;
	assign aliens_alive[1] = 11'b11111111100;
	assign aliens_alive[2] = 11'b11101111011;
	assign aliens_alive[3] = 11'b11111001111;
	assign aliens_alive[4] = 11'b11111111111;


	always @ (*) begin : PLOT_ALIENS
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


		in_x_range = (hCount >= alien_x)  &&  (hCount < alien_x + GROUP_WIDTH);
		in_y_range = (vCount >= alien_y)  &&  (vCount < alien_y + GROUP_HEIGHT);

		in_block = in_x_range && in_y_range;


		wrapped_x = (hCount - alien_x) % (ALIEN_WIDTH + X_SPACING);
		wrapped_y = (vCount - alien_y) % (ALIEN_HEIGHT + Y_SPACING);

		alien_overlap_x = wrapped_x < ALIEN_WIDTH;
		alien_overlap_y = wrapped_y < ALIEN_HEIGHT;

		alien_overlap = alien_overlap_x && alien_overlap_y;


		alien_col = (hCount - alien_x) / (ALIEN_WIDTH + X_SPACING);
		alien_row = (vCount - alien_y) / (ALIEN_HEIGHT + Y_SPACING);
		live_alien = aliens_alive[alien_row][alien_col];


		alien_present = live_alien && in_block && alien_overlap;
	end


	// x in [144, 783] & y in [35, 514]

	always @ (*) begin : PLOT_SHIELDS
		reg x_overlap_1;
		reg x_overlap_2;
		reg x_overlap_3;
		reg x_overlap_4;
		reg x_overlap;
		reg y_overlap;

		localparam shield_y = 395;
		localparam shield_height = 40;

		localparam shield_1_x = 232;
		localparam shield_2_x = 360;
		localparam shield_3_x = 488;
		localparam shield_4_x = 615;
		localparam shield_width = 80;


		y_overlap = (vCount >= shield_y)  &&  (vCount < shield_y + shield_height); // 40 tall centered on 379 & 380

		
		x_overlap_1 = hCount >= shield_1_x  &&  hCount < shield_1_x + shield_width; // 80 wide centered on 127 & 128
		x_overlap_2 = hCount >= shield_2_x  &&  hCount < shield_2_x + shield_width; // 80 wide centered on 255 & 256
		x_overlap_3 = hCount >= shield_3_x  &&  hCount < shield_3_x + shield_width; // 80 wide centered on 383 & 384
		x_overlap_4 = hCount >= shield_4_x  &&  hCount < shield_4_x + shield_width; // 80 wide centered on 511 & 512


		x_overlap = x_overlap_1 | x_overlap_2 | x_overlap_3 | x_overlap_4;
		shield_present = x_overlap && y_overlap;
	end

	always @ (*) begin : PLOT_SHIP
		ship_present = (hCount >= ship_x)  &&  (hCount < ship_x + SHIP_WIDTH)  &&  (vCount >= ship_y)  &&  (vCount < ship_y + SHIP_HEIGHT);
	end

	always @(*) begin : PLOT_LASERS
		reg in_ship_x;
		reg in_ship_y;
		reg hit_ship_laser;
		reg in_alien_x;
		reg in_alien_y;
		reg hit_alien_laser;
		
		
		in_ship_x = (hCount >= ship_laser_x - LASER_X_BOUND)  &&  (hCount <= ship_laser_x + LASER_X_BOUND);
		in_ship_y = (vCount >= ship_laser_y)  &&  (vCount < ship_laser_y + LASER_HEIGHT);
		hit_ship_laser = in_ship_x && in_ship_y;

		in_alien_x = (hCount >= alien_laser_x - LASER_X_BOUND)  &&  (hCount <= alien_laser_x + LASER_X_BOUND);
		in_alien_y = (vCount > alien_laser_y - LASER_HEIGHT)  &&  (vCount <= alien_laser_y);
		hit_alien_laser = in_alien_x && in_alien_y;
		
		laser_present = hit_ship_laser || hit_alien_laser;
	end
	
	
	always@ (*) begin : ASSIGN_COLORS
    	if (~bright) begin
			rgb = BLACK;
		end else if ((hCount==ship_laser_x)&&(vCount==ship_laser_y) || (hCount==alien_laser_x)&&(vCount==alien_laser_y)) begin
			rgb = BLUE; // Plot laser draw points in blue for debugging purposes
		end else if (laser_present) begin
			rgb = WHITE;
		end else if (alien_present) begin
			rgb = WHITE;
		end else if (shield_present) begin
			rgb = GREEN;
		end else if (ship_present) begin
			rgb = GREEN;
		end else begin
			rgb = BLACK; // background color
		end
		
		// These are real corners of display! Update bright signal!
		// However, hCount=144 & vCount=35 are only partially visible!
		// x in [144, 783] & y in [35, 514]
		if (hCount==144) begin
			rgb = BLUE;
		end else if (hCount==783) begin
			rgb = BLUE;
		end
		
		if (hCount==143 || hCount==145) begin
			rgb = RED;
		end else if (hCount==782 || hCount==784) begin
			rgb = RED;
		end
		
		if (vCount==35) begin
			rgb = BLUE;
		end else if (vCount==514) begin
			rgb = BLUE;
		end
		
		if (vCount==34 || vCount==36) begin
			rgb = RED;
		end else if (vCount==513 || vCount==515) begin
			rgb = RED;
		end
	end

	always @ (*) begin
		score = 15'd0;
	end
	
endmodule