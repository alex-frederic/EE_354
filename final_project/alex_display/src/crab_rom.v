`timescale 1ns / 1ps

module crab_rom
	(
		input wire clk,
		input wire [4:0] row,
		input wire [5:0] col,
		output reg [11:0] color_data
	);

	(* rom_style = "block" *)

	//signal declaration
	reg [4:0] row_reg;
	reg [5:0] col_reg;

	always @(posedge clk)
	begin
		row_reg <= row;
		col_reg <= col;
	end

	always @(*) begin








		if(({row_reg, col_reg}>=11'b00000000000) && ({row_reg, col_reg}<11'b01000001110)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==11'b01000001110)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}>=11'b01000001111) && ({row_reg, col_reg}<11'b01000010100)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==11'b01000010100)) color_data = 12'b111111111111;

		if(({row_reg, col_reg}>=11'b01000010101) && ({row_reg, col_reg}<11'b01001001111)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==11'b01001001111)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}>=11'b01001010000) && ({row_reg, col_reg}<11'b01001010011)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==11'b01001010011)) color_data = 12'b111111111111;

		if(({row_reg, col_reg}>=11'b01001010100) && ({row_reg, col_reg}<11'b01010001110)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}>=11'b01010001110) && ({row_reg, col_reg}<11'b01010010101)) color_data = 12'b111111111111;

		if(({row_reg, col_reg}>=11'b01010010101) && ({row_reg, col_reg}<11'b01011001101)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}>=11'b01011001101) && ({row_reg, col_reg}<11'b01011001111)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}==11'b01011001111)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}>=11'b01011010000) && ({row_reg, col_reg}<11'b01011010011)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}==11'b01011010011)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}>=11'b01011010100) && ({row_reg, col_reg}<11'b01011010110)) color_data = 12'b111111111111;

		if(({row_reg, col_reg}>=11'b01011010110) && ({row_reg, col_reg}<11'b01100001100)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}>=11'b01100001100) && ({row_reg, col_reg}<11'b01100010111)) color_data = 12'b111111111111;

		if(({row_reg, col_reg}>=11'b01100010111) && ({row_reg, col_reg}<11'b01101001100)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==11'b01101001100)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}==11'b01101001101)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}>=11'b01101001110) && ({row_reg, col_reg}<11'b01101010101)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}==11'b01101010101)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==11'b01101010110)) color_data = 12'b111111111111;

		if(({row_reg, col_reg}>=11'b01101010111) && ({row_reg, col_reg}<11'b01110001100)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==11'b01110001100)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}==11'b01110001101)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==11'b01110001110)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}>=11'b01110001111) && ({row_reg, col_reg}<11'b01110010100)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==11'b01110010100)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}==11'b01110010101)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==11'b01110010110)) color_data = 12'b111111111111;

		if(({row_reg, col_reg}>=11'b01110010111) && ({row_reg, col_reg}<11'b01111001111)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}>=11'b01111001111) && ({row_reg, col_reg}<11'b01111010001)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}==11'b01111010001)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}>=11'b01111010010) && ({row_reg, col_reg}<11'b01111010100)) color_data = 12'b111111111111;









		if(({row_reg, col_reg}>=11'b01111010100) && ({row_reg, col_reg}<=11'b10111100011)) color_data = 12'b000000000000;
	end
endmodule