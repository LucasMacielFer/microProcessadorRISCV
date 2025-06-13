library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- João Pedro de Andrade Argenton e Lucas Maciel Ferreira

entity banco_regs is
    port (
        clk         : in std_logic;
        rst         : in std_logic;
        wr_en       : in std_logic;
        w_address   : in std_logic_vector(3 downto 0);
        r_address_1 : in std_logic_vector(3 downto 0);
        r_address_2 : in std_logic_vector(3 downto 0);
        data_in     : in unsigned(15 downto 0);
        data_out_1  : out unsigned(15 downto 0);
        data_out_2  : out unsigned(15 downto 0)
    );
end entity;

architecture structural of banco_regs is
    signal we0, we1, we2, we3, we4, we5, we6, we7, we8, we9 : std_logic;
    signal registrador_0: unsigned(15 downto 0);
    signal registrador_1: unsigned(15 downto 0);
    signal registrador_2: unsigned(15 downto 0);
    signal registrador_3: unsigned(15 downto 0);
    signal registrador_4: unsigned(15 downto 0);
    signal registrador_5: unsigned(15 downto 0);
    signal registrador_6: unsigned(15 downto 0);
    signal registrador_7: unsigned(15 downto 0);
    signal registrador_8: unsigned(15 downto 0);
    signal registrador_9: unsigned(15 downto 0);

begin
    reg0 : entity work.reg16bit
    port map(
        clk => clk,
        rst => rst,
        wr_en => we0,
        data_in => data_in,
        data_out => registrador_0
    );

    reg1 : entity work.reg16bit
    port map(
        clk => clk,
        rst => rst,
        wr_en => we1,
        data_in => data_in,
        data_out => registrador_1
    );

    reg2 : entity work.reg16bit
    port map(
        clk => clk,
        rst => rst,
        wr_en => we2,
        data_in => data_in,
        data_out => registrador_2
    );

    reg3 : entity work.reg16bit
    port map(
        clk => clk,
        rst => rst,
        wr_en => we3,
        data_in => data_in,
        data_out => registrador_3
    );

    reg4 : entity work.reg16bit
    port map(
        clk => clk,
        rst => rst,
        wr_en => we4,
        data_in => data_in,
        data_out => registrador_4
    );

    reg5 : entity work.reg16bit
    port map(
        clk => clk,
        rst => rst,
        wr_en => we5,
        data_in => data_in,
        data_out => registrador_5
    );

    reg6 : entity work.reg16bit
    port map(
        clk => clk,
        rst => rst,
        wr_en => we6,
        data_in => data_in,
        data_out => registrador_6
    );

    reg7 : entity work.reg16bit
    port map(
        clk => clk,
        rst => rst,
        wr_en => we7,
        data_in => data_in,
        data_out => registrador_7
    );

    reg8 : entity work.reg16bit
    port map(
        clk => clk,
        rst => rst,
        wr_en => we8,
        data_in => data_in,
        data_out => registrador_8
    );

    reg9 : entity work.reg16bit
    port map(
        clk => clk,
        rst => rst,
        wr_en => we9,
        data_in => data_in,
        data_out => registrador_9
    );

    we0 <= '1' when (w_address = "0000" and wr_en = '1') else '0';
    we1 <= '1' when (w_address = "0001" and wr_en = '1') else '0';
    we2 <= '1' when (w_address = "0010" and wr_en = '1') else '0';
    we3 <= '1' when (w_address = "0011" and wr_en = '1') else '0';
    we4 <= '1' when (w_address = "0100" and wr_en = '1') else '0';
    we5 <= '1' when (w_address = "0101" and wr_en = '1') else '0';
    we6 <= '1' when (w_address = "0110" and wr_en = '1') else '0';
    we7 <= '1' when (w_address = "0111" and wr_en = '1') else '0';
    we8 <= '1' when (w_address = "1000" and wr_en = '1') else '0';
    we9 <= '1' when (w_address = "1001" and wr_en = '1') else '0';

    data_out_1 <= registrador_0 when r_address_1 = "0000" else
                registrador_1 when r_address_1 = "0001" else
                registrador_2 when r_address_1 = "0010" else
                registrador_3 when r_address_1 = "0011" else
                registrador_4 when r_address_1 = "0100" else
                registrador_5 when r_address_1 = "0101" else
                registrador_6 when r_address_1 = "0110" else
                registrador_7 when r_address_1 = "0111" else
                registrador_8 when r_address_1 = "1000" else
                registrador_9 when r_address_1 = "1001" else
                "0000000000000000";

    data_out_2 <= registrador_0 when r_address_2 = "0000" else
                registrador_1 when r_address_2 = "0001" else
                registrador_2 when r_address_2 = "0010" else
                registrador_3 when r_address_2 = "0011" else
                registrador_4 when r_address_2 = "0100" else
                registrador_5 when r_address_2 = "0101" else
                registrador_6 when r_address_2 = "0110" else
                registrador_7 when r_address_2 = "0111" else
                registrador_8 when r_address_2 = "1000" else
                registrador_9 when r_address_2 = "1001" else
                "0000000000000000";
                    
end architecture;