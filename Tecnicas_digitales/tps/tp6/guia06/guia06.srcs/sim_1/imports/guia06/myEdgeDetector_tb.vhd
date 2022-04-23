library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myEdgeDetector_tb is
--  Port ( );
end myEdgeDetector_tb;

architecture Behavioral of myEdgeDetector_tb is
component myEdgeDetector is
    Port ( clk : in std_logic;
           rst : in std_logic;
           d : in std_logic;
           ascendente : out std_logic;
           descendente : out std_logic);
end component;

signal rst : std_logic;
signal d : std_logic;
signal ascendente : std_logic;
signal descendente : std_logic;
           
    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;
begin

-- Instantiate the Unit Under Test (UUT) --
uut: myEdgeDetector
    Port map ( clk => clk,
               rst => rst,
               d => d,
               ascendente => ascendente,
               descendente => descendente);


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
    d <= '0';
    wait until falling_edge (rst); 
    d <= '0';     wait for 100 ns;
    d <= '1';     wait for 100 ns;
    d <= '0';     wait for 100 ns;
    d <= '1';     wait for 100 ns;
    wait;
end process;


end Behavioral;
