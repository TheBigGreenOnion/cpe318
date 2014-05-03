library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.lib_mips32.all;

entity alu is
    port (a,b : in std_logic_vector(31 downto 0);
        ctrl, shamt : in std_logic_vector(4 downto 0);
        result : out std_logic_vector(31 downto 0);
        zf : out std_logic);
end entity alu;

architecture behav of alu is
    signal res_t : signed(31 downto 0);
begin
    res_t <= signed(a) + signed(b);
    result <= std_logic_vector(res_t);
end architecture behav;

