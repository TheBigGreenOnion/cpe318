-- derp
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_mem is
    port (read_addr, write_addr : in std_logic_vector(9 downto 0);
          d_in : in std_logic_vector(31 downto 0);
          d_out : out std_logic_vector(31 downto 0);
          write_en, read_en, clk : in std_logic);
end entity data_mem;

architecture behav of data_mem is
    type ram_t is array (0 to 1023) of std_logic_vector(7 downto 0);
    signal ram : ram_t;
begin
    data_rw : process(clk, write_en, read_en)
    begin
        if (rising_edge(clk)) then
            if (write_en = '1') then
                ram(to_integer(unsigned(write_addr))) <= d_in;
            elsif (read_en = '1') then
                d_out <= ram(to_integer(unsigned(read_addr)));
            end if;
        end if;
    end process data_rw;

end architecture behav;

