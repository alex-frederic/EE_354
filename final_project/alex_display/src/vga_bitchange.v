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
	
	parameter BLACK = 12'b0000_0000_0000;
	parameter WHITE = 12'b1111_1111_1111;
	parameter RED   = 12'b1111_0000_0000;
	parameter GREEN = 12'b0000_1111_0000;
	parameter BLUE  = 12'b0000_0000_1111;

	parameter ALIEN_WIDTH = 10'd36;
	parameter ALIEN_HEIGHT = 10'd24;
	parameter X_SPACING = 10'd5;
	parameter Y_SPACING = 10'd2;
	parameter GROUP_WIDTH = (11*ALIEN_WIDTH + 10*X_SPACING);
	parameter GROUP_HEIGHT = (5*ALIEN_HEIGHT + 4*Y_SPACING);

	parameter SHIP_WIDTH = 10'd20;
	parameter SHIP_HEIGHT = 10'd5;



	wire [9:0] alien_x;
	wire [9:0] alien_y;


	wire [9:0] ship_x;
	wire [9:0] ship_y;


	reg alien_present;
	reg shield_present;
	reg ship_present;



	assign alien_x = 10'd224;
	assign alien_y = 10'd85;
	assign ship_x = 10'd300;
	assign ship_y = 10'd465;


	always @ (*) begin : PLOT_ALIENS
		reg in_x_range;
		reg in_y_range;
		reg in_block;
		reg [9:0] wrapped_x;
		reg [9:0] wrapped_y;
		reg alien_overlap_x;
		reg alien_overlap_y;
		reg alien_overlap;


		in_x_range = (hCount >= alien_x)  &&  (hCount < alien_x + GROUP_WIDTH);
		in_y_range = (vCount >= alien_y)  &&  (vCount < alien_y + GROUP_HEIGHT);

		in_block = in_x_range && in_y_range;


		wrapped_x = (hCount - alien_x) % (ALIEN_WIDTH + X_SPACING);
		wrapped_y = (vCount - alien_y) % (ALIEN_HEIGHT + Y_SPACING);

		alien_overlap_x = wrapped_x < ALIEN_WIDTH;
		alien_overlap_y = wrapped_y < ALIEN_HEIGHT;

		alien_overlap = alien_overlap_x && alien_overlap_y;


		alien_present = in_block && alien_overlap;
	end


	// hCount > 10'd143 && hCount < 10'd784 && vCount > 10'd34 && vCount < 10'd516
	// x in [144, 783] & y in [35, 515]

	always @ (*) begin : PLOT_SHIELDS
		reg x_overlap_1;
		reg x_overlap_2;
		reg x_overlap_3;
		reg x_overlap_4;
		reg x_overlap;
		reg y_overlap;


		y_overlap = vCount >= 395 && vCount <= 434; // 40 tall centered on 379 & 380


		// x_overlap_1 = hCount >= 253 && hCount <= 292; // 40 wide centered on 127 & 128
		// x_overlap_2 = hCount >= 381 && hCount <= 420; // 40 wide centered on 255 & 256
		// x_overlap_3 = hCount >= 509 && hCount <= 548; // 40 wide centered on 383 & 384
		// x_overlap_4 = hCount >= 636 && hCount <= 676; // 40 wide centered on 511 & 512
		
		x_overlap_1 = hCount >= 233 && hCount <= 312; // 40 wide centered on 127 & 128
		x_overlap_2 = hCount >= 361 && hCount <= 440; // 40 wide centered on 255 & 256
		x_overlap_3 = hCount >= 489 && hCount <= 568; // 40 wide centered on 383 & 384
		x_overlap_4 = hCount >= 616 && hCount <= 696; // 40 wide centered on 511 & 512

		x_overlap = x_overlap_1 | x_overlap_2 | x_overlap_3 | x_overlap_4;


		shield_present = x_overlap && y_overlap;
	end

	always @ (*) begin : PLOT_SHIP
		ship_present = (hCount >= ship_x)  &&  (hCount < ship_x + SHIP_WIDTH)  &&  (vCount >= ship_y)  &&  (vCount < ship_y + SHIP_HEIGHT);
	end
	
	
	always@ (*) begin : ASSIGN_COLORS
    	if (~bright) begin
			rgb = BLACK;
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