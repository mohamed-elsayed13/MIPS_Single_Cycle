--Library Decaration 
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

--Entity Decaration
Entity InstMemory Is
port(
READADD : In STD_LOGIC_VECTOR(31 downto 0);
COUT :OUT STD_LOGIC_VECTOR(31 downto 0)
);
end InstMemory;

--Architecture Decaration
architecture Behavioral of InstMemory Is
type Memory is array (0 to 31) of STD_LOGIC_VECTOR(7 downto 0);  
signal MEM: Memory:= (
        -- Initialize the instruction memory with your instructions
        0 => "00000000",  -- 0x00851020 (Add $v0, $a0, $a1)
        1 => "10000101",
        2 => "00010000",
        3 => "00100000",
        4 => "10101100",  -- 0xAC020008 (sw $v0, 8($zero))
        5 => "00000010",
        6 => "00000000",
        7 => "00001000",
        8 => "10001100",  -- 0x8C060008 (lw $a2, 8($zero))
        9 => "00000110",
        10 => "00000000",
        11 => "00001000",
        12 => "00010000", -- 0x10460004 (beq $v0, $a2)
        13 => "01000110",
        14 => "00000000",
        15 => "00000100",
        16 => "00000000", -- 0x0056082A (slt $s1, $v0, $a2)
        17 => "01000110",
        18 => "10001000",
        19 => "00101010",
        20 => "00000000", -- 0x00A42022 (sub $s1, $a1, $a0)
        21 => "10100100",
        22 => "10001000",
        23 => "00100010",
        others => (others => '0')  -- Fill remaining memory with zeros
    );
begin
PROCESS(READADD)
BEGIN
COUT(31 downto 24) <= MEM(to_integer(unsigned(READADD)));
COUT(23 downto 16) <= MEM(to_integer(unsigned(READADD)+1));
COUT(15 downto  8) <= MEM(to_integer(unsigned(READADD)+2));
COUT(7  downto  0) <= MEM(to_integer(unsigned(READADD)+3));
END process;
end Behavioral;