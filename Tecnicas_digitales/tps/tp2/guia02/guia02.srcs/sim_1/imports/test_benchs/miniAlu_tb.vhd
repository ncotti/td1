library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity miniAlu_tb is
Generic (N: integer := 4);
end miniAlu_tb;

architecture Behavioral of miniAlu_tb is
component miniAlu is
Generic (N: integer := 4);
Port ( a : in std_logic_vector (N-1 downto 0);
       b : in std_logic_vector (N-1 downto 0);
       op : in std_logic_vector (1 downto 0);
       zero : out std_logic;
       ov : out std_logic;
       resultado: out std_logic_vector (N-1 downto 0));
end component;

    signal a :std_logic_vector (N-1 downto 0);
    signal b : std_logic_vector (N-1 downto 0);
    signal op : std_logic_vector (1 downto 0);
    signal zero : std_logic;
    signal ov : std_logic;
    signal resultado: std_logic_vector (N-1 downto 0);
begin

uut: miniAlu 
    Generic map (N => N)
    PORT MAP (
      a => a,          
      b => b,
      op => op,
      zero => zero,
      ov => ov,
      resultado => resultado
    );

stim_proc: process
begin
	
	-- SUMA --
	op <= "00"; b <= X"1"; a <= X"1";  wait for 100 ns; -- 1 + 1
	op <= "00"; b <= X"7"; a <= X"1";  wait for 100 ns; -- 7 + 1 (overflow)
	op <= "00"; b <= X"7"; a <= X"F";  wait for 100 ns; -- 7 + - 1
    
    -- Resta --
	op <= "01"; b <= X"F"; a <= X"F";  wait for 100 ns; -- -1 - -1
	op <= "01"; b <= X"8"; a <= X"F";  wait for 100 ns; -- -8 - -1 
	op <= "01"; b <= X"8"; a <= X"1";  wait for 100 ns; -- -8 - 1 (overflow)
    
    -- AND --
    op <= "10"; b <= X"5"; a <= X"A";  wait for 100 ns;
    op <= "10"; b <= X"6"; a <= X"3";  wait for 100 ns;
    
    -- OR --
    op <= "10"; b <= X"5"; a <= X"A";  wait for 100 ns;
    op <= "10"; b <= X"6"; a <= X"3";  wait for 100 ns;
    
    -- ZERO --
    op <= "01"; b <= X"1"; a <= X"1";  wait for 100 ns;
    
    wait;
    
end process;

end Behavioral;
