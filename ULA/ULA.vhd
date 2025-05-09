library ieee;
use ieee.std_logic.all;
use ieee.numeric_std.all;

entity ULA is 
port (
    input_A : in unsigned(15 downto 0);
    input_B : in unsigned(15 downto 0);
    output_S : out unsigned(15 downto 0);

    operation: std_logic_vector(2 downto 0);

    output_Zero: out std_logic;
    output_Carry: out std_logic;
    output_Overflow: out std_logic;
    output_Negative: out std_logic
    );
    end entity;

    architecture arch of ent is
    
        signal A, B, C: std_logic;
        signal result: unsigned(15 downto 0);
    
    begin
        d0 <= operation(0);
        d1 <= operation(1);
        d2 <= operation(2);

        result <= (input_A + input_B) when (not(A) and not(B) and not(C)) else
                    (input_A - input_B) when (not(A) and not(B) and (C)) else
                    (input_A or input_B) when (not(A) and (B) and not(C)) else
                    (input_A and input_B) when (not(A) and (B) and (C)) else
                    '0000000000000000';

                

    
    --ADD
    --SUB
    --AND
    --OR
    --XOR
    end arch ; -- arch