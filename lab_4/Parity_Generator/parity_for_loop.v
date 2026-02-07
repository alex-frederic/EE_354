
/////////////////////////////////////////////////
// Course: EE354L                              // 
// File: parity_for_loop.v using a "for" loop  //
// Gandhi Puvvada 1/29/2019                    //
///////////////////////////////////////////////// 

`timescale 1ns / 100ps

module parity (X, p);

	//inputs
	input[7:0] X;
	
	//outputs
	output p; // p for parity
	
	//declarations
	reg p;      // Notice the "reg" declaration,
				// This is because p is on the LHS of a statement 
				// in a begin..end block in an always construct 
				
	integer i;  // "for" loop iteration control
	
//************** // TO DO // COMPLETE THE "for" LOOP BELOW	******************************
	//parity generation 
	always @(*) begin
		p = 0;     // Notice the need for starting with zero before the "for" loop
		for (i = 0; i <= 7; i = i+1)                       // Check syntax for the "for" loop on page 71 of the guide
			begin 
				// Decide whether to use blocking assignment or non-blocking assignment. 
				// What happens if you use the wrong assignment. Discuss with your TA.
				p = p ^ X[i];
			end
	end


endmodule
