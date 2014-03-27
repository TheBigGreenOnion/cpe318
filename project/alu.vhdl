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

    sub <= unsigned(a) - unsigned(b);
    sum <= unsigned(a) + unsigned(b);
    shiftra <= sra
    shiftr <= srl
    shiftl <= sll
    orl <= a or b;
    andl <= a and b;
    norl <= a nor b;
    xorl <= a xor b;
    mult <= unsigned(a) * unsigned(b);

    mux_results : process 
    begin
    with op select
        result <= derp when merp else

    end process mux_results;

    branch_cond : process
    begin

    end process branch_cond;

end architecture behav

