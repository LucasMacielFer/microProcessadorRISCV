library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira

entity TL_ULA_Banco is
    port(
        A_source    : in std_logic;
        B_source    : in std_logic;
        clk         : in std_logic;
        rst         : in std_logic;
        A_rst       : in std_logic;
        wr_en       : in std_logic;
        A_wr_en     : in std_logic;
        operation   : in std_logic_vector(2 downto 0);
        w_address   : in std_logic_vector(3 downto 0);
        r_address   : in std_logic_vector(3 downto 0);
        data_in     : in unsigned(15 downto 0);
        constante   : in unsigned(15 downto 0)
        zero    : out std_logic;
        negative: out std_logic;
        carry   : out std_logic;
        overflow: out std_logic
    );
end entity;

architecture structural of TL_ULA_Banco is
signal operando_A, operando_B, data_banco   : unsigned(15 downto 0);
signal ULA_out, acum_out                    : unsigned(15 downto 0);
signal A_we : std_logic;
begin
    acumulador : entity work.reg16bit
    port map(
        clk => clk,
        rst => A_rst,
        wr_en => A_wr_en,
        data_in <= operando_A,
        data_out <= acum_out
    );

    banco : entity work.Banco_regs
    port map(
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        w_address => w_address,
        r_address => r_address,
        data_in => data_in,
        sata_out => data_banco
    );

    ULA : entity work.ULA
    port map(
        input_A => acum_out,
        input_B => operando_B,
        result => result,
        operation => operation,
        zero => zero,
        negative => negative,
        carry => carry,
        overflow => overflow
    );

    operando_A <= ULA_out when A_source = '0' else data_banco;
    operando_B <= acum_out when B_source = '1' else constante;

end architecture;