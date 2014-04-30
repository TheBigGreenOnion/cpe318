-- program counter
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity program_counter is
    port (pc_dest : in std_logic_vector (31 downto 0);
        clk, pc_en, rst : in std_logic;
        pc_addr : out std_logic_vector(31 downto 0));
end entity program_counter;

-- Behavior of program counter
architecture behav of program_counter is
    signal ip : std_logic_vector(31 downto 0) := x"FFFFFFFF";
begin
    pc_addr <= ip;
    pc_inc : process (clk, rst, pc_en)
    begin
        if (rst = '1') then
            ip <= (others => '0');
        elsif falling_edge(clk) then 
            if (pc_en = '1') then
                ip <= pc_dest;
            end if;
        end if;
    end process;
end architecture behav;
