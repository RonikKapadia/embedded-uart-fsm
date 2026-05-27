-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- entity
entity top is
    port(
        TXD, clk        : in std_logic;
        btn             : in std_logic_vector(1 downto 0);
        RXD, CTS, RTS   : out std_logic
    );
end top;

architecture top of top is 
    -- components
    component debounce 
        port(
            btn : in std_logic;
            clk : in std_logic;
            dbnc : out std_logic
        );
    end component;

    component clock_div
        port(
            clk : in std_logic;
            div : out std_logic
        );
    end component;

    component sender
        port(
            rst, clk, en, btn, ready    : in std_logic;
            send                        : out std_logic;
            char                        : out std_logic_vector (7 downto 0)
        );
    end component;

    component uart
        port (
            clk, en, send, rx, rst      : in std_logic;
            charSend                    : in std_logic_vector (7 downto 0);
            ready, tx, newChar          : out std_logic;
            charRec                     : out std_logic_vector (7 downto 0)
        );
    end component;

    -- intermediate signals
    signal div : std_logic;
    signal ready : std_logic;
    signal send : std_logic;
    signal btn0 : std_logic;
    signal btn1 : std_logic;
    signal char : std_logic_vector (7 downto 0);

begin

    db0 : debounce
    port map(
        btn => btn(0),
        clk => clk,
        dbnc => btn0
    );

    db1 : debounce
    port map(
        btn => btn(1),
        clk => clk,
        dbnc => btn1
    );

    cd : clock_div
    port map(
        clk => clk,
        div => div
    );

    sen : sender
    port map(
        btn => btn1,
        clk => clk,
        en => div,
        ready => ready,
        rst => btn0,
        char => char,
        send => send
    );

    urt : uart 
    port map(
        clk => clk,
        en => div,
        send => send,
        rx => TXD,
        rst => btn0,
        charSend => char,
        ready => ready,
        tx => RXD
    );

end top;