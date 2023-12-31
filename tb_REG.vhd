LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_REG IS
END tb_REG;
 
ARCHITECTURE behavior OF tb_REG IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT REG
    PORT(
         DIN : IN  std_logic_vector(3 downto 0);
         LD_A : IN  std_logic;
         LD_B : IN  std_logic;
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         A_DOUT : OUT  std_logic_vector(3 downto 0);
         B_DOUT : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DIN : std_logic_vector(3 downto 0) := (others => '0');
   signal LD_A : std_logic := '0';
   signal LD_B : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';

 	--Outputs
   signal A_DOUT : std_logic_vector(3 downto 0);
   signal B_DOUT : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: REG PORT MAP (
          DIN => DIN,
          LD_A => LD_A,
          LD_B => LD_B,
          CLK => CLK,
          RESET => RESET,
          A_DOUT => A_DOUT,
          B_DOUT => B_DOUT
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
      -- hold reset state for 100 ns.
		RESET <= '0';
      wait for 100 ns;	
		RESET <= '1';

      wait for CLK_period*10;

      -- insert stimulus here 
		DIN <= "1100";
		LD_A <= '1' after 20 ns;
		

      wait;
   end process;

END;
