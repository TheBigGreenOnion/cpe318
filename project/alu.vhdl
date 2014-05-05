-- 32 bit ALU.
-- Ignore stuff for a ton of complex operations because
-- school
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.lib_mips32.all;

entity alu is
    port (a,b : in std_logic_vector(31 downto 0);
        ctrl, shamt : in std_logic_vector(4 downto 0);
        clk : in std_logic;
        result, res_unbuff : out std_logic_vector(31 downto 0);
        zf : out std_logic);
end entity alu;

architecture behav of alu is
    -- signed and unsigned signals 
    signal result_s, slt_val : signed (31 downto 0);
    signal result_u, sltu_val : unsigned (31 downto 0);

    signal a_s, b_s : signed(31 downto 0);
    signal a_u, b_u : unsigned(31 downto 0);

    signal signedp : std_logic;
begin
    a_s <= signed (a);
    b_s <= signed (b);
    a_u <= unsigned(a);
    b_u <= unsigned(b);

    res_unbuff <= std_logic_vector(result_u);

    with ctrl select
        signedp <= '1' when ALU_CTRL_ADD,
                '1' when ALU_CTRL_SLT, 
                '1' when ALU_CTRL_SUBU,
                '1' when ALU_CTRL_SRA,
                '0' when others;

    slt_val <= x"00000001" when (a < b) and signedp = '1' else signed(Zero32);
    sltu_val <= x"00000001" when (a < b) else unsigned(Zero32);

    with ctrl select
        result_u <= 
            a_u - b_u when ALU_CTRL_SUBU,
            a_u + b_u when ALU_CTRL_ADDU, 
            unsigned(a and b) when ALU_CTRL_AND,
            unsigned(a or b) when ALU_CTRL_OR,
            unsigned(a xor b) when ALU_CTRL_XOR,
            unsigned(a nor b) when ALU_CTRL_NOR,
            a_u srl to_integer(b_s)when ALU_CTRL_SRL,
            a_u sll to_integer(b_s) when ALU_CTRL_SLL,
            sltu_val when ALU_CTRL_SLTU,
            unsigned(Zero32) when others;
--        result_u <= a_u  b_u when ALU_CTRL_,

    with ctrl select
        result_s <= 
            a_s + b_s when ALU_CTRL_ADD,
            a_s - b_s when ALU_CTRL_SUB,
            slt_val when ALU_CTRL_SLT,
            shift_right(a_s, to_integer(b_s)) when ALU_CTRL_SRA,
            signed(Zero32) when others;
--        result_s <= a_s   b_s when ALU_CTRL_,

    -- Add branch logic as well

    latch : process (clk, signedp)
    begin
        if (rising_edge(clk)) then 
            if (signedp = '1') then
                result <= std_logic_vector(result_s);
            elsif (signedp = '0') then  
                result <= std_logic_vector(result_u);
            else
                result <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
            end if;
        end if;
    end process latch;

end architecture behav;
