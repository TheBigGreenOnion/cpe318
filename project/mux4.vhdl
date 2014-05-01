library ieee;
use ieee.std_logic_1164.all;

entity mux4 is
    generic (n : integer);
    port (a, b, c, d : in std_logic_vector(n-1 downto 0);
        sel : in std_logic_vector(1 downto 0);
        output : out std_logic_vector(n-1 downto 0));
end entity mux4;

architecture behav of mux4 is
begin
    output <= a when sel = "00" else
           b when sel = "01" else
           c when sel = "10" else
           d when sel = "11" else
           (others => '0');
end architecture behav;
