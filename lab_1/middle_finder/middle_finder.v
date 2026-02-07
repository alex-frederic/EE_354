// ----------------------------------------------------------------------
// 	A Verilog module for a  middle_finder
//
// 	Written by Gandhi Puvvada  Date: 8/28/2008
//      This is basically a translation of my earlier middle_finder.vhd
//
//      File name:  middle_finder.v
// ------------------------------------------------------------------------

module middle_finder (A, B, C, MIDDLE);

input [3:0] A, B, C;
output MIDDLE;

reg [3:0] MIDDLE;  // MIDDLE is the middle number of the three: A, B. C

always @(A, B, C) 

  begin  : middle_finder_block
	if (A > B) // if A is bigger than B
		begin
			if (B > C) // if further B is bigger thab C
				begin
					MIDDLE <= B;
				end
			else //  B is the smallest
				begin
					if (A > C) // if A is bigger than C, then C is the middle number
						begin
							MIDDLE <= C;
						end
					else  // else A is the middle number
						begin
							MIDDLE <= A;
						end
				end
		end
	else // if B is bigger than A
		begin
			if (A > C) // if  B > A > C
				begin
					MIDDLE <= A;
				end
			else //  A is the smallest
				begin
					if (B > C) // B > C > A
						begin
							MIDDLE <= C;
						end
					else  // C > B > A
						begin
							MIDDLE <= B;
						end
				end
		end
		
  end // middle_finder_block


endmodule  // middle_finder