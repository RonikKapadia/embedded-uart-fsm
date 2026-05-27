-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- entity
entity sender is
    port(
        rst, clk, en, btn, ready    : in std_logic;
        send                        : out std_logic;
        char                        : out std_logic_vector (7 downto 0)
    );
end sender;

-- architecture
architecture sender of sender is
    -- intermediate signals
    type str is array (0 to 4) of std_logic_vector(7 downto 0);
    signal MESSAGE : str := (x"48", x"65", x"6C", x"6C", x"6F"); -- Hello
    signal i : std_logic_vector(2 downto 0) := (others => '0');
    type state is (idle, busyA, busyB, busyC);
    signal current_state : state := idle;
begin

    proc: process(clk)
    begin
        if rising_edge(clk) then

            -- reset machine
            if rst = '1' then 
                current_state <= idle;
                i <= (others => '0');
            end if;

            -- main sending
            if en = '1' then
                case current_state is
                    -- idle
                    when idle =>
                        if (ready = '1') and (btn = '1') then
                            if    (unsigned(i) < 5) then
                                send <= '1';
                                char <= MESSAGE(to_integer(unsigned(i)));
                                i <= std_logic_vector(unsigned(i) + 1);
                                current_state <= busyA;
                            elsif (unsigned(i) = 5) then 
                                i <= (others => '0');
                            end if;
                        end if;
                    
                    -- busyA
                    when busyA =>
                        current_state <= busyB;

                    -- busyB
                    when busyB => 
                        send <= '0';
                        current_state <= busyC;

                    -- busyC
                    when busyC =>
                        if (ready = '1') and (btn = '0') then 
                            current_state <= idle;
                        end if;

                end case;
            end if;
        end if;
    end process;

end sender;