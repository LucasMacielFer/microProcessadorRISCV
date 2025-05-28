library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira

entity Top_Level is
    port(
        A_source    : in std_logic_vector(1 downto 0);
        B_source    : in std_logic;
        REG_source  : in std_logic;
        clk         : in std_logic;
        rst         : in std_logic;
        A_rst       : in std_logic;
        wr_en       : in std_logic;
        A_wr_en     : in std_logic;
        operation   : in std_logic_vector(2 downto 0);
        w_address   : in std_logic_vector(3 downto 0);
        r_address   : in std_logic_vector(3 downto 0);
        immediate   : in unsigned(15 downto 0);
        zero        : out std_logic;
        negative    : out std_logic;
        carry       : out std_logic;
        overflow    : out std_logic;
        reg, regA   : out unsigned(15 downto 0) -- Apenas para TESTE
    );
end entity;

architecture structural of Top_Level is
    signal acum_out, acum_in, banco_out, ULA_out: unsigned(15 downto 0);
    signal operando_B, reg_in                   : unsigned(15 downto 0);
    signal saidaPC                              : unsigned(6 downto 0);
    signal entradaPC                            : unsigned(6 downto 0) := "0000000";
    signal instruction                          : unsigned(13 downto 0);
    signal we_PC                                : std_logic := '0';
begin
    Estado : entity work.TFF
    port map(
        clk => clk,
        rst => rst,
        data_out => we_PC
    );

    ROM : entity work.ROM
    port map(
        clk => clk,
        address => saidaPC,
        data_out => instruction
    );

    PC : entity work.reg1bit
    port map(
        clk => clk,
        rst => rst,
        wr_en => we_PC,
        data_in => entradaPC,
        data_out => saidaPC
    );

    soma1 : entity work.soma1
    port map(
        data_in => saidaPC,
        data_out => entradaPC
    );

    acumulador : entity work.reg16bit
    port map(
        clk => clk,
        rst => A_rst,
        wr_en => A_wr_en,
        data_in => acum_in,
        data_out => acum_out
    );

    banco : entity work.Banco_regs
    port map(
        clk => clk,
        rst => rst,
        wr_en => wr_en,
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

    acum_in     <= ULA_out when A_source = "00" else immediate when A_source = "01" else banco_out;
    operando_B  <= banco_out when B_source = '0' else immediate;
    reg_in      <= acum_out when REG_source = '0' else immediate;
    reg         <= banco_out;
    regA        <= acum_out;

end architecture;
