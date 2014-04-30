-- derp
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.lib_mips32.all;

entity code_mem is
    port (read_addr : in unsigned ();
        en, clk : in std_logic;
        d_out : out std_logic_vector(31 downto 0));
end entity code_mem;


architecture behav of code_mem is
    type code_t is array (0 to ?XXX?) of std_logic_vector(31 downto 0);
    imem : code_t; --:= ""

begin
    fetch : process (read_addr)
        d_out <= imem(to_integer(unsigned(read_addr)));
    end process fetch;
end architecture behav;

