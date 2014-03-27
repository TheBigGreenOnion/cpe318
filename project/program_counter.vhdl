-- program counter
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is
    port (pc_next : in std_logic_vector (31 downto 0);
        zero, jump, branch, clk : in std_logic;
        j_inst : in std_logic_vector (25 downto 0);
        i_inst : in std_logic_vector (31 downto 0);
        pc_current : out std_logic_vector(31 downto 0));
end entity program_counter;

-- Behavior of program counter
architecture behav of program_counter is
    signal jumpdest, branchdest, pc_inc : unsigned(31 downto 0);
    signal clk_count : unsigned(2 downto 0) := "000";
begin
    -- Combinational portion.  Generate outputs for branch, jump, and inc
    pc_inc <= unsigned(pc_current) + 4;
    jumpdest <= pc_inc(31 downto 28) & (j_inst sll 2);
    branchdest <= unsigned(pc_inc) + unsigned(i_inst(29 downto 0) & "00");


    -- Determine which operation to use.  
    -- selecting on every clock will leave the result stable by the time
    -- the next state of the PC is determined.
    select_pc : process (clk)
    begin
        if (rising_edge(clk)) then
            pc_next <= branchdest when (zero = '1' and branch = '1') else
                    jumpdest when (branch = '0' and jump = '1') else
                    pc_inc when others;
        end if;
    end process select_pc;

    -- Take result of PC determining hardware on the last clock of the machine cycle.   
    latch_pc : process(clk, clk_count)
    begin
        if (rising_edge(clk)) then
            if (clk_count = 4) then
                pc_current <= pc_next;
                clk_count <= 0;
            else
                clk_count <= clk_count + 1;
            end if;
        end if;
    end process latch_pc;
end architecture behav;
