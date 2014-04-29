library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package lib_mips32 is

    -- R type function codes
    constant ADD_FN     :   std_logic_vector(5 downto 0)    := "100000"; -- 20
    constant ADDU_FN    :   std_logic_vector(5 downto 0)    := "100001"; -- 21
    constant SUB_FN 	:   std_logic_vector(5 downto 0)    := "100010"; -- 22	
    constant SUBU_FN	:   std_logic_vector(5 downto 0)    := "100011"; -- 23	
    constant AND_FN     :   std_logic_vector(5 downto 0)    := "100100"; -- 24
    constant DIV_FN	    :   std_logic_vector(5 downto 0)    := "011010"; -- 1a
    constant DIVU_FN	:   std_logic_vector(5 downto 0)    := "011011"; -- 1b	
    constant JALR_FN	:   std_logic_vector(5 downto 0)    := "001001"; -- 09	
    constant JR_FN  	:   std_logic_vector(5 downto 0)    := "001000"; -- 08	
    constant MFHI_FN	:   std_logic_vector(5 downto 0)    := "010000"; -- 10	
    constant MFLO_FN	:   std_logic_vector(5 downto 0)    := "010010"; -- 12	
    constant MTHI_FN	:   std_logic_vector(5 downto 0)    := "010001"; -- 11	
    constant MTLO_FN	:   std_logic_vector(5 downto 0)    := "010011"; -- 13	
    constant MULT_FN	:   std_logic_vector(5 downto 0)    := "011000"; -- 18	
    constant MULTU_FN	:   std_logic_vector(5 downto 0)    := "011001"; -- 19	
    constant NOR_FN 	:   std_logic_vector(5 downto 0)    := "100111"; -- 27	
    constant OR_FN  	:   std_logic_vector(5 downto 0)    := "100101"; -- 25	
    constant REM_FN 	:   std_logic_vector(5 downto 0)    := "011010"; -- 1a	
    constant REMU_FN	:   std_logic_vector(5 downto 0)    := "011011"; -- 1b	
    constant SLL_FN 	:   std_logic_vector(5 downto 0)    := "000000"; -- 00	
    constant SLLV_FN	:   std_logic_vector(5 downto 0)    := "000100"; -- 04	
    constant SLT_FN 	:   std_logic_vector(5 downto 0)    := "101010"; -- 2a	
    constant SLTU_FN	:   std_logic_vector(5 downto 0)    := "101011"; -- 2b	
    constant SRA_FN 	:   std_logic_vector(5 downto 0)    := "000011"; -- 03	
    constant SRA_FN 	:   std_logic_vector(5 downto 0)    := "000111"; -- 07	
    constant SRL_FN 	:   std_logic_vector(5 downto 0)    := "000010"; -- 02	
    constant SRLV_FN	:   std_logic_vector(5 downto 0)    := "000110"; -- 06	
    constant XOR_FN 	:   std_logic_vector(5 downto 0)    := "100110"; -- 26	
    
    -- OPCode based instruction definitions
    constant R_TYPE_OP  :   std_logic_vector(5 downto 0)    := "000000";
    constant REGIMM_OP  :   std_logic_vector(5 downto 0)    := "000001";
    --  constant BGEZ_OP    :   std_logic_vector(5 downto 0)    := "0x04	0100	00";
    --  constant BGEZAL_OP	:   std_logic_vector(5 downto 0)    := "0x04	1100	00";
    --  constant BLTZ_OP	:   std_logic_vector(5 downto 0)    := "0X04	0000	00";	
    --  constant BLTZAL_OP	:   std_logic_vector(5 downto 0)    := "0x04	1000	00";	
    constant J_OP   	:   std_logic_vector(5 downto 0)    := "000010";	
    constant JAL_OP 	:   std_logic_vector(5 downto 0)    := "000011";	
    constant BEQ_OP	    :   std_logic_vector(5 downto 0)    := "000100";	
    constant BNE_OP	    :   std_logic_vector(5 downto 0)    := "000101";	
    constant BLEZ_OP	:   std_logic_vector(5 downto 0)    := "000110";	
    constant BGTZ_OP	:   std_logic_vector(5 downto 0)    := "000111";	
    constant ADDI_OP	:   std_logic_vector(5 downto 0)    := "001000";	
    constant ADDIU_OP	:   std_logic_vector(5 downto 0)    := "001001";	
    constant SLTI_OP	:   std_logic_vector(5 downto 0)    := "001010";	
    constant SLTIU_OP	:   std_logic_vector(5 downto 0)    := "001011";	
    constant ANDI_OP	:   std_logic_vector(5 downto 0)    := "001100";	
    constant ORI_OP	    :   std_logic_vector(5 downto 0)    := "001101";	
    constant XORI_OP	:   std_logic_vector(5 downto 0)    := "001110";	
    constant LUI_OP	    :   std_logic_vector(5 downto 0)    := "001111";	
    constant LB_OP	    :   std_logic_vector(5 downto 0)    := "100000";	
    constant LH_OP	    :   std_logic_vector(5 downto 0)    := "100001";	
    constant LWL_OP	    :   std_logic_vector(5 downto 0)    := "100010";	
    constant LW_OP	    :   std_logic_vector(5 downto 0)    := "100011";	
    constant LBU_OP 	:   std_logic_vector(5 downto 0)    := "100100";	
    constant LHU_OP 	:   std_logic_vector(5 downto 0)    := "100101";	
    constant LWR_OP 	:   std_logic_vector(5 downto 0)    := "100110";	
    constant SB_OP	    :   std_logic_vector(5 downto 0)    := "101000";	
    constant SH_OP	    :   std_logic_vector(5 downto 0)    := "101001";	
    constant SWL_OP 	:   std_logic_vector(5 downto 0)    := "101010";	
    constant SW_OP  	:   std_logic_vector(5 downto 0)    := "101011";	
    constant SWR_OP     :   std_logic_vector(5 downto 0)    := "101110";	

    -- MIPS Declarations
    constant Zero32     :   std_logic_vector(31 downto 0)   := (others => '0');

end package lib_mips32;
