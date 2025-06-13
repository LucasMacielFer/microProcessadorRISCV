library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira

entity ROM is
    port (
        clk     : in std_logic;
        address : in unsigned(6 downto 0);
        data_out: out unsigned(13 downto 0)
    );
end entity;

architecture behavioral of ROM is
    type mem is array (0 to 127) of unsigned(13 downto 0);
    constant content : mem := (
        
        0 =>    "00001000001010", -- 0 em R3
        1 =>    "11110000011010", -- 0 em R4
        2 =>    "10110000101010", -- mv A R3
        3 =>    "00100000000110", -- add A R4
        4 =>    "00010010000110", -- mv R4 A ?????
        5 =>    "10000000000101", -- ld A 1
        6 =>    "10010010000010", -- add A, R3
        7 =>    "00010010000010", -- mv R3, A
        8 =>    "00001110111000", -- mv A R3
        9 =>    "00000000001100", -- cmpi A, 30
        others => (others => '0')
    );
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            data_out <= content(to_integer(address));
        end if;
    end process;
end architecture;
