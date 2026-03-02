//////////////////////////////////////////////////////////////////////////////////
// Picoblaze 4 bit divider testbench for the divider_4_top_simulation design                 //
//     File: divider_4_top_simulation_tb.v   Gandhi Puvvada  3/13/2021                                                                  //
// Here, we want to simulate the top design which is generally uncommon.        //
//////////////////////////////////////////////////////////////////////////////////
/*
Most of our designs have been without a picoblaze processor until now. Our designs
(like the detour lab, the number lock lab, divider with single-stepping, the GCD) 
have a core design and a top design. We simulate the core design with a testbench. 
The top design interfaces the core design to Switches, Push Buttons, LEDs, and SSDs.
It has a clock divider and a scanning mechanism to deal with the SSDs. It's not convenient 
to simulate this because of clock divider, etc. And there is no need to simulate this 
top as it is essentially the same top that we have been using and it is working properly.  
*/
/*
But when it comes to the picoblaze-based design, the picoblaze and the .psm program
running on it make up the core of the design. And the top design is essential to 
to talk to the picoblaze program through the input and output ports. 
So, what we are doing in these cases is to design a simplified top for simulation  
purposes and also design a testbench to instantiate this simplified top. 
The simplified top (called divider_4_top_simulation.v here) is basically a copy 
of the original top (divider_4_top.v) with clock divider and the SSD scanning control 
removed. The module statement is substantially modified as we do not talk about
SWs/Btns/LEDs/Anodes or Cathodes for SSDs in this simplified top. 
The module statement for this simplified top would look similar to module 
statement for the earlier core designs! 
*/
/*
The following is a testbench to simulate the simplified top.  
*/

`timescale 1ns / 1ps

module divider_4_top_simulation_tb;

	// Inputs
	reg ClkPort;
	reg Reset;
	reg Start;
	reg Ack;
	reg [3:0] Xin;
	reg [3:0] Yin;

	// Outputs - to monitor
	wire [3:0] Quotient, Remainder;
	wire Qi;
	wire Qc;
	wire Qd;
	wire Done;
	
	wire [17:0] instruction;
	wire [7:0] port_id;
	wire [7:0] out_port;
	wire [7:0] in_port;
	wire [11:0] address;
	
	wire write_strobe, k_write_strobe, read_strobe;
	
	reg [2*8:0] state_string; // displays current state as string
	
	integer clk_cnt, start_clock_cnt,clocks_taken;
	integer results_file, instruction_trace_file;
	
	// Instantiate the Unit Under Test (UUT)
	divider_4_top_simulation uut (
		.ClkPort(ClkPort),
		.Xin(Xin), 
		.Yin(Yin),
		.Start(Start), 
		.Ack(Ack),
		.Reset(Reset),
		.Quotient(Quotient), 
		.Remainder(Remainder),
		.Done(Done), 
		.Qi(Qi), 
		.Qc(Qc), 
		.Qd(Qd),
		.instruction(instruction),
		.port_id(port_id),
		.in_port(in_port),
		.out_port(out_port),
		.address(address),
		.write_strobe(write_strobe), 
		.k_write_strobe(k_write_strobe), 
		.read_strobe(read_strobe)
	);

		// clock generation in the testbench
		always  begin #5; ClkPort = ~ ClkPort; end

		// clock count incrementation in the testbench
		// Note that this counter starts without an asynchronous reset 
		// through the "Reset" signal.
		// It is initialized through an "initial" construct of the Verilog.
		// This is desirable as in some systems, the reset wakes up a top system 
		// and it in turn wakes up the rest of the sub systems a little later.
		// We may like to keep a track of how many clocks were spent in this activity.
		always@(posedge ClkPort) begin 	clk_cnt=clk_cnt+1;	end


		// Like any structured testbench which generates stimulus, here also, 
		// we have an APPLY_STIMULUS task, which applies a given set of
		// inputs (dividend and divisor pair here) and monitors the results
		// (Quotient and Remainder pair here). It involves timing. Stimulus needs
		// to be applied in Qi (initial) state and we need to make sure that we 
		// allowed enough time for the picoblaze to get to read the applied stimulus
		// before we give a Start signal. In fact, I made a mistake of giving the
		// Start signal too early and it took a couple of hours to debug and find
		// that problem. One of the things, we need to realize is the important 
		// difference between testing a hardware state machine and testing a 
		// programmable state machine (psm). A hardware state machine reacts to  
		// the inputs in a clock (in the same clock). The software state machine  
		// reads the input port perhaps once in 5 to 15 instructions (which is 
		// 10 to 30 clocks in picoblaze (1 instruction = 2 clocks here).
		
		
		// generate stimulus
		initial begin
		// Initialize Inputs
		results_file = $fopen("results_divider_4.txt", "w");
		clk_cnt = 0;
		ClkPort = 0;
		Reset = 1; // Start with an active Reset signal
		Start = 0;
		Ack = 0;
		Xin = 0;
		Yin = 0;

		// wait for some time before inactivating the Reset
		// We change inputs such as Reset, Start, Ack, 1 ns after a clock edge 
		// so that it is easy to read the waveform and also it does not create
		// any ambiguity about the signal value at the edge of the clock.
		#200;
		@(posedge ClkPort); // means wait for the next clock positive clock edge
		#1; // small delay to be away from the clock edge
		Reset = 0;
		
		Xin = 7;
		Yin = 2;
		APPLY_STIMULUS(Xin, Yin); // calling the task
		
		Xin = 15;
		Yin = 3;
		APPLY_STIMULUS(Xin, Yin);

		
		Xin = 14;
		Yin = 4;
		APPLY_STIMULUS(Xin, Yin);
		
		/* // a for loop to apply a series of stimuli
		for (Xin=6; Xin<=15; Xin=Xin+1)begin
			for (Yin=5; Yin<=15; Yin=Yin+1)begin
				APPLY_STIMULUS(Xin, Yin);
			end
		end*/

	end
	
	task APPLY_STIMULUS;
		input [3:0] Xin_val;
		input [3:0] Yin_val;
		begin
			// In our specific design, in the initial state, we read the dividend-divisor pair 
			// and separately the control signal status which includes the Start signal. So, by
			// waiting for the two read strobes, we make sure that, we are allowing enough time
			// before giving a Start signal. The read-strobe is one-clock wide (page 73 of the 
			// KCPSM6 user guide). By waiting for two clocks after the read strobe goes active high,
			// you are sure that the strobe is over.
			wait (read_strobe);
			@(posedge ClkPort);
			@(posedge ClkPort);
			wait (read_strobe);
			@(posedge ClkPort);
			@(posedge ClkPort);
			#1;
			Start=1;
			// Once we activate the start signal, we do not know how long it should be kept active.
			// In a hardware state machine, if we keep the Start active for one clock, we are sure
			// that it is recognized by the state machine. In a PSM, that is not the case.
			// So, we wait until the PSM moves to the next state and reports to us that it has moved,
			// and then we inactivate the Start signal! Good strategy! (a pat on my own back!).
			wait(Qc);
			@(posedge ClkPort);
			#1;
			Start=0;
			
			start_clock_cnt=clk_cnt;
			
			// Since clocks taken in the Compute state are data-dependent, the easiest and the correct
			// way is to wait until the PSM reaches the Done state before checking the results.
			// Even after noting that it has reached the Done state, you need to wait for the processor
			// to actually report the results to the top design. 
			// In our code for the picoblaze, we have the following five instructions at the beginning 
			// of the Done state.
					/*
	state_done:	   OUTPUTK Report_Qd_Done, Current_State_port	; Indicating Current State as Done State and also the Done signal (QD, Done)	   
				   LOAD sA,s2								; Make a copy of quotient in the upper 4 bits of s2 in Register sA
				   OR  sA, s0								; Merge Quotient_Remainder into sA for reporting to the top design
				   OUTPUT sA, Quotient_Remainder_port		; Sending out Quotient and Remainder to the fabric logic
				   INPUT s4, Control_signal_port			; Load the Control Signal Information into register s4
					*/
			// Hence, besides waiting for the "Done state reaching report", if we wait till the "read_strobe" 
			// goes active, then we know for sure that the processor has finished conveying the results 
			// (Quotient_Remainder) to the Top design (and hence to the testbench).
			wait(Qd);
			wait (read_strobe);
			@(posedge ClkPort);
			@(posedge ClkPort);
			#1;
			clocks_taken = clk_cnt - start_clock_cnt;
			$display("Reporting from the Qd Done state");
			$fdisplay(results_file,"Reporting from the Qd Done state");			
			$display("Xin:%d Yin:%d Quotient:%d Remainder:%d", Xin_val, Yin_val, Quotient, Remainder);
			$display("It took %d clocks to compute the quotient", clocks_taken);
			$fdisplay(results_file,"Xin:%d Yin:%d Quotient:%d Remainder:%d", Xin_val, Yin_val, Quotient, Remainder);
			$fdisplay(results_file,"It took %d clocks to compute the quotient", clocks_taken);

			// Now we convey the Acknowledge signal through an Ack pulse.
			// How wide it should be? Well you know by this time that you need to wait till the PSM 
			// reaches the Qi state!
			Ack=1;
			wait(Qi);
			@(posedge ClkPort);
			#1;			
			Ack=0;
			@(posedge ClkPort);
			#1;			
		end
	endtask
			

	always @(*)
		begin
			case ({Qi, Qc, Qd})  
				3'b100: state_string = "Qi";  
				3'b010: state_string = "Qc";  
				3'b001: state_string = "Qd";
			endcase
		end

// Dynamic Instruction Execution Trace (DIET or DET) is an important methodology we use in our graduate courses.
// When a program does not work, we can try to debug it by single-stepping. Alternatively, 
// we can capture the actual sequence of instructions executed along with values of some key 
// registers and/or memory locations in a text file. To do so, we need a reverse assembler 
// to convert the instructions in binary to instructions in mnemonic form (human readable text form).
// KCPSM designer has already provided the reverse assembler and facilitated displaying 
// instructions in text form in the simulation waveform. 
// Reference: Lines 2548 to 2644 of kcpsm6.v
// I have further captured them along with key registers (s0, s1, s2, sa, and s4 here). 
// In addition, we record clock count (cc) so that we can quickly 
// go to the corresponding area in the waveform and look at the other signals.
// You know hierarchical reference method to access signals hidden in deep in the hierarchy.
// For example, to access the content of the register s4, we use the hierarchical reference
//    uut.processor.bank_a_s4
// uut is instance name of the top design in the testbench.
// processor is the instance name for the KCPSM6. Inside the processor code, you see that 
// bank_a_s4 is the name of the signal for the s4 register in register bank A.

// Method used here:
// Picoblaze is like a 2-stage pipeline ((more in my graduate Digital System Design course)). 
// The BRAM (Block RAM) holding the instructions has an input register causing one clock delay. 
// Hence, if you wait until the address 001 hex appears at the input of the BRAM 
// and capture the instruction at the out of the BRAM at that very moment, it would
// be the instruction at 000 hex (i.e. the very first instruction). Then after, 
// every two clocks, you can capture the next instruction. Note that the picoblaze 
// instructions take exactly two clocks to decode and execute. 
// Hence in the "forever loop" we have 
// two "@ (negedge ClkPort)".

    initial 
	begin : Trace
		reg [11:0] ADDR;
		reg [17:0] INSTR;
		reg	[1:152]	INSTR_ASCII; 
		instruction_trace_file = $fopen("instruction_trace_divider_4.txt", "w");
		ADDR = 12'h000;
		wait (address == 12'h001); 
		forever
			begin
				@ (negedge ClkPort) 
				INSTR = instruction;
				INSTR_ASCII  = uut.processor.kcpsm6_opcode ;
				$fdisplay(instruction_trace_file, "Addr: %h  Instr: %h %s Dividend_Remainder_s0: %h Divider_s1: %h Quotient_s2: %h Quotient_Remainder_sa: %h Control_s4: %h  cc: %0d ", ADDR, INSTR, INSTR_ASCII, uut.processor.bank_a_s0, uut.processor.bank_a_s1, uut.processor.bank_a_s2, uut.processor.bank_a_sa, uut.processor.bank_a_s4,  clk_cnt);
				ADDR = address;
				@(negedge ClkPort);
			end
			// Notice that "ADDR = address;" is placed after recording the current instruction. 
			// So, this ADDR is for the next instruction. There is a "ADDR = 12'h000;" before 
			// we entered the forever loop and that is for the very first instruction.
	end

endmodule
