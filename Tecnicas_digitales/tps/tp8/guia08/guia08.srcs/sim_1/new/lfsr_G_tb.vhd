library work;
library IEEE;
    use IEEE.STD_LOGIC_1164.ALL;
    use STD.textio.all;
    use IEEE.std_logic_textio.all;

entity lfsr_G_tb is
    Generic (N: integer := 8);
    end lfsr_G_tb;

architecture Behavioral of lfsr_G_tb is
    constant PATH: string := "data.txt";
    constant PERIOD : time := 10ns;
    
    --Signals que del componente
    signal clk:     std_logic := '0';
    signal rst:     std_logic;
    signal inits:   std_logic_vector (N-1 downto 0);
    signal taps:    std_logic_vector (N-1 downto 0);
    signal salida:  std_logic_vector (N-1 downto 0);

begin

lfsr_g: entity work.lfsr_G
        generic map (N => N)
        port map (clk => clk, rst => rst, inits => inits, taps => taps, salida => salida);
         
clock: process
begin
    clk <= not clk; wait for PERIOD/2;
end process;



fileIO : process
    file file_handler: text;
    variable file_status: file_open_status;
    variable buffer_line: line;
    variable spacer: character;
    variable v_error: boolean := false;  --Detecta si hubo errores
    variable v_rows: integer := 1;  --Cuanta las filas del archivo
    
    variable v_rst: std_logic;
    variable v_inits: std_logic_vector (N-1 downto 0);
    variable v_taps: std_logic_vector (N-1 downto 0);
    variable v_salida: std_logic_vector (N-1 downto 0);
    
    
begin
    file_open (file_status, file_handler, PATH, READ_MODE);
    
    assert (file_status = OPEN_OK) report "No se pudo abrir el archivo" severity failure;
    
    wait until falling_edge(clk);   --Cargo los valores antes del próximo ciclo de clock
    
    while (not endfile(file_handler) ) loop
    
        --Leo todos los datos del archivo
        readLine (file_handler, buffer_line);
        
        read (buffer_line, v_rst);
        read (buffer_line, spacer);
        read (buffer_line, v_inits);
        read (buffer_line, spacer);
        read (buffer_line, v_taps);
        read (buffer_line, spacer);
        read (buffer_line, v_salida);
        
        --Igualo los datos del archivo con las signals
        rst <= v_rst;
        inits <= v_inits;
        taps <= v_taps;
        
        wait until rising_edge(clk);    --Espero al próximo flanco ascendente para leer la salida
        
        --Chequeo si son distintas
        if (v_salida /= salida) then
            v_error := true;
            report "Salida distinta en fila: " & INTEGER'image(v_rows)  severity error;
            
        end if;
         
        v_rows := v_rows + 1;
        
    end loop;
    
    report "Fin del archivo" severity note;
    assert (v_error) report "No hubo errores" severity note;
    assert (not v_error) report "Hubo errores" severity warning;
    
    file_close (file_handler);
    
    wait;
    
end process;


end Behavioral;
