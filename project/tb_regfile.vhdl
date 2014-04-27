library ieee;
use ieee.std_logic_1164.all;

entity regfile is
    port (addr1, addr2, addr3, write_data : in std_logic_vector (31 downto 0);
        out1 out2 : out std_logic_vector (31 downto 0);
        reg_write, clk : in std_logic);
end entity regfile;

architecture verify of regfile is
    signal s_addr1, s_addr2, s_addr3, s_out1, s_out2, s_write_data : std_logic_vector(31 downto 0);
    signal s_reg_write : std_logic;

begin
    duv : entity work.regfile
        port map (s_addr1, s_addr2, s_addr3, s_write_data, s_out1, s_out2, s_reg_write);

    test : process is
    begin

end architecture behav;
