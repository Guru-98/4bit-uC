library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           SEL : in  STD_LOGIC;
           Y : out  STD_LOGIC_VECTOR (3 downto 0));
end MUX;

architecture Behavioral of MUX is
begin

	with SEL select
	Y <= A when '0',
		  B when '1',
		  "ZZZZ" when others;

end Behavioral;

