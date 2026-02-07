//  File: middle_finder_tb.v (testbench for middle_finder.v)
// (based on my earlier testbench middle_finder_tb.vhd)
// Date: 8/28/2008 
//  Gandhi Puvvada
// -----------------------------------------------------------------------------
`timescale 1 ns / 100 ps

module middle_finder_tb ;

reg [3:0] A_tb, B_tb, C_tb;
wire [3:0] MIDDLE_tb;

middle_finder middle_finder_1 (A_tb, B_tb, C_tb, MIDDLE_tb);

initial  // consider what happens if we replace "initial" with "always"
  begin  : STIMULUS
  
	// B is the middle number
	A_tb = 15; B_tb = 10; C_tb = 5;
	#10; // wait for 10ns -- note: it is "ns" because the "timescale 1 ns"
	A_tb =  5; B_tb = 10; C_tb = 15;
	#10; 
	// A is the middle number
	A_tb = 8; B_tb =  4; C_tb = 10;
	#10; 
	A_tb = 8; B_tb = 10; C_tb =  4;
	#10; 
	// C is the middle number
	A_tb = 9; B_tb = 5; C_tb = 7;
	#10; 
	A_tb = 5; B_tb = 9; C_tb = 7;
	#10; 
	// A = B,   A or B is the middle number
	A_tb = 13; B_tb = 13; C_tb = 8;
	#10; 
	A_tb = 13; B_tb = 13; C_tb = 14;
	#10; 
	// B = C,   B or C is the middle number
	A_tb =  6; B_tb = 12; C_tb = 12;
	#10; 
	A_tb = 15; B_tb = 12; C_tb = 12;
	#10; 
	// A = C,   A or C is the middle number
	A_tb = 9; B_tb = 2; C_tb = 9;
	#10; 
	A_tb = 9; B_tb = 14; C_tb = 9;
	#10; 
	// A = B = C,   A or B or C is the middle number
	A_tb = 11; B_tb = 11; C_tb = 11;
	#10; 
  end
endmodule  // middle_finder_tb
// ----------------------------------------------------------------------------
