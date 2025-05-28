library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira

entity soma1 is
    port (
        data_in : in unsigned(6 downto 0);
        data_out: out unsigned(6 downto 0)
    );
end entity;

architecture behavioral of soma1 is
    signal registro: unsigned(6 downto 0);
begin
    registro <= data_in + "0000001";  -- Soma 1 ao valor de entrada
    data_out <= registro;  -- Saída do valor somado
end architecture;