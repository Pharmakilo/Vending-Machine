library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VComponents.all;

entity vending_machine is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           coin_25 : in  STD_LOGIC;
           coin_75 : in  STD_LOGIC;
           cd : out  STD_LOGIC;
           wd : out  STD_LOGIC;
           bd : out  STD_LOGIC);
end vending_machine;

architecture Behavioral of vending_machine is
    type state_type is (s0, s25, s50, s75, s100);
    signal state : state_type;
begin
    process (clk, reset)
    begin
        if (reset = '1') then
            state <= s0;
        elsif (clk'event and clk = '1') then
            case state is
                when s0 =>
                    if (coin_25 = '1') then
                        state <= s25;
                        wd <= '1';
                    elsif (coin_75 = '1') then
                        state <= s75;
                        bd <= '1';
                    end if;
                when s25 =>
                    if (coin_25 = '1') then
                        state <= s50;
                    elsif (coin_75 = '1') then
                        state <= s75;
                        cd <= '1';
                        bd <= '1';
                    end if;
                when s50 =>
                    if (coin_25 = '1') then
                        state <= s75;
                        cd <= '1';
                        wd <= '1';
                    elsif (coin_75 = '1') then
                        state <= s100;
                    end if;
                when s75 =>
                    if (coin_75 = '1') then
                        state <= s100;
                    end if;
                when s100 =>
                    null;
            end case;
        end if;
    end process;
end Behavioral;
