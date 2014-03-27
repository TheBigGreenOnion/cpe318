-- derp
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_mem is
    port (read_addr, write_addr : in unsigned ();
        d_in, d_out : out std_logic_vector(31 downto 0));
end entity data_mem;


architecture behav of data_mem is
    type data array (0 to n) of std_logic_vector(31 downto 0);
    mem : data;

end architecture behav;

