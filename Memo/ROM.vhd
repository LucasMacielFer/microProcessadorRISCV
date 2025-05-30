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
        
        0 =>    "00010100111010",
        1 =>    "00100001001010",
        2 =>    "00000110000010",
        3 =>    "00001000000001",
        4 =>    "00001010000011",
        5 =>    "00100000000001",
        6 =>    "00001010000011",
        7 =>    "00101000001111",
        8 =>    "00000001011010",
        9 =>    "00000000000000",
        10 =>   "00000000000000",
        11 =>   "00000000000000",
        12 =>   "00000000000000",
        13 =>   "00000000000000",
        14 =>   "00000000000000",
        15 =>   "00000000000000",
        16 =>   "00000000000000",
        17 =>   "00000000000000",
        18 =>   "00000000000000",
        19 =>   "00000000000000",
        20 =>   "00001010000010",
        21 =>   "00000110000011",
        22 =>   "00000100001111",
        23 =>   "00000000111010", 
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