library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira

entity somador7bit is
    port (
        operando_A  : in unsigned(7 downto 0);
        operando_B  : in unsigned(6 downto 0);
        saida       : out unsigned(6 downto 0)
    );
end entity;

architecture comportamental of somador7bit is
    signal op_B, parcial: unsigned(7 downto 0);
begin
    op_B <= '0' & operando_B;
    parcial <= operando_A + op_B;
    saida <= parcial(6 downto 0);
end architecture;