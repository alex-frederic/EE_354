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
	// control buttons forwarded from top
	input left_button,
	input right_button,
	input fire_button,
	output reg [11:0] rgb,
	output reg [15:0] score
);
	
	localparam BLACK = 12'b0000_0000_0000;
	localparam WHITE = 12'b1111_1111_1111;
	localparam RED   = 12'b1111_0000_0000;
	localparam GREEN = 12'b0000_1111_0000;
	localparam BLUE  = 12'b0000_0000_1111;
	
	localparam TRANSPARENT = 12'hF0F;

	localparam ALIEN_WIDTH = 36;
	localparam ALIEN_HEIGHT = 24;
	localparam X_SPACING = 5;
	localparam Y_SPACING = 2;
	localparam GROUP_WIDTH = (11*ALIEN_WIDTH + 10*X_SPACING);
	localparam GROUP_HEIGHT = (5*ALIEN_HEIGHT + 4*Y_SPACING);

	localparam SHIP_WIDTH = 20;
	localparam SHIP_HEIGHT = 5;

	localparam LASER_X_BOUND = 1; // For a LASER_WIDTH of 2*LASER_X_BOUND + 1
	localparam LASER_HEIGHT = 10;



	// wires driven by game logic
	wire [9:0] alien_x;
	wire [9:0] alien_y;
	wire [54:0] aliens_alive_flat; // flattened 5*11 bits
	// alien laser / collision point driven by game logic
	wire [9:0] alien_laser_x;
	wire [9:0] alien_laser_y;

	wire [9:0] ship_x;
	wire [9:0] ship_y;
	wire [9:0] ship_laser_x;
	wire [9:0] ship_laser_y;
	wire ship_laser_active;
	wire [79:0] ship_laser_x_flat;
	wire [79:0] ship_laser_y_flat;
	wire [7:0] ship_laser_active_flat;

	wire [79:0] alien_laser_x_flat;
	wire [79:0] alien_laser_y_flat;
	wire [7:0] alien_laser_active_flat;

	wire [15:0] score_from_logic;
	wire [10:0] aliens_alive[4:0];

	//sprite dimensions
	wire [4:0]  sprite_row;
	wire [5:0]  sprite_col;
	wire [11:0] alien_color_data;

	//wire instationation of wrapped due to rom needing to address wires instead of registers
	wire [9:0] wrapped_x_wire;
	wire [9:0] wrapped_y_wire;

	reg alien_present;
	reg shield_present;
	reg ship_present;
	reg laser_present;

	//
	assign wrapped_x_wire = (hCount >= alien_x) 
                   ? (hCount - alien_x) % (ALIEN_WIDTH  + X_SPACING) : 0;
	assign wrapped_y_wire = (vCount >= alien_y) 
                   ? (vCount - alien_y) % (ALIEN_HEIGHT + Y_SPACING) : 0;
				   
	assign sprite_row = wrapped_y_wire[4:0];
	assign sprite_col = wrapped_x_wire[5:0];

	//rename to image file
	crab_rom alien_rom_inst (
		.clk        (clk),
		.row        (sprite_row),
		.col        (sprite_col),
		.color_data (alien_color_data)
	);

	//rom lag
	reg alien_present_delayed;
	always @(posedge clk) begin
		alien_present_delayed <= alien_present;
	end





	// Instantiate game logic
	game_logic gl(
		.clk(clk),
		.btnA(btnA),
		.btnB(btnB),
		.alien_x(alien_x),
		.alien_y(alien_y),
		.aliens_alive_flat(aliens_alive_flat),
		.ship_x(ship_x),
		.ship_y(ship_y),
		.ship_laser_x(ship_laser_x),
		.ship_laser_y(ship_laser_y),
		.ship_laser_active(ship_laser_active),
		.alien_laser_x(alien_laser_x),
		.alien_laser_y(alien_laser_y),
		.score(score_from_logic),
		.ship_laser_x_flat(ship_laser_x_flat),
		.ship_laser_y_flat(ship_laser_y_flat),
		.ship_laser_active_flat(ship_laser_active_flat),
		.alien_laser_x_flat(alien_laser_x_flat),
		.alien_laser_y_flat(alien_laser_y_flat),
		.alien_laser_active_flat(alien_laser_active_flat),
		.shield_damage(shield_damage),
		.ship_damage(ship_damage)
	);

	// unpack flattened alive mask into row vectors for compatibility with existing renderer code
	assign aliens_alive[0] = aliens_alive_flat[ 0 +: 11];
	assign aliens_alive[1] = aliens_alive_flat[11 +: 11];
	assign aliens_alive[2] = aliens_alive_flat[22 +: 11];
	assign aliens_alive[3] = aliens_alive_flat[33 +: 11];
	assign aliens_alive[4] = aliens_alive_flat[44 +: 11];

	// forward score from logic to top-level
	always @(*) score = score_from_logic;


	always @ (*) begin : PLOT_ALIENS
		reg in_x_range;
		reg in_y_range;
		reg in_block;
		reg alien_overlap_x;
		reg alien_overlap_y;
		reg [9:0] wrapped_x;
		reg [9:0] wrapped_y;
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
		integer li;
		reg hit_ship_l;
		reg hit_alien_l;
		reg [9:0] lx;
		reg [9:0] ly;
		reg [9:0] ax;
		reg [9:0] ay;
		
		
		hit_ship_l = 0;
		hit_alien_l = 0;
		// check ship lasers pool
		for (li = 0; li < 8; li = li + 1) begin
			lx = ship_laser_x_flat[li*10 +: 10];
			ly = ship_laser_y_flat[li*10 +: 10];
			if (ship_laser_active_flat[li]) begin
				
				if ((hCount >= lx - LASER_X_BOUND) && (hCount <= lx + LASER_X_BOUND) && (vCount >= ly) && (vCount < ly + LASER_HEIGHT)) begin
					hit_ship_l = 1;
				end
			end
		end

		// check alien lasers pool
		for (li = 0; li < 8; li = li + 1) begin
			ax = alien_laser_x_flat[li*10 +: 10];
			ay = alien_laser_y_flat[li*10 +: 10];
			if (alien_laser_active_flat[li]) begin
				if ((hCount >= ax - LASER_X_BOUND) && (hCount <= ax + LASER_X_BOUND) && (vCount > ay - LASER_HEIGHT) && (vCount <= ay)) begin
					hit_alien_l = 1;
				end
			end
		end

		laser_present = hit_ship_l || hit_alien_l;
	end
	
	
	always@ (*) begin : ASSIGN_COLORS
		integer li;
		reg [9:0] lx;
		reg [9:0] ly;
		reg [9:0] ax;
		reg [9:0] ay;
		
		
		
	
		if (~bright) begin
			rgb = BLACK;
		end else begin
			// default background
			rgb = BLACK;

			// ship lasers (blue)
			for (li = 0; li < 8; li = li + 1) begin
				lx = ship_laser_x_flat[li*10 +: 10];
				ly = ship_laser_y_flat[li*10 +: 10];
				if (ship_laser_active_flat[li]) begin
					if ((hCount >= lx - LASER_X_BOUND) && (hCount <= lx + LASER_X_BOUND) && (vCount >= ly) && (vCount < ly + LASER_HEIGHT)) begin
						rgb = BLUE;
					end
				end
			end

			// alien lasers (white)
			for (li = 0; li < 8; li = li + 1) begin
				ax = alien_laser_x_flat[li*10 +: 10];
				ay = alien_laser_y_flat[li*10 +: 10];
				if (alien_laser_active_flat[li]) begin
					if ((hCount >= ax - LASER_X_BOUND) && (hCount <= ax + LASER_X_BOUND) && (vCount > ay - LASER_HEIGHT) && (vCount <= ay)) begin
						rgb = WHITE;
					end
				end
			end

			// aliens, shields, ship
			if (alien_present_delayed && alien_color_data != TRANSPARENT) 
			begin
			/* Real sprite pixel — use the ROM color */
			rgb = alien_color_data;
			end
			else if (alien_present_delayed) 
			begin
			/* Transparent sprite pixel — show background */
			rgb = BLACK;
			end

			if (shield_present) rgb = GREEN;
			if (ship_present) rgb = GREEN;
		
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
	end

	// (score comes from game_logic)
	
endmodule