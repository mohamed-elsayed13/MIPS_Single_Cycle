-- Testbench for MIPS Processor

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entity Declaration
entity MIPSProcessor_tb is
end MIPSProcessor_tb;

-- Architecture Declaration
architecture Testbench of MIPSProcessor_tb is
    -- Component declaration of the MIPS Processor
    component MIPSProcessor
        port(
            clk   : in STD_LOGIC;
            reset : in STD_LOGIC
        );
    end component;

    -- Signals
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';

    -- Clock period constant
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: MIPSProcessor
        port map(
            clk => clk,
            reset => reset
        );

    -- Clock generation process
    clock_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
    end process;

    -- Reset process
    reset_process : process
    begin
        -- Assert reset for the first few clock cycles
        reset <= '1';
        wait for 20 ns;  -- Hold reset high for 20 ns
        reset <= '0';
        wait;  -- Keep running the simulation
    end process;

end Testbench;


-- -- Testbench for MIPS Processor

-- library IEEE;
-- use IEEE.STD_LOGIC_1164.ALL;
-- use IEEE.NUMERIC_STD.ALL;

-- -- Entity Declaration
-- entity MIPSProcessor_tb is
-- end MIPSProcessor_tb;

-- -- Architecture Declaration
-- architecture Testbench of MIPSProcessor_tb is
    -- -- Component declaration of the MIPS Processor
    -- component MIPSProcessor
        -- port(
            -- clk : in STD_LOGIC
        -- );
    -- end component;

    -- -- Signals
    -- signal clk : STD_LOGIC := '0';

    -- -- Clock period constant
    -- constant clk_period : time := 10 ns;

-- begin

    -- -- Instantiate the Unit Under Test (UUT)
    -- uut: MIPSProcessor
        -- port map(
            -- clk => clk
        -- );

    -- -- Clock generation process
    -- clock_process : process
    -- begin
        -- while true loop
            -- clk <= '0';
            -- wait for clk_period / 2;
            -- clk <= '1';
            -- wait for clk_period / 2;
        -- end loop;
    -- end process;


-- end Testbench;
