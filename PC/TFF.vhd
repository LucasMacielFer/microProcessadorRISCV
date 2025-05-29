library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira


entity TFF is
    port (
        clk     : in std_logic;
        rst     : in std_logic;
        data_out: out std_logic
    );
end entity;

architecture behavioral of TFF is
    signal toggle: std_logic := '0';
begin
    process(clk)
    begin
        if rst = '1' then
            toggle <= '0';
        elsif rising_edge(clk) then
            toggle <= not toggle;
        end if;
    end process;
    data_out <= toggle;
end architecture;