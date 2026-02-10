// ----------------------------------------------------------------------
// 	A Verilog module to test the ee201_debounce_DPB_SCEN_CCEN_MCEN described in ee201_debounce_DPB_SCEN_CCEN_MCEN.v
//
// 	Written by Gandhi Puvvada  Date: 7/17/98, 2/15/2008, 10/13/08, 2/28/2011, 9/24/2014
//
//      File name: ee201_debounce_DPB_SCEN_CCEN_MCEN_tb.v
// ------------------------------------------------------------------------

`timescale 1 ns / 100 ps

module ee201_debounce_DPB_SCEN_CCEN_MCEN_tb ;

reg  Clk_tb, Reset_tb;
reg  PB_tb;

wire  DPB_tb, SCEN_tb, MCEN_tb, CCEN_tb;

reg [16*8:0] state_string; // 8-character string
//constants used for state naming
localparam
 INI = 6'b000000,
 WQ = 6'b000001,
 SCEN_st = 6'b111100,
 WH = 6'b100000,
 MCEN_st = 6'b101100,
 CCEN_st = 6'b100100,
 MCEN_cont = 6'b101101,
 CCR = 6'b100001,
 WFCR = 6'b100010;
 
integer  Clk_cnt;

localparam CLK_PERIOD = 10; // to match with Nexys-3 with 1`00MHz clock

// Instantiate the UUT
// module ee201_debouncer(CLK, RESET, PB, DPB, SCEN, MCEN, CCEN);
ee201_debouncer #(.N_dc(4)) ee201_debouncer_1 
        (.CLK(Clk_tb), .RESET(Reset_tb), .PB(PB_tb), .DPB(DPB_tb), .SCEN(SCEN_tb), .MCEN(MCEN_tb), .CCEN(CCEN_tb));

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
	#(0.5 * CLK_PERIOD);
    forever
       begin
	      #(CLK_PERIOD) Clk_cnt = Clk_cnt + 1;
       end 
  end

initial
  begin  : STIMULUS
  
    PB_tb = 1'b0;
	wait (!Reset_tb);    // wait until reset is over
	@(posedge Clk_tb);    // wait for a clock

// test #1 begin
	@(posedge Clk_tb);
	 #2;  // a little (2ns) after the clock edge
	 
	 PB_tb = 1'b1;
	 # (16*CLK_PERIOD);
	 PB_tb = 1'b0;
	 # (3*CLK_PERIOD);
	 
	 
	 PB_tb = 1'b1;
	 # (3*CLK_PERIOD);
	 PB_tb = 1'b0;
	 # (4*CLK_PERIOD);
	 
	 PB_tb = 1'b1;
	 # (4*CLK_PERIOD);
	 PB_tb = 1'b0;
	 # (1*CLK_PERIOD);
	 
	 PB_tb = 1'b1;
	 # (175*CLK_PERIOD);
	 PB_tb = 1'b0;
	 # (6*CLK_PERIOD);
	 
	 PB_tb = 1'b1;
	 # (40*CLK_PERIOD);
	 PB_tb = 1'b0;
	 # (1*CLK_PERIOD);
	 
	 PB_tb = 1'b1;
	 # (60*CLK_PERIOD);
	 PB_tb = 1'b0;
	 # (6*CLK_PERIOD);
	 
	 PB_tb = 1'b1;
	 # (55*CLK_PERIOD);
	 PB_tb = 1'b0;
	 # (50*CLK_PERIOD); 
	 
	 # (1000*CLK_PERIOD);
	 $stop;
	 	 
  end // STIMULUS

  always @ (ee201_debouncer_1.state) // a combinational process to report the state in text format in the waveform
	begin : report_state	
		case (ee201_debouncer_1.state)
		// spaces distributed around the names of the state 
		// to make it an 8-character string
		INI: 		state_string  =   "   INI  ";
		WQ: 		state_string  =   "   WQ   ";
		SCEN_st: 	state_string  =   "  SCEN  ";
		WH: 		state_string  =   "   WH   ";
		MCEN_st: 	state_string  =   " MCEN_st";
		CCEN_st: 	state_string  =   " CCEN_st";
		MCEN_cont: 	state_string  =   "MCEN_con";
		CCR: 		state_string  =   "   CCR  ";
		WFCR: 		state_string  =   "  WFCR  ";
		default: 	state_string  =   " Unknown";
		endcase
	end


endmodule  // ee201_debounce_DPB_SCEN_CCEN_MCEN_tb