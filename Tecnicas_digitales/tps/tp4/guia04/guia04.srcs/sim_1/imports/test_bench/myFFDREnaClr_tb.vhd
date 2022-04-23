library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myFFDREnaClr_tb is
--  Port ( );
end myFFDREnaClr_tb;

architecture Behavioral of myFFDREnaClr_tb is
component myFFDREnaClr is
    Port ( clk : in std_logic;
           rst : in std_logic;
           ena : in std_logic;
           clr : in std_logic;
           d : in std_logic;
           q : out std_logic);
end component;

signal rst : std_logic;
signal ena : std_logic;
signal clr : std_logic;
signal d : std_logic;
signal q : std_logic;

    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;
begin

-- Instantiate the Unit Under Test (UUT) --
uut: myFFDREnaClr 
    Port map ( clk => clk,
               rst => rst,
               ena => ena, 
               clr => clr,
               d => d, 
               q => q);


-- Clock process --
clk_process :process
begin
    clk <= '0';     wait for clk_period/2;
    clk <= '1';     wait for clk_period/2;
end process;

-- Reset process --
resetProc :process
begin      
    rst <= '1';     wait for 50 ns;
    rst <= '0';     wait;
end process;

-- Stimulus process --
stimProc :process
begin      
    ena <= '0'; d <= '0'; clr <= '0';
    wait until falling_edge (rst); 
    clr <= '0'; ena <= '1'; d <= '0'; wait for 100 ns;
    clr <= '0'; ena <= '1'; d <= '1'; wait for 100 ns;
    clr <= '0'; ena <= '0'; d <= '0'; wait for 100 ns;
    clr <= '0'; ena <= '0'; d <= '1'; wait for 100 ns;
    clr <= '1'; ena <= '1'; d <= '0'; wait for 100 ns;
    clr <= '1'; ena <= '1'; d <= '0'; wait for 100 ns;
    wait;    
end process;


end Behavioral;
