library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira

entity Control_Unit is
    port(
        instruction                 : in unsigned(13 downto 0);
        muxAdd, muxB                : out std_logic;
        muxA, muxR                  : out std_logic_vector(1 downto 0);
        we_R, we_A                  : out std_logic;
        operation                   : out std_logic_vector(2 downto 0);
        imm                         : out std_logic_vector(1 downto 0);
        jump, bhi, blt              : out std_logic;
        we_flags                    : out std_logic;
        we_RAM                      : out std_logic;
        r_addr_mux                  : out std_logic  
    );
end entity;

architecture behavioral of Control_Unit is
    signal opcode                   : unsigned(3 downto 0);
    signal funct3                   : unsigned(2 downto 0);

begin
    opcode <= instruction(3 downto 0);
    funct3 <= instruction(13 downto 11);

    bhi <=  '1' when opcode = "1100" else  '0';
    blt <=  '1' when opcode = "1101" else  '0';
    jump <= '1' when opcode = "1111" else  '0';

    muxA <= "00" when opcode = "0001" else
            "01" when opcode = "1001" else
            "10";
    muxB <= '1' when opcode = "1000" else '0';
    muxR <= "11" when opcode = "1010" else "10" when opcode = "0101" else "00";
    muxAdd <= '1' when opcode = "1010" else '0';
    we_A <= '1' when (opcode = "0001" or opcode = "1001" or opcode = "0010") else '0';
    we_R <= '1' when (opcode = "0011" or opcode = "1010" or opcode = "0101") else '0';
    operation <= std_logic_vector(funct3) when opcode = "0001" else 
                "010" when opcode = "1000" else "000";
    imm <= "01" when opcode = "1010" else "10" when opcode = "1111" else "11" when (opcode = "1100" or opcode = "1101") else "00";

    we_flags <= '1' when (opcode ="0001" or opcode = "1000") else '0';
    we_RAM <= '1' when opcode = "0110" else '0';
    r_addr_mux <= '1' when opcode = "0101" else '0';
end behavioral;