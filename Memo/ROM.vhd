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
    0  => "01111100011010" , -- ld r1, 31 //
    1  => "00001000101010" , -- ld r2, 2 //
    2  => "00000100111010" , -- ld r3, 1 //

    -----------------------LOOP preencher ram------------------------------
    3  => "00000100000010" , -- mv A, r2 //
    4  => "00100010000110", -- sw r2 (r2) //
    
    5  => "00000110000001" , -- add A, r3 //
    6  => "00000100000011" , -- mv r2, A //

    7  => "00010000011000" , -- cmpi A 33 
    8 =>  "11111011001101" , -- blt linha 3 (deslocamento -5)
    --------------------------------------------------------------
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
