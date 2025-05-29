library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira
-- Operações escolhidas: adição, subtração, decremento, 'ou' lógico, 'e' lógico e 'ou' exclusivo

entity ULA is 
port (
    input_A : in unsigned(15 downto 0);
    input_B : in unsigned(15 downto 0);
    result  : out unsigned(15 downto 0);

    operation   : in std_logic_vector(2 downto 0);

    zero    : out std_logic;
    negative: out std_logic;
    carry   : out std_logic;
    overflow: out std_logic
    );
end entity;

architecture behavioral of ULA is
    signal calc     : unsigned(16 downto 0);
    signal op1, op2 : unsigned(16 downto 0);


begin
    calc <= (op1 + op2) when operation = "000" else                 -- Adicao
            (op1 - "00000000000000001") when operation = "001" else  -- Decremento
            (op1 - op2) when operation = "010" else             -- Subtracao
            (op1 or op2) when operation = "100" else            -- Ou lógico
            (op1 and op2) when operation = "101" else           -- E lógico
            (op1 xor op2) when operation = "110" else           -- Ou exclusivo
            "00000000000000000";

    op1 <= input_A(15) & input_A;
    op2 <= input_A(15) & input_B;
    result <= calc(15 downto 0);
    zero <= '1' when (calc = "000000000000000000") else '0';
    negative <= calc(15);
    carry <= calc(16);
    overflow <=  (input_A(15) and input_B(15) and not calc(15)) or (not input_A(15) and not input_B(15) and calc(15));
    
end behavioral;