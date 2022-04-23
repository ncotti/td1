library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity lfsr_G_tb is
    Generic (N : integer := 4);
end lfsr_G_tb;

architecture Behavioral of lfsr_G_tb is

component lfsr_G is
    Generic (N : integer := 8);
    Port ( clk     : in  std_logic;
           rst     : in  std_logic;
           inits    : in  std_logic_vector(N - 1 downto 0);
           taps    : in  std_logic_vector(N - 1 downto 0);
           salida  : out  std_logic_vector(N - 1 downto 0));
end component;

    signal salida  : std_logic_vector(N - 1 downto 0);

    -- Clk --
    signal rst : std_logic := '0';
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;
    
begin

uut: lfsr_G
    Generic map (N => N)
    Port map (clk => clk,
              rst => rst,
              inits => "1111",
              taps => "0010",
              salida => salida);

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
    wait until falling_edge (rst);
    wait;     
       
end process;

end Behavioral;
