library ieee;
use ieee.std_logic_1164.all;

entity alu_control is
    port (alu_op : in std_logic_vector(1 downto 0);
        fn : in std_logic_vector(5 downto 0);
        alu_ctrl : out std_logic_vector(3 downto 0));
end entity alu_control;

architecture behav of alu_control is
signal r : std_logic_vector (3 downto 0);
begin

    -- store/load
    with alu_op select
        alu_control <= "0000" when "000" else  -- store/load
            r      when "001" else       -- determined by fn
            "0000" when "010" else  -- add
            "0100" when "011" else  -- or
            "0010" when "100" else  -- and
            "0101" when "101" else  -- xor
            "0001" when "110" else  -- sub
            "0000" when others;

    -- R type
    -- sort by function parameter
    with fn select
        r <= "0000" when "100000" else  -- add
             "0000" when "100001" else  -- addu
             "0001" when "100010" else  -- sub
             "0001" when "100011" else  -- subu
             "0010" when "100100" else  -- and
             "0011" when "100111" else  -- nor
             "0100" when "100101" else  -- or
             "0101" when "100110" else  -- xor
             "0110" when "011000" else  -- mult
             "0110" when "011001" else  -- multu
             "0111" when "011010" else  -- div
             "0111" when "011011" else  -- divu
             "1000" when "000000" else  -- sll
             "1001" when "000100" else  -- sllv
             "1010" when "000011" else  -- sra
             "1011" when "000111" else  -- srav
             "1100" when "000010" else  -- srl
             "1101" when "000110" else  -- srlv
             "0000" when others;

    -- other stuff

--mfhi    0x00    0000    10  
--mflo    0x00    0000    12  
--mthi    0x00    0000    11  
--mtlo    0x00    0000    13  
--slt     0x00    0000    2a  
--sltu    0x00    0000    2b  
--slti    0x28    0000    00  
--sltiu   0x2c    0000    00  
    
end architecture behav;
