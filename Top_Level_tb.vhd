library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira

entity Top_Level_tb is
end entity;

architecture testbech of Top_Level_tb is
    signal period_time                      : time      := 100 ns;
    signal finished                         : std_logic := '0';
    signal clk, rst, wr_en                  : std_logic;
    signal B_source, A_rst, A_wr_en         : std_logic;                
    signal A_source                         : std_logic_vector(1 downto 0);
    signal operation                        : std_logic_vector(2 downto 0);
    signal w_address,r_address              : std_logic_vector(3 downto 0);
    signal immediate                        : unsigned(15 downto 0);
    signal zero, negative, carry, overflow  : std_logic;

begin
    uut : entity work.Top_Level
    port map(
        A_source    : in std_logic_vector(1 downto 0);
        B_source    : in std_logic;
        clk         : in std_logic;
        rst         : in std_logic;
        A_rst       : in std_logic;
        wr_en       : in std_logic;
        A_wr_en     : in std_logic;
        operation   : in std_logic_vector(2 downto 0);
        w_address   : in std_logic_vector(3 downto 0);
        r_address   : in std_logic_vector(3 downto 0);
        immediate   : in unsigned(15 downto 0);
        zero        : out std_logic;
        negative    : out std_logic;
        carry       : out std_logic;
        overflow    : out std_logic
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
        -- Escrever os testes aqui. Explorar todas as possiblidades.
        wait;
    end process;
end architecture;