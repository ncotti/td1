library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity myEdgeCnt_tb is
    Generic (N: integer := 4);
--  Port ( );
end myEdgeCnt_tb;

architecture Behavioral of myEdgeCnt_tb is

component myEdgeCnt is
    Generic (N: integer := 4);
    Port ( clk: in std_logic;
           rst: in std_logic;
           d: in std_logic;
           q : out std_logic_vector (N-1 downto 0));
end component;

signal rst : std_logic;
signal d : std_logic;
signal q : std_logic_vector (N-1 downto 0);

    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;

begin

uut: myEdgeCnt 
    Generic map (N => N)
    Port map ( clk => clk,
               rst => rst,
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
    d <= '0';
    wait until falling_edge (rst); 
    wait for 50 ns;
    d <= '1';   wait for 200 ns;
    d <= '0';   wait for 50 ns;
    d <= '1';   wait for 200 ns;
    d <= '0';   wait for 50 ns;
    d <= '1';   wait for 100 ns;
    d <= '0';   wait for 50 ns;
    wait;    
end process;

end Behavioral;
