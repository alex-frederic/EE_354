module test_sprite_rom
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







		if(({row_reg, col_reg}>=11'b00000000000) && ({row_reg, col_reg}<11'b00111001011)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}>=11'b00111001011) && ({row_reg, col_reg}<11'b00111010111)) color_data = 12'b001101001100;

		if(({row_reg, col_reg}>=11'b00111010111) && ({row_reg, col_reg}<11'b01000010000)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}>=11'b01000010000) && ({row_reg, col_reg}<11'b01000010010)) color_data = 12'b001101001100;

		if(({row_reg, col_reg}>=11'b01000010010) && ({row_reg, col_reg}<11'b01001010000)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}>=11'b01001010000) && ({row_reg, col_reg}<11'b01001010010)) color_data = 12'b001101001100;

		if(({row_reg, col_reg}>=11'b01001010010) && ({row_reg, col_reg}<11'b01010010000)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}>=11'b01010010000) && ({row_reg, col_reg}<11'b01010010010)) color_data = 12'b001101001100;

		if(({row_reg, col_reg}>=11'b01010010010) && ({row_reg, col_reg}<11'b01011010000)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}>=11'b01011010000) && ({row_reg, col_reg}<11'b01011010010)) color_data = 12'b001101001100;

		if(({row_reg, col_reg}>=11'b01011010010) && ({row_reg, col_reg}<11'b01100010000)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}>=11'b01100010000) && ({row_reg, col_reg}<11'b01100010010)) color_data = 12'b001101001100;

		if(({row_reg, col_reg}>=11'b01100010010) && ({row_reg, col_reg}<11'b01101010000)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}>=11'b01101010000) && ({row_reg, col_reg}<11'b01101010010)) color_data = 12'b001101001100;

		if(({row_reg, col_reg}>=11'b01101010010) && ({row_reg, col_reg}<11'b01110010000)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}>=11'b01110010000) && ({row_reg, col_reg}<11'b01110010010)) color_data = 12'b001101001100;

		if(({row_reg, col_reg}>=11'b01110010010) && ({row_reg, col_reg}<11'b01111010000)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}>=11'b01111010000) && ({row_reg, col_reg}<11'b01111010010)) color_data = 12'b001101001100;

		if(({row_reg, col_reg}>=11'b01111010010) && ({row_reg, col_reg}<11'b10000010000)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}>=11'b10000010000) && ({row_reg, col_reg}<11'b10000010010)) color_data = 12'b001101001100;

		if(({row_reg, col_reg}>=11'b10000010010) && ({row_reg, col_reg}<11'b10001010000)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}>=11'b10001010000) && ({row_reg, col_reg}<11'b10001010010)) color_data = 12'b001101001100;

		if(({row_reg, col_reg}>=11'b10001010010) && ({row_reg, col_reg}<11'b10010010000)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}>=11'b10010010000) && ({row_reg, col_reg}<11'b10010010010)) color_data = 12'b001101001100;

		if(({row_reg, col_reg}>=11'b10010010010) && ({row_reg, col_reg}<11'b10011010000)) color_data = 12'b111111111111;
		if(({row_reg, col_reg}>=11'b10011010000) && ({row_reg, col_reg}<11'b10011010010)) color_data = 12'b001101001100;





		if(({row_reg, col_reg}>=11'b10011010010) && ({row_reg, col_reg}<=11'b10111100011)) color_data = 12'b111111111111;
	end
endmodule