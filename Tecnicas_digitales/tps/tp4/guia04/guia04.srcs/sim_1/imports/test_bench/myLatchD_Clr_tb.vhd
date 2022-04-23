library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myLatchD_Clr_tb is
--  Port ( );
end myLatchD_Clr_tb;

architecture Behavioral of myLatchD_Clr_tb is
component myLatchD_Clr is
    Port ( ena : in std_logic;
           clr : in std_logic;
           d : in std_logic;
           q : out std_logic);
end component;

signal ena : std_logic;
signal clr : std_logic;
signal d : std_logic;
signal q : std_logic;

begin

-- Instantiate the Unit Under Test (UUT) --
uut: myLatchD_Clr
    Port map ( ena => ena,
               clr => clr,
                d => d,
                q => q);


-- Stimulus process --
stimProc :process
begin
    ena <= '0';     d <= '0';      
    clr <= '0';     wait for 100 ns;
    clr <= '1';
    ena <= '0';     d <= '0';   wait for 100 ns; 
    ena <= '0';     d <= '1';   wait for 100 ns;
    ena <= '1';     d <= '0';   wait for 100 ns;
    ena <= '1';     d <= '1';   wait for 100 ns;
    wait;    
end process;

end Behavioral;
