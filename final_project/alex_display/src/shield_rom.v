
`timescale 1ns / 1ps

module shield_rom
	(
		input wire clk,
		input wire [3:0] row,
		input wire [4:0] col,
		output reg [11:0] color_data
	);

	(* rom_style = "block" *)

	//signal declaration
	reg [3:0] row_reg;
	reg [4:0] col_reg;

	always @(posedge clk)
		begin
		row_reg <= row;
		col_reg <= col;
		end

	always @(*) begin
		if(({row_reg, col_reg}>=9'b000000000) && ({row_reg, col_reg}<9'b000000011)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==9'b000000011)) color_data = 12'b000011010100;
		if(({row_reg, col_reg}>=9'b000000100) && ({row_reg, col_reg}<9'b000010010)) color_data = 12'b000011110100;
		if(({row_reg, col_reg}==9'b000010010)) color_data = 12'b000011010100;

		if(({row_reg, col_reg}>=9'b000010011) && ({row_reg, col_reg}<9'b000100010)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==9'b000100010)) color_data = 12'b000011010100;
		if(({row_reg, col_reg}>=9'b000100011) && ({row_reg, col_reg}<9'b000110011)) color_data = 12'b000011110100;
		if(({row_reg, col_reg}==9'b000110011)) color_data = 12'b000011010100;

		if(({row_reg, col_reg}>=9'b000110100) && ({row_reg, col_reg}<9'b001000001)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==9'b001000001)) color_data = 12'b000011010100;
		if(({row_reg, col_reg}>=9'b001000010) && ({row_reg, col_reg}<9'b001010100)) color_data = 12'b000011110100;
		if(({row_reg, col_reg}==9'b001010100)) color_data = 12'b000011010100;

		if(({row_reg, col_reg}==9'b001010101)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==9'b001100000)) color_data = 12'b000011010100;
		if(({row_reg, col_reg}>=9'b001100001) && ({row_reg, col_reg}<9'b001110101)) color_data = 12'b000011110100;

		if(({row_reg, col_reg}==9'b001110101)) color_data = 12'b000011010100;









		if(({row_reg, col_reg}>=9'b010000000) && ({row_reg, col_reg}<9'b110100101)) color_data = 12'b000011110100;
		if(({row_reg, col_reg}>=9'b110100101) && ({row_reg, col_reg}<9'b110110001)) color_data = 12'b000011010100;

		if(({row_reg, col_reg}>=9'b110110001) && ({row_reg, col_reg}<9'b111000011)) color_data = 12'b000011110100;
		if(({row_reg, col_reg}>=9'b111000011) && ({row_reg, col_reg}<9'b111000101)) color_data = 12'b000011010100;
		if(({row_reg, col_reg}>=9'b111000101) && ({row_reg, col_reg}<9'b111010001)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}>=9'b111010001) && ({row_reg, col_reg}<9'b111010011)) color_data = 12'b000011010100;

		if(({row_reg, col_reg}>=9'b111010011) && ({row_reg, col_reg}<9'b111100011)) color_data = 12'b000011110100;
		if(({row_reg, col_reg}==9'b111100011)) color_data = 12'b000011010100;
		if(({row_reg, col_reg}>=9'b111100100) && ({row_reg, col_reg}<9'b111110010)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==9'b111110010)) color_data = 12'b000011010100;

		if(({row_reg, col_reg}>=9'b111110011) && ({row_reg, col_reg}<=9'b111110101)) color_data = 12'b000011110100;
	end
endmodule