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
        
        0 =>    "00000000111010", -- 0 em R3
        1 =>    "00000001001010", -- 0 em R4
        2 =>    "00000110000010", -- mv A R3
        3 =>    "00001000000001", -- add A R4
        4 =>    "00001000000011", -- mv R4 A ?????
        5 =>    "00000000011001", -- ld A 1
        6 =>    "00000110000001", -- add A, R3
        7 =>    "00000110000011", -- mv R3, A
        8 =>    "00000110000010", -- mv A R3
        9 =>    "00000111101000", -- cmpi A, 30
        10 =>   "11111000001101", -- ble -8
        11 =>   "00001000000010", -- mv A R4
        12 =>   "00001010000011", -- mv R5 A
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
