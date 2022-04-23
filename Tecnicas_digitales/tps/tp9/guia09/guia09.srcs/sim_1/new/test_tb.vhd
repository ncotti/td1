library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.textio.all;
use ieee.std_logic_textio.all;


entity test_tb is
--  Port ( );
end test_tb;

architecture Behavioral of test_tb is
constant PATH0: string := "/home/ngc/Escritorio/Git/ncotti/Tecnicas_digitales/tps/tp9/guia09/guia09.srcs/sim_1/new/blockRamRd00.txt";
begin

stimulus_proc: process
        file file_handler : text;
        variable file_status: file_open_status;
        variable buffer_line: line;
    
begin
file_open (file_status, file_handler, PATH0, WRITE_MODE);
        
assert (file_status = OPEN_OK) report "No se pudo abrir el archivo read00" severity failure;

write (buffer_line, 999);
writeline (file_handler, buffer_line);

file_close(file_handler);

wait;
end process;
end Behavioral;
