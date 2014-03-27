-- derp
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity code_mem is
    port (read_addr : in unsigned ();
        d_out : out std_logic_vector(31 downto 0));
end entity code_mem;


architecture behav of code_mem is
    type code array (0 to n) of std_logic_vector(31 downto 0);
    program : code;

begin
    fetch : process (read_addr)
        d_out <= program(read_addr);
    end process fetch;
end architecture behav;

