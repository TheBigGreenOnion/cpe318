-- derp
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.lib_mips32.all;

entity code_mem is
    port (read_addr : in std_logic_vector(31 downto 0);
        en, clk : in std_logic;
        d_out : out std_logic_vector(31 downto 0));
end entity code_mem;


architecture behav of code_mem is
    type code_t is array (0 to 31) of std_logic_vector(31 downto 0);
    signal imem : code_t; --:= ""
    signal inst : std_logic_vector(31 downto 0);
begin
    d_out <= inst;
    process (clk)
    begin
        if rising_edge(clk) then
            inst <= imem(to_integer(unsigned(read_addr)));
        end if;
    end process;
end architecture behav;

