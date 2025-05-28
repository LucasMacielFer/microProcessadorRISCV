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
        0 => "11111111111111", -- NOP
        1 => "00000000000001", -- ADDI x1, x0, 1
        2 => "00000000000010", -- ADDI x2, x0, 2
        3 => "00000000000100", -- ADDI x4, x0, 4
        4 => "00000000001000", -- ADDI x8, x0, 8
        5 => "00000000101000", -- ADDI x8, x0, 16
        6 => "00000001010000", -- ADDI x8, x0, 32
        7 => "00000101010000", -- ADDI x8, x0, 64
        others => (others => '0') -- Fill the rest with zeros
    );
begin
    process(clk)
    begin
        if(rising_edge(clk)) then
            data_out <= content(to_integer(address));
        end if;
    end process;
end architecture;