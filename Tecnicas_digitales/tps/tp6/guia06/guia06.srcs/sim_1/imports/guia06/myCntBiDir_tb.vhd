library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myCntBiDir_tb is
Generic (N: integer := 4);
end myCntBiDir_tb;

architecture Behavioral of myCntBiDir_tb is
component myCntBiDir is
    Generic (N: integer := 4);
    Port ( clk: in std_logic;
           rst: in std_logic;
           ena: in std_logic;
           dir: in std_logic;
           q : out std_logic_vector (N-1 downto 0));
end component;

signal rst: std_logic;
signal ena: std_logic;
signal dir: std_logic;
signal q : std_logic_vector (N-1 downto 0);
           
    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;
begin

-- Instantiate the Unit Under Test (UUT) --
uut:myCntBiDir 
    Generic map (N => N)
    Port map ( clk => clk,
               rst => rst,
               ena => ena,
               dir => dir,
               q  => q);

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
    ena <= '0'; dir <= '0';
    wait until falling_edge (rst); 
    ena <= '1'; 
    wait for 200 ns;
    dir <= '1';
    wait;
    
end process;


end Behavioral;
