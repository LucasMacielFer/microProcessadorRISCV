library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processador_tb is
end entity;

architecture testbech of processador_tb is
    signal period_time                      : time      := 100 ns;
    signal finished                         : std_logic := '0';
    signal clk, rst, wr_en                  : std_logic;
    signal A_rst                            : std_logic;


begin
    uut : entity work.processador
    port map(
        clk         => clk,
        rst         => rst,
        A_rst       => A_rst
    );       

    reset_global: process
    begin
        rst <= '1';
        A_rst <= '1';
        wait for period_time*2;
        rst <= '0';
        A_rst <= '0';
        wait;
    end process;
    
    sim_time_proc: process
    begin
        wait for 110 us;
        finished <= '1';
        wait;
    end process sim_time_proc;

    clk_proc: process
    begin
        while finished /= '1' loop
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;
end architecture;
