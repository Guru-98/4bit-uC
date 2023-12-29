--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:03:11 01/20/2018
-- Design Name:   
-- Module Name:   E:/_IVIaster/Microprocessor/tb_PC.vhd
-- Project Name:  Microprocessor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: PC
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
 
ENTITY tb_PC IS
END tb_PC;
 
ARCHITECTURE behavior OF tb_PC IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT PC
    PORT(
         PC_DIN : IN  std_logic_vector(3 downto 0);
         INC : IN  std_logic;
         LD_DATA : IN  std_logic;
         RESTORE : IN  std_logic;
         SAVE : IN  std_logic;
         CLR : IN  std_logic;
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         PC_DOUT : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal PC_DIN : std_logic_vector(3 downto 0) := (others => '0');
   signal INC : std_logic := '0';
   signal LD_DATA : std_logic := '0';
   signal RESTORE : std_logic := '0';
   signal SAVE : std_logic := '0';
   signal CLR : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';

 	--Outputs
   signal PC_DOUT : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: PC PORT MAP (
          PC_DIN => PC_DIN,
          INC => INC,
          LD_DATA => LD_DATA,
          RESTORE => RESTORE,
          SAVE => SAVE,
          CLR => CLR,
          CLK => CLK,
          RESET => RESET,
          PC_DOUT => PC_DOUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		RESET <= '0';
      wait for 100 ns;
		RESET <= '1';
      
		PC_DIN <= "1010";
		
		LD_DATA <= '1' after 20 ns, '0' after 30 ns; 
		
		INC <= '1' after 40 ns, '0' after 50 ns;
      wait;
   end process;

END;
