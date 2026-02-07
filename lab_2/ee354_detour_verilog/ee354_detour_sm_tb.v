//////////////////////////////////////////////////////////////////////////////////
// Author:			Gandhi Puvvada
// Create Date:   	02/13/2008, 2/5/2012, 1/21/2020 
// File Name:		ee354_detour_sm_tb.v 
// Description: 
//
//
// Revision: 		1.1
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module ee354_detour_sm_tb;

reg L_Rbar_tb, Clk_tb, reset_tb;
wire q_I_tb, q_R1_tb, q_R12_tb, q_R123_tb, q_L1_tb, q_L12_tb, q_L123_tb, 
								 GLL_tb, GL_tb, GR_tb, GRR_tb;

// Instantiate the UUT
// Recall the original module statement in the UUT code and the order of signals. 
//module ee354_detour_sm(Clk, reset, L_Rbar, q_I, q_R1, q_R12, q_R123, q_L1, q_L12, q_L123, 
//								  GLL, GL, GR, GRR);

// positional association below is right, but we prefer named association.
// ee354_detour_sm  UUT  (Clk_tb, reset_tb, L_Rbar_tb, q_I_tb, q_R1_tb, q_R12_tb, q_R123_tb, q_L1_tb, q_L12_tb, q_L123_tb, 
//								GLL_tb, GL_tb, GR_tb, GRR_tb);
// Instantiate the UUT by named association. Notation:  .pin(system_label)

ee354_detour_sm  UUT  (.Clk(Clk_tb), .reset(reset_tb), .L_Rbar(L_Rbar_tb), .q_I(q_I_tb), .q_R1(q_R1_tb), .q_R12(q_R12_tb), .q_R123(q_R123_tb), .q_L1(q_L1_tb), .q_L12(q_L12_tb), .q_L123(q_L123_tb), 
								.GLL(GLL_tb), .GL(GL_tb), .GR(GR_tb), .GRR(GRR_tb));
// Initialize Inputs
initial begin Clk_tb = 1'b0; end
always  begin #10; Clk_tb = ~ Clk_tb; end
initial begin reset_tb = 1'b1; #22; reset_tb = 1'b0; end
initial 
   begin 
		      L_Rbar_tb = 1'b0; 
		#100; L_Rbar_tb = 1'b1; 
		#100; L_Rbar_tb = 1'b0; 
		#100; L_Rbar_tb = 1'b1;
   end

endmodule

