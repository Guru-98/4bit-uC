LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.mp_pack.ALL;

ENTITY tb_TIM IS
END tb_TIM;
 
ARCHITECTURE behavior OF tb_TIM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TIM
    PORT(
         NEXT_FETCH : IN  std_logic;
         CLK : IN  std_logic;
         RESET : IN  std_logic;
         MEM_R_W : IN  std_logic;
         HALT : IN  std_logic;
         LD_PC : OUT  std_logic;
         P_D : OUT  std_logic;
         RDBAR : OUT  std_logic;
         WRBAR : OUT  std_logic;
         INC_PC : OUT  std_logic;
         LD_IR : OUT  std_logic;
         MC_STATES : OUT  MACHINE_STATES;
         LD_STATES : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal NEXT_FETCH : std_logic := '0';
   signal CLK : std_logic := '0';
   signal RESET : std_logic := '0';
   signal MEM_R_W : std_logic := '0';
   signal HALT : std_logic := '0';

 	--Outputs
   signal LD_PC : std_logic;
   signal P_D : std_logic;
   signal RDBAR : std_logic;
   signal WRBAR : std_logic;
   signal INC_PC : std_logic;
   signal LD_IR : std_logic;
   signal MC_STATES : MACHINE_STATES;
   signal LD_STATES : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TIM PORT MAP (
          NEXT_FETCH => NEXT_FETCH,
          CLK => CLK,
          RESET => RESET,
          MEM_R_W => MEM_R_W,
          HALT => HALT,
          LD_PC => LD_PC,
          P_D => P_D,
          RDBAR => RDBAR,
          WRBAR => WRBAR,
          INC_PC => INC_PC,
          LD_IR => LD_IR,
          MC_STATES => MC_STATES,
          LD_STATES => LD_STATES
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
      wait for 100 ns;	
		RESET <= '1';

      wait for CLK_period*10;

      wait for 100ns;
		NEXT_FETCH <= '1';
		wait for 10ns;
		NEXT_FETCH <= '0';
		
		wait for 500ns;
		HALT <= '1';
		wait for 60ns;
		HALT <= '0';
		
      wait;
   end process;

END;
