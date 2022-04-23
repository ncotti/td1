library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

---------------------------------------------------------------------------
--  Program Counter.
--  Cuando se habilita el "pl" o el "enable", se conecta el valor futuro del sumador con la entrada de la RAM.
--  Esto permite que en el mismo flanco de clock, se actualice el valor leido de la RAM junto con la dirección leida.
--  Si se conectará la salida del sumador a la RAM, al activar el enable se tardarían 2 ciclos de clock en recibir el dato:
--  primero un ciclo en actualizar la dirección, y luego otro ciclo para que la RAM lea esa dirección.
---------------------------------------------------------------------------

entity pc is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ena : in STD_LOGIC;
           pl : in STD_LOGIC;
           addrPl : in STD_LOGIC_VECTOR (9 downto 0);
           data : out STD_LOGIC_VECTOR (31 downto 0));
end pc;

architecture Behavioral of pc is

    COMPONENT pcMem
      PORT (
        clka :  IN STD_LOGIC;
        addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
      );
    END COMPONENT;
    
    signal s_incremental_addr : std_logic_vector (9 downto 0);
    signal s_next_ram_addr :    std_logic_vector (9 downto 0);
    
begin

    pcMem_inst : pcMem
      PORT MAP (
        clka  => clk,
        addra => s_next_ram_addr,
        douta => data
      );
    
    --Se asigna la dirección de la RAM junto con el enable.  
    s_next_ram_addr <=  (others => '0')                                     when (rst = '1') else
                        addrPl                                              when (pl = '1') else
                        std_logic_vector (unsigned(s_incremental_addr) + 1) when (ena = '1') else
                        s_incremental_addr; 

    incremental_addr: process(clk)
    begin
        if (rising_edge(clk)) then
            s_incremental_addr <= s_next_ram_addr;                         
        end if;
    end process;

end Behavioral;
