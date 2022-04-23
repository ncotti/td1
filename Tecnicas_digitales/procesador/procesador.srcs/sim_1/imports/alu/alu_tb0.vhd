library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library  std;
use std.textio.all;
library work;
use work.txt_util.all;

entity alu_tb0 is
     generic (N_TB : integer := 8;
     N : integer := 8);

end alu_tb0;

architecture Behavioral of alu_tb0 is
    component alu is
        generic (N : integer := 8);
        Port ( clk : in std_logic;                           -- Clock del sistema
               rst : in std_logic;                           -- Reset sincronico del sistema
               ena : in std_logic;                           -- Habilita la realizacion de la operacion
               code: in std_logic_vector (3 downto 0);       -- Codigo de la operacion a realizar
               op  : in std_logic_vector (N-1 downto 0);     -- Operando
               acc : out std_logic_vector (N-1 downto 0);    -- Acumulador
               zero : out std_logic;                         -- Acumulador en cero
               overflow : out std_logic;                     -- Overflow
               carryBorrow : out std_logic;                  -- Carry/Borrow
               negative : out std_logic                      -- Acumulador negativo
                );
    end component;

    signal clk      : std_logic := '0';
    signal rst      : std_logic;
    signal ena      : std_logic;
    signal code: std_logic_vector (3 downto 0);
    signal op  : std_logic_vector (N-1 downto 0);
    signal acc : std_logic_vector (N-1 downto 0);
    signal zero : std_logic;
    signal overflow : std_logic;
    signal carryBorrow : std_logic;
    signal negative : std_logic;
    signal flags: std_logic_vector (3 downto 0);
    constant clk_period : time := 10 ns;

begin

flags <= zero & overflow & carryBorrow & negative;

-- uut --
uut: alu
    generic map (N => N)
    port map (
        clk => clk,
        rst => rst,
        ena => ena,
        code => code,
        op => op,
        acc => acc,
        zero => zero,
        overflow => overflow,
        carryBorrow => carryBorrow,
        negative => negative);


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
	variable enaChr : character;
	variable codeFile: string (4 downto 1);   -- Code leido
	variable opFile: integer;   -- Code leido
	variable accFile : integer;			       -- Acc leido
	variable flagsFile: string (4 downto 1);   -- Flags leidos	
	variable line : integer;
begin

    -- Inicializo todo --
    ena <= '0';
    code <= "0000";
    op <= (others => '0');

	-- Abro el archivo como lectura --
	file_open (fileStatus, fileHandler, "./aluTbCode7_8.txt", READ_MODE);
	assert (fileStatus = OPEN_OK)	report "Error al abrir el archivo para leer"	severity failure;
	readLine (fileHandler, bufferLine);	     -- Leo la primer linea del archivo y la tiro
	line := 2;     -- Numero de linea a leer
	wait until falling_edge (rst);              -- Espero a que liberen el reset

	while not endfile(fileHandler) loop
	    wait until falling_edge (clk);
		readLine (fileHandler, bufferLine);	     -- enable,code,op;acc,flags(Z,OV,CB,N)
		read (bufferLine, enaChr);    read (bufferLine, comaChr);
		read (bufferLine, codeFile);  read (bufferLine, comaChr);
        read (bufferLine, opFile);    read (bufferLine, comaChr);
        read (bufferLine, accFile);   read (bufferLine, comaChr);
        read (bufferLine, flagsFile);

        if (enaChr = '0') then
		    ena <= '0';
		else
		    ena <= '1';
		end if;

		code <= to_std_logic_vector(codeFile);
		op <= std_logic_vector(to_unsigned(opFile, op'length));

        if (acc /= std_logic_vector (to_unsigned(accFile, acc'length))) then
            report "Error ACC!!! Line: " severity ERROR;
      	    report str (line, 10) severity ERROR;
      	    wait;
        end if;

        if (flags /= to_std_logic_vector(flagsFile)) then
            report "Error Flags!!! Line: " severity ERROR;
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
