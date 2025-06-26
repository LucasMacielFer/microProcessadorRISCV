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
    0  => "00000000011010" , -- ld r1, 0 //
    1  => "00001000101010" , -- ld r2, 2 //
    2  => "00000100111010" , -- ld r3, 1 //

    -----------------------LOOP preencher ram------------------------------
    3  => "00000100000010" , -- mv A, r2 //
    4  => "00110010000110", -- sw r3 (r2) // era r2 (r2)
    
    5  => "00000110000001" , -- add A, r3 //
    6  => "00000100000011" , -- mv r2, A //

    7  => "00001000001000" , -- cmpi A 33 
    8  => "11111011001101" , -- blt linha 3 (deslocamento -5)
    --------------------------------------------------------------
    --loop interno -> zerar multiplos de r2          
    9  => "00000100101010", -- ld r2, 1
    10 => "00000100000010", -- mv A r2
    11 => "00000110000001", -- add A r3
    12 => "00000100000011", -- mv r2 A
    13 => "00000100000001", -- add A r2
    14 => "00001000000011", -- mv r4 A
    15 => "00010100000110", -- sw r1 r4
    16 => "00001000001000", -- cmpi A 31 
    17 => "11111100001101", -- blt -4 //ok

    18 => "00000100000010", -- mv A r2
    19 => "00000010001000", -- cmpi A 16
    20 => "11110110001101", -- blt -10 // OK
    21 => "00000001101010", -- ld r6 0
    -------------------------------------
    --ler tabela e jogar numero de primos em r2
    22 => "00000100101010", -- ld r2 1
    23 => "00000100000010", -- mv A r2
    24 => "00000110000001", -- add A r3
    25 => "00000100000011", -- mv r2 A
    26 => "01010010000101", -- lw r5 r2
    27 => "00001100000010", -- mv A r6
    28 => "00001010000001", -- add A r5
    29 => "00001100000011", -- mv r6 A
    30 => "00000010101000", -- cmpi A 10
    31 => "11111000001101", -- blt -8
    32 => "00000100000010",

    -- lopp para iterar entre 2 e 32
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
