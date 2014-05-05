library ieee;
use ieee.std_logic_1164.all;
use work.lib_mips32.all;

entity alu_control is
    port (alu_op : in std_logic_vector(2 downto 0);
        fn : in std_logic_vector(5 downto 0);
        alu_ctrl : out std_logic_vector(4 downto 0));
end entity alu_control;

architecture behav of alu_control is
signal FNCODE : std_logic_vector (4 downto 0);
signal shift_sel : std_logic;
begin

    -- store/load
    with alu_op select
        alu_ctrl <= 
            FNCODE        when ALU_OP_FN,       -- determined by fn
            ALU_CTRL_ADD  when ALU_OP_ADD,  -- add
            ALU_CTRL_OR   when ALU_OP_OR,  -- or
            ALU_CTRL_AND  when ALU_OP_AND,  -- and
            ALU_CTRL_XOR  when ALU_OP_XOR,  -- xor
            ALU_CTRL_SUB  when ALU_OP_SUB,  -- sub
            ALU_CTRL_SLT  when ALU_OP_SLT,
            ALU_CTRL_ADDU when ALU_OP_ADDU,
            ALU_CTRL_ADD  when others;

    -- R type
    -- sort by function parameter
    -- ALU_CTRL_* => 
    with fn select
        FNCODE <= 
            ALU_CTRL_ADD  when  ADD_FN,
            ALU_CTRL_ADDU when  ADDU_FN,
            ALU_CTRL_SUB  when  SUB_FN,
            ALU_CTRL_SUBU when  SUBU_FN,
            ALU_CTRL_AND  when  AND_FN,
--            ALU_CTRL_DIV  when  DIV_FN,
--            ALU_CTRL_DIVU when  DIVU_FN,
            ALU_CTRL_JALR when  JALR_FN,
            ALU_CTRL_JR   when  JR_FN,
--            ALU_CTRL_MFHI when  MFHI_FN,
--            ALU_CTRL_MFLO when  MFLO_FN,
--            ALU_CTRL_MTHI when  MTHI_FN,
--            ALU_CTRL_MTLO when  MTLO_FN,
--            ALU_CTRL_MUL  when  MULT_FN,
--            ALU_CTRL_MULU when  MULTU_FN,
            ALU_CTRL_NOR  when  NOR_FN,
            ALU_CTRL_OR   when  OR_FN,
--            ALU_CTRL_REM  when  REM_FN,
--            ALU_CTRL_REMU when  REMU_FN,
            ALU_CTRL_SLL  when  SLL_FN,
            ALU_CTRL_SLL  when  SLLV_FN,
            ALU_CTRL_SLT  when  SLT_FN,
            ALU_CTRL_SLTU when  SLTU_FN,
            ALU_CTRL_SRA  when  SRA_FN,
            ALU_CTRL_SRA  when  SRAV_FN,
            ALU_CTRL_SRL  when  SRL_FN,
            ALU_CTRL_SRL  when  SRLV_FN,
            ALU_CTRL_XOR  when  XOR_FN,
            ALU_CTRL_ADD  when others;
        
    with fn select
    shift_sel <= 
        '1' when SRLV_FN, 
        '1' when SRAV_FN, 
        '1' when SLLV_FN,
        '0' when others;

end architecture;
