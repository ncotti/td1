library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library  std;
use std.textio.all;
library work;
use work.txt_util.all;

entity pc_tb is
end pc_tb;

architecture Behavioral of pc_tb is

    COMPONENT pc
    Port ( clk : in std_logic;
           rst : in std_logic;
           ena : in std_logic;
           pl : in std_logic;
           addrPl : in std_logic_vector (9 downto 0);
           data: out std_logic_vector (31 downto 0)
           );
    END COMPONENT;

    signal clk      : std_logic := '0';
    signal rst      : std_logic;
    signal ena      : std_logic;
    signal pl       : std_logic;
    signal addrPl : std_logic_vector (9 downto 0);
    signal data   : std_logic_vector (31 downto 0);
    signal data_S   : std_logic_vector (31 downto 0);
    constant clk_period : time := 10 ns;

begin

-- uut --
uut: pc
    Port map ( clk => clk,
               rst => rst,
               ena => ena,
               pl => pl,
               addrPl => addrPl,
               data => data
           );

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
	variable line : integer;

	variable comaChr : character;
	variable enaChr : character;
	variable plChr: character;
	variable addrPlInt: integer;
	variable dataInt: integer;

begin

    -- Inicializo todo --
    ena <= '0';
    pl <= '0';
    addrPl <= (others => '0');

	-- Abro el archivo como lectura --
	file_open (fileStatus, fileHandler, "./pcTb01.txt", READ_MODE);
	assert (fileStatus = OPEN_OK)	report "Error al abrir el archivo para leer"	severity failure;
	readLine (fileHandler, bufferLine);	     -- Leo la primer linea del archivo y la tiro
	line := 2;     -- Numero de linea a leer
	wait until falling_edge (rst);              -- Espero a que liberen el reset
	wait until rising_edge (clk);              -- Espero por la block ram

	while not endfile(fileHandler) loop
	    wait until rising_edge (clk);
	    wait for 100ps;
		readLine (fileHandler, bufferLine);	     -- enable,pl,addrPl;data
		read (bufferLine, enaChr);       read (bufferLine, comaChr);
		read (bufferLine, plChr);        read (bufferLine, comaChr);
        read (bufferLine, addrPlInt);    read (bufferLine, comaChr);
        read (bufferLine, dataInt);

        if (enaChr = '0') then
		    ena <= '0';
		else
		    ena <= '1';
		end if;

        if (plChr = '0') then
		    pl <= '0';
		else
		    pl <= '1';
		end if;

        addrPl <= std_logic_vector (to_unsigned(addrPlInt, addrPl'length));

        data_S <= std_logic_vector (to_unsigned(dataInt, data_S'length));

        if (data /= std_logic_vector (to_unsigned(dataInt, data'length))) then
            report "Error data!!! Line: " severity ERROR;
      	    report str (line, 10) severity ERROR;
      	    wait;
        end if;

  	    line := line + 1;
	end loop;

	file_close (fileHandler);

	report "Fin del archivo" severity note;
	wait;
end process;

end Behavioral;
