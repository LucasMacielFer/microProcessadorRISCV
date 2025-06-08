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
        
        0 =>    "00000000111010",
        1 =>    "00000001001010",
        2 =>    "00000110000010",
        3 =>    "00001000000001",
        4 =>    "00001000000011",
        5 =>    "00000000011001",
        6 =>    "00000110000001",
        7 =>    "00000110000011",
        8 =>    "00000110000010",
        9 =>    "00000111101000",
        10 =>   "11111000001101",
        11 =>   "00001000000010",
        12 =>   "00001010000011",
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