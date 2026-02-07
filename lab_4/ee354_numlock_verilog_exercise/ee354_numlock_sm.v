//////////////////////////////////////////////////////////////////////////////////
// Author:			Alex Frederic
// Create Date:   	02/02/2026, 
// File Name:		ee354_numlock_sm.v 
// Description: 
//
//
// Revision: 		1.1
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps

module ee354_numlock_sm(clk, reset, q_I, q_G1get, q_G1, q_G10get, q_G10, q_G101get,
                        q_G101, q_G1011get, q_G1011, q_Opening, q_Bad, U, Z, Unlock);

	/*  INPUTS */
	// Clock & Reset
	input		clk, reset;
	input       U, Z;

	/*  OUTPUTS */
	output q_I, q_G1get, q_G1, q_G10get, q_G10, q_G101get;
    output q_G101, q_G1011get, q_G1011, q_Opening, q_Bad;
    output Unlock;

    // store current state
	reg [10:0] state;	
	assign {q_Bad, q_Opening, q_G1011, q_G1011get, q_G101, q_G101get, q_G10,
            q_G10get, q_G1, q_G1get, q_I} = state;

	// lets make accessing the state information easier within the state machine code
	// each line aliases the approriate state bits and sets up a 1-hot code
	localparam
	    QI		    =   11'b00000000001,
	    QG1get	    =   11'b00000000010,
	    QG1	        =   11'b00000000100,
	    QG10get	    =   11'b00000001000,
	    QG10	    =   11'b00000010000,
	    QG101get	=   11'b00000100000,
	    QG101   	=   11'b00001000000,
        QG1011get   =   11'b00010000000,
        QG1011      =   11'b00100000000,
        QOpening    =   11'b01000000000,
        QBad        =   11'b10000000000,
	    UNK		    =   11'bXXXXXXXXXXX;
	

    // Configure Timerout signal
    reg [3:0] Timerout_count;
    wire Timerout;
    assign Timerout = (Timerout_count[3]) & (Timerout_count[2]) & (Timerout_count[1]) & (Timerout_count[0]);

    always @ (posedge clk, posedge reset)
    begin : TIMEROUT_COUNT
        if (reset)
            Timerout_count <= 0;
        else
            if (state == QOpening)
                Timerout_count <= Timerout_count + 1;
            else
                Timerout_count <= 0;
    end


	// NSL AND SM
	always @ (posedge clk, posedge reset)
	begin
		if(reset)
			state <= QI;
		else 
		begin
			case(state)
                QI:
                    if (U==1 && Z==0)
                        state <= QG1get;
                QG1get:
                    if (U==0)
                        state <= QG1;
                QG1:
                    if (U==0 && Z==1)
                        state <= QG10get;
                    else if (U==1)
                        state <= QBad;
                QG10get:
                    if (Z==0)
                        state <= QG10;
                QG10:
                    if (U==1 && Z==0)
                        state <= QG101get;
                    else if (Z==1)
                        state <= QBad;
                QG101get:
                    if (U==0)
                        state <= QG101;
                QG101:
                    if (U==1 && Z==0)
                        state <= QG1011get;
                    else if (Z==1)
                        state <= QBad;
                QG1011get:
                    if (U==0)
                        state <= QG1011;
                QG1011:
                    state <= QOpening;
                QOpening:
                    if (Timerout==1)
                        state <= QI;
                QBad:
                    if (U==0 && Z==0)
                        state <= QI;
                default:
                    state <= UNK;
            endcase
		end
	end
	
	// OFL
	assign Unlock = state[9];
	
endmodule
