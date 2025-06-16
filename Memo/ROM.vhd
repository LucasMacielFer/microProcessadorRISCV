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
        
        0 =>    "00001000001010", -- r0 <- 2
        1 =>    "01110000011010", -- r1 <- 28
        2 =>    "00110000101010", -- r2 <- 12
        3 =>    "00000100111010", -- 13 <- 1
        4 =>    "00100000000110", -- RAM(r0) <- r2 [RAM(2) <- 12]
        5 =>    "00010010000110", -- RAM(r2) <- r1 [RAM(12) <- 28]
        6 =>    "10000000000101", -- r8 <- RAM(r0) [r8 <- RAM(2) = 12]
        7 =>    "10010010000101", -- r9 <- RAM(r2) [r9 <- RAM(12) = 28]
        8 =>    "00010010000010", -- A <- r9
        9 =>    "00000110000001", -- A <- A + r3 = 1
        10 =>   "00000011001000", -- compara A, 12
        11 =>   "00000000001100", -- Branch if higher para o próprio 11 (paraliza)
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
