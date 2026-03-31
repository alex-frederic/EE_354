------------------------------------------------------------------------------
--	File name: detour_top.vhd  
--  Written by Da Cheng, Gandhi Puvvada on 6/19/2012
--  Revised substantially by Gandhi Puvvada on 3/24/2013
--  Date: 6/19/2012, 3/24/2013, 6/7/2020
--  Runyi Li <runyili@usc.edu> added ILA in Vivado 5/28/2019 
--  This code is provided to EE560 and EE201L students in completed form 
--  so that they try to add chipscope ILA to this design (using core instantiation flow) 
--  to capture and display signals. 
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library UNISIM;
use UNISIM.VComponents.all; -- Xilinx primitive BUFGP

entity detour_top is

port	(ClkPort:  in std_logic;
	    SW0, SW1, SW2, SW3, SW4: in std_logic; -- SW0 is the left/right detour select button.
		-- The SW1, SW2, and SW3 are used to demonstrate trigger sequencer usage in chipscope
		-- The SW4 is used to demonstrate storage condition
		BtnC: in std_logic;	             -- the Left, Up, Right, Down, and Center buttons
		CA,CB,CC,CD,CE,CF,CG,DP : out std_logic;
		AN0,AN1,AN2,AN3,AN4,AN5,AN6,AN7: out std_logic;
	    LD7, LD6, LD5, LD4, LD3, LD2, LD1, LD0: out std_logic; -- 
	    MemOE, MemWR, RamCS, QuadSpiFlashCS : out std_logic -- Nexys4
		);
end  detour_top ;
------------------------------------------------------------------------------
architecture detour_top_arc of detour_top   is
	------------
	signal RESET: std_logic; -- pressing BtnC means RESET
	signal BCLK: std_logic; -- buffered clock
	signal clk : std_logic; -- divided clock
	signal sev_seg_clk: std_logic_vector (1 downto 0); -- for scan control of the 7-seg. displays	
	signal display_digit:   std_logic_vector (3 downto 0); -- hex digit to be sent to 7-seg
	signal SSD: std_logic_vector (6 downto 0); -- Seven Segment Display Digit
	
	signal L, resetb :        std_logic;
	signal detour_signals : std_logic_vector(7 downto 0);
	signal divclk : std_logic_vector(31 downto 0);
	signal state_encoded: std_logic_vector(3 downto 0); -- state
	-- signal J_COUNTER: std_logic_vector(3 downto 0); -- counter
	signal JC_Copy: std_logic_vector(3 downto 0); -- J_COUNTER copy created in the top design
	-- We want to illustrate a situation where there are hidden signals which are not normally brought out such as J in the core design and we need to tap that for debugging.
	-- This JC_Copy is created to aid display but we can say that the real design does not have this JC_Copy
	------------	
	--component declarations done here
	------------	
	component detour 
	  port (
		clk, resetb: IN  std_logic;
		L: IN  std_logic; -- 1 = Left detour, 0 => Right detour
		detour_signals: OUT std_logic_vector(7 downto 0);
	    state_encoded: OUT std_logic_vector(3 downto 0) -- ; -- state
	    -- J_COUNTER: OUT std_logic_vector(3 downto 0) -- counter
		);	
	end component;
	
	component BUFGP
         port (I: in std_logic; O: out std_logic);
	end component;
	
	------------	
	-- Xilinx Vivado provides ila_Racheal_Dheeraj.vho (a VHDL Instantiation template) 
		-- when you configure and generate the ILA core as shown below.
	------------- Begin Cut here for COMPONENT Declaration ------ COMP_TAG
		-- COMPONENT ila_Racheal_Dheeraj

		-- PORT (
			-- clk : IN STD_LOGIC;
			
			-- probe0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			-- probe1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			-- probe2 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			-- probe3 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			-- probe4 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			-- probe5 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			-- probe6 : IN STD_LOGIC_VECTOR(0 DOWNTO 0)	
			-- );
		-- END COMPONENT  ;

-- COMP_TAG_END ------ End COMPONENT Declaration ------------
--	
	------------
	
	
	------------
	-- -- TODO #1
    -- ILA signals and component declarations done here
	-- Uncomment the following lines when you add a chipscope ILA.
	       -- Use Block Uncomment utility under Edit => Comment/Uncommnet in Notepad++
		   -- You can select the set of lines using your mouse and right-click to find this Comment/Uncommnet option
    ------------    
	signal data_to_sample : std_logic_vector(15 downto 0);
    signal ILA_JC_Copy: std_logic_vector(3 downto 0);
    signal ILA_sw1: std_logic_vector(0 to 0);
    signal ILA_sw2: std_logic_vector(0 to 0);
    signal ILA_sw3: std_logic_vector(0 to 0);
    signal ILA_sw4: std_logic_vector(0 to 0);
    -- signal ILA_Trigger_probe6: std_logic_vector(0 to 0);
    signal ILA_Capture_Qualification: std_logic_vector(0 to 0);

    -- -- TODO #2
	-- Important: component ila_Racheal_Dheeraj -- named after our two mentors who worked on this lab
	-- You choose Component name as ila_TeamMember1FirstName_TeamMember2FirstName to distinguish from others

    component ila_Racheal_Dheeraj -- Choose Component name as ila_TeamMember1FirstName_TeamMember2FirstName
      PORT (
         clk : IN STD_LOGIC;
         
         probe0 : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
         probe1 : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
         probe2 : IN STD_LOGIC_VECTOR(0 TO 0);
         probe3 : IN STD_LOGIC_VECTOR(0 TO 0);
         probe4 : IN STD_LOGIC_VECTOR(0 TO 0);
         probe5 : IN STD_LOGIC_VECTOR(0 TO 0);
         probe6 : IN STD_LOGIC_VECTOR(0 TO 0)
         );

    end component;
   ------------
   ------------

begin
	------------
	BUF_GP_1:   BUFGP   port map (I => CLKPORT, O => BCLK); 
	
	RESET <= BtnC;		 -- You reset by pushing BtnC
	resetb <= not (RESET); -- low active reset for the core design
	
	
	L <= SW0; -- 1 = Left detour, 0 => Right detour
	
	
	-- Disable the memories so that they do not interfere with the rest of the design.
	MemOE <= '1';  RamCS <= '1';  
	MemWR <= '1';  QuadSpiFlashCS <= '1'; 
	
	CLOCK_DIVIDER: process (BCLK, RESET)
						 begin
							 if (RESET = '1') then
								 divclk <= (others => '0');
							 elsif (BCLK'event and BCLK = '1') then
								 divclk <= divclk + '1';
							 end if;
							 -- -- TODO #3
							 -- -- Uncomment the following five lines when you add a chipscope.
							 if (divclk(23 downto 0) = x"FFFFF0") then
							 ILA_Capture_Qualification(0) <=  '1';
							 else
							 ILA_Capture_Qualification(0) <=  '0';
							 end if;
							 
						 end process CLOCK_DIVIDER;
--  ILA needs a free running clock to control it. So we will connect BCLK to it.
--  But, if we start collecting every BCLK one sample, then, for this slow running detour system, 
--  we will be collecting too many samples and we do not have enough storeage to store the samples.
--  So we want to collect 
--    	either 
--			two samples for every clock of the divclk(25), 
--  		once in the middle of its high period and 
--			once in the middle of its low period by using 
--			(divclk(24 downto 0) = x"1000000") as the 
--			the ILA_Capture_Qualification
-- 		or
--			four samples for every clock of the divclk(25), 
--  		twice in the middle of its high period and 
--			twicw in the middle of its low period by using 
--			(divclk(24 downto 0) = x"1000000") as the 
--			the ILA_Capture_Qualification
-- 		
--  That is the purpose of the above ILA_Capture_Qualification.


						 
 -- divclk(25), a very low frequency is deliberately chosen so as to make the detour signal cycle through states slowly for humans to observe

	clk <= divclk(25); --  divclk(25) = (~1.5Hz) = (100MHz / 2**26)              
	
	detour_1:detour
	
		port map (
					 clk, resetb,L, detour_signals, state_encoded -- , J_COUNTER
					);
					
	------------
	-- -- TODO #4
	-- ILA connections and instantiation here
	-- Uncomment the following lines when you add a chipscope ILA.
	       -- Use Block Uncomment utility under Edit => Comment/Uncommnet in Notepad++
		   -- You can select the set of lines using your mouse and right-click to find this Comment/Uncommnet option
	------------
	-- -- ILA related connections
	data_to_sample(0) <= divclk(25); -- the sytem clock
                
    data_to_sample(1) <= detour_signals(0);
    data_to_sample(2) <= detour_signals(2);
    data_to_sample(3) <= detour_signals(4);
    data_to_sample(4) <= detour_signals(6);
                                        
    data_to_sample(8 downto 5) <= state_encoded;
                                        
    data_to_sample(12 downto 9) <= JC_copy;
                                        
    data_to_sample(13) <= SW1;
    data_to_sample(14) <= SW2;
    data_to_sample(15) <= SW3;
                              
                              
   ILA_JC_Copy <= JC_Copy;     -- probe1
   ILA_sw1 <= (others => SW1); -- probe2
   ILA_sw2 <= (others => SW2); -- probe3
   ILA_sw3 <= (others => SW3); -- probe4
   ILA_sw4 <= (others => SW4); -- probe5
   -- ILA_Trigger_probe6 <= ILA_Capture_Qualification; --we activate sample qualification every 2^^24 clocks.
   
   --------

    -- -- TODO #5
	-- Important: component ila_Racheal_Dheeraj -- named after our two mentors who worked on this lab
	-- Also the instantiation name has a suffix _RD indicating the initials of the two mentors.
	-- You choose Component name as ila_TeamMember1FirstName_TeamMember2FirstName to distinguish from others
	-- Also you choose instant name according to your initials.


   -- -- ILA Instantiation
   
   ILA_RD : ila_Racheal_Dheeraj  
   port map (
                                              
   clk => BCLK,  -- use 100MHz as input clock, 
   probe0 => data_to_sample,
   probe1 => ILA_JC_Copy,
   probe2 => ILA_sw1,
   probe3 => ILA_sw2,
   probe4 => ILA_sw3,
   probe5 => ILA_sw4,
   probe6 => ILA_Capture_Qualification
   );
					
	------------
					
	------------   	
	-- 	JC_Copy (J_COUNTER copy created in the top design) generation
	JC_Gen: process (clk, RESET)
						 begin
							 if (RESET = '1') then
								 JC_Copy <= (others => '0');
							 elsif (clk'event and clk = '1') then
								case (state_encoded) is
									when ("0010")    =>  -- when in IDLE_State
										JC_Copy <= (others => '0');
									when  ("0001") | ("0111") | ("1100")  => -- when state is IDLE_START_1 or R123_REA_state or L123_REA_state
										JC_Copy <= JC_Copy + '1';
									when others    =>  -- when in IDLE_State
										null;
								end case;
							 end if;
						 end process JC_Gen;
					
	------------        
	LD7 <= detour_signals(7) ;
    LD6 <= detour_signals(6) ;
    LD5 <= detour_signals(5) ;
    LD4 <= detour_signals(4) ;
    LD3 <= detour_signals(3) ;
	LD2 <= detour_signals(2) ;
	LD1 <= detour_signals(1) ;
	LD0 <= detour_signals(0) ;
	------------

		
	DP <= divclk(25) and (not SW1) and (not SW2) and (not SW3) and (not SW4) ; 
	-- dot points flash when downloading is successful provided all the three switches (1,2,and3) are down.
	-- notice that we wanted to use the three switches in our design to do some operation, or otherwise they get trimmed away by XST!
		
	AN4 <= '1'; AN5 <= '1'; AN6 <= '1'; AN7 <= '1'; 

	-- need a scan clk for the seven segment display 
	-- 191Hz (100 MHz / 2^19) works well	
	sev_seg_clk  <= divclk(19 downto 18); -- 7 segment display scanning 
	------------
	------------
		process (sev_seg_clk)
		 begin
			AN0 <= '1'; AN1 <= '1'; AN2 <= '1'; AN3 <= '1'; 
			-- Note: The above default assignments are needed so that
			-- we can assign an active value selectively to one anode at a time
			-- The anodes or driven through inverting power transistor. So the anode xontrol signals are active low.
			case sev_seg_clk  is
				 when "00" => AN0 <= '0'; -- SSD0 right-most
				 -- In this detour design we are not using the middle two digits
				 -- when "01" => AN1 <= '0'; -- SSD1
				 -- when "10" => AN2 <= '0'; -- SSD2
				 when "11" => AN3 <= '0'; -- SSD3 left-most
				 when others => AN0 <= '1'; AN3 <= '1';
			end case;
		 end process;
	------------
		with sev_seg_clk  select
			display_digit <=      state_encoded when "11",    -- SSD3  left-most
								  state_encoded when "10",    -- SSD2  <== We have disabled this digit anyway
								  JC_Copy  when "00",    -- SSD0  right-most
								  JC_Copy  when others;  -- SSD1 <== We have disabled this digit anyway
								  -- J_COUNTER     when "01",    -- SSD1  <== We have disabled this digit anyway
								  -- J_COUNTER     when others;  -- SSD0 right-most
	------------
		with display_digit select
			SSD <=   "0000001" when "0000",  --0
					 "1001111" when "0001",  --1
					 "0010010" when "0010",  --2
					 "0000110" when "0011",  --3
					 "1001100" when "0100",  --4
					 "0100100" when "0101",  --5
					 "0100000" when "0110",  --6
					 "0001111" when "0111",  --7
					 "0000000" when "1000",  --8
					 "0000100" when "1001",  --9
					 "0001000" when "1010",  --A
					 "1100000" when "1011",  --b
					 "0110001" when "1100",  --C
					 "1000010" when "1101",  --d
					 "0110000" when "1110",  --E
					 "0111000" when "1111",  --F
					 "1111111" when others;  --?
	
	(CA,CB,CC,CD,CE,CF,CG) <= SSD; -- aggregate notation on the left
	------------

end detour_top_arc ;
------------------------------------------------------------------------------
