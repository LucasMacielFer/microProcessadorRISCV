library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira

entity banco_regs_tb is
end entity;

architecture testbench of banco_regs_tb is
signal period_time          : time      := 100 ns;
signal finished             : std_logic := '0';
signal clk, rst, wr_en      : std_logic;
signal w_address, r_address : std_logic_vector(3 downto 0);    
signal data_in, data_out    : unsigned(15 downto 0);

begin
    uut : entity work.banco_regs
    port map(
        clk         => clk,
        rst         => rst,
        wr_en       => wr_en,      
        w_address   => w_address,
        r_address   => r_address,
        data_in     => data_in,
        data_out    => data_out
    );

    reset_global: process
    begin
        rst <= '1';
        wait for period_time*2;
        rst <= '0';
        wait;
    end process reset_global;

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
        wait for period_time;
        w_address <= "0001";
        r_address <= "0000";
        wr_en <= '0';
        data_in <= "0000000000001010";
        wait for period_time;
        w_address <= "0001";
        r_address <= "0001";
        wr_en <= '1';
        data_in <= "0000000000001010";
        wait for period_time;
        w_address <= "1001";
        r_address <= "0001";
        wr_en <= '1';
        data_in <= "0000000000000010";
        wait for period_time;
        w_address <= "0001";
        r_address <= "1010";
        wr_en <= '0';
        data_in <= "1111111111111111";
        wait;
    end process;
end architecture;
