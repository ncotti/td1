----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.05.2021 19:55:49
-- Design Name: 
-- Module Name: sumadorRestadorSat - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity sumadorRestadorSat is
    Generic (N: integer := 4);
    Port ( a : in STD_LOGIC_VECTOR (N-1 downto 0);
           b : in STD_LOGIC_VECTOR (N-1 downto 0);
           s_r : in STD_LOGIC;
           ov : out STD_LOGIC;
           resultado : out STD_LOGIC_VECTOR (N-1 downto 0));
end sumadorRestadorSat;

architecture Behavioral of sumadorRestadorSat is

    --Guarda el valor de la operación realizada.
    signal op : signed(N-1 downto 0);
    
    --Almacena las condiciones de overflow
    signal ov_check: std_logic_vector (3 downto 0);
    
    --Creada para poder leer el valor de overflow.
    signal ov_buffer: std_logic;
    
    --Valor de saturación superior e inferior
    signal max: std_logic_vector(N-1 downto 0);
    signal min: std_logic_vector(N-1 downto 0); 

begin
    --El número más alto positivo es: 011...11 con N-2 "1"
    max <= (N-1 => '0',
            others => '1');
    
    --El número más bajo es: 100...00 con N-2 "0"         
    min <= (N-1 => '1',
            others => '0'); 
    
    --La operación de suma o resta
    op <= signed(b) + signed(a) when (s_r = '0') else
          signed(b) - signed(a);
          
    --Almaceno la operación y los MSB de ambas entradas y de la operación.        
    ov_check <= s_r & b(N-1) & a(N-1) & op(N-1);
       
  --Habrá overflow si: 
    --la suma (0) de dos números positivos (MSB = 0) da negativo (MSB = 1).  
    --la suma (0) de dos números negativos (MSB = 1) da positivo (MSB = 0).
    --la resta (1) de un número positivo (MSB = 0) y uno negativo (MSB = 1) da negativo (MSB = 1)
    --la resta (1) de un número negativo (MSB = 1) y uno positivo (MSB = 0) da positvo (MSB = 0)
    ov_buffer <= '1' when (ov_check = "0001") else
                 '1' when (ov_check = "0110") else
                 '1' when (ov_check = "1011") else
                 '1' when (ov_check = "1100") else
                 '0';
                 
    ov <= ov_buffer;             
     
    --Tendré que saturar positivamente si el resultado es negativo, y tendré que saturar
    --negativamente si el resultado es positivo.     
    resultado <= std_logic_vector(op) when (ov_buffer = '0') else
                 max when (ov_check(0) = '1') else
                 min when (ov_check(0) = '0');

end Behavioral;
