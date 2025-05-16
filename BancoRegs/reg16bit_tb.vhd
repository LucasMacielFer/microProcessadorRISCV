library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira

entity reg16bit_tb is
end entity;

architecture testbech of reg16bit_tb is
    signal period_time          : time      := 100 ns;
    signal finished             : std_logic := '0';
    signal clk, rst, wr_en      : std_logic;
    signal data_in, data_out    : unsigned(15 downto 0);
begin
    uut : entity work.reg16bit
    port map
    (
        clk => clk,
        rst => rst,
        wr_en => wr_en,
        data_in => data_in,
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

    process
    begin
        wait for 200 ns;
        wr_en <= '1';
        data_in <= "1111111111111111";
        wait for 100 ns;
        data_in <= "0000000000000001";
        wr_en <= '0';
        wait for 300 ns;
        data_in <= "1111111111111111";
        wr_en <= '0';
        wait;
    end process;
end architecture;