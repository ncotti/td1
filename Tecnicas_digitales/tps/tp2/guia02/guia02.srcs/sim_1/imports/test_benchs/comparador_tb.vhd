library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity comparador_tb is
    Generic (N : integer := 4);
--  Port ( );
end comparador_tb;

architecture Behavioral of comparador_tb is
component comparador is
    Generic (N : integer := 4);
    Port ( a : in STD_LOGIC_VECTOR (N - 1 downto 0);
           b : in STD_LOGIC_VECTOR (N - 1 downto 0);
           magCa2 : in std_logic;
           aMayorQueB : out STD_LOGIC;
           aMenorQueB : out STD_LOGIC;
           aIgualB : out STD_LOGIC);
end component;

    signal a : STD_LOGIC_VECTOR (N - 1 downto 0);
    signal b : STD_LOGIC_VECTOR (N - 1 downto 0);
    signal magCa2 : std_logic;
    signal aMayorQueB : STD_LOGIC;
    signal aMenorQueB : STD_LOGIC;
    signal aIgualB : STD_LOGIC;

begin

uut: comparador PORT MAP (
      a => a,          
      b => b,
      magCa2 => magCa2,
      aMayorQueB => aMayorQueB,
      aMenorQueB => aMenorQueB,
      aIgualB => aIgualB
    );

stim_proc: process
begin
    -- Mag --
	magCa2 <= '0';	
	b <= X"0"; a <= X"0"; wait for 100 ns; -- igual
	b <= X"8"; a <= X"1"; wait for 100 ns; -- b > a
	b <= X"1"; a <= X"8"; wait for 100 ns; -- b < a    
	-- Ca2 --
	magCa2 <= '1';	
	b <= X"0"; a <= X"0"; wait for 100 ns; -- igual
	b <= X"8"; a <= X"1"; wait for 100 ns; -- b < a
	b <= X"1"; a <= X"8"; wait for 100 ns; -- b > a    
    wait;
    
end process;



end Behavioral;

