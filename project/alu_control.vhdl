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
begin

    -- store/load
    with alu_op select
        alu_control <= 
            FNCODE        when alu_ctrl = ALU_FN else       -- determined by fn
            ALU_CTRL_ADD  when alu_ctrl = ALU_OP_ADD else  -- add
            ALU_CTRL_OR   when alu_ctrl = ALU_OP_OR else  -- or
            ALU_CTRL_AND  when alu_ctrl = ALU_OP_AND else  -- and
            ALU_CTRL_XOR  when alu_ctrl = ALU_OP_XOR else  -- xor
            ALU_CTRL_SUB  when alu_ctrl = ALU_OP_SUB else  -- sub
            ALU_CTRL_SLT  when alu_ctrl = ALU_OP_SLT;

    -- R type
    -- sort by function parameter
    -- ALU_CTRL_* => 
    with fn select
        FNCODE <= 
            ALU_CTRL_ADD  when  ADD_FN    else
            ALU_CTRL_ADDU when  ADDU_FN   else
            ALU_CTRL_SUB  when  SUB_FN 	else
            ALU_CTRL_SUBU when  SUBU_FN   else
            ALU_CTRL_AND  when  AND_FN    else
            ALU_CTRL_DIV  when  DIV_FN	else
            ALU_CTRL_DIVU when  DIVU_FN   else
            ALU_CTRL_JALR when  JALR_FN   else
            ALU_CTRL_JR   when  JR_FN     else
            ALU_CTRL_MFHI when  MFHI_FN   else
            ALU_CTRL_MFLO when  MFLO_FN   else
            ALU_CTRL_MTHI when  MTHI_FN   else
            ALU_CTRL_MTLO when  MTLO_FN   else
            ALU_CTRL_MUL  when  MULT_FN   else
            ALU_CTRL_MULU when  MULTU_FN  else
            ALU_CTRL_NOR  when  NOR_FN 	else
            ALU_CTRL_OR   when  OR_FN     else
            ALU_CTRL_REM  when  REM_FN 	else
            ALU_CTRL_REMU when  REMU_FN	else
            ALU_CTRL_SLL  when  SLL_FN 	else
            ALU_CTRL_SLL  when  SLLV_FN	else
            ALU_CTRL_SLT  when  SLT_FN 	else
            ALU_CTRL_SLTU when  SLTU_FN	else
            ALU_CTRL_SRA  when  SRA_FN 	else
            ALU_CTRL_SRA  when  SRAV_FN 	else
            ALU_CTRL_SRL  when  SRL_FN 	else
            ALU_CTRL_SRL  when  SRLV_FN	else
            ALU_CTRL_XOR  when  XOR_FN; 
        
        shift_sel <= '1' when fn = SRLV_FN | SRAV_FN | SLLV_FN else
                     '0';


end architecture;
