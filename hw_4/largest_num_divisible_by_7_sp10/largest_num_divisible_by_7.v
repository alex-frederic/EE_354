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
// largest_num_divisible_by_7.v
// Written by Suraj Abraham, Gandhi Puvvada 
// March 1, 2009, March 3, 2010

// Given an array of 16 unsigned 8-bit numbers, we need to find the largest non-zero
// number that is exactly divisible by 7. 

`timescale 1 ns / 100 ps

module largest_num_divisible_by_7 (Max, Start, Ack, Clk, Reset, 
				 Qi, Ql, Qdiv, Qdf, Qdnf);

input Start, Ack, Clk, Reset;
output [7:0] Max;
output Qi, Ql, Qdiv, Qdf, Qdnf;

reg [7:0] M [0:15]; 
reg [7:0] X;
reg [4:0] state;
reg [7:0] Max;
reg [3:0] I;

localparam 
INI = 	5'b00001, // "Initial" state
LD_X = 	5'b00010, // "Load X with the next M[I]" state
DIV = 	5'b00100, // "Divide X by 7 and Update Max if appropriate" state
D_F = 	5'b01000, // "Done Found largest number divisible by 7" state
D_NF = 	5'b10000 ;// "Done Not Found any non-zero number divisible by 7" state

         
         
assign {Qdnf, Qdf, Qdiv, Ql, Qi} = state;

always @(posedge Clk, posedge Reset) 

  begin  : CU_n_DU
    if (Reset)
       begin
         state <= INI;
          I <= 4'bXXXX;
	      Max <= 8'bXXXXXXXX;
	      X <= 8'bXXXXXXXX;	   // to avoid recirculating mux controlled by Reset 
	    end
    else
       begin
         (* full_case, parallel_case *)
         case (state)
	        INI	: 
	          begin
		         // state transitions in the control unit
		         if (Start)
		           state <= LD_X;
		         // RTL operations in the DPU (Data Path Unit)            	              
		           Max <= 0;
		           I <= 0;
	          end
	        LD_X	:  // ** TODO **  complete RTL Operations and State Transitions
	          begin
		         // state transitions in the control unit

				 
				 
				 
				 
				 
				 
				 
				 
				 
							
		       // RTL operations in the Data Path   

			   
			   
 	          end
	        
	        DIV :  // ** TODO **  complete RTL Operations and State Transitions
	          begin
	          // state transitions in the control unit

			  
			  
			  
			  
			  
			  
			  
			  
			  
	             
	          // RTL operations in the Data Path




			  
	          end
	        
	        D_F	:
	          begin  
		         // state transitions in the control unit
		         if (Ack)
		           state <= INI;
		       end    
	        D_NF	:
	          begin  
		         // state transitions in the control unit
		         if (Ack)
		           state <= INI;
		       end    
      endcase
    end 
  end 
endmodule  

