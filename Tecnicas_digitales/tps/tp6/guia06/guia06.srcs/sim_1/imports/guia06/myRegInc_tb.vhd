library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity myRegInc_tb is
    Generic (N : integer := 8);
end myRegInc_tb;

architecture Behavioral of myRegInc_tb is

component myRegInc is
    Generic (N : integer := 8);
    Port ( clk       : in  std_logic;
           rst       : in  std_logic;
           dataUp    : in  std_logic;
           dataDown  : in  std_logic;
           regOut    : out std_logic_vector(N - 1 downto 0));
end component;

signal rst : std_logic;
signal dataUp : std_logic;
signal dataDown : std_logic;
signal regOut : std_logic_vector (N - 1 downto 0);

    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;
begin

uut: myRegInc
    Generic map (N => N)
    Port map (clk => clk,
              rst => rst,
              dataUp => dataUp,
              dataDown => dataDown,
              regOut => regOut);

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

-- Ena process --
enaProc :process
begin  
    dataUp <= '0';
    dataDown <= '0';
    wait until falling_edge (rst);
    wait for 50 ns;     
    dataUp <= '1';  dataDown <= '0';   wait for 50 ns;
    dataUp <= '0';  dataDown <= '1';   wait for 50 ns;
    dataUp <= '1';  dataDown <= '1';   wait for 50 ns;
    dataUp <= '0';  dataDown <= '0';   wait;   
end process;


end Behavioral;
