library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PC is
    Port ( PC_DIN : in  STD_LOGIC_VECTOR (3 downto 0);
           INC : in  STD_LOGIC;
           LD_DATA : in  STD_LOGIC;
           RESTORE : in  STD_LOGIC;
           SAVE : in  STD_LOGIC;
           CLR : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           PC_DOUT : out  STD_LOGIC_VECTOR (3 downto 0));
end PC;

architecture Behavioral of PC is
	signal PC_DATA: STD_LOGIC_VECTOR (3 downto 0) := "UUUU";
	signal PC_STACK : STD_LOGIC_VECTOR (3 downto 0) := "UUUU";
begin

process(RESET,CLK)
begin
	if  RESET ='0' then
		PC_DATA <= "UUUU";
		PC_STACK <= "UUUU";
	else
		if RESET'EVENT and RESET = '1' then
			PC_DATA <= "0000";
			PC_STACK <= "0000";
		end if;

		if CLK'EVENT and CLK = '1' then
				if (INC='1') then
					PC_DATA <= PC_DATA + 1;
				end if;
				
				if (LD_DATA='1') then
					PC_DATA <= PC_DIN;
				end if;
				
				if (CLR='1') then
					PC_DATA <= "0000";
				end if;
				
				if (SAVE ='1') then
					PC_STACK <= PC_DATA;
				end if;
				
				if (RESTORE='1') then
					PC_DATA <= PC_STACK;
				end if;
		end if;
	end if;
end process;

PC_DOUT <= std_logic_vector(PC_DATA);

end Behavioral;

