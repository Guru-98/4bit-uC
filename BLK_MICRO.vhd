library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use WORK.MP_PACK.ALL;

entity BLK_MICRO is
    Port ( CLK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           P_D : out  STD_LOGIC;
           RD_BAR : out  STD_LOGIC;
           WR_BAR : out  STD_LOGIC;
           ADR : out  STD_LOGIC_VECTOR (3 downto 0);
           D : inout  STD_LOGIC_VECTOR (3 downto 0));
end BLK_MICRO;

architecture Behavioral of BLK_MICRO is
	COMPONENT ALU
	PORT(
		A_DOUT : IN std_logic_vector(3 downto 0);
		B_DOUT : IN std_logic_vector(3 downto 0);
		SEL_OPER : IN std_logic_vector(1 downto 0);          
		Y_DOUT : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	COMPONENT IDEC
	PORT(
		DIN : IN std_logic_vector(3 downto 0);
		RESET : IN std_logic;
		CLK : IN std_logic;
		LD_IR : IN std_logic;
		LD_STATE : IN std_logic;
		MC_STATE : IN MACHINE_STATES;          
		SEL_MUX : OUT std_logic_vector(1 downto 0);
		CLR : OUT std_logic;
		SEL : OUT std_logic;
		HALT : OUT std_logic;
		LD_A : OUT std_logic;
		LD_B : OUT std_logic;
		SAVE : OUT std_logic;
		RESTORE : OUT std_logic;
		SEL_OPER : OUT std_logic_vector(1 downto 0);
		MEM_R_W : OUT std_logic;
		NEXT_FETCH : OUT std_logic
		);
	END COMPONENT;

	COMPONENT MUX
	PORT(
		A : IN std_logic_vector(3 downto 0);
		B : IN std_logic_vector(3 downto 0);
		SEL : IN std_logic;          
		Y : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	COMPONENT PC
	PORT(
		PC_DIN : IN std_logic_vector(3 downto 0);
		INC : IN std_logic;
		LD_DATA : IN std_logic;
		RESTORE : IN std_logic;
		SAVE : IN std_logic;
		CLR : IN std_logic;
		CLK : IN std_logic;
		RESET : IN std_logic;          
		PC_DOUT : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	COMPONENT REG
	PORT(
		DIN : IN std_logic_vector(3 downto 0);
		LD_A : IN std_logic;
		LD_B : IN std_logic;
		CLK : IN std_logic;
		RESET : IN std_logic;          
		A_DOUT : OUT std_logic_vector(3 downto 0);
		B_DOUT : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	COMPONENT RMUX
	PORT(
		A_DOUT : IN std_logic_vector(3 downto 0);
		B_DOUT : IN std_logic_vector(3 downto 0);
		PC_DOUT : IN std_logic_vector(3 downto 0);
		DIN : IN std_logic_vector(3 downto 0);
		SEL_MUX : IN std_logic_vector(1 downto 0);          
		M_DOUT : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;

	COMPONENT TRIBUF
	PORT(
		M_DOUT : IN std_logic_vector(3 downto 0);
		WR_BAR : IN std_logic;    
		D : INOUT std_logic_vector(3 downto 0);      
		DIN : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	
	COMPONENT TIM
	PORT(
		NEXT_FETCH : IN std_logic;
		CLK : IN std_logic;
		RESET : IN std_logic;
		MEM_R_W : IN std_logic;
		HALT : IN std_logic;          
		LD_PC : OUT std_logic;
		P_D : OUT std_logic;
		RDBAR : OUT std_logic;
		WRBAR : OUT std_logic;
		INC_PC : OUT std_logic;
		LD_IR : OUT std_logic;
		MC_STATES : OUT MACHINE_STATES;
		LD_STATES : OUT std_logic
		);
	END COMPONENT;

	SIGNAL CON_LD_IR : std_logic := 'U';
	SIGNAL CON_LD_STATE : std_logic := 'U';
	SIGNAL CON_MC_STATE : MACHINE_STATES := S1;
	SIGNAL CON_CLR : std_logic := 'U';
	SIGNAL CON_SEL : std_logic := 'U';
	SIGNAL CON_HALT : std_logic := 'U';
	SIGNAL CON_LD_A : std_logic := 'U';
	SIGNAL CON_LD_B : std_logic := 'U';
	SIGNAL CON_SAVE : std_logic := 'U';
	SIGNAL CON_RESTORE : std_logic := 'U';
	SIGNAL CON_MEM_RW : std_logic := 'U';
	SIGNAL CON_NEXT_FETCH : std_logic := 'U';
	SIGNAL CON_INC_PC : std_logic := 'U';
	SIGNAL CON_LD_PC : std_logic := 'U';
	SIGNAL CON_WR_BAR : std_logic := 'U';
	
	SIGNAL CON_SEL_OPER : std_logic_vector (1 downto 0) := "UU";
	SIGNAL CON_SEL_MUX : std_logic_vector (1 downto 0) := "UU";	
	
	SIGNAL BUS_A_DOUT : std_logic_vector (3 downto 0) := "UUUU";
	SIGNAL BUS_B_DOUT : std_logic_vector (3 downto 0) := "UUUU";
	SIGNAL BUS_ALU_Y : std_logic_vector (3 downto 0) := "UUUU";
	SIGNAL BUS_D : std_logic_vector (3 downto 0) := "UUUU";
	SIGNAL BUS_M_DOUT : std_logic_vector (3 downto 0) := "UUUU";
	SIGNAL BUS_MUX_Y : std_logic_vector (3 downto 0) := "UUUU";
	SIGNAL BUS_PC_DOUT : std_logic_vector (3 downto 0) := "UUUU";
	
begin

	Inst_TIM: TIM PORT MAP(
		NEXT_FETCH => CON_NEXT_FETCH,
		CLK => CLK,
		RESET => RESET,
		MEM_R_W => CON_MEM_RW,
		HALT => CON_HALT,
		LD_PC => CON_LD_PC,
		P_D => P_D,
		RDBAR => RD_BAR,
		WRBAR => WR_BAR,
		INC_PC => CON_INC_PC,
		LD_IR => CON_LD_IR,
		MC_STATES => CON_MC_STATE,
		LD_STATES => CON_LD_STATE
	);
	
	Inst_IDEC: IDEC PORT MAP(
		DIN => BUS_D,
		RESET => RESET,
		CLK => CLK,
		LD_IR => CON_LD_IR,
		LD_STATE => CON_LD_STATE,
		MC_STATE => CON_MC_STATE,
		SEL_MUX => CON_SEL_MUX,
		CLR => CON_CLR,
		SEL => CON_SEL,
		HALT => CON_HALT,
		LD_A => CON_LD_A,
		LD_B => CON_LD_B,
		SAVE => CON_SAVE,
		RESTORE => CON_RESTORE,
		SEL_OPER => CON_SEL_OPER,
		MEM_R_W => CON_MEM_RW,
		NEXT_FETCH => CON_NEXT_FETCH
	);
	
	Inst_MUX: MUX PORT MAP(
		A => BUS_ALU_Y,
		B => BUS_M_DOUT,
		SEL => CON_SEL,
		Y => BUS_MUX_Y
	);
	
	Inst_PC: PC PORT MAP(
		PC_DIN => BUS_D,
		INC => CON_INC_PC,
		LD_DATA => CON_LD_PC,
		RESTORE => CON_RESTORE,
		SAVE => CON_SAVE,
		CLR => CON_CLR,
		CLK => CLK,
		RESET => RESET,
		PC_DOUT => BUS_PC_DOUT
	);
	
	Inst_REG: REG PORT MAP(
		DIN => BUS_MUX_Y,
		LD_A => CON_LD_A,
		LD_B => CON_LD_B,
		CLK => CLK,
		RESET => RESET,
		A_DOUT => BUS_A_DOUT,
		B_DOUT => BUS_B_DOUT
	);
	
	Inst_RMUX: RMUX PORT MAP(
		A_DOUT => BUS_A_DOUT,
		B_DOUT => BUS_B_DOUT,
		PC_DOUT =>BUS_PC_DOUT,
		DIN => BUS_D,
		SEL_MUX => CON_SEL_MUX,
		M_DOUT => BUS_M_DOUT
	);
	Inst_ALU: ALU PORT MAP(
		A_DOUT => BUS_A_DOUT,
		B_DOUT => BUS_B_DOUT,
		SEL_OPER => CON_SEL_OPER,
		Y_DOUT => BUS_ALU_Y
	);

	
	Inst_TRIBUF: TRIBUF PORT MAP(
		DIN => BUS_D,
		D => D,
		M_DOUT => BUS_M_DOUT,
		WR_BAR => CON_WR_BAR
	);
	
	ADR <= BUS_PC_DOUT;
end Behavioral;

