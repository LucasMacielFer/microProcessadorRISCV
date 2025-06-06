library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity one_shot_FF is
    port(
        clk     : in std_logic;
        rst     : in std_logic;
        data_out: out std_logic
    );
end entity;

architecture behavioral of one_shot_FF is
    signal registro: std_logic := '0';
begin
    process(clk, rst)
    begin
        if rst = '1' then
            registro <= '0';
        elsif rising_edge(clk) then
            registro <= '1';
        end if;
    end process;

    data_out <= registro;
end architecture;