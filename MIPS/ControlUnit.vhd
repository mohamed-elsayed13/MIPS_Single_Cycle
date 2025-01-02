--Library Decaration 
library IEEE;
use IEEE.STD_LOGIC_1164.all;

--Entity Decaration
Entity ControlUnit Is
port(
OP 		: IN STD_LOGIC_VECTOR(5 downto 0);
RegDst	: Out STD_LOGIC;
ALUSrc	: Out STD_LOGIC;
MemtoReg: Out STD_LOGIC;
RegWrite: Out STD_LOGIC;
MemRead : Out STD_LOGIC;
MemWrite: Out STD_LOGIC;
Branch  : Out STD_LOGIC;
Jump    : Out STD_LOGIC;
ALUOP1	: Out STD_LOGIC;
ALUOP0	: Out STD_LOGIC
);
end ControlUnit;

--Architecture Decaration
architecture Behavioral of ControlUnit Is
begin
process(op)
begin
if op = "000000" then 
RegDst	<='1';	
ALUSrc	<='0';
MemtoReg<='0';
RegWrite<='1';
MemRead <='0';
MemWrite<='0';
Branch	<='0';  
ALUOP1	<='1';	
ALUOP0	<='0';
Jump    <='0';	
elsif op = "100011" then
RegDst	<='0';	
ALUSrc	<='1';
MemtoReg<='1';
RegWrite<='1';
MemRead <='1';
MemWrite<='0';
Branch	<='0';  
ALUOP1	<='0';	
ALUOP0	<='0';
Jump    <='0';	
elsif op = "101011" then
RegDst	<='0';	
ALUSrc	<='1';
MemtoReg<='0';
RegWrite<='0';
MemRead <='0';
MemWrite<='1';
Branch	<='0';  
ALUOP1	<='0';	
ALUOP0	<='0';
Jump    <='0';	
elsif op = "000100" then
RegDst	<='0';	
ALUSrc	<='0';
MemtoReg<='0';
RegWrite<='0';
MemRead <='0';
MemWrite<='0';
Branch	<='1';  
ALUOP1	<='0';	
ALUOP0	<='1';
Jump    <='0';
elsif op = "000010" then
RegDst	<='0';	
ALUSrc	<='0';
MemtoReg<='0';
RegWrite<='0';
MemRead <='0';
MemWrite<='0';
Branch	<='0';  
ALUOP1	<='0';	
ALUOP0	<='0';
Jump    <='1';	
end if;
end process;
end Behavioral;