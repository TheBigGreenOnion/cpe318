library ieee;
use ieee.std_logic_1164.all;

entity regfile is
    port (r1, r2, r3, write_data : in std_logic_vector (31 downto 0);
        out1 out2 : out std_logic_vector (31 downto 0);
        reg_write, clk : in std_logic);
end entity regfile;

architecture behav of regfile is
type regarray is array (31 downto 0) of std_logic_vector(31 downto 0);
registers : regarray := (others => '0');

begin
    out1 <= regarray(to_integer(unsigned(r1)));
    out2 <= regarray(to_integer(unsigned(r2)));

    write : process (reg_write, write_data)
    begin
        if (rising_edge(clk)) then
            if (reg_write = '1') then
                redarray(to_integer(unsigned(r3))) <= write_data;
            end if;
        end if;
    end process write;
end architecture behav;