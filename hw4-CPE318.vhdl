entity count4 is 
    port (clk, ce, rst : in std_logic;
        Q : out unsigned(3 downto 0));
end entity count4;

architecture behavioral of count4 is
signal count_t : unsigned (3 downto 0) := "0000";

begin
    Q <= count_t;

    process : count (clk)
    begin
        if (rising_edge(clk)) then
            if (rst = '1') then
                count_t <= "0000";
            elsif (ce = '1') then
                count_t <= count_t + 1;
            end if;
        end if;
    end process count;
end architecture behavioral;



entity ripplecount is
    port (Q : Q_n : out unsigned(3 downto 0);
        clk : in std_logic);
end entity ripplecount;

architecture behavioral of ripplecount is
signal st1, st2, st3, st4 : std_logic := '0';
begin
    Q <= st4 & st3 & st2 & st1;
    Q_n <= not (st4 & st3 & st2 & st1);
    stage0 : process (clk)
    begin
        if (rising_edge(clk)) then
            st1 <= not st1;
        end if;
    end process stage0;

    stage1 : process (st1);
    begin
        if (rising_edge(st1)) then
            st2 <= not st2;
        end if;
    end process stage1;

    stage2 : process (st2)
    begin
        if (rising_edge(st2)) then
            st3 <= not st3;
        end if;
    end process stage2;
        
    stage3 : process (st3)
    begin
        if (rising_edge(st3)) then 
            st4 <= not st4;
        end if;
    end process stage3;

end architecture behavioral;
