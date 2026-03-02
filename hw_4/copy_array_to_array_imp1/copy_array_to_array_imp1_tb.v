// testbench in completted form
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


// -------------------------------------------------------------------------------------

// -------------------------------------------------------------------------------------
// Module: copy_array_to_array_imp1_tb 
// File: copy_array_to_array_imp1_tb.v (testbench for copy_array_to_array_imp1.v)
// By: Ananth Rampura Sheshagiri Rao , Gandhi Puvvada 
// Date: 10/26/2009, 1/31/2010, 3/13/2010, 3/11/2019, 10-04-2025
// -------------------------------------------------------------------------------------

//  In Spring 2025, Phani Teja Vempati and Gandhi Puvvada have revised
//  this file and the associated DUT (Design under test) (core design file) so that the two arrays 
//  are declared in the DUT
//  (unlike in the previous case where they were declared in the testbench).
//  reg [3:0] M [0:9];
//  reg [3:0] N [0:9]; 


`timescale 1 ns / 100 ps

module copy_array_to_array_imp1_tb; // notice empty port list


reg Start_tb, Clk_tb, Ack_tb, Reset_tb;
wire  Qini_tb, Qls2c_tb, Qc221_tb, Qc122_tb, Qdone_tb;

reg [4*8:1] state_string, last_UUT_state_string; // 4 character state string for displaying state in text mode in the waveform

integer  Clk_cnt, file_results; // file_results is a logical name for the physical file output_results.txt here.
reg [1:0] test_number = 0;
reg [39:0] M_tb;
reg [39:0] N_tb;
wire [3:0] M_of_I; // a copy of the M[I] in the UUT
wire [3:0] N_of_J; // a copy of the N[I] in the UUT
reg [3:0] II_JJ; // Index into M and N array for console display and file output
reg signed [3:0] signed_Ns_of_J;
reg [32*8:1] string; // a maximum of 32 characters can be stored in this string

localparam II_JJ_max  = 4'b1001;

localparam CLK_PERIOD = 20;

copy_array_to_array_imp1 UUT (Reset_tb, Clk_tb, Start_tb, Ack_tb,  
				           Qini_tb, Qls2c_tb, Qc221_tb, Qc122_tb, Qdone_tb);
				 
assign M_of_I = {UUT.M[UUT.I]}; // this is for displaying in waveform
assign N_of_J = {UUT.N[UUT.J]}; // this is for displaying in waveform		
		 
always @(*)
	begin
		case ({ Qini_tb, Qls2c_tb, Qc221_tb, Qc122_tb, Qdone_tb})
			5'b10000: state_string = "INI ";
			5'b01000: state_string = "LS2C";
			5'b00100: state_string = "C221";
			5'b00010: state_string = "C122";
			5'b00001: state_string = "DONE";
		   default: state_string = "UNKN";
		endcase
	end


initial
  begin  : CLK_GENERATOR
    Clk_tb = 0;
    forever
       begin
	      #(CLK_PERIOD/2) Clk_tb = ~Clk_tb;
       end 
  end

initial
  begin  : RESET_GENERATOR
    Reset_tb = 1;
    #(2 * CLK_PERIOD) Reset_tb = 0;
  end

initial
  begin  : CLK_COUNTER
    Clk_cnt = 0;
	# (0.6 * CLK_PERIOD); // wait until a little after the positive edge
    forever
       begin
	      #(CLK_PERIOD) Clk_cnt <= Clk_cnt + 1;
       end 
  end

initial
  begin  : STIMULUS
	file_results = $fopen("output_results.txt", "w");
	test_number = 0;
	   M_tb = 40'h0_0_0_0_0_0_0_0_0_0;
       N_tb = 40'h0_0_0_0_0_0_0_0_0_0;	   
	   memory_initialization (M_tb);
	   memory_initialization1 (N_tb);
      // these initalization before reset are not important
	   Start_tb = 0;		// except for avoiding red color
	
	wait (!Reset_tb);    // wait until reset is over
	@(posedge Clk_tb);   // wait for a clock
	$fdisplay (file_results, " ");
    $fdisplay (file_results, " Implementation #1 results ");
	$fdisplay (file_results, " ");
	
// test #1 begin
     $fdisplay (file_results, "Test #1: Negative numbers start from M[3] ");
	 M_tb = 40'hF_E_D_C_B_A_9_7_5_2;
	 N_tb = 40'h0_0_0_0_0_0_0_0_0_0;
	 test_number = test_number + 1;
	 run_test (M_tb, N_tb, test_number);

// test #1 end
// test #2 begin
     $fdisplay (file_results, "Test #2: Last number negative  ");
	 M_tb = 40'h9_7_7_6_5_4_3_2_1_0;
	 N_tb = 40'h0_0_0_0_0_0_0_0_0_0;
	 test_number = test_number + 1;
	 run_test (M_tb, N_tb, test_number);

// test #2 end

// test #3 begin
     $fdisplay (file_results, "Test #3: All numbers negative ");
	 M_tb = 40'b1111_1110_1101_1100_1011_1010_1001_1000_1000_1000;
	 N_tb = 40'h0_0_0_0_0_0_0_0_0_0;
	 test_number = test_number + 1;
	 run_test (M_tb, N_tb, test_number);

// test #3 end

// test #4 begin
     $fdisplay (file_results, "Test #4: All numbers positive ");
	 M_tb = 40'b0111_0110_0101_0100_0011_0010_0001_0000_0000_0000;
	 N_tb = 40'h0_0_0_0_0_0_0_0_0_0;
	 test_number = test_number + 1;
	 run_test (M_tb, N_tb, test_number);

// test #4 end

     $fdisplay (file_results, "All tests concluded.");
	 $fclose (file_results);
	 $display ("\n All tests concluded. Inspect the text file output_results_part1.txt. \n Current Clock Count = %0d ", Clk_cnt);
	 
	 // $stop;  // break in simulation. Enter interactive simulation mode
	end // STIMULUS

task memory_initialization; 
   input [39:0] M_local_tb;   // we could have avoided passing argument for this task as all parent variables are visible to the task.
	integer i, j;
	begin
		for (i=0; i<=9; i = i +1)
		    begin
				for (j=0; j<=3; j = j +1)
		         UUT.M[i][j]  = M_local_tb[(i*4)+j];
			end 
	end
endtask

task memory_initialization1; 
   input [39:0] N_local_tb;   
	integer i, j;
	begin
		for (i=0; i<=9; i = i +1)
		    begin
				for (j=0; j<=3; j = j +1)
		         UUT.N[i][j]  = N_local_tb[(i*4)+j];
			end 
	end
endtask

task display_M_and_N_arrays;
  begin
    // Display header for arrays
    $display("\n The M and the N arrays \n");
    $fdisplay(file_results, "\n The M and the N arrays \n");
    
    // Loop through all the rows (from 0 to 9) and display the values
    for (II_JJ = 0; II_JJ <= II_JJ_max; II_JJ = II_JJ + 1) begin
      signed_Ns_of_J = UUT.N[II_JJ];  // Assuming N array is in UUT
      string = "\n";
      
      // Print index, value of M in decimal, binary, and value of N in binary and signed decimal
      $sformat(string, "%s\t%d", string, II_JJ);   // Index in decimal
      $sformat(string, "%s\t%d", string, UUT.M[II_JJ]); // M array in decimal
      $sformat(string, "%s\t%b", string, UUT.M[II_JJ]); // M array in binary
      $sformat(string, "%s\t%b", string, signed_Ns_of_J); // N array in binary
      $sformat(string, "%s\t%d", string, signed_Ns_of_J); // N array in signed decimal
      
      // Display and write to file
      $display("%s", string);
      $fwrite(file_results, "%s\n", string);
    end  
    
  end
endtask

task run_test;
	input [39:0] M_10x3_tb; // we could have avoided passing argument for this task as all parent variables are visible to the task.
	input [39:0] N_10x3_tb; 
	input [1:0] test_numb;   // we could have avoided passing argument for this task as all parent variables are visible to the task.
	integer Start_clock_count, Clocks_taken;
	begin
		// test begins
		@(posedge Clk_tb);
		#2;
		memory_initialization (M_10x3_tb);
		memory_initialization1 (N_10x3_tb);
		Start_tb = 1;	// After a little while provide START
		@(posedge Clk_tb); 
		#5;
		Ack_tb <=0;
		Start_tb = 0;	// After a little while remove START
		Start_clock_count = Clk_cnt;
		wait (Qdone_tb);
		#5;
		Clocks_taken = Clk_cnt - Start_clock_count;
		if (Qdone_tb == 1) 
		   begin
		   display_M_and_N_arrays;
		   $fdisplay (file_results, "\nDesign entered DONE state from  %s .", last_UUT_state_string);
		   $display ("\nDesign entered DONE state from  %s .", last_UUT_state_string);
		   end
		$fdisplay (file_results, "Clocks taken for this test = %0d. \n", Clocks_taken);
		$display ("Clocks taken for this test = %0d. \n", Clocks_taken);
		Ack_tb <=0;
		#4;
		Ack_tb <=1;

	end
endtask

always @(negedge Clk_tb)
	if (UUT.Qdone != 1) last_UUT_state_string <= state_string;

endmodule