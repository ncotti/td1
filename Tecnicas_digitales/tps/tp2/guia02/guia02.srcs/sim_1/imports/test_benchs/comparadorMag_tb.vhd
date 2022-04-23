library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity comparadorMag_tb is
    Generic (N : integer := 4);
--  Port ( );
end comparadorMag_tb;

architecture Behavioral of comparadorMag_tb is
component comparadorMag is
    Generic (N : integer := 4);
    Port ( a : in STD_LOGIC_VECTOR (N - 1 downto 0);
           b : in STD_LOGIC_VECTOR (N - 1 downto 0);
           aMayorQueB : out STD_LOGIC;
           aMenorQueB : out STD_LOGIC;
           aIgualB : out STD_LOGIC);
end component;

    signal a : STD_LOGIC_VECTOR (N - 1 downto 0);
    signal b : STD_LOGIC_VECTOR (N - 1 downto 0);
    signal aMayorQueB : STD_LOGIC;
    signal aMenorQueB : STD_LOGIC;
    signal aIgualB : STD_LOGIC;

begin

uut: comparadorMag PORT MAP (
      a => a,          
      b => b,
      aMayorQueB => aMayorQueB,
      aMenorQueB => aMenorQueB,
      aIgualB => aIgualB
    );

stim_proc: process
begin
		
	b <= X"0"; a <= X"0"; wait for 100 ns; -- igual
	b <= X"8"; a <= X"1"; wait for 100 ns; -- b > a
	b <= X"1"; a <= X"8"; wait for 100 ns; -- b < a    
    wait;
    
end process;



end Behavioral;
