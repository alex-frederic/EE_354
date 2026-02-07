/*
File     : test_nexys4_verilog.v (based on test_nexys3_verilog.v)
Author of the original test_nexys3_verilog.v code  : Gandhi Puvvada
Ported from Nexys-3 to Nexys-4 by: Siqi Sun <siqisun@usc.edu> and Runyi Li <runyili@usc.edu>
Revision  : 1.0
Date of the original code: Feb 14, 2008, Aug 29, 2011, Jan 10, 2011
Date of porting: 5/14/2019
*/
/* 
Copyright (c) 2019 by Gandhi Puvvada, EE-Systems, USC, Los Angeles, CA 90089
USC students are encouraged to copy sections of this code freely.
They need not acknowledge or state that they have extracted those sections.
*/

/*
This is a verilog module for testing the Nexys-4 board from Digilent Inc.

The program does the following:

BtnC (the Center button) acts as a reset to our test system.

The dot-points on the 8 SSDs flash at a slow rate.

The 16-bit value set by the switches (SW15-SW0) is displayed
on the 7-seg. displays. The true value of the switches is displayed 
on right four 7-segment displays and the complement of the switches
on the left four 7-segment displays.
The 16 LEDs (LD15-LD0)display a walking-led pattern. However when one or more
buttons (BtnL, BtnU, BtnD, BtnR) is/are pressed, corresponding LEDs glow
and the walking LED display is temporarily suspended.
BtnL controls LD15, LD14, LD13, and LD12.
BtnU controls LD11, LD10, LD9,  and LD8.
BtnD controls LD7,  LD6,  LD5,  and LD4.
BtnL controls LD3,  LD2,  LD1,  and LD0.

Make sure to use the test_nexys4_verilog.xdc 
This file contains pin info.

When you setup the project on webpack_ISE or webpack_Vivado,
selct the following project properties:
Family: Artix-7
Device: XC7A100T
Package: CSG324
Speed grade: -1 (i.e. -1C; C=Comercial Temperature)

On the package of the Artix-7 FPGA chip on the Nexys-4 board, the inscriptions read
XC7A100T
CSG324ACX1345
D4635423A
1C
https://www.xilinx.com/support/documentation/data_sheets/ds197-xa-artix7-overview.pdf
https://www.xilinx.com/support/documentation/data_sheets/ds181_Artix_7_Data_Sheet.pdf
https://www.xilinx.com/support/documentation/selection-guides/7-series-product-selection-guide.pdf

------------------------------------------------------------------------------
 */
/*
Some naming conventions we will follow:

- module names and file names: all lower case
- Input and Output variables start with an Upper case alphabet.
- Internal variables start with lower case alphabet.
- Active low signals have a _b suffix. 
- Parameters are all in UPPER CASE
- Macros (`define) also are in all UPPER CASE
*/

module test_nexysA7_verilog    
        (   
		QuadSpiFlashCS, // Disable the three memory chips

        ClkPort,                           // the 100 MHz incoming clock signal
		
		BtnL, BtnU, BtnD, BtnR,            // the Left, Up, Down, and the Right buttons 
		BtnC,                              // the center button (this is our reset in most of our designs)
		//SW7, SW6, SW5, SW4, SW3, SW2, SW1, SW0, // 8 switches
		SW15, SW14, SW13, SW12, SW11, SW10, SW9, SW8, SW7, SW6, SW5, SW4, SW3, SW2, SW1, SW0, // 16  switches
		//LD7, LD6, LD5, LD4, LD3, LD2, LD1, LD0, // 8 LEDs
		LD15, LD14, LD13, LD12, LD11, LD10, LD9, LD8, LD7, LD6, LD5, LD4, LD3, LD2, LD1, LD0, // 16 LEDs
		//An3, An2, An1, An0,			       // 4 anodes
		AN7, AN6, AN5, AN4, AN3, AN2, AN1, AN0,			       // 8 anodes
		CA, CB, CC, CD, CE, CF, CG,        // 7 cathodes
		DP                                 // Dot Point Cathode on SSDs
	  );
									
  
  output	QuadSpiFlashCS;

  input 	 ClkPort;
  input		 BtnL, BtnU, BtnD, BtnR, BtnC;
  input		 SW15, SW14, SW13, SW12, SW11, SW10, SW9, SW8, SW7, SW6, SW5, SW4, SW3, SW2, SW1, SW0;

  output		 LD15, LD14, LD13, LD12, LD11, LD10, LD9, LD8, LD7, LD6, LD5, LD4, LD3, LD2, LD1, LD0;
  output		 AN7, AN6, AN5, AN4, AN3, AN2, AN1, AN0;
  output		 CA, CB, CC, CD, CE, CF, CG;
  output		 DP;

// local signal declaration

  wire         reset;
  wire         board_clk;
  //wire         sys_clk;        	// to control student core design
  wire [3:0]   slow_bits;      	// to control walking led pattern
  wire [2:0]   sev_seg_clk; 		// to control SSD scanning
  reg  [27:0]  divclk;
//------------ 

// Disable the three memories so that they do not interfere with the rest of the design.
assign QuadSpiFlashCS = 1'b1;

// CLOCK DIVISION

	// The clock division circuitary works like this:
	//
	// ClkPort ---> [BUFGP1] ---> board_clk
	// board_clk ---> [clock dividing counter] ---> divclk
	// divclk ---> [constant assignment] ---> sys_clk;
	BUFGP BUFGP1 (board_clk, ClkPort); 	

// As the ClkPort signal travels throughout our design,
// it is necessary to provide global routing to this signal. 
// The BUFGPs buffer these input ports and connect them to the global 
// routing resources in the FPGA.

	// BUFGP BUFGP2 (reset, BtnC); In the case of Spartan 3E (on Nexys-2 board), we were using BUFGP to provide global routing for the reset signal. But Spartan 6 (on Nexys-3) does not allow this.
	assign reset = BtnC;

//------------
	// Our clock is too fast (100MHz) for SSD scanning
	// create a series of slower "divided" clocks
	// each successive bit is 1/2 frequency
  always @(posedge board_clk, posedge reset) 	
    begin							
        if (reset)
		divclk <= 0;
        else
		divclk <= divclk + 1'b1;
    end
//------------
  assign DP = divclk[25]; // The dot point on each SSD flashes 
                  // divclk[25] (~1.5Hz) = (100MHz / 2**26)	
			// count the number of flashes for a minute, you should get about 90
  
//assign sys_clk = divclk[18];  // a slow clock for use by students core design 
                                // divclk[18] (~191Hz) = (1000MHz / 2 **19)
  assign sev_seg_clk  = divclk[17:14]; // 7 segment display scanning is completed 
						 // every divclk[17] (~381Hz) = (100MHz / 2 **18)
  
  assign slow_bits  =  divclk[26:23];

//------------         
// Buttons and LEDs

  wire         button_pressed;

  assign button_pressed = BtnL | BtnU | BtnD | BtnR ;

  wire  [15:0]   leds;
  reg   [15:0]   walking_leds;
    
  assign {LD15, LD14, LD13, LD12, LD11, LD10, LD9, LD8, LD7, LD6, LD5, LD4, LD3, LD2, LD1, LD0} = leds;
  assign leds =	button_pressed ? {BtnL, BtnL, BtnL, BtnL, BtnU, BtnU, BtnU, BtnU, BtnD, BtnD, BtnD, BtnD, BtnR, BtnR, BtnR, BtnR} :
                       ( divclk[27] ? 16'b0000000000000000 : walking_leds );
  // Notice that when divclk[27] is zero, the slow_bits (i.e. divclk[26:23])
  // go through a complete sequence of 0000-1111.

  always @ (slow_bits)
    begin
      case (slow_bits)
        4'b0000: walking_leds = 16'b1000000000000001 ;
        4'b0001: walking_leds = 16'b0100000000000010 ;
        4'b0010: walking_leds = 16'b0010000000000100 ;
        4'b0011: walking_leds = 16'b0001000000001000 ;
        4'b0100: walking_leds = 16'b0000100000010000 ;
        4'b0101: walking_leds = 16'b0000010000100000 ;
        4'b0110: walking_leds = 16'b0000001001000000 ;
        4'b0111: walking_leds = 16'b0000000110000000 ;
		4'b1000: walking_leds = 16'b0000000110000000 ;
        4'b1001: walking_leds = 16'b0000001001000000 ;
        4'b1010: walking_leds = 16'b0000010000100000 ;
        4'b1011: walking_leds = 16'b0000100000010000 ;
        4'b1100: walking_leds = 16'b0001000000001000 ;
        4'b1101: walking_leds = 16'b0010000000000100 ;
        4'b1110: walking_leds = 16'b0100000000000010 ;
        4'b1111: walking_leds = 16'b1000000000000001 ;
        default: walking_leds = 16'bXXXXXXXXXXXXXXXX ;
      endcase
    end
//------------
// SSD (Seven Segment Display)

reg  [3:0] SSD;
wire [7:0] SSD7, SSD6, SSD5, SSD4, SSD3, SSD2, SSD1, SSD0;

assign AN0	= ~(~(sev_seg_clk[2]) && ~(sev_seg_clk[1]) && ~(sev_seg_clk[0]));  // when sev_seg_clk = 000
assign AN1	= ~(~(sev_seg_clk[2]) && ~(sev_seg_clk[1]) &&  (sev_seg_clk[0]));  // when sev_seg_clk = 001
assign AN2	= ~(~(sev_seg_clk[2]) &&  (sev_seg_clk[1]) && ~(sev_seg_clk[0]));  // when sev_seg_clk = 010
assign AN3	= ~(~(sev_seg_clk[2]) &&  (sev_seg_clk[1]) &&  (sev_seg_clk[0]));  // when sev_seg_clk = 011
assign AN4	= ~( (sev_seg_clk[2]) && ~(sev_seg_clk[1]) && ~(sev_seg_clk[0]));  // when sev_seg_clk = 100
assign AN5	= ~( (sev_seg_clk[2]) && ~(sev_seg_clk[1]) &&  (sev_seg_clk[0]));  // when sev_seg_clk = 101
assign AN6	= ~( (sev_seg_clk[2]) &&  (sev_seg_clk[1]) && ~(sev_seg_clk[0]));  // when sev_seg_clk = 110
assign AN7	= ~( (sev_seg_clk[2]) &&  (sev_seg_clk[1]) &&  (sev_seg_clk[0]));  // when sev_seg_clk = 111

assign SSD0 = {   SW3,   SW2,   SW1,   SW0};
assign SSD1 = {   SW7,   SW6,   SW5,   SW4};
assign SSD2 = {  SW11,  SW10,   SW9,   SW8};
assign SSD3 = {  SW15,  SW14,  SW13,  SW12};
assign SSD4 = {  ~SW3,  ~SW2,  ~SW1,  ~SW0};
assign SSD5 = {  ~SW7,  ~SW6,  ~SW5,  ~SW4};
assign SSD6 = { ~SW11, ~SW10,  ~SW9,  ~SW8};
assign SSD7 = { ~SW15, ~SW14,  ~SW13, ~SW12};

always @ (sev_seg_clk, SSD0, SSD1, SSD2, SSD3, SSD4, SSD5, SSD6, SSD7)
begin
   case (sev_seg_clk) 
           3'b000: SSD = SSD0;
           3'b001: SSD = SSD1;
           3'b010: SSD = SSD2;
           3'b011: SSD = SSD3;
		   3'b100: SSD = SSD4;
           3'b101: SSD = SSD5;
           3'b110: SSD = SSD6;
           3'b111: SSD = SSD7;
   endcase 
end

reg [6:0]  cathodes;

assign   {CA, CB, CC, CD, CE, CF, CG} = cathodes; 
//
// Following is Hex-to-SSD conversion. 
always @ (SSD)
    begin
      case (SSD)
        4'b0000: cathodes = 7'b0000001 ; // 0
        4'b0001: cathodes = 7'b1001111 ; // 1
        4'b0010: cathodes = 7'b0010010 ; // 2
        4'b0011: cathodes = 7'b0000110 ; // 3
        4'b0100: cathodes = 7'b1001100 ; // 4
        4'b0101: cathodes = 7'b0100100 ; // 5
        4'b0110: cathodes = 7'b0100000 ; // 6
        4'b0111: cathodes = 7'b0001111 ; // 7
        4'b1000: cathodes = 7'b0000000 ; // 8
        4'b1001: cathodes = 7'b0000100 ; // 9
        4'b1010: cathodes = 7'b0001000 ; // A
        4'b1011: cathodes = 7'b1100000 ; // b
        4'b1100: cathodes = 7'b0110001 ; // C
        4'b1101: cathodes = 7'b1000010 ; // d
        4'b1110: cathodes = 7'b0110000 ; // E
        4'b1111: cathodes = 7'b0111000 ; // F    
        default: cathodes = 7'bXXXXXXX ; // default is actually not needed as we covered all cases
      endcase
    end

// Notice that, when the reset button (BtnC) is pressed, the divclk counter 
// is held in the reset (cleared) state and scanning stops. Only An0 anode will be active and 
// the right-most SSD displays SSD0 in much brighter fashion (4 times brighter)!
//------------
endmodule