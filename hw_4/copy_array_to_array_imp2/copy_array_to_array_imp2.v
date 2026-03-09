// Exercise file to be completed by students
// ----------------------------------------------------------------------------------

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


//  Module: copy_array_to_array_imp2
//  File name:  copy_array_to_array_imp2.v
// 	By: Ananth Rampura Sheshagiri Rao, Gandhi Puvvada
//  Date: 10/26/2009, 1/31/2010, 3/10/2010, 10/16/2025

//  In Spring 2025, Phani Teja Vempati and Gandhi Puvvada have revised
//  this file and the associated testbench file so that the two arrays 
//  are declared here in the core design (i.e. DUT Design Under Test)
//  (unlike in the previous case where they were declared in the testbench).
//  reg [3:0] M [0:9];
//  reg [3:0] N [0:9]; 

//  Description: Given a soted array M[I] of ten unsigned numbers,
//  create an array N[J] of ten signed numbers. 


// ---------------------------------------------------------------------------------

`timescale 1 ns / 100 ps

module copy_array_to_array_imp2 (Reset, Clk, Start, Ack, Qini, Qls2c, Qcbc, Qdone);


//inputs and outputs declaration
input Reset, Clk;
input Start, Ack;
output Qini, Qls2c, Qcbc, Qdone;

// reg and wire declaration

// the two arrays M and N
reg [3:0] M [0:9];
reg [3:0] N [0:9]; 

reg [3:0] I,J;  // the two indicies
reg [3:0] state;

// State machine states
localparam
 INI   = 4'b0001,
 LS2C  = 4'b0010,
 CBC   = 4'b0100,
 DONE  = 4'b1000,
 UNKN  = 4'bxxxx;
 
localparam 
// **********  TODO  **************
// Fill-in 4'b1001 (for nine) or 4'b1010 (for ten) or 4'b1011 (for eleven) as appropriate
 Imax  = 4'b1001, Jmax = 4'b1001; // Imax and Jmax for use in conditions such as (I == Imax) or (J == Jmax) .

 
assign {Qdone, Qcbc, Qls2c, Qini} = state;

//start of state machine (both Datapath and Control Unit)

// Use 	if (M[I][3]) to check if MSB is a one.
// Use   N[J] <= M[I];   to transfer an element from array M to array N.

always @(posedge Clk, posedge Reset) //asynchronous active_high Reset
 begin  
	   if (Reset) 
	       begin
	           I <= 4'bXXXX;
	           J <= 4'bXXXX;
			   state <= INI;
	       end
       else // under positive edge of the clock
         begin
            case (state) // state and data transfers
                 INI:
					begin
					// state transitions
                        if(Start) 
							state <= LS2C;
					// RTL
					   	I <= 4'b0000;
						J <= 4'b0000;
					end
                       
                 LS2C: // // **********  TODO  **************                  
                    begin 
						// state transitions
						if ( (M[I][3])  ||  (I == Imax) ) begin
							state <= CBC;
						end


						//RTL
						if (M[I][3]) begin
							N[J] <= M[I];
							J <= J + 1;
						end

						if (I == Imax) begin
							I <= 0;
						end else begin
							I <= I + 1;
						end
                    end
					
                 CBC:  // **********  TODO  **************     
					begin  
						// state transitions
						if (J == Jmax) begin
							state <= DONE;
						end


						//RTL
						N[J] <= M[I];
						J <= J + 1;
						
						if (I == Imax) begin
							I <= 0;
						end else begin
							I <= I + 1;
						end
					end
                                               
                 DONE:
                    begin
                        if(Ack)
							state <= INI;
						// else state <= DONE;
                    end
				default: 
                    begin
                         state <= UNKN;    
                    end
            endcase
         end   
 end // end of always procedural block 
               
 endmodule