-- alu

entity alu is
    port (a,b : in std_logic_vector(31 downto 0);
        op : in std_logic_vector(XXX downto 0);
        result : out std_logic_vector(31 downto 0);
        zf : out std_logic);
end entity alu

architecture behav of alu is
    signal mult, div : std_logic_vector(63 downto 0);
    signal sub, sum, shiftra, shiftl, shiftr, orl, andl, xorl, norl : std_logic_vector(31 downto 0);


end architecture behav

