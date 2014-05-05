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
--  constant DIV_FN	    :   std_logic_vector(5 downto 0)    := "011010"; -- 1a
--  constant DIVU_FN	:   std_logic_vector(5 downto 0)    := "011011"; -- 1b	
    constant JALR_FN	:   std_logic_vector(5 downto 0)    := "001001"; -- 09	
    constant JR_FN  	:   std_logic_vector(5 downto 0)    := "001000"; -- 08	
--  constant MFHI_FN	:   std_logic_vector(5 downto 0)    := "010000"; -- 10	
--  constant MFLO_FN	:   std_logic_vector(5 downto 0)    := "010010"; -- 12	
--  constant MTHI_FN	:   std_logic_vector(5 downto 0)    := "010001"; -- 11	
--  constant MTLO_FN	:   std_logic_vector(5 downto 0)    := "010011"; -- 13	
--  constant MUL_FN 	:   std_logic_vector(5 downto 0)    := "011000"; -- 18	
--  constant MULU_FN	:   std_logic_vector(5 downto 0)    := "011001"; -- 19	
    constant NOR_FN 	:   std_logic_vector(5 downto 0)    := "100111"; -- 27	
    constant OR_FN  	:   std_logic_vector(5 downto 0)    := "100101"; -- 25	
-- constant REM_FN 	:   std_logic_vector(5 downto 0)    := "011010"; -- 1a	
-- constant REMU_FN	:   std_logic_vector(5 downto 0)    := "011011"; -- 1b	
    constant SLL_FN 	:   std_logic_vector(5 downto 0)    := "000000"; -- 00	
    constant SLLV_FN	:   std_logic_vector(5 downto 0)    := "000100"; -- 04	
    constant SLT_FN 	:   std_logic_vector(5 downto 0)    := "101010"; -- 2a	
    constant SLTU_FN	:   std_logic_vector(5 downto 0)    := "101011"; -- 2b	
    constant SRA_FN 	:   std_logic_vector(5 downto 0)    := "000011"; -- 03	
    constant SRAV_FN 	:   std_logic_vector(5 downto 0)    := "000111"; -- 07	
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
--  constant LUI_OP	    :   std_logic_vector(5 downto 0)    := "001111";	
--  constant LB_OP	    :   std_logic_vector(5 downto 0)    := "100000";	
--  constant LH_OP	    :   std_logic_vector(5 downto 0)    := "100001";	
--  constant LWL_OP	    :   std_logic_vector(5 downto 0)    := "100010";	
    constant LW_OP	    :   std_logic_vector(5 downto 0)    := "100011";	
--  constant LBU_OP 	:   std_logic_vector(5 downto 0)    := "100100";	
--  constant LHU_OP 	:   std_logic_vector(5 downto 0)    := "100101";	
--  constant LWR_OP 	:   std_logic_vector(5 downto 0)    := "100110";	
--  constant SB_OP	    :   std_logic_vector(5 downto 0)    := "101000";	
--  constant SH_OP	    :   std_logic_vector(5 downto 0)    := "101001";	
--  constant SWL_OP 	:   std_logic_vector(5 downto 0)    := "101010";	
    constant SW_OP  	:   std_logic_vector(5 downto 0)    := "101011";	
--  constant SWR_OP     :   std_logic_vector(5 downto 0)    := "101110";	

    -- Define control unit - alu communications
    constant ALU_OP_ADD :   std_logic_vector(2 downto 0)    := "000";
    constant ALU_OP_FN  :   std_logic_vector(2 downto 0)    := "001";
    constant ALU_OP_SLT :   std_logic_vector(2 downto 0)    := "010";
    constant ALU_OP_AND :   std_logic_vector(2 downto 0)    := "011";
    constant ALU_OP_XOR :   std_logic_vector(2 downto 0)    := "100";
    constant ALU_OP_OR  :   std_logic_vector(2 downto 0)    := "101";
    constant ALU_OP_SUB :   std_logic_vector(2 downto 0)    := "110";
    constant ALU_OP_ADDU :   std_logic_vector(2 downto 0)    := "111";

    -- Define alu control signals
	constant ALU_CTRL_ADD  	: std_logic_vector(4 downto 0) := "00001";
	constant ALU_CTRL_ADDU 	: std_logic_vector(4 downto 0) := "00010";
	constant ALU_CTRL_SUB  	: std_logic_vector(4 downto 0) := "00011";
	constant ALU_CTRL_SUBU 	: std_logic_vector(4 downto 0) := "00100";
	constant ALU_CTRL_AND  	: std_logic_vector(4 downto 0) := "00101";
--	constant ALU_CTRL_DIV  	: std_logic_vector(4 downto 0) := "00110";
--	constant ALU_CTRL_DIVU 	: std_logic_vector(4 downto 0) := "00111";
	constant ALU_CTRL_JALR 	: std_logic_vector(4 downto 0) := "01000";
	constant ALU_CTRL_JR   	: std_logic_vector(4 downto 0) := "01001";
--	constant ALU_CTRL_MFHI 	: std_logic_vector(4 downto 0) := "01010";
--	constant ALU_CTRL_MFLO 	: std_logic_vector(4 downto 0) := "01011";
--	constant ALU_CTRL_MTHI 	: std_logic_vector(4 downto 0) := "01100";
--	constant ALU_CTRL_MTLO 	: std_logic_vector(4 downto 0) := "01101";
--	constant ALU_CTRL_MUL  	: std_logic_vector(4 downto 0) := "01110";
--	constant ALU_CTRL_MULU 	: std_logic_vector(4 downto 0) := "01111";
	constant ALU_CTRL_NOR  	: std_logic_vector(4 downto 0) := "10000";
	constant ALU_CTRL_OR   	: std_logic_vector(4 downto 0) := "10001";
--	constant ALU_CTRL_REM  	: std_logic_vector(4 downto 0) := "10010";
--	constant ALU_CTRL_REMU 	: std_logic_vector(4 downto 0) := "10011";
	constant ALU_CTRL_SLL  	: std_logic_vector(4 downto 0) := "10101";
	constant ALU_CTRL_SLT  	: std_logic_vector(4 downto 0) := "10110";
	constant ALU_CTRL_SLTU 	: std_logic_vector(4 downto 0) := "10111";
	constant ALU_CTRL_SRA  	: std_logic_vector(4 downto 0) := "11001";
	constant ALU_CTRL_SRL  	: std_logic_vector(4 downto 0) := "11010";
	constant ALU_CTRL_XOR  	: std_logic_vector(4 downto 0) := "11100";


    -- General Declarations
    constant Zero32     :   std_logic_vector(31 downto 0)   := (others => '0');


end package lib_mips32;
