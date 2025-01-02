--Library Decaration 
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;
--use IEEE.STD_LOGIC_ARITH.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

--Entity Decaration
Entity RegisterFile Is
port(
REGREAD1:IN STD_LOGIC_VECTOR(4 downto 0):= (others => '0');
REGREAD2:IN STD_LOGIC_VECTOR(4 downto 0):= (others => '0');
WRITEREG: IN STD_LOGIC_VECTOR(4 downto 0):= (others => '0');
DATA :IN STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
regWRITE : IN STD_LOGIC;
CLK : IN STD_LOGIC;
READDATA1: OUT STD_LOGIC_VECTOR(31 downto 0):= (others => '0');
READDATA2: OUT STD_LOGIC_VECTOR(31 downto 0):= (others => '0')
);
end RegisterFile;

--Architecture Decaration
architecture Behavioral of RegisterFile Is
type RegArray is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
signal RegFile : RegArray:=(
    X"00000000", X"00000000", X"00000000", X"00000000", 
    X"00000006", X"00000008", X"00000000", X"00000000",
    X"00000009", X"0000000A", X"0000000B", X"0000000C",
    X"0000000D", X"0000000E", X"0000000F", X"00000000",
    X"00000000", X"00000012", X"00000013", X"00000014",
    X"00000015", X"00000016", X"00000017", X"00000018",
    X"00000019", X"0000001A", X"0000001B", X"0000001C",
    X"0000001D", X"0000001E", X"0000001F", X"00000020"
);	 
begin
READDATA1<=RegFile(to_integer(unsigned(REGREAD1)));
READDATA2<=RegFile(to_integer(unsigned(REGREAD2)));
process(CLK,regWRITE)
begin
if rising_edge(CLK) and regWRITE = '1'
then RegFile(to_integer(unsigned(WRITEREG)))<=DATA;
end if;
end process;
end Behavioral;