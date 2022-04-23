library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use STD.textio.all;
use ieee.std_logic_textio.all;
use ieee.numeric_std.all;

entity blockRamTest0_tb is
--  Port ( );
end blockRamTest0_tb;

architecture Behavioral of blockRamTest0_tb is

    COMPONENT blockRamTest0
      PORT (
        clka : IN STD_LOGIC;
        wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
        addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
      );
    END COMPONENT;

    constant PERIOD: time := 10ns;
    constant PATH0: string := "/home/ngc/Escritorio/Git/ncotti/Tecnicas_digitales/tps/tp9/guia09/guia09.srcs/sim_1/new/blockRamRd00.txt";
    constant PATH1: string := "/home/ngc/Escritorio/Git/ncotti/Tecnicas_digitales/tps/tp9/guia09/guia09.srcs/sim_1/new/blockRamRd01.txt";
    constant MEM_SIZE: integer := 1024;

    signal clka: std_logic := '0';
    signal wea: std_logic_vector(0 downto 0);
    signal addra: std_logic_vector (9 downto 0) := (others => '0');
    signal dina: std_logic_vector (15 downto 0) := (others => '0');
    signal douta: std_logic_vector (15 downto 0);
    

begin

    instA : blockRamTest0
      PORT MAP (
        clka => clka,
        wea => wea,
        addra => addra,
        dina => dina,
        douta => douta
      );
    
    clk_proc: process
    begin
        wait for PERIOD/2;
        clka <= not clka; 
    end process;
    
    stimulus_proc: process
        file file_handler : text;
        variable file_status: file_open_status;
        variable buffer_line: line;
        
        variable mem_pos: integer := 0;
        
    begin
        --Escribo el primer archivo
        file_open (file_status, file_handler, PATH0, WRITE_MODE);
        
        assert (file_status = OPEN_OK) report "No se pudo abrir el archivo read00" severity failure;
        
        --Preparo la dirección, y espero un ciclo de clock.
        wea <= "0";
        addra <= (others => '0');
        mem_pos := 0;
        wait until rising_edge(clka); wait until falling_edge(clka);
        
        while mem_pos < MEM_SIZE loop
            write       (buffer_line, mem_pos);
            write       (buffer_line, ',');
            hwrite      (buffer_line, douta);
            writeline   (file_handler, buffer_line);
            
            addra <= std_logic_vector(unsigned(addra) + 1);
            mem_pos := mem_pos + 1;
            
            wait until falling_edge (clka); --Espero un ciclo a obtener el dato de la address cambiada      
        end loop;
        
        file_close (file_handler);
        
        --Escribo en la RAM los números consecutivos
        wait until falling_edge(clka);
        
        --Preparo la memoria para escritura
        wea <= "1";
        addra <= (others => '0');
        dina <= x"AA00";
        mem_pos := 0;
        wait until falling_edge(clka);
        
        --Escribo los datos en las posiciones de la memoria
        while (mem_pos < MEM_SIZE) loop
        
            addra <= std_logic_vector(unsigned(addra) + 1);
            dina <= std_logic_vector(unsigned(dina) + 1);
            mem_pos := mem_pos + 1;
            if (mem_pos = 1024) then
                wea <= "0";
            end if;               
            wait until falling_edge(clka); --Me doy un ciclo para que le escriba.
        end loop;
        
        --Escribo el segundo archivo
        wea <= "0";
        addra <= (others => '0');
        mem_pos := 0;  
        wait until falling_edge(clka);
        
        file_open (file_status, file_handler, PATH1, WRITE_MODE);
        
        assert (file_status = OPEN_OK) report "No se pudo abrir el archivo read01" severity failure;
        
        while mem_pos < MEM_SIZE loop
        
            write       (buffer_line, mem_pos);
            write       (buffer_line, ',');
            hwrite      (buffer_line, douta);
            writeline   (file_handler, buffer_line);
            
            addra <= std_logic_vector(unsigned(addra) + 1);
            mem_pos := mem_pos + 1;
            
            wait until falling_edge (clka);
        end loop;
        
        file_close (file_handler);
        
        wait;
        
     end process;
     
end Behavioral;