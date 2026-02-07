//////////////////////////////////////////////////////////////////////////////////
// Author:			Brandon Franzke, Gandhi Puvvada, Bilal Zafar
// Create Date:   	02/13/2008, 
// Revised: Gandhi 2/6/2012 replaced `define with localparam
// File Name:		ee354_detour_sm.v 
// Description: 
//
//
// Revision: 		1.1
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module ee354_detour_sm(Clk, reset, L_Rbar, q_I, q_R1, q_R12, q_R123, q_L1, q_L12, q_L123, 
								GLL, GL, GR, GRR);

	/*  INPUTS */
	// Clock & Reset
	input		Clk, reset;
	input 	L_Rbar;
	
	/*  OUTPUTS */
	// store current state
	output q_I, q_R1, q_R12, q_R123, q_L1, q_L12, q_L123;
	reg [6:0] state;	
	
	assign {q_L123, q_L12, q_L1, q_R123, q_R12, q_R1, q_I} = state;
		
	// lets make accessing the state information easier within the state machine code
	// each line aliases the approriate state bits and sets up a 1-hot code
	localparam
	    QI		=   7'b0000001,
	    QR1		=   7'b0000010,
	    QR12	=   7'b0000100,
	    QR123	=   7'b0001000,
	    QL1		=   7'b0010000,
	    QL12	=   7'b0100000,
	    QL123	=   7'b1000000,
	    UNK		=   7'bXXXXXXX;
	
	// our output leds (leftleft, left, right, rightright)
	output GLL, GL, GR, GRR;	
	

	// NSL AND SM
	always @ (posedge Clk, posedge reset)
	begin
		if(reset)
			state <= QI;
		else 
		begin
			case(state)
				QI:
					// dont worry about async reset here because 'if' statement considers this first
					if(L_Rbar)
						// switch left
						state <= QL1;
					else
						// switch right
						state <= QR1;
				// these are pretty boring, just unconditionals
				QR1:		state <= QR12;
				QR12:		state <= QR123;
				QR123:		state <= QI;	
				QL1:		state <= QL12;	
				QL12:		state <= QL123;	
				QL123:		state <= QI;	
				default:	state <= UNK;
			endcase
		end
	end
	
	
	// OFL
	assign GLL = q_L123;
	assign GL  = q_L123 | q_L12 | q_R1 | q_R12 | q_R123;
	assign GR  = q_R123 | q_R12 | q_L1 | q_L12 | q_L123;
	assign GRR = q_R123;
	
endmodule
