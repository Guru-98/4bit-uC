LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.mp_pack.ALL;
 
ENTITY tb_IDEC IS
END tb_IDEC;
 
ARCHITECTURE behavior OF tb_IDEC IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT IDEC
    PORT(
         DIN : IN  std_logic_vector(3 downto 0);
         RESET : IN  std_logic;
         CLK : IN  std_logic;
         LD_IR : IN  std_logic;
         LD_STATE : IN  std_logic;
         MC_STATE : IN  MACHINE_STATES;
         SEL_MUX : OUT  std_logic_vector(1 downto 0);
         CLR : OUT  std_logic;
         SEL : OUT  std_logic;
         HALT : OUT  std_logic;
         LD_A : OUT  std_logic;
         LD_B : OUT  std_logic;
         SAVE : OUT  std_logic;
         RESTORE : OUT  std_logic;
         SEL_OPER : OUT  std_logic_vector(1 downto 0);
         MEM_R_W : OUT  std_logic;
         NEXT_FETCH : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal DIN : std_logic_vector(3 downto 0) := (others => '0');
   signal RESET : std_logic := '0';
   signal CLK : std_logic := '0';
   signal LD_IR : std_logic := '0';
   signal LD_STATE : std_logic := '0';
   signal MC_STATE : MACHINE_STATES := S1;

 	--Outputs
   signal SEL_MUX : std_logic_vector(1 downto 0);
   signal CLR : std_logic;
   signal SEL : std_logic;
   signal HALT : std_logic;
   signal LD_A : std_logic;
   signal LD_B : std_logic;
   signal SAVE : std_logic;
   signal RESTORE : std_logic;
   signal SEL_OPER : std_logic_vector(1 downto 0);
   signal MEM_R_W : std_logic;
   signal NEXT_FETCH : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: IDEC PORT MAP (
          DIN => DIN,
          RESET => RESET,
          CLK => CLK,
          LD_IR => LD_IR,
          LD_STATE => LD_STATE,
          MC_STATE => MC_STATE,
          SEL_MUX => SEL_MUX,
          CLR => CLR,
          SEL => SEL,
          HALT => HALT,
          LD_A => LD_A,
          LD_B => LD_B,
          SAVE => SAVE,
          RESTORE => RESTORE,
          SEL_OPER => SEL_OPER,
          MEM_R_W => MEM_R_W,
          NEXT_FETCH => NEXT_FETCH
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
		LD_IR <= '1';
		wait for 20 ns;
		LD_IR <= '0';

      wait;
   end process;

END;
