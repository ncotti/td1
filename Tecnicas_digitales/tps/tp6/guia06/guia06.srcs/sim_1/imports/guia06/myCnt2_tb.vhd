library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myCnt2_tb is
Generic (N : integer := 4);
end myCnt2_tb;

architecture Behavioral of myCnt2_tb is
component myCnt2 is
    Generic (N : integer := 4);
    Port ( clk : in std_logic;
           rst : in std_logic;
           ena : in std_logic;
           p   : in std_logic_vector (N - 1 downto 0);
           salida : out std_logic);
end component;


signal rst : std_logic;
signal ena : std_logic;
signal p   : std_logic_vector (N - 1 downto 0);
signal salida : std_logic;

    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;
begin

-- Instantiate the Unit Under Test (UUT) --
uut: myCnt2 
    Generic map (N => N)
    Port map ( clk => clk,
               rst => rst,
               ena => ena,
               p => p,
               salida =>salida);

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
    rst <= '0';     wait for 500ns;
    rst <= '1';     wait for 50ns;
    rst <= '0';     wait;
end process;

-- Stimulus process --
stimProc :process
begin      
    ena <= '0'; p <= "0111";
    wait until falling_edge (rst); 
    ena <= '1'; 
    wait;
end process;

end Behavioral;
