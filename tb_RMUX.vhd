LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_RMUX IS
END tb_RMUX;
 
ARCHITECTURE tb OF tb_RMUX IS 
 
    COMPONENT RMUX
    PORT(
         A_DOUT : IN  std_logic_vector(3 downto 0);
         B_DOUT : IN  std_logic_vector(3 downto 0);
         PC_DOUT : IN  std_logic_vector(3 downto 0);
         DIN : IN  std_logic_vector(3 downto 0);
         SEL_MUX : IN  std_logic_vector(1 downto 0);
         M_DOUT : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A_DOUT : std_logic_vector(3 downto 0) := (others => 'U');
   signal B_DOUT : std_logic_vector(3 downto 0) := (others => 'U');
   signal PC_DOUT : std_logic_vector(3 downto 0) := (others => 'U');
   signal DIN : std_logic_vector(3 downto 0) := (others => 'U');
   signal SEL_MUX : std_logic_vector(1 downto 0) := (others => 'U');

 	--Outputs
   signal M_DOUT : std_logic_vector(3 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RMUX PORT MAP (
          A_DOUT => A_DOUT,
          B_DOUT => B_DOUT,
          PC_DOUT => PC_DOUT,
          DIN => DIN,
          SEL_MUX => SEL_MUX,
          M_DOUT => M_DOUT
        );

		  A_DOUT <= "1010";
		  B_DOUT <= "1100";
		  PC_DOUT <= "0110";
		  DIN <= "1011", "0101" after 400ns ;
		  
		  SEL_MUX <= "00",
						 "01" after 100ns,
						 "10" after 200ns,
						 "11" after 300ns;

END;
