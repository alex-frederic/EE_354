//////////////////////////////////////////////////////////////////////////////
//
// Copyright (c) 2010 Gandhi Puvvada, EE-Systems, VSoE, USC
//
// This design exercise, its solution, and its test-bench are confidential items.
// They are University of Southern California's (USC's) property. All rights are reserved.
// Students in our courses have right only to complete the exercise and submit it as part of their course work.
// They do not have any right on our exercise/solution or even on their completed solution as the solution contains our exercise.
// Students would be violating copyright laws besides the University's Academic Integrity rules if they post or convey to anyone
// either our exercise or our solution or their solution (their completed exercise). 
// 
// THIS COPYRIGHT NOTICE MUST BE RETAINED AS PART OF THIS FILE (AND ITS SOLUTION AND/OR ANY OTHER DERIVED FILE) AT ALL TIMES.
//
//////////////////////////////////////////////////////////////////////////////
//
// A student would be violating the University's Academic Integrity rules if he/she gets help in writing or debugging the code 
// from anyone other than the help from his/her teaching team members in completing the exercise(s). 
// However he/she can discuss with fellow students the method of solving the exercise. 
// But writing the code or debugging the code should not be with the help of others. 
// One should never share the code or even look at the code of others (code from classmates or seniors 
// or any code or solution posted online or on GitHub).
// 
// THIS NOTICE OF ACADEMIC INTEGRITY MUST BE RETAINED AS PART OF THIS FILE (AND ITS SOLUTION AND/OR ANY OTHER DERIVED FILE) AT ALL TIMES.
//
//////////////////////////////////////////////////////////////////////////////



// EE201L RTL Exercises
// make_A_close_to_B.v
// Written by Suraj Abraham, Gandhi Puvvada 
// March 1, 2009, March 4, 2010

// Given two 12-bit unsigned numbers A and B where A < B, we increase A 
// by 100s initially and then decrease it by 10s, if needed, to bring it (A) close to B, 
// but not higher than B.

`timescale 1 ns / 100 ps

module make_A_close_to_B (Ain, Bin, Start, Ack, Clk, Reset, 
				Flag, Qi, Qc, Qd, A);

input [11:0] Ain, Bin;
input Start, Ack, Clk, Reset;
output Flag;  // Flag FF
output Qi, Qc, Qd;
output [11:0] A;

// Rest are wire by default
reg [11:0] A, B;
reg [2:0] state;
reg Flag;

localparam
INI	= 3'b001,
ADJ	= 3'b010,
DONE = 3'b100;

assign {Qd, Qc, Qi} = state;

always @(posedge Clk, posedge Reset) 

  begin  : CU_n_DU
    if (Reset)
       begin
          state <= INI;
	      A <= 12'bXXXXXXXXXXXX;        // to avoid recirculating mux controlled by Reset
	      B <= 12'bXXXXXXXXXXXX;	    // to avoid recirculating mux controlled by Reset 
		  Flag <= 1'bX;                 // to avoid ...
	    end
    else
       begin
         (* full_case, parallel_case *)
         case (state)
	        INI	: 
	          begin
		         // state transitions in the control unit
		         if (Start)
		           state <= ADJ;
		         // RTL operations in the DPU (Data Path Unit) 
		           A <= Ain;
		           B <= Bin;
		           Flag <= 0;
	          end
	        ADJ	:  // ** TODO **  complete RTL Operations and State Transitions
	          begin
		         // state transitions in the control unit

				 
		         // RTL operations in the Data Path 		           

				 
				 
				 
				 
 	          end
	        DONE	:
	          begin  
		         // state transitions in the control unit
		         if (Ack)
		           state <= INI;
		       end    
      endcase
    end 
  end
 
endmodule  
