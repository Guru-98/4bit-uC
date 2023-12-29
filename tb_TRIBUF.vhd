--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:38:18 02/05/2018
-- Design Name:   
-- Module Name:   D:/Documents/Academic/SEM VI/LAB/VLSI/Experiment/tb_TRIBUF.vhd
-- Project Name:  Microprocessor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TRIBUF
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_TRIBUF IS
END tb_TRIBUF;
 
ARCHITECTURE behavior OF tb_TRIBUF IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TRIBUF
    PORT(
         DIN : OUT  std_logic_vector(3 downto 0);
         D : INOUT  std_logic_vector(3 downto 0);
         M_DOUT : IN  std_logic_vector(3 downto 0);
         WR_BAR : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal M_DOUT : std_logic_vector(3 downto 0) := (others => '0');
   signal WR_BAR : std_logic := '1';

	--BiDirs
   signal D : std_logic_vector(3 downto 0);

 	--Outputs
   signal DIN : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TRIBUF PORT MAP (
          DIN => DIN,
          D => D,
          M_DOUT => M_DOUT,
          WR_BAR => WR_BAR
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		
		M_DOUT <= "1011";
		
		wait for 100ns;
      D <= "1100";
		wait for 100ns;
		D <= "ZZZZ";
		WR_BAR <= '0';
		wait for 50ns;
		WR_BAR <= '1';
		
		wait;
   end process;

END;
