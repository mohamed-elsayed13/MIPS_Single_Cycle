--Library Declaration 
library IEEE;
use IEEE.STD_LOGIC_1164.all;

--Entity Declaration
Entity MIPSProcessor Is
port(
    clk : in STD_LOGIC;
    reset : in STD_LOGIC 
);
end MIPSProcessor;

--Architecture Declaration
architecture Structural of MIPSProcessor Is
	----------------------------------------------------------------------------------
	-- Signals
	----------------------------------------------------------------------------------
	signal NextAddr : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');   
	signal CurrAddr : STD_LOGIC_VECTOR(31 downto 0):= (others => '0'); 
	signal Inst : STD_LOGIC_VECTOR (31 downto 0):= (others => '0');
	Signal MemWrite : STD_LOGIC:= '0';
	Signal MemRead : STD_LOGIC:= '0';
	signal MemtoReg : STD_LOGIC:= '0';
	signal Branch : STD_LOGIC:= '0';
	signal ALUSrc : STD_LOGIC:= '0';
	signal RegDst : STD_LOGIC:= '0';
	signal RegWrite : STD_LOGIC:= '0';
	signal Jump : STD_LOGIC:= '0';
	Signal ALUOP : STD_LOGIC_VECTOR(1 downto 0):= (others => '0');
	Signal FUNC : STD_LOGIC_VECTOR(4 downto 0):= (others => '0');
	signal ALUOPERATION : STD_LOGIC_VECTOR(3 downto 0):= (others => '0');
	signal RegDstOut : STD_LOGIC_VECTOR(4 downto 0):= (others => '0');
	signal RdOut1 : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
	signal RdOut2 : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
	signal ALUIn : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
	signal SXOut : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
	signal ALUOut : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
	signal COMP : STD_LOGIC:= '0';
	signal MemOut : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
	signal MemtoRegOut : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
	signal PCad4 : STD_LOGIC_VECTOR(31 downto 0):= x"00000004";
	signal PCad4ad16bit : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
	signal PCAd4Ad16bitFinal : STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
	
	----------------------------------------------------------------------------------
	-- Components
	----------------------------------------------------------------------------------
	component Adder32 Is
	port(
		input1 : In STD_LOGIC_VECTOR (31 downto 0);
		input2 : In STD_LOGIC_VECTOR (31 downto 0);
		Sum    : OUT STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;
	
	component ALU Is
	port(
		A      : In STD_LOGIC_VECTOR(31 DOWNTO 0);
		B      : In STD_LOGIC_VECTOR(31 DOWNTO 0);
		CONTROL: In STD_LOGIC_VECTOR(3 DOWNTO 0);
		RESULT : Out STD_LOGIC_VECTOR(31 DOWNTO 0);
		ZERO   : OUT STD_LOGIC
	);
	end component;
	
	component SignExtend Is
	port(
		input : In STD_LOGIC_VECTOR (15 downto 0);
		OUTPUT: OUT STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;
	
	component RegisterFile Is
	port(
		REGREAD1 :IN STD_LOGIC_VECTOR(4 downto 0);
		REGREAD2 :IN STD_LOGIC_VECTOR(4 downto 0);
		WRITEREG :IN STD_LOGIC_VECTOR(4 downto 0);
		DATA     :IN STD_LOGIC_VECTOR(31 downto 0);
		regWRITE :IN STD_LOGIC;
		CLK      :IN STD_LOGIC;
		READDATA1:OUT STD_LOGIC_VECTOR(31 downto 0);
		READDATA2:OUT STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;
	
	component PC Is
	port(
		clk   : in STD_LOGIC;
		reset : in STD_LOGIC; 
		input : In STD_LOGIC_VECTOR (31 downto 0);
		OUTPUT: OUT STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;
	
	component LShifter Is
	port(
		input : In STD_LOGIC_VECTOR (31 downto 0);
		OUTPUT: OUT STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;
	
	component InstMemory Is
	port(
		READADD : In STD_LOGIC_VECTOR(31 downto 0);
		COUT :OUT STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;
	
	component DataMemory Is
	port(
		ADDRESS   : IN STD_LOGIC_VECTOR(31 downto 0);
		WRITEDATA : IN STD_LOGIC_VECTOR(31 downto 0);
		MemWRITE  : IN STD_LOGIC;
		MemREAD   : IN STD_LOGIC;
		CLK       : IN STD_LOGIC;
		READDATA  : OUT STD_LOGIC_VECTOR(31 downto 0)
	);
	end component;
	
	component ControlUnit Is
	port(
		OP      : IN STD_LOGIC_VECTOR(5 downto 0);
		RegDst  : Out STD_LOGIC;
		ALUSrc  : Out STD_LOGIC;
		MemtoReg: Out STD_LOGIC;
		RegWrite: Out STD_LOGIC;
		MemRead : Out STD_LOGIC;
		MemWrite: Out STD_LOGIC;
		Branch  : Out STD_LOGIC;
		Jump    : Out STD_LOGIC;
		ALUOP1  : Out STD_LOGIC;
		ALUOP0  : Out STD_LOGIC
	);
	end component;
	
	component ALUControl Is
	port(
		Func         : In STD_LOGIC_VECTOR(5 downto 0);
		ALUOP        : IN STD_LOGIC_VECTOR(1 downto 0);
		ALUOPERATION : OUT STD_LOGIC_VECTOR(3 downto 0)
	);
	end component;

begin
    RegDstProcess: process(CLK)
    begin
        if RegDst = '1' then
            RegDstOut <= Inst(15 downto 11);
        elsif RegDst = '0' then
            RegDstOut <= Inst(20 downto 16);
        end if;
    end process;

    ALUInMux: process(CLK)
    begin
        if ALUSrc = '0' then
            ALUIn <= RdOut2;
        elsif ALUSrc = '1' then
            ALUIn <= SXOut;
        end if;
    end process;

    MemtoRegMux: process(CLK)
    begin
        if MemtoReg = '1' then
            MemtoRegOut <= MemOut;
        elsif MemtoReg = '0' then
            MemtoRegOut <= ALUOut;
        end if;
    end process;

    NextAddrCalc: process(CLK)
    begin
        if Jump = '1' then
            NextAddr <= (PCad4(31 downto 28) & Inst(25 downto 0) & "00"); -- Jump not supported 
        elsif Branch = '1' and COMP = '1' then
            NextAddr <= PCAd4Ad16bitFinal;
        else
            NextAddr <= PCad4;
        end if;
    end process;

	----------------------------------------------------------------------------------
	-- Port Map of Components
	----------------------------------------------------------------------------------

    ProgramCounter: PC port map (
        clk   => CLK,
        reset => reset, 
        input => NextAddr,
        OUTPUT => CurrAddr
    );

	
    CU: ControlUnit port map (
        OP      => Inst(31 downto 26),
        RegDst  => RegDst,
        ALUSrc  => ALUSrc,
        MemtoReg => MemtoReg,
        RegWrite => RegWrite,
        MemRead  => MemRead,
        MemWrite => MemWrite,
        Branch   => Branch,
        Jump     => Jump,
        ALUOP1   => ALUOP(1),
        ALUOP0   => ALUOP(0)
    );

    RegFile: RegisterFile port map (
        READDATA2 => RdOut2,
        READDATA1 => RdOut1,
        CLK       => CLK,
        regWRITE  => RegWrite,
        DATA      => MemtoRegOut,
        WRITEREG  => RegDstOut,
        REGREAD2  => Inst(20 downto 16),
        REGREAD1  => Inst(25 downto 21)
    );

    SX: SignExtend port map (
        input => Inst(15 downto 0),
        OUTPUT => SXOut
    );

    ALU1: ALU port map (
        A      => RdOut1,
        B      => ALUIn,
        CONTROL => ALUOPERATION,
        RESULT  => ALUOut,
        ZERO    => COMP
    );

    DATAMEM: DataMemory port map (
        ADDRESS   => ALUOut,
        WRITEDATA => RdOut2,
        MemWRITE  => MemWrite,
        MemREAD   => MemRead,
        CLK       => CLK,
        READDATA  => MemOut
    );

    INSTMEM: InstMemory port map (
        READADD => CurrAddr,
        COUT    => Inst
    );

    ALUCont: ALUControl port map (
        Func         => Inst(5 downto 0),
        ALUOP        => ALUOP,
        ALUOPERATION => ALUOPERATION
    );

    PCadd4: Adder32 port map (
        input1 => CurrAddr,
        input2 => x"00000004",
        Sum    => PCad4
    );

    LeftShifter1: LShifter port map (
        input  => SXOut,
        OUTPUT => PCad4ad16bit
    );

    PCadd4add16bit: Adder32 port map (
        input1 => PCad4,
        input2 => PCad4ad16bit,
        Sum    => PCAd4Ad16bitFinal
    );

end Structural;