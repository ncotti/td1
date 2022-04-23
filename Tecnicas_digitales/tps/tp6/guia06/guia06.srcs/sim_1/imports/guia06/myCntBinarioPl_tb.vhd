library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myCntBinarioPl_tb is
Generic (N: integer := 4);
end myCntBinarioPl_tb;

architecture Behavioral of myCntBinarioPl_tb is
component myCntBinarioPl is
    Generic (N: integer := 4);
    Port ( clk : in std_logic;
           rst : in std_logic;
           ena : in std_logic;
           dl  : in std_logic;
           d   : in std_logic_vector (N - 1 downto 0);
           q   : out std_logic_vector (N - 1 downto 0));
end component;


signal rst : std_logic;
signal ena : std_logic;
signal dl  : std_logic;
signal d   : std_logic_vector (N - 1 downto 0);
signal q   : std_logic_vector (N - 1 downto 0);
           
    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;
begin

-- Instantiate the Unit Under Test (UUT) --
uut: myCntBinarioPl
    Generic map (N => N)
    Port map ( clk => clk,
           rst => rst,
           ena => ena,
           dl  => dl,
           d   => d,
           q   => q);


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
    ena <= '0'; d <= (others => '0'); dl <= '0'; 
    wait until falling_edge (rst); 
    ena <= '0'; wait for 100 ns;
    wait until falling_edge (clk);
    ena <= '1'; wait for 100 ns;   
    wait until falling_edge (clk);
    ena <= '1'; d <= (others => '0'); dl <= '1';  wait until falling_edge (clk);
    dl <= '0'; 
    wait;
end process;

end Behavioral;
