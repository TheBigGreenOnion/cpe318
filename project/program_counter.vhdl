-- program counter
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is
    port (pc_jmp : in std_logic_vector (31 downto 0);
        clk, pc_en : in std_logic;
        pc_addr : out std_logic_vector(31 downto 0));
end entity program_counter;

-- Behavior of program counter
architecture behav of program_counter is
    signal : unsigned(31 downto 0);
begin

    jump : process
end architecture behav;
