library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira

entity TFF_tb is
end entity;

architecture testbech of TFF_tb is
    signal period_time  : time      := 100 ns;
    signal finished     : std_logic := '0';
    signal clk, rst     : std_logic;
    signal data_out     : std_logic;
begin
    uut : entity work.TFF
    port map
    (
        clk => clk,
        rst => rst,
        data_out => data_out
    );

    reset_global: process
    begin
        rst <= '1';
        wait for period_time*2;
        rst <= '0';
        wait;
    end process;
    
    sim_time_proc: process
    begin
        wait for 10 us;
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