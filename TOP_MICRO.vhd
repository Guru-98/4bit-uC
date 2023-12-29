library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.MP_PACK.ALL;

entity TOP_MICRO is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC);
end TOP_MICRO;

architecture Behavioral of TOP_MICRO is
	COMPONENT ROM
	PORT(
		CS : IN std_logic;
		RD_BAR : IN std_logic;
		ADR_IN : IN std_logic_vector(3 downto 0);          
		D : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	COMPONENT RAM
	PORT(
		ADR_IN : IN std_logic_vector(3 downto 0);
		CS_BAR : IN std_logic;
		WR_BAR : IN std_logic;
		RD_BAR : IN std_logic;       
		D : INOUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT BLK_MICRO
	PORT(
		CLK : IN std_logic;
		RESET : IN std_logic;    
		D : INOUT std_logic_vector(3 downto 0);      
		P_D : OUT std_logic;
		RD_BAR : OUT std_logic;
		WR_BAR : OUT std_logic;
		ADR : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	SIGNAL CON_CS : std_logic := 'Z';
	SIGNAL CON_RD : std_logic := 'Z';
	SIGNAL CON_WR : std_logic := 'Z';
	
	SIGNAL BUS_D : std_logic_vector(3 downto 0) := "ZZZZ";
	SIGNAL BUS_A : std_logic_vector(3 downto 0) := "ZZZZ";

begin
	Inst_ROM: ROM PORT MAP(
		CS => CON_CS,
		RD_BAR => CON_RD,
		ADR_IN => BUS_A,
		D => BUS_D
	);

	Inst_RAM: RAM PORT MAP(
		ADR_IN => BUS_A,
		CS_BAR => CON_CS,
		WR_BAR => CON_WR,
		RD_BAR => CON_RD,
		D => BUS_D
	);
	
	Inst_BLK_MICRO: BLK_MICRO PORT MAP(
		CLK => CLK,
		RESET => RESET,
		P_D => CON_CS,
		RD_BAR => CON_RD,
		WR_BAR => CON_WR,
		ADR => BUS_A,
		D => BUS_D
	);
end Behavioral;

