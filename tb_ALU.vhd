LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_ALU IS
END tb_ALU;
 
ARCHITECTURE behavior OF tb_ALU IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ALU
    PORT(
         A_DOUT : IN  std_logic_vector(3 downto 0);
         B_DOUT : IN  std_logic_vector(3 downto 0);
         SEL_OPER : IN  std_logic_vector(1 downto 0);
         Y_DOUT : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A_DOUT : std_logic_vector(3 downto 0) := (others => '0');
   signal B_DOUT : std_logic_vector(3 downto 0) := (others => '0');
   signal SEL_OPER : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Y_DOUT : std_logic_vector(3 downto 0);

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ALU PORT MAP (
          A_DOUT => A_DOUT,
          B_DOUT => B_DOUT,
          SEL_OPER => SEL_OPER,
          Y_DOUT => Y_DOUT
        );
		  
	A_DOUT <= "1010";
	B_DOUT <= "1100";
	
	SEL_OPER <= "00",
					"01" after 100ns,
					"10" after 200ns,
					"11" after 300ns;
END;
