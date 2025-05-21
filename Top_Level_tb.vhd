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
    signal reg_source                       : std_logic;
    signal w_address,r_address              : std_logic_vector(3 downto 0);
    signal immediate                        : unsigned(15 downto 0);
    signal zero, negative, carry, overflow  : std_logic;
    signal reg, regA                               :  unsigned(15 downto 0);
begin
    uut : entity work.Top_Level
    port map(
        A_source    => A_source,
        B_source    => B_source,
        Reg_source  => reg_source,
        clk         => clk,
        rst         => rst,
        A_rst       => A_rst,
        wr_en       => wr_en,
        A_wr_en     => A_wr_en,
        operation   => operation,
        w_address   => w_address,
        r_address   => r_address,
        immediate   => immediate,
        zero        => zero,
        negative    => negative,
        carry       => carry,
        overflow    => overflow,
        reg         => reg,
        regA        => regA
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
        wait for period_time;
            -- Subtrai 10 de 5 
            -- 5 -> reg 0001, 10 -> reg 0010

            -- Escreve 5 no reg 0001
            wr_en <= '1';
            REG_source <= '1';
            immediate <= to_unsigned(5, 16);
            w_address <= "0001";

            wait for period_time;

            -- Escreve 10 no reg 0010
            wr_en <= '1';
            immediate <= to_unsigned(10, 16);
            w_address <= "0010";

            wait for period_time;

            -- Carrega 5 no acumulador
            A_source <= "10";
            r_address <= "0001"; -- reg
            A_wr_en <= '1';

            wait for period_time;
            
            -- Subtrai 10 (reg 0010)
            r_address <= "0010";
            operation <= "001";  
            A_source <= "00";
            A_wr_en <= '1';
 


        wait;
    end process;
end architecture;