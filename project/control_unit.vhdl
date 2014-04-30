library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.lib_mips32.all;

entity control is
    port ( pc_write_cond, pc_write, pc_src : out std_logic;
        mem_to_reg, mem_write, mem_read : out std_logic;
        ir_write, reg_dest, reg_write : out std_logic;
        alu_src_a : out std_logic;
        alu_src_b : out std_logic_vector(1 downto 0);
        alu_op : out std_logic_vector(2 downto 0);
        opcode : in std_logic_vector(5 downto 0);
        clk : in std_logic);
end entity control;


architecture behav of control is 
    signal s_pc_write_cond, s_pc_write, s_pc_src : std_logic;
    signal s_mem_addr, s_mem_toreg, s_mem_write : std_logic;
    signal s_reg_writeinst, s_reg_dest, s_reg_write : std_logic;
    signal s_alu_src_a, s_ir_write : std_logic;
    signal s_alu_src_b : std_logic_vector(1 downto 0);
    signal s_alu_op : std_logic_vector(2 downto 0);
    
    type state is (IF_0, ID_0, EX_0, MEM_0, REGWB_0);
    type inst is (R, I, J, B);
    type memaccess is (load, store, none);

    signal clkstate : state := IF_0;
    signal itype : inst;
    signal memwb : memaccess;
    
begin

    -- Set flags based on instruction
    with opcode select
        itype <= 
            J when JAL_OP | J_OP,
            B when REGIMM_OP,
            R when R_TYPE_OP,
            I when others;

    -- Determine various flags to be used later in the instruction cycle.
    -- All intermediate values that need to be set will be done directly,
    -- preserving the signal values
    -- -- itype dependent signals
    with itype select
        s_alu_src_a <= '1' when B | R,
                       '0' when others;
    with  itype select
        s_alu_src_b <= "00" when B | R,
                       "10" when I,
                       "11" when others;
    with itype select
        s_reg_dest <= '1' when R | B,
                      '0' when others;
    
    -- Determine signals using opcode 
    with opcode select
        s_alu_op <= 
            ALU_OP_ADD  when ADDI_OP | ADDIU_OP,
            ALU_OP_SLT  when SLTI_OP | SLTIU_OP,
            ALU_OP_AND  when ANDI_OP,
            ALU_OP_OR   when ORI_OP,
            ALU_OP_XOR  when XORI_OP,
            ALU_OP_FN   when others;


    -- State generation
    state_tbl : process (clk) 
    begin
        if (falling_edge(clk)) then
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
                clkstate <= IF_0;
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
                alu_op <= ALU_OP_ADD;
                
                pc_write <= '1';
                pc_src <= '0';
                ir_write <= '1';

            -- Decode
            elsif (clkstate = ID_0) then
                -- reset write enables
                pc_write <= '0';
                ir_write <= '0';

                -- end write disables


                ir_write <= '0';
                reg_write <= '0';

                reg_dest <= s_reg_dest;

            -- Execute
            elsif (clkstate = EX_0) then
                alu_src_a <= s_alu_src_a; 
                alu_src_b <= s_alu_src_b;
                alu_op <= s_alu_op;         

--                           -- Writeback
--            elsif (clkstate = MEM_0) then
--                s_pc_src <= "10" when itype = J else
--                            "01";
--                -- 00 reserved for automatic PC increment
--
--                s_pc_write_cond <= '1' when itype = B else '0';
--                
--                s_pc_write <= '1' when (itype = B | J) else '0';
--
--                s_mem_read <= '1' when memwb = load else '0';
--                s_mem_write <= '1' when memwb = store else '0';
--
--            -- RegWrite
--            elsif (clkstate = REGWB_0) then
--                s_mem_to_reg <= '1' when memwb = load else '0';
            end if;
        end if;
    end process;

end architecture behav;

