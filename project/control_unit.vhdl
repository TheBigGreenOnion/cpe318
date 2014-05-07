library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.lib_mips32.all;

entity control is
    port ( pc_write : out std_logic;
        mem_to_reg, mem_write, mem_read : out std_logic;
        ir_write, reg_dest, reg_write : out std_logic;
        alu_src_a : out std_logic;
        alu_src_b, pc_src : out std_logic_vector(1 downto 0);
        alu_op : out std_logic_vector(3 downto 0);
        opcode : in std_logic_vector(5 downto 0);
        rst, clk : in std_logic);
end entity control;

architecture behav of control is 
    signal s_pc_write : std_logic;
    signal s_mem_addr, s_mem_to_reg, s_mem_write, s_mem_read : std_logic;
    signal s_reg_writeinst, s_reg_dest, s_reg_write : std_logic;
    signal s_alu_src_a : std_logic;
    signal s_alu_src_b, s_pc_src : std_logic_vector(1 downto 0);
    signal s_alu_op : std_logic_vector(3 downto 0);
    
    type state_t is (IF_0, ID_0, EX_0, MEM_0, REGWB_0);
    type inst_t is (R, I, J, B, MEM);
    type memaccess_t is (load, store, none);

    signal clkstate : state_t := REGWB_0; 
    signal itype : inst_t;
    signal memwb : memaccess_t;
    
begin

    with opcode select
        memwb <=
        load when LW_OP,    --LUI_OP | LB_OP | LH_OP | LWL_OP | LW_OP | LBU_OP | LHU_OP | LWR_OP,
        store when SW_OP,   --SB_OP | SH_OP | SWL_OP | SW_OP | SWR_OP,
        none when others;

    -- Set flags based on instruction
    with opcode select
        itype <= 
            J when JAL_OP,
            J when J_OP,
            B when REGIMM_OP,
            B when BEQ_OP,
            B when BNE_OP,
            B when BLEZ_OP,
            B when BGTZ_OP,
            R when R_TYPE_OP,
            I when others;

    -- Determine various flags to be used later in the instruction cycle.
    -- All intermediate values that need to be set will be done directly,
    -- preserving the signal values
    -- -- itype dependent signals
    with itype select
        s_alu_src_a <= '0' when J,
                       '1' when others;
    with  itype select
        s_alu_src_b <= "00" when R,
                       "10" when I,
                       "11" when others; -- load and store
    with itype select
        s_reg_dest <= '0' when I,
                      '0' when B,
                      '0' when J,
                      '1' when R,
                      '0' when others;
    
    with itype select
        s_pc_write <=
            '1' when J,
            '0' when others;

    s_mem_read <= '1'  when memwb = load else '0';
    s_mem_write <= '1'  when memwb = store else '0';

    s_pc_src <= "10" when itype = J else
                "01";
    s_mem_to_reg <= '1' when memwb = load else '0';
    
    with itype select
        s_reg_write <= '1' when R,
                       '1' when I,
                       '0' when others;
    -- Determine signals using opcode 
    with opcode select
        s_alu_op <= 
            ALU_OP_FN   when R_TYPE_OP,
            ALU_OP_SLT  when SLTI_OP,
            ALU_OP_SLT  when SLTIU_OP,
            ALU_OP_AND  when ANDI_OP,
            ALU_OP_OR   when ORI_OP,
            ALU_OP_XOR  when XORI_OP,

            ALU_OP_BEQ  when BEQ_OP,  
            ALU_OP_BNE  when BNE_OP,
            ALU_OP_BLEZ when BLEZ_OP,
            ALU_OP_BGTZ when BGTZ_OP,
            -- Branch instructions have aluop too
            ALU_OP_ADD  when others;

                
    -- State generation
    state_tbl : process (clk, rst) 
    begin
        if (falling_edge(clk)) then
            if (rst = '0') then
                if (clkstate = IF_0) then
                    clkstate <= ID_0;
                elsif (clkstate = ID_0) then
                    clkstate <= EX_0;
                elsif (clkstate = EX_0) then
                    clkstate <= MEM_0;
                elsif (clkstate = MEM_0) then
                    clkstate <= REGWB_0;
                elsif (clkstate = REGWB_0) then
                    clkstate <= IF_0;
                else
                    clkstate <= REGWB_0;
                end if;
            else
                clkstate <= REGWB_0;
            end if;
        end if;
    end process state_tbl;


    -- Combinational logic for control signals.
    control : process(clk, clkstate, itype, memwb) 
    begin
        if (rising_edge(clk)) then
            -- Instruction Read
            if (clkstate = IF_0) then
                alu_src_a <= '0';     -- Source PC
                alu_src_b <= "01";    -- Source '4'
                alu_op <= ALU_OP_ADDU;
                
                pc_write <= '1';
                pc_src <= "00";
                ir_write <= '0';
                reg_write <= '0';

            -- Decode
            elsif (clkstate = ID_0) then
                ir_write <= '0';
                pc_write <= '0';
                reg_dest <= s_reg_dest;

            -- Execute
            elsif (clkstate = EX_0) then
                pc_write <= '0';
                alu_src_a <= s_alu_src_a; 
                alu_src_b <= s_alu_src_b;
                alu_op <= s_alu_op;         

            -- Writeback
            elsif (clkstate = MEM_0) then
                -- write to PC if branch or jmp instruction
                pc_src <= s_pc_src;
                pc_write <= s_pc_write; 

                mem_read <= s_mem_read;
                mem_write <= s_mem_write; 
                mem_to_reg <= s_mem_to_reg; -- '1' when memwb = load else '0';
            -- RegWrite
            elsif (clkstate = REGWB_0) then
                pc_write <= '0';
                ir_write <= '1';
                reg_write <= s_reg_write;  
                --mem_to_reg <= s_mem_to_reg;
            end if;
        end if;
    end process;

end architecture behav;
