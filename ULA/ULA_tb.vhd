library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira

entity ULA_tb is
end;

architecture testBench of ULA_tb is
    signal input_A, input_B, result: unsigned(15 downto 0);
    signal operation: std_logic_vector(2 downto 0);
    signal zero, negative, carry, overflow: std_logic;
begin
    uut: entity work.ULA
        port map (
            input_A => input_A,
            input_B => input_B,
            result => result,
            operation => operation,
            zero => zero,
            negative => negative,
            carry => carry,
            overflow => overflow
        );

    process
    begin
        -- Teste de adição
        input_A <= "0000000000000001";
        input_B <= "0000000000000001";
        operation <= "000"; -- Adição
        wait for 10 ns;
        -- Teste de decremento
        input_A <= "1111111111111111"; -- Lixo
        input_B <= "0000000000000010";
        operation <= "001"; -- Decremento
        wait for 10 ns;
        -- Teste de subtração
        input_A <= "0000000000000010";
        input_B <= "0000000000000001";
        operation <= "010"; -- Subtração
        wait for 10 ns;
        -- Teste de 'ou' lógico
        input_A <= "0000000000000010";
        input_B <= "0000000000000101";
        operation <= "100"; -- 'Ou' lógico
        wait for 10 ns;
        -- Teste de 'e' lógico
        input_A <= "0000000000000001";  
        input_B <= "0000000001000011";
        operation <= "101"; -- 'E' lógico
        wait for 10 ns;
        -- Teste de 'ou' exclusivo
        input_A <= "0000000000000110";
        input_B <= "0000000000000101";
        operation <= "110"; -- 'Ou' exclusivo
        wait for 10 ns;
        -- Teste de overflow
        input_A <= "0111111111111111";
        input_B <= "0000000000000001";
        operation <= "000"; -- Adição
        wait for 10 ns;
        -- Teste de carry
        input_A <= "1111111111111111";
        input_B <= "0000000000000001";
        operation <= "000"; -- Adição
        wait for 10 ns;
        -- Teste de zero
        input_A <= "0000000000000000"; -- 0
        input_B <= "0000000000000000"; -- 0
        operation <= "000"; -- Adição
        wait for 10 ns;
        -- Teste de negativo
        input_A <= "1111111111111100"; -- -1
        input_B <= "0000000000000001"; -- 0
        operation <= "000"; -- Adição
        wait for 10 ns;
        wait;
    end process;
end architecture;