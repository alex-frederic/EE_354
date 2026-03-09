// ----------------------------------------------------------------------
//  A Verilog module for a simple divider
//
//  Written by Gandhi Puvvada  Date: 7/17/98, 2/15/2008
//
//  File name:  divider_timing_part1.v
//  Ported to Nexys 4: Yue (Julien) Niu, Gandhi Puvvada
//  Date: Mar 29, 2020 (changed 4-bit divider to 8-bit divider, added SCEN signle step control)
// ------------------------------------------------------------------------
module divider_timing (Xin, Yin, Start, Ack, Clk, Reset,  SCEN,  // Notice SCEN
                Done, Quotient, Remainder, Qi, Qc, Qd);

input [7:0] Xin, Yin;
input Start, Ack, Clk, Reset;
output Done;
input SCEN;
output [7:0] Quotient, Remainder;
output Qi, Qc, Qd;

reg [7:0] Quotient;  // Remainder is a wire by default
reg [7:0] x, y;
reg [2:0] state;

localparam
INITIAL = 3'b001,
COMPUTE	= 3'b010,
DONE_S	= 3'b100;

assign {Qd, Qc, Qi} = state;

always @(posedge Clk, posedge Reset) 

  begin  : CU_n_DU
    if (Reset)
       begin
            state       <= INITIAL;
            x           <= 8'bXXXX_XXXX;     
            y           <= 8'bXXXX_XXXX;     
            Quotient    <= 8'bXXXX_XXXX;     // to avoid recirculating mux controlled by Reset
       end
    else
       begin
         (* full_case, parallel_case *)
         case (state)
            INITIAL : 
              begin
                  // state transitions in the control unit
                  if (Start)
                      state <= COMPUTE;
                  // RTL operations in the Data Path 
                      x <= Xin;
                      y <= Yin;
                      Quotient <= 0;
              end
            COMPUTE :
			  if (SCEN)  // Notice SCEN
              begin
                 // state transitions in the control unit
                  if (x < y)
                      state <= DONE_S;
                  // RTL operations in the Data Path 
                  if (x >= y)
                      begin
                          x <= x - y;
                          Quotient <= Quotient + 1;
                      end
              end 
            DONE_S  :
              begin  
                  // state transitions in the control unit
                  if (Ack)
                      state <= INITIAL;
                  // In DONE_S state, there are no RTL operations in the Data Path 
              end    
      endcase
    end 
  end
 
assign Remainder = x;
assign Done = (state == DONE_S) ;

endmodule  // divider_timing
