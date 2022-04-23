library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myCnt_tb is
Generic (M : integer := 100);
end myCnt_tb;

architecture Behavioral of myCnt_tb is
component myCnt is
    Generic (M : integer := 100);
    Port ( clk       : in std_logic;
           rst       : in std_logic;
           ena       : in std_logic;
           salidaM_2 : out std_logic;
           salidaM   : out std_logic);
end component;

signal rst       : std_logic;
signal ena       : std_logic;
signal salidaM_2 : std_logic;
signal salidaM   : std_logic;

    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;
begin

-- Instantiate the Unit Under Test (UUT) --
uut: myCnt
    Generic map (M => M)
    Port map ( clk => clk,
               rst => rst,
               ena => ena,
               salidaM_2 => salidaM_2,
               salidaM  => salidaM);

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
    ena <= '0';
    wait until falling_edge (rst); 
    ena <= '1';
    wait;    
end process;


end Behavioral;
