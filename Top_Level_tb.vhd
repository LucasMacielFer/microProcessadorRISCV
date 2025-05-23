library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

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
    signal w_address, r_address             : std_logic_vector(3 downto 0);
    signal immediate                        : unsigned(15 downto 0);
    signal zero, negative, carry, overflow  : std_logic;
    signal reg, regA                        : unsigned(15 downto 0);
    -- os vetores e unsigned nao apareciam no gtkwave, encontramos essa solução online
    -- o problema nao foi resolvido após adicionar essa passagem, porém ficamos com medo de tirar e qubrar 
    -- a simulação no futuro 
    attribute keep : boolean;
    attribute keep of A_source   : signal is true;
    attribute keep of operation  : signal is true;
    attribute keep of w_address  : signal is true;
    attribute keep of r_address  : signal is true;
    attribute keep of immediate  : signal is true;
    attribute keep of reg        : signal is true;
    attribute keep of regA       : signal is true;

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
        -- Escreve valor 10 no registrador 1
        A_source   <= "01";
        B_source   <= '0';  
        REG_source <= '1';  
        wr_en      <= '1';
        A_wr_en    <= '1';
        operation  <= "001"; -- sum
        w_address  <= "0001";
        r_address  <= "0001";
        immediate  <= to_unsigned(10, 16);
        wait for period_time;

        wr_en      <= '0';
        A_wr_en    <= '0';
        wait for period_time;

        -- Escreve valor 20 no registrador 4
        REG_source <= '1';
        wr_en      <= '1';
        A_wr_en    <= '0';
        w_address  <= "0100";
        immediate  <= to_unsigned(21, 16);
        wait for period_time;

        wr_en      <= '0';
        wait for period_time;

        -- Carrega valor do registrador 4 no acumulador
        A_source   <= "10"; 
        r_address  <= "0100";
        A_wr_en    <= '1';
        wait for period_time;

        A_wr_en    <= '0';
        wait for period_time;

        -- Subtrai registrador 1 do acumulador
        A_source   <= "00"; 
        B_source   <= '0';  
        r_address  <= "0001";
        operation  <= "010"; -- sub
        A_wr_en    <= '1';
        wait for period_time;

        A_wr_en    <= '0';
        wait for period_time;

        -- Guarda acumulador no registrador 3
        REG_source <= '0'; 
        wr_en      <= '1';
        w_address  <= "0011";
        wait for period_time;

        wr_en      <= '0';
        wait;

    end process;
end architecture;
