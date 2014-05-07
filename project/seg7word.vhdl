library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.lib_mips32.all;

entity seg7word is
    port (
        d_in : in std_logic_vector(31 downto 0);
        seg_0, seg_1, seg_2, seg_3, seg_4, seg_5, seg_6, seg_7 : out std_logic_vector(6 downto 0));
end entity seg7word;

architecture behav of seg7word is
begin
    seg0 : entity work.segdec
        port map (
            d_in => d_in(3 downto 0),
            segout => seg_0
        );

    seg1 : entity work.segdec
        port map (
            d_in => d_in(7 downto 4),
            segout => seg_1
        );
    seg2 : entity work.segdec
        port map (
            d_in => d_in(11 downto 8),
            segout => seg_2
        );
    seg3 : entity work.segdec
        port map (
            d_in => d_in(15 downto 12),
            segout => seg_3
        );
    seg4 : entity work.segdec
        port map (
            d_in => d_in(19 downto 16),
            segout => seg_4
        );
    seg5 : entity work.segdec
        port map (
            d_in => d_in(23 downto 20),
            segout => seg_5
        );
    seg6 : entity work.segdec
        port map (
            d_in => d_in(27 downto 24),
            segout => seg_6
        );
    seg7 : entity work.segdec
        port map (
            d_in => d_in(31 downto 28),
            segout => seg_7
        );

end architecture behav; 
