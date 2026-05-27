-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- entity
entity top_tb is
end top_tb;

architecture top_tb of top_tb is 
    -- components
    component top
        port(
            TXD, clk        : in std_logic;
            btn             : in std_logic_vector(1 downto 0);
            RXD, CTS, RTS   : out std_logic
        );
    end component;

    -- intermedite signals
    signal tb_TXD, tb_clk : std_logic;
    signal tb_btn : std_logic_vector(1 downto 0);
    signal tb_RXD, tb_CTS, tb_RTS : std_logic;

begin

    u1 : top
    port map(
        TXD => tb_TXD,
        clk => tb_clk,
        btn => tb_btn,
        RXD => tb_RXD, 
        CTS => tb_CTS,
        RTS => tb_RTS
    );

    process begin
        tb_clk <= '0';
        wait for 4 ns;
        tb_clk <= '1';
        wait for 4 ns;
    end process;

    process begin
        -- reset
        tb_TXD <= '0';
        tb_btn(0) <= '1';
        tb_btn(1) <= '0';
        wait for 50000 ns;

        -- nothing
        tb_btn(0) <= '0';
        tb_btn(1) <= '0';
        wait for 50000 ns;

        -- click button
        tb_btn(1) <= '1';
        wait for 50000 ns;
        tb_btn(1) <= '0';
        wait for 250000 ns;

        -- click button
        tb_btn(1) <= '1';
        wait for 50000 ns;
        tb_btn(1) <= '0';
        wait for 250000 ns;

        -- click button
        tb_btn(1) <= '1';
        wait for 50000 ns;
        tb_btn(1) <= '0';
        wait for 250000 ns;

        -- reset
        tb_TXD <= '0';
        tb_btn(0) <= '1';
        tb_btn(1) <= '0';
        wait for 50000 ns;

        -- nothing
        tb_btn(0) <= '0';
        tb_btn(1) <= '0';
        wait for 50000 ns;

        -- click button
        tb_btn(1) <= '1';
        wait for 50000 ns;
        tb_btn(1) <= '0';
        wait for 250000 ns;

        -- nothing
        tb_TXD <= '0';
        tb_btn(0) <= '0';
        tb_btn(1) <= '0';
        wait for 50000 ns;

        report "End of testbench" severity FAILURE;

    end process;

end top_tb;
