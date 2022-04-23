library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myFFDREN_tb is
Generic (N: integer := 4);
end myFFDREN_tb;

architecture Behavioral of myFFDREN_tb is
component myFFDREN is
    Generic (N: integer := 4);
    Port ( clk : in std_logic;
           rst : in std_logic;
           ena : in std_logic;
           d : in std_logic_vector (N-1 downto 0);
           q : out std_logic_vector (N-1 downto 0));
end component;

signal rst : std_logic;
signal ena : std_logic;
signal d : std_logic_vector (N-1 downto 0);
signal q : std_logic_vector (N-1 downto 0);

    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;
begin

-- Instantiate the Unit Under Test (UUT) --
uut: myFFDREN 
    Generic map (N => N)
    Port map( clk => clk,
              rst => rst,
              ena => ena,
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
    ena <= '0'; d <= (others => '0');
    wait until falling_edge (rst); 
    ena <= '1'; d <= (others => '0'); wait for 100 ns;
    ena <= '1'; d <= (others => '1'); wait for 100 ns;
    ena <= '0'; d <= (others => '0'); wait for 100 ns;
    ena <= '0'; d <= (others => '1'); wait for 100 ns;
    wait;    
    
end process;


end Behavioral;
