--    6    5    5    5      5      6
--R: OP  | RS | RT | RD | SHAMT | FUNC |
--I: OP  | RS | RT |     IMMEDIATE     |
--J: OP  |          TARGET             |



entity alu32 is
begin
    port (aluop : in std_logic_vector (1 downto 0);
        op_fn : in std_logic_vector(5 downto 0);
        alu_ctrl : out std_logic_vector (2 downto 0);

end entity alu32;

architecture behavioral of alu32 is
signal a, b, add_res : unsigned(31 downto 0);
begin
    a <= read1;
    b <= read2 when alu_src = '0' else
         immediate when alu_src = '1' else
         (others => '0');   -- error
    
    add_res <= a + b;
    sub_res <= a - b;
    or_res <= a or b;
    and_res <= a and b;
    slt_res <= -- set less than?

    alu_ctrl : process
    begin
    
    
    end process alu_ctrl;

    
