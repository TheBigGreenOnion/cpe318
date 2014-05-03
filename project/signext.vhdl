library ieee;
use ieee.std_logic_1164.all;

entity signext is
    port (d_in : in std_logic_vector(15 downto 0);
          d_out, d_out_sl2 : out std_logic_vector(31 downto 0));
end entity signext;

architecture behav of signext is
    signal ext : std_logic_vector(31 downto 0);
begin
    -- Sign extend and lshift by 2. Won't lose any valuable bits from shifting
    -- sign extended 16 bit number.
    ext <= (x"FFFF" & d_in) when d_in(15) = '1' else
             (x"0000" & d_in);

    d_out <= ext;
    d_out_sl2 <= ext(29 downto 0) & "00";
end architecture behav;
