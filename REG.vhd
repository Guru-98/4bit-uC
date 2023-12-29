library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REG is
    Port ( DIN : in  STD_LOGIC_VECTOR (3 downto 0);
           LD_A : in  STD_LOGIC;
           LD_B : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           A_DOUT : out  STD_LOGIC_VECTOR (3 downto 0);
           B_DOUT : out  STD_LOGIC_VECTOR (3 downto 0));
end REG;

architecture Behavioral of REG is
begin
	
clk_proc: process (CLK, RESET) begin
	if RESET = '0' then
		A_DOUT <= "0000";
		B_DOUT <= "0000";
		
	else if CLK'EVENT and CLK='1' then		
			if LD_A ='1' then
				A_DOUT <= DIN;
			end if;
			
			if LD_B ='1' then
				B_DOUT <= DIN;
			end if;
		end if;
	end if;
end process;

end Behavioral;

