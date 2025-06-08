library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira

entity processador is
    port(
        clk         : in std_logic;
        rst         : in std_logic;
        A_rst       : in std_logic
    );
end entity;

architecture structural of processador is
    signal immediate                                    : unsigned(15 downto 0);
    signal acum_out, acum_in, banco_out, ULA_out        : unsigned(15 downto 0);
    signal w_address, r_address                         : std_logic_vector(3 downto 0);
    signal operando_B, reg_in                           : unsigned(15 downto 0);
    signal PC_out, delta                                : unsigned(6 downto 0);
    signal PC_in, sum_out                               : unsigned(6 downto 0);
    signal Reg_instruction, ROM_instruction             : unsigned(13 downto 0);
    signal muxAdd, muxB, muxR                           : std_logic;
    signal muxA, imm_ctrl                               : std_logic_vector(1 downto 0);
    signal we0_R, we0_A, we_R, we_A                     : std_logic;
    signal we_PC, we_inst_reg                           : std_logic;
    signal operation                                    : std_logic_vector(2 downto 0);  
    signal state_out                                    : unsigned(1 downto 0);  
    signal first_instr                                  : std_logic;  
    signal flag_neg, flag_over, flag_zero, flag_carry   : std_logic;
    signal bhi, blt, jump, branch                       : std_logic;
    signal ULA_flags_wr_en, we_0flags                   : std_logic;
    signal negative, carry, overflow, zero              : std_logic;

begin

    -----------------------------------------------------------------------------------------------------------------------------
    --                                                  < CONTROL UNITY >                                                      --
    -----------------------------------------------------------------------------------------------------------------------------
    UC : entity work.Control_Unit
    port map(
        instruction => Reg_instruction,
        muxAdd => muxAdd,
        muxB => muxB,
        muxR => muxR,
        muxA => muxA,
        we_R => we0_R,
        we_A => we0_A,
        operation => operation,
        imm => imm_ctrl,
        bhi => bhi,
        blt => blt,
        jump => jump,
        we_flags => we_0flags
    );



    -----------------------------------------------------------------------------------------------------------------------------
    --                                                  < STATE MACHINE >                                                      --
    -----------------------------------------------------------------------------------------------------------------------------

    -- Estado : entity work.TFF
    -- port map(
    --     clk => clk,
    --     rst => rst,
    --     data_out => state_out
    -- );
    

    first_inst_OSFF : entity work.one_shot_FF
    port map(
        clk => state_out(1),
        rst => rst,
        data_out => first_instr
    );

    state_machine : entity work.Maq_estados
    port map(
        clk => clk,
        rst => rst,
        estado => state_out
    );

    -----------------------------------------------------------------------------------------------------------------------------
    --                                                  < FLAGS FFS ULA >                                                      --
    -----------------------------------------------------------------------------------------------------------------------------
    ULA_flags_wr_en <= '1' when (state_out = "11" and we_0flags = '1') else '0';

    negative_flag : entity work.reg1bit
    port map(
        clk => clk,
        rst => rst,
        wr_en => ULA_flags_wr_en,
        data_in => negative,
        data_out => flag_neg
    );
    
    carry_flag : entity work.reg1bit
    port map(
        clk => clk,
        rst => rst,
        wr_en => ULA_flags_wr_en,
        data_in => carry,
        data_out => flag_carry
    );

    zero_flag : entity work.reg1bit
    port map(
        clk => clk,
        rst => rst,
        wr_en => ULA_flags_wr_en,
        data_in => zero,
        data_out => flag_zero
    );

    overflow_flag : entity work.reg1bit
    port map(
        clk => clk,
        rst => rst,
        wr_en => ULA_flags_wr_en,
        data_in => overflow,
        data_out => flag_over
    );

    -----------------------------------------------------------------------------------------------------------------------------
    --                                                    MEMORIA DE INSTRUCOES                                               --
    -----------------------------------------------------------------------------------------------------------------------------

    instruction_reg : entity work.reg14bit
    port map(
        clk     => clk,
        rst     => rst,
        wr_en   => we_inst_reg,
        data_in =>  ROM_instruction,
        data_out => Reg_instruction
    );

    we_R        <= '1' when (state_out = "11" and (we0_R = '1')) else '0'; 
    we_inst_reg <= '1' when (state_out = "10") else '0';

    ROM : entity work.ROM
    port map(
        clk => clk,
        address => PC_out,
        data_out => ROM_instruction
    );
    -----------------------------------------------------------------------------------------------------------------------------
    --                                                < PC | MUX_PC | SOMADORES >                                              --
    -----------------------------------------------------------------------------------------------------------------------------

    PC : entity work.reg7bit
    port map(
        clk => clk,
        rst => rst,
        wr_en => we_PC,
        data_in => PC_in,
        data_out => PC_out
    );

    --PC_in   <= sum_out when muxPC = '0' else Reg_instruction(13 downto 7);
    branch <= (flag_carry and (not flag_zero) and bhi) or ((flag_neg xor flag_over) and blt);
    PC_in <= immediate(6 downto 0) when (jump = '1') else delta when branch = '1' else sum_out;
    we_pc       <= '1' when (state_out = "00" and first_instr = '1') else '0'; 

    soma1 : entity work.soma1
    port map(
        data_in => PC_out,
        data_out => sum_out
    );

    somador_sete_bites : entity work.somador7bit
    port map(
        operando_A => immediate(7 downto 0),
        operando_B => PC_out,
        saida => delta
    );
    ------------------------------------------------------------------------------------------------------------------------------
    --                                                      < ACUMULADOR >                                                      --
    ------------------------------------------------------------------------------------------------------------------------------
    acumulador : entity work.reg16bit
    port map(
        clk => clk,
        rst => A_rst,
        wr_en => we_A,
        data_in => acum_in,
        data_out => acum_out
    );

    acum_in     <= ULA_out when muxA = "00" else immediate when muxA = "01" else banco_out;
    we_A        <= '1' when (state_out = "11" and (we0_A = '1')) else '0';

    ------------------------------------------------------------------------------------------------------------------------------
    --                                                      < BANCO REGS >                                                      --
    ------------------------------------------------------------------------------------------------------------------------------
    banco : entity work.Banco_regs
    port map(
        clk => clk,
        rst => rst,
        wr_en => we_R,
        w_address => w_address,
        r_address => r_address,
        data_in => reg_in,
        data_out => banco_out
    );

    reg_in      <= acum_out when muxR = '0' else immediate;
    w_address   <= std_logic_vector(Reg_instruction(10 downto 7)) when muxAdd = '0' else std_logic_vector(Reg_instruction(7 downto 4));
    r_address   <= std_logic_vector(Reg_instruction(10 downto 7));

    -----------------------------------------------------------------------------------------------------------------------------
    --                                                      < ULA >                                                            --
    -----------------------------------------------------------------------------------------------------------------------------
    ULA : entity work.ULA
    port map(
        input_A => acum_out,
        input_B => operando_B,
        result => ULA_out,
        operation => operation,
        zero => zero,
        negative => negative,
        carry => carry,
        overflow => overflow
    );

    operando_B  <= banco_out when muxB = '0' else immediate;
    -----------------------------------------------------------------------------------------------------------------------------
    --                                                  < GLOBAL >                                                             --
    -----------------------------------------------------------------------------------------------------------------------------

    immediate   <= (5 downto 0 => Reg_instruction(13)) & Reg_instruction(13 downto 4) when imm_ctrl = "00" else
                    (9 downto 0 => Reg_instruction(13)) & Reg_instruction(13 downto 8) when imm_ctrl = "01" else
                    (8 downto 0 => Reg_instruction(13)) & Reg_instruction(13 downto 7) when imm_ctrl = "10" else
                    (7 downto 0 => Reg_instruction(13)) & Reg_instruction(13 downto 6);

end architecture;



-- PC_in       <= sum_out when muxPC = '0' else Reg_instruction(13 downto 7);
-- immediate   <= (5 downto 0 => Reg_instruction(13)) & Reg_instruction(13 downto 4) when imm_ctrl = '0' else
--             (9 downto 0 => Reg_instruction(13)) & Reg_instruction(13 downto 8);
-- we_pc       <= '1' when (state_out = "00" and first_instr = '1') else '0'; 
-- acum_in     <= ULA_out when muxA = "00" else immediate when muxA = "01" else banco_out;
-- operando_B  <= banco_out when muxB = '0' else immediate;
-- reg_in      <= acum_out when muxR = '0' else immediate;

-- w_address   <= std_logic_vector(Reg_instruction(10 downto 7)) when muxAdd = '0' else std_logic_vector(Reg_instruction(7 downto 4));
-- r_address   <= std_logic_vector(Reg_instruction(10 downto 7));
-- we_A        <= '1' when (state_out = "11" and (we0_A = '1')) else '0';
-- we_R        <= '1' when (state_out = "11" and (we0_R = '1')) else '0'; 
-- we_inst_reg <= '1' when (state_out = "10") else '0';