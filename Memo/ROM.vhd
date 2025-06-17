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
    -- --- INICIALIZAÇÃO ---
    0  => "00000010101001",  -- ld A, 10
    1  => "00000010000011",  -- mv r1, A
    2  => "00000000011001",  -- ld A, 1
    3  => "00001000000011",  -- mv r4, A
    4  => "11111111111001",  -- ld A, -1
    5  => "00001010000011",  -- mv r5, A
    6  => "00000000001010",  -- ld r0, 0
    -- --- FASE 1: ESCREVER ENDEREÇO COMO DADO ---
    7  => "00000000000010",  -- write_loop_1: mv A, r0
    8  => "00000100000011",  -- mv r2, A
    9  => "00100000000110",  -- sw r2 (r0)
    10 => "00001000000001",  -- add A, r4
    11 => "00000000000011",  -- mv r0, A
    12 => "01000010000001",  -- sub A, r1
    13 => "11111010001101",  -- blt write_loop_1 (Delta = 7 - 13 = -6)
    -- --- FASE 1: VERIFICAR ENDEREÇO COMO DADO ---
    14 => "00000000001010",  -- ld r0, 0
    15 => "00110000000101",  -- verify_loop_1: lw r3 (r0)
    16 => "00000000000010",  -- mv A, r0
    17 => "01000110000001",  -- sub A, r3
    18 => "00000000001000",  -- cmpi A, 0
    19 => "00100001001101",  -- blt error (Delta = 52 - 19 = +33)
    20 => "00000000011000",  -- cmpi A, 1
    21 => "00011111001100",  -- bhi error (Delta = 52 - 21 = +31)
    22 => "00000000000010",  -- mv A, r0
    23 => "00001000000001",  -- add A, r4
    24 => "00000000000011",  -- mv r0, A
    25 => "01000010000001",  -- sub A, r1
    26 => "11110101001101",  -- blt verify_loop_1 (Delta = 15 - 26 = -11)
    -- --- FASE 2: ESCREVER NOT(ENDEREÇO) ---
    27 => "00000000001010",  -- ld r0, 0
    28 => "00000000000010",  -- write_loop_2: mv A, r0
    29 => "10101010000001",  -- xor A, r5
    30 => "00000100000011",  -- mv r2, A
    31 => "00100000000110",  -- sw r2 (r0)
    32 => "00000000000010",  -- mv A, r0
    33 => "00001000000001",  -- add A, r4
    34 => "00000000000011",  -- mv r0, A
    35 => "01000010000001",  -- sub A, r1
    36 => "11111000001101",  -- blt write_loop_2 (Delta = 28 - 36 = -8)
    -- --- FASE 2: VERIFICAR NOT(ENDEREÇO) ---
    37 => "00000000001010",  -- ld r0, 0
    38 => "00110000000101",  -- verify_loop_2: lw r3 (r0)
    39 => "00000000000010",  -- mv A, r0
    40 => "10101010000001",  -- xor A, r5
    41 => "01000110000001",  -- sub A, r3
    42 => "00000000001000",  -- cmpi A, 0
    43 => "00001001001101",  -- blt error (Delta = 52 - 43 = +9)
    44 => "00000000011000",  -- cmpi A, 1
    45 => "00000111001100",  -- bhi error (Delta = 52 - 45 = +7)
    46 => "00000000000010",  -- mv A, r0
    47 => "00001000000001",  -- add A, r4
    48 => "00000000000011",  -- mv r0, A
    49 => "01000010000001",  -- sub A, r1
    50 => "11110100001101",  -- blt verify_loop_2 (Delta = 38 - 50 = -12)
    -- --- FIM DO PROGRAMA ---
    51 => "01100110001111",  -- success: jump success (pula para 51)
    52 => "01101000001111",  -- error:   jump error (pula para 52)
    -- O resto da memória é inicializado com zeros
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
