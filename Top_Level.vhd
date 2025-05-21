library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira

entity Top_Level is
    port(
        A_source    : in std_logic_vector(1 downto 0);
        B_source    : in std_logic;
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
        overflow    : out std_logic
    );
end entity;

architecture structural of Top_Level is
signal acum_out, acum_in, banco_out, ULA_out: unsigned(15 downto 0);
signal operando_B                           : unsigned(15 downto 0);
signal A_we : std_logic;
begin
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
        data_in => acum_out,
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

    acum_in <= ULA_out when A_source = "00" else immediate when A_source = "01" else banco_out;
    operando_B <= banco_out when B_source = '0' else immediate;

end architecture;