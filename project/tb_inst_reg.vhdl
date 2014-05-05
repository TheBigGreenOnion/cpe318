library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use lib_mips32.all;

entity ENT is
    port ( ); 
end entity ENT;

architecture verify of ENT is
    signal 
begin
    duv : entity work.ARCH
        port map ( 
            clk => clk,
            PERTS
        );

    test : process
    begin
 
    end process test;

    clkgen : process
    begin
        clk <= not clk;
        wait for 1 ns;
    end process clkgen;

end architecture verify;
