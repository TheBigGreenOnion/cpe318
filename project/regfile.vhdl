library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity regfile is
    port (addr1, addr2, addr3 : in std_logic_vector (5 downto 0);
        write_data : in std_logic_vector(31 downto 0);
        out1, out2 : out std_logic_vector (31 downto 0);
        reg_write, clk, rst : in std_logic);
end entity regfile;

architecture behav of regfile is
type regarray is array (31 downto 0) of std_logic_vector(31 downto 0);
signal registers : regarray; -- := (others => '0');

begin
    out1 <= registers(to_integer(unsigned(addr1)));
    out2 <= registers(to_integer(unsigned(addr2)));

    write : process (clk, reg_write, rst)
    begin
        if (rst = '1') then
            registers <= (others => (others => '0'));
        elsif (rising_edge(clk)) then
            if (reg_write = '1') then
                registers(to_integer(unsigned(addr3))) <= write_data;
            end if;
        end if;
    end process write;
end architecture behav;
