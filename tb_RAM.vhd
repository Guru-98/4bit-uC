LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_RAM IS
END tb_RAM;
 
ARCHITECTURE behavior OF tb_RAM IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RAM
    PORT(
         ADR_IN : IN  std_logic_vector(3 downto 0);
         CS_BAR : IN  std_logic;
         WR_BAR : IN  std_logic;
         RD_BAR : IN  std_logic;
         D : INOUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ADR_IN : std_logic_vector(3 downto 0) := (others => '0');
   signal CS_BAR : std_logic := '1';
   signal WR_BAR : std_logic := '1';
   signal RD_BAR : std_logic := '1';

	--BiDirs
   signal D : std_logic_vector(3 downto 0);

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RAM PORT MAP (
          ADR_IN => ADR_IN,
          CS_BAR => CS_BAR,
          WR_BAR => WR_BAR,
          RD_BAR => RD_BAR,
          D => D
        );
	
	process begin
		wait for 50ns;
		CS_BAR <= '0';
			ADR_IN <= "0000";
			D <= "1000";
				wait for 5ns;
				WR_BAR <= '0';
				wait for 50ns;
				WR_BAR <= '1';
				wait for 5ns;
		CS_BAR <= '1';
		
		D <= "ZZZZ";
		
		wait for 50ns;
		CS_BAR <= '0';
			ADR_IN <= "0000";
				wait for 5ns;
				RD_BAR <= '0';
				wait for 50ns;
				RD_BAR <= '1';
				wait for 5ns;
		CS_BAR <= '1';
		
		
		wait;
	end process;

END;
