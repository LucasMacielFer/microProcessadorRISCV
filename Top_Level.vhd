library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira

entity Top_Level is
    port(
        clk         : in std_logic;
        rst         : in std_logic;
        A_rst       : in std_logic;
        zero        : out std_logic;
        negative    : out std_logic;
        carry       : out std_logic;
        overflow    : out std_logic
    );
end entity;

architecture structural of Top_Level is
    signal immediate                            : unsigned(15 downto 0);
    signal acum_out, acum_in, banco_out, ULA_out: unsigned(15 downto 0);
    signal w_address, r_address                 : std_logic_vector(3 downto 0);
    signal operando_B, reg_in                   : unsigned(15 downto 0);
    signal PC_out                               : unsigned(6 downto 0);
    signal PC_in, sum_out                       : unsigned(6 downto 0);
    signal instruction                          : unsigned(13 downto 0);
    signal muxPC, muxAdd, muxB, muxR            : std_logic;
    signal muxA                                 : std_logic_vector(1 downto 0);
    signal we0_R, we0_A, imm_ctrl, we_R, we_A   : std_logic;
    signal we_PC, state_out                     : std_logic;
    signal operation                            : std_logic_vector(2 downto 0);     

begin
    UC : entity work.Control_Unit
    port map(
        instruction => instruction,
        muxPC => muxPC,
        muxAdd => muxAdd,
        muxB => muxB,
        muxR => muxR,
        muxA => muxA,
        we_R => we0_R,
        we_A => we0_A,
        operation => operation,
        imm => imm_ctrl
    );

    Estado : entity work.TFF
    port map(
        clk => clk,
        rst => rst,
        data_out => state_out
    );

    ROM : entity work.ROM
    port map(
        clk => clk,
        address => PC_out,
        data_out => instruction
    );

    PC : entity work.reg1bit
    port map(
        clk => clk,
        rst => rst,
        wr_en => we_PC,
        data_in => PC_in,
        data_out => PC_out
    );

    soma1 : entity work.soma1
    port map(
        data_in => PC_out,
        data_out => sum_out
    );

    acumulador : entity work.reg16bit
    port map(
        clk => clk,
        rst => A_rst,
        wr_en => we_A,
        data_in => acum_in,
        data_out => acum_out
    );

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

    immediate   <= (5 downto 0 => instruction(13)) & instruction(13 downto 4) when imm_ctrl = '0' else
                    (9 downto 0 => instruction(13)) & instruction(13 downto 8);
    we_pc       <= not state_out; 
    acum_in     <= ULA_out when muxA = "00" else immediate when muxA = "01" else banco_out;
    operando_B  <= banco_out when muxB = '0' else immediate;
    reg_in      <= acum_out when muxR = '0' else immediate;
    PC_in       <= sum_out when muxPC = '0' else instruction(13 downto 7);
    w_address   <= std_logic_vector(instruction(10 downto 7)) when muxAdd = '0' else std_logic_vector(instruction(7 downto 4));
    r_address   <= std_logic_vector(instruction(10 downto 7));
    we_A <= we0_A and not state_out;
    we_R <= we0_R and not state_out; -- Perguntar para o prof se está certo sexta-feira

end architecture;