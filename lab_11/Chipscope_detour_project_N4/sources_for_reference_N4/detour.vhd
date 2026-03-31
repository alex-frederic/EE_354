------------------------------------------------------------------------------
--	A vhdl module for a detour 
--  Written by Da Cheng, Gandhi Puvvada
--  Date: 6/19/2012, 3/24/2013
------------------------------------------------------------------------------
-- Libraries and use clauses

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
-----------------------------------
entity detour is
port(
	clk, resetb: IN  std_logic;
	L: IN  std_logic; -- 1 = Left detour, 0 => Right detour
	detour_signals: OUT std_logic_vector(7 downto 0);
	state_encoded: OUT std_logic_vector(3 downto 0) --; -- state
	-- J_COUNTER: OUT std_logic_vector(3 downto 0) -- counter
	);
end detour ;

------------------------------------------------------------------------------

architecture detour_RTL of detour   is
 
type statetype is (IDLE_START_0,IDLE_START_1,IDLE_STATE, R1_state,R12_state,R123_state, R123_DIS_state,R123_REA_state,
                     L1_state,L12_state,L123_state, L123_DIS_state, L123_REA_state); 
-- Open XST User Guide UG687 (v13.2) C:\Xilinx\13.2\ISE_DS\ISE\doc\usenglish\isehelp\xst_v6s6.pdf
-- Refer to Enumerated Encoding on page 364/487.
attribute enum_encoding : string;
-- attribute enum_encoding of statetype : type is "0_0000_0000_0001 0_0000_0000_0010 0_0000_0000_0100 0_0000_0000_1000 0_0000_0001_0000 0_0000_0010_0000 0_0000_0100_0000 0_0000_1000_0000 0_0001_0000_0000 0_0010_0000_0000 0_0100_0000_0000 0_1000_0000_0000 1_0000_0000_0000"; -- If you wanted one-hot state assignment, you can do this
attribute enum_encoding of statetype : type is "0000 0001 0010 0011 0100 0101 0110 0111 1000 1001 1010 1011 1100"; -- This tells XST to use these user-selected codes for the enumerated states (we chose encoded state assignment).
signal state_enu: statetype;
-- signal state_encoded: std_logic_vector(3 downto 0);
signal J: std_logic_vector(3 downto 0); -- Local J counter

begin
   ----------
   -- J_COUNTER <= J; -- Concurrent assignment 
   ----------
   State_Output: process (state_enu)
   begin
	case (state_enu) is
	    when IDLE_START_0 => 	state_encoded <= "0000";	-- 0
		when IDLE_START_1 =>	state_encoded <= "0001";	-- 1
		when IDLE_State =>		state_encoded <= "0010";	-- 2
		when R1_state  =>		state_encoded <= "0011";	-- 3
		when R12_state  =>		state_encoded <= "0100";	-- 4
		when R123_state  =>		state_encoded <= "0101";	-- 5
		when R123_DIS_state  =>	state_encoded <= "0110";	-- 6
		when R123_REA_state  =>	state_encoded <= "0111";	-- 7
		when L1_state  =>		state_encoded <= "1000";	-- 8
		when L12_state  =>		state_encoded <= "1001";	-- 9
		when L123_state  =>		state_encoded <= "1010";	-- A
		when L123_DIS_state  =>	state_encoded <= "1011";	-- B
		when L123_REA_state  =>	state_encoded <= "1100";	-- C
		when others =>			state_encoded <= "1111";	-- F  -- This line is not necessary as we covered all states
	end case;
   end process State_Output;
   ----------
   CU: process (clk, resetb)
   begin
	  if (resetb = '0') then
			state_enu <= IDLE_START_0;
			J <= (others=>'0');
	  elsif (clk'event and clk = '1') then
	    case (state_enu) is
	      when IDLE_START_0 =>
				state_enu <= IDLE_START_1;
	      when IDLE_START_1 =>
				J <= J+'1';
				if (J = "0111") then          -- after 8 times lamp test
				  state_enu <= IDLE_STATE;
				else
				  state_enu <= IDLE_START_0;
				end if; 
		  when IDLE_State =>
				J <= (others=>'0');
  				if(L = '0') then
					state_enu <= R1_STATE;
				else 
					state_enu <= L1_STATE;
				end if;
	      when R1_state  =>
				state_enu <= R12_STATE;		  
		  when R12_state  =>
				state_enu <= R123_STATE;
		  when R123_state  =>
				state_enu <= R123_DIS_STATE;
		  when R123_DIS_state  =>
				state_enu <= R123_REA_STATE;
		  when R123_REA_state  =>
				J <= J+'1';
				if (J = "0011") then          -- after 4 flashes, repeat the growing arrow
				  state_enu <= IDLE_STATE;
				else
				  state_enu <= R123_DIS_STATE;
				end if; 
		  when L1_state  =>
				state_enu <= L12_STATE;
		  when L12_state  =>
				state_enu <= L123_STATE;
		  when L123_state  =>
				state_enu <= L123_DIS_STATE;
		  when L123_DIS_state  =>
  				state_enu <= L123_REA_STATE;
		  when L123_REA_state  =>
		   		J <= J+'1';
				if (J = "0011") then          --  after 4 flashes, repeat the growing arrow
				  state_enu <= IDLE_STATE;
				else
				  state_enu <= L123_DIS_STATE;
				end if; 
		end case;
	  end if;
	end process CU;
   ----------
	OFL: process (state_enu) -- Output function logic (OFL)
	begin
		case (state_enu) is
	      when IDLE_START_0 =>
				detour_signals <= (others=>'0');
	      when IDLE_START_1 =>
				detour_signals <= (others=>'1');
		  when IDLE_State =>
  				detour_signals <= (others=>'0');
  		  when R1_state  =>
				detour_signals <=  "00110000";
		  when R12_state  =>
				detour_signals <=  "00111100";
		  when R123_state  =>
				detour_signals <=  "00111111";
		  when R123_DIS_state  =>
				detour_signals <= (others=>'0');
		  when R123_REA_state  =>
				detour_signals <=  "00111111";
		  when L1_state  =>
				detour_signals <=  "00001100";
		  when L12_state  =>
				detour_signals <=  "00111100";
		  when L123_state  =>
				detour_signals <=  "11111100";
		  when L123_DIS_state  =>
  				detour_signals <= (others=>'0');
		  when L123_REA_state  =>
				detour_signals <=  "11111100";
		end case;
	end process OFL;
   ----------
end detour_RTL ;
------------------------------------------------------------------------------
