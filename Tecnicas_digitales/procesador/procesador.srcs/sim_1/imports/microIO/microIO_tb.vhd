library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library  std;
use std.textio.all;
library work;
use work.txt_util.all;

entity microIO_tb is
     generic (N : integer := 8);

end microIO_tb;

architecture Behavioral of microIO_tb is
    component microIO is
        generic (N : integer := 8);
        Port ( clk : in std_logic;
               rst : in std_logic;
               portRd : in std_logic_vector (7 downto 0);
               portWr : out std_logic_vector (7 downto 0));
    end component;

    signal clk    : std_logic := '0';
    signal rst    : std_logic;
    signal portRd : std_logic_vector (7 downto 0);
    signal portWr : std_logic_vector (7 downto 0);
    signal portWrDbg : std_logic_vector (7 downto 0);

    constant clk_period : time := 10 ns;

begin

-- uut --
uut: microIO
    generic map (N => N)
    port map ( clk => clk,
           rst => rst,
           portRd => portRd,
           portWr => portWr);

-- Clock process --
clkProc :process
begin
    clk <= '0';     wait for clk_period/2;
    clk <= '1';     wait for clk_period/2;
end process;

-- Reset process --
resetProc :process
begin
    rst <= '1';     wait for clk_period*2;
    rst <= '0';     wait;
end process;

-- Stimulus process --
fileRdProcess: process
	file fileHandler : text;				-- Handler para abrir el archivo
	variable fileStatus : file_open_status;	-- Indica si el archivo se puedo abrir
	variable bufferLine : line;				-- Lugar donde poner la linea leida
	variable comaChr : character;
	variable portRdStr: integer;   -- Port de entrada leido --
	variable portWrStr: integer;   -- Port de Salida leido --
	variable line : integer;

begin

    -- Inicializo todo --
    portRd <= (others => '0');

	-- Abro el archivo como lectura --
	file_open (fileStatus, fileHandler, "./prog_por73.txt", READ_MODE);
	assert (fileStatus = OPEN_OK)	report "Error al abrir el archivo para leer"	severity failure;
	readLine (fileHandler, bufferLine);	     -- Leo la primer linea del archivo y la tiro
	line := 2;     -- Numero de linea a leer
	wait until falling_edge (rst);              -- Espero a que liberen el reset

	while not endfile(fileHandler) loop
	
	    readLine (fileHandler, bufferLine);	     -- enable,code,op;acc,flags(Z,OV,CB,N)
		read (bufferLine, portRdStr);    read (bufferLine, comaChr);
		read (bufferLine, portWrStr);
		
		portRd <= std_logic_vector(to_unsigned(portRdStr, portRd'length));
		
	    wait until falling_edge (clk);

		portWrDbg <= std_logic_vector(to_unsigned(portWrStr, portWrDbg'length));
		
        if (portWr /= std_logic_vector(to_unsigned(portWrStr, portWrDbg'length))) then
            report "Error Port!!! Line: " severity ERROR;
      	    report str (line, 10) severity ERROR;
      	    --wait;
        end if;

  	    line := line + 1;
	end loop;

	file_close (fileHandler);

	report "Fin del archivo" severity note;
	wait;
end process;


end Behavioral;
