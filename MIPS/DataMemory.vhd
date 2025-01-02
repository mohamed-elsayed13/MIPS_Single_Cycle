--Library Decaration 
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

--Entity Decaration
Entity DataMemory Is
port(
ADDRESS : IN STD_LOGIC_VECTOR(31 downto 0);
WRITEDATA : IN STD_LOGIC_VECTOR(31 downto 0);
MemWRITE : IN STD_LOGIC;
MemREAD :IN STD_LOGIC;
CLK: IN STD_LOGIC;
READDATA : OUT STD_LOGIC_VECTOR(31 downto 0)
);
end DataMemory;

--Architecture Decaration
architecture Behavioral of DataMemory Is
type Memory is array (0 to 63) of STD_LOGIC_VECTOR(7 downto 0);
signal MemoryUnit : Memory := (X"AB",X"CD",X"EF",X"00",X"75",X"74",X"65",X"72",
							   X"20",X"41",X"72",X"63",X"68",X"69",X"74",X"65",
							   X"12",X"34",X"56",X"78",X"7F",X"7F",X"6D",X"6D",
							   X"00",X"00",X"00",X"00",X"78",X"78",X"6A",X"6A",
							   X"00",X"00",X"00",X"01", others => (others => '0'));  
begin
PROCESS(CLK,MemREAD,MemWRITE,ADDRESS)
BEGIN
if  MemREAD ='1' and MemWRITE ='0'
then 
READDATA(31 downto 24) <= MemoryUnit(to_integer(unsigned(ADDRESS)));
READDATA(23 downto 16) <= MemoryUnit(to_integer(unsigned(ADDRESS)+1));
READDATA(15 downto  8) <= MemoryUnit(to_integer(unsigned(ADDRESS)+2));
READDATA(7  downto  0) <= MemoryUnit(to_integer(unsigned(ADDRESS)+3));
elsif rising_edge(clk) and MemREAD ='0' and MemWRITE ='1'
then
MemoryUnit(to_integer(unsigned(ADDRESS))) <=WRITEDATA(31 downto 24);
MemoryUnit(to_integer(unsigned(ADDRESS)+1))<=WRITEDATA(23 downto 16);
MemoryUnit(to_integer(unsigned(ADDRESS)+2))<=WRITEDATA(15 downto  8);
MemoryUnit(to_integer(unsigned(ADDRESS)+3))<=WRITEDATA(7  downto  0);
end if;
END process;
end Behavioral;