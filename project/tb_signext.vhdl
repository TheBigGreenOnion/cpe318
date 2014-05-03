library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_signext is
end entity tb_signext;

architecture verify of tb_signext is
    signal s_d_in : std_logic_vector(15 downto 0);
    signal s_d_out, s_d_out_sl2 : std_logic_vector (31 downto 0);
begin
    duv : entity work.signext
        port map ( 
            d_in => s_d_in,
            d_out => s_d_out,
            d_out_sl2 => s_d_out_sl2
        );

    test : process
    begin
        wait for 10 ns;
        s_d_in <= x"F000";
        wait for 10 ns;
        assert (s_d_out = x"FFFFF000");
        assert (s_d_out_sl2 = x"FFFFC000");
    end process test;

end architecture verify;
