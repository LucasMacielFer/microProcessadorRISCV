library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira

entity soma1_tb is
end entity;

architecture testbech of soma1_tb is
    signal period_time  : time      := 100 ns;
    signal finished     : std_logic := '0';
    signal data_in      : unsigned(6 downto 0);
    signal data_out     : unsigned(6 downto 0);
begin
    uut : entity work.soma1
    port map
    (
        data_in => data_in,
        data_out => data_out
    );
    
    sim_time_proc: process
    begin
        wait for 10 us;
        finished <= '1';
        wait;
    end process sim_time_proc;

    process
    begin
        wait for 100 ns;
        data_in <= "0000000";  -- Teste com entrada 0
        wait for 100 ns;
        data_in <= "0000001";  -- Teste com entrada 1
        wait for 100 ns;
        data_in <= "0000010";  -- Teste com entrada 2
        wait for 100 ns;
        data_in <= "0000011";  -- Teste com entrada 3
        wait;
    end process;
end architecture;