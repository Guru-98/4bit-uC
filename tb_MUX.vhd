LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY tb_MUX IS
END tb_MUX;
 
ARCHITECTURE tb OF tb_MUX IS 
 
    COMPONENT MUX
    PORT(
         A : IN  std_logic_vector(3 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         SEL : IN  std_logic;
         Y : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => 'U');
   signal B : std_logic_vector(3 downto 0) := (others => 'U');
   signal SEL : std_logic := 'U';

 	--Outputs
   signal Y : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX PORT MAP (
          A => A,
          B => B,
          SEL => SEL,
          Y => Y
        );
	
	A <= "1100";
	B <= "1010";
	
	SEL <= '0' after 100ns,
			 '1' after 200ns;
END;
