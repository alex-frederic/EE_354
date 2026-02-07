
///////////////////////////////////////////////////
// Course: EE354L                                // 
// File: parity_tb.v                             //
// used for all versions of the parity generator //
// Gandhi Puvvada 1/28/2019                      //
/////////////////////////////////////////////////// 

`timescale 1ns / 100ps

module parity_tb;

// local variable declarations
    reg [7:0] X_tb;
    wire p_tb; // parity
    wire p_expected;
	integer i_tb;  // "for" loop iteration control

    parity DUT (     // DUT = Design Under Test; just an instance label
        .X(X_tb),
        .p(p_tb)
		       );

	assign p_expected = X_tb[7] ^ X_tb[6] ^ X_tb[5] ^ X_tb[4] ^ X_tb[3] ^ X_tb[2] ^ X_tb[1] ^ X_tb[0]; 

	// Generate stimulus to DUT (Design Under Test) also called UUT (Unit Under Test)
	// and verify if the DUT produced correct parity 
    initial 
		begin  // 
			X_tb = 8'b00000000;
			for (i_tb=1; i_tb<=256; i_tb=i_tb+1) // Notice the syntax of the for loop
			// Should it be 255 iterations or 256 iterations? 
			// Well we already made X_tb=0 outside the for loop.
			// So Mr. ___________ (Trojan/Bruin) says that 255 iterations are enough 
			// to take X_tb through all possible 8-bit values!
			// But Mr. ___________ (Trojan/Bruin) cautions that after the last value is assigned,
			// we need to go through the loop once more so that its result is verified!
			begin 
				#10; // wait for 10 ns and then increment X_tb
				if (p_tb != p_expected)
					$display("Parity was wrongly generated as %b for X_tb of %b .", p_tb, X_tb);
				else
					$display("Parity was correctly generated as %b for X_tb of %b .", p_tb, X_tb);
				// Notice that we allow time (10ns here) after a new value is given
				// to X_tb before we check p_tb. Well, a delta-T is all what we need, as 
				// we are doing what is called a behavioral simulation with zero delays.
				X_tb = X_tb + 1; // every 10ns, let us increment
			end
		
		end


endmodule

