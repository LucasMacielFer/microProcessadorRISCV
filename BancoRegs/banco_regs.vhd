library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira

entity Banco_regs is
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        wr_en   : in std_logic;
        data_in : in unsigned(15 downto 0);
        data_out: out unsigned(15 downto 0)
    );
end entity;

architecture structural of Banco_regs is
    signal registrador_0: unsigned(15 downto 0);
    signal registrador_1: unsigned(15 downto 0);
    signal registrador_2: unsigned(15 downto 0);
    signal registrador_3: unsigned(15 downto 0);
    signal registrador_4: unsigned(15 downto 0);
    signal registrador_5: unsigned(15 downto 0);
    signal registrador_6: unsigned(15 downto 0);
    signal registrador_7: unsigned(15 downto 0);
    signal registrador_8: unsigned(15 downto 0);
    signal registrador_9: unsigned(15 downto 0);

begin
    process(clk, rst, wr_en)
    begin

        reg0 : entity work.reg16bit
            port map(
                clk => clk,
                rst => rst,
                wr_en => wr_en,
                data_in => data_in,
                data_out => data_out
            );

        if rst='1' then
            registro <= "0000000000000000";
        elsif wr_en='1' then
            if rising_edge(clk) then
                registro <= data_in;
            end if;
        end if;
    end process;
    data_out <= registro;
end architecture;