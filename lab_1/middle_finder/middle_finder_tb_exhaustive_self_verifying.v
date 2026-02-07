//  File: middle_finder_tb_exhaustive_self_verifying.v  (testbench for middle_finder.v)
//  This is basically an improved version of the middle_finder_tb.v 
// (based on my earlier testbench middle_finder_tb1.vhd).
// It tests the DUT (Design Under Test) exhaustively.

// The assignment:
// Simulate for  40960ns using the command "run 40960ns"
// This test bench will reports several errors. such as the one below:
// # Sorry!      A =  0 , B =  1 , and C =  1 produced the wrong Middle =  0 instead of   1 . test_number =          17
// You have to decide whether the errors are due to failure of the DUT 
// or incorrect coding of the test bench or both, and fix the bugs.
// If you fixed all bugs, you will just receive the following message.
// # Congratulations! All 4096 tests were completed successfully!

// After finishing debugging, you need to answer questions at the end of this file.

// Date: 8/29/2008 
//  Gandhi Puvvada
// ------------------------------------------------------------------------
// We kept the module name same as middle_finder_tb.
// So, between middle_finder_tb.v and middle_finder_tb_exhuastive_self_verifying.v, 
// the file, which was mostly recently compiled, will define the behavior of the 
// compiled module middle_finder_tb.
// ------------------------------------------------------------------------
`timescale 1 ns / 100 ps

module middle_finder_tb ;

reg [3:0] A_tb, B_tb, C_tb;
reg [3:0] MIDDLE_calculated;
wire [3:0] MIDDLE_tb;
integer i, j, k, error_count, test_number;
middle_finder middle_finder_1 (A_tb, B_tb, C_tb, MIDDLE_tb);

initial  // consider what happens if we replace "initial" with "always"
  begin  : STIMULUS
	error_count = 0; test_number = 0;
	for (i = 0; i <= 15; i = i + 1)
		for (j = 0; j <= 15; j = j + 1)
			for (k = 0; k <= 15; k = k + 1)
				begin
					A_tb = i; B_tb = j; C_tb = k;
					// now let us find the MIDDLE in a slightly different way 
					// and use it to verify the middle produced by the DUT (design under test).
					// Let us first make a default assignment to MIDDLE_calculated
					// and then selectively override it.
					//     														// ******************** Line B1a
					//    															// ******************** Line B1b
					MIDDLE_calculated = A_tb;    // *************************** Line A1
					// Now conditionally over-ride the default assignment, if B_tb were to be the MIDDLE
					if (	((A_tb > B_tb) && (B_tb > C_tb)) ||
							((C_tb > B_tb) && (B_tb > A_tb))	)
							MIDDLE_calculated = B_tb;    // *************************** Line A2
					// Now conditionally over-ride the default assignment,  if C_tb should be the MIDDLE
					if (	((A_tb > C_tb) && (C_tb > B_tb)) ||
							((B_tb > C_tb) && (C_tb > A_tb))	)
							MIDDLE_calculated = C_tb;   // *************************** Line A3
					// wait for a delta-T (we are actually waiting for 1ns) to let the new MIDDLE_tb value to be updated 	// ******************** Line B2a
					#1; 																	// ******************** Line B2b
					// Now check to see if there is a match
					if (MIDDLE_calculated == MIDDLE_tb)
						begin
							// Commented out the following line to avoid too many lines reported on the screen
							// $display ("Congrats!   A = %d , B = %d , and C = %d produced the right Middle = %d . test_number = %d", A_tb, B_tb, C_tb, MIDDLE_tb, test_number);
						end	
					else
						begin
							$display ("Sorry!      A = %d , B = %d , and C = %d produced the wrong Middle = %d instead of %d . test_number = %d ", A_tb, B_tb, C_tb, MIDDLE_tb, MIDDLE_calculated, test_number);
							error_count = error_count + 1;
						end
					#9; // wait for 9ns more -- note: it is "ns" because the "timescale 1 ns"
					test_number = test_number + 1;
				end
	if (error_count !== 0)
		$display ("Sorry to note that you had a total of %d errors.", error_count);
	else	
		$display ("Congratulations! All 4096 tests were completed successfully!");
  end
endmodule  // middle_finder_tb
// ----------------------------------------------------------------------------
/*
Questions to be answered by the students:

1. 	Describe briefly the errors you fixed in the DUT or the testbench or both.

2. 	In your working design, think what happens, if you do one or more of the following modifications.
	After arriving at your answer mentally, verify if you were thinking right by actually modifying
	the code as suggested and simulating. Finally describe briefly your findings (together with 
	reasons for any changed or unchanged behavior of the testbench) in your report.
	
2.1	Refer to the three lines labeled Line A1, Line A2, and Line A3.
	If you use non-blocking assignments "<=" in place of the blocking assignments "=", would it matter?
	
2.2	Refer to the two lines labeled Line B2a and Line B2b.
	If you move these lines from the current position to the area marked by Line B1a and Line B1b,
	what happens? What happens if you do this change together with the change suggested in 2.1 above,
	or if you do this change without the change suggested in 2.1 above?
	
*/