library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myShiftReg_tb is
Generic (N: integer := 4);
--  Port ( );
end myShiftReg_tb;

architecture Behavioral of myShiftReg_tb is
component myShiftReg is
    Generic (N: integer := 4);
    Port ( clk : in std_logic;
           rst : in std_logic;
           ena : in std_logic;
           si  : in std_logic;
           so  : out std_logic;
           po  : out std_logic_vector (N - 1 downto 0);
           pi  : in std_logic_vector (N - 1 downto 0);
           pl  : in std_logic);
end component;

signal rst : std_logic;
signal ena : std_logic;
signal si  : std_logic;
signal so  : std_logic;
signal po  : std_logic_vector (N - 1 downto 0);
signal pi  : std_logic_vector (N - 1 downto 0);
signal pl  : std_logic;


    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;
begin

-- Instantiate the Unit Under Test (UUT) --
uut: myShiftReg 
    Generic map (N => N)
    Port map( clk => clk,
              rst => rst,
              ena => ena,
              si => si,
              so => so,
              po => po,
              pi => pi,
              pl => pl);

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
    si <= '0'; ena <= '0'; pi <= (others => '0'); pl <= '0'; 
    wait until falling_edge (rst); 
    ena <= '0'; si <= '1';  wait for 100 ns;
    wait until rising_edge (clk);
    ena <= '1'; si <= '1';  wait for 100 ns;
    ena <= '1'; si <= '0';  wait for 100 ns;
    wait until rising_edge (clk);
    pl <= '1'; pi <= (others => '1');  wait until rising_edge (clk);
    pl <= '0'; 
    wait;
end process;


end Behavioral;
