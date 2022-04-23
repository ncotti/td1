library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use work.constants.all;

package functions is

    ---------------------------------------------------------------------------
    --  Estados de la máquina de estados.
    ---------------------------------------------------------------------------
    type state_type is (st_RST, st_NOP, st_ALU_OP, st_ALU_READ_MEM, st_JMP, 
                        st_WRITE_RAM, st_READ_RAM_TO_WRITE_PORT, 
                        st_WRITE_PORT);
                        
    ---------------------------------------------------------------------------
    --  Devuelve el NEXT_OP, el estado futuro de la siguiente operación al leer un 
    --  nuevo dato de la ROM. Recibe todas las entradas del sistema.
    ---------------------------------------------------------------------------                   
    function    next_op(    
                    op_type:        std_logic_vector; 
                    op_code:        std_logic_vector; 
                    op_alu_code:    std_logic;
                    aluZero:        std_logic;
                    aluOverflow:    std_logic;
                    aluCarryBorrow: std_logic;
                    aluNegative:    std_logic) 
                return state_type;
    
    ---------------------------------------------------------------------------
    --  Devuelve las salidas de NEXT_OP, dependiendetes de las entradas.
    --La salida es "00000" donde
    --out(4) = pcEna
    --out(3) = pcPl
    --out(2) = aluEna
    --out(1) = ramDataWea
    --out(0) = portWrEna
    ---------------------------------------------------------------------------            
    function    next_op_output( 
                    op_type:        std_logic_vector; 
                    op_code:        std_logic_vector; 
                    op_alu_code:    std_logic;
                    aluZero:        std_logic;
                    aluOverflow:    std_logic;
                    aluCarryBorrow: std_logic;
                    aluNegative:    std_logic) 
                return std_logic_vector;
                
end functions;

package body functions is

    function    next_op (
                    op_type:        std_logic_vector; 
                    op_code:        std_logic_vector; 
                    op_alu_code:    std_logic;
                    aluZero:        std_logic;
                    aluOverflow:    std_logic;
                    aluCarryBorrow: std_logic;
                    aluNegative:    std_logic) 
                return state_type is       
    begin
    
        if op_type = NOP then
            return st_NOP;
              
               
        elsif op_type = ALU then
        
            if op_alu_code = ALU_CODE_MEM then
                return st_ALU_READ_MEM;
                
            elsif op_alu_code = ALU_CODE_LIT then
                return st_ALU_OP;
            
            else
                return st_RST;
            end if;
                
                
        elsif op_type = JMP then
        
            if  (op_code = JMP_CODE_ZERO    and aluZero         = '1') or
                (op_code = JMP_CODE_OV      and aluOverflow     = '1') or
                (op_code = JMP_CODE_CB      and aluCarryBorrow  = '1') or
                (op_code = JMP_CODE_NEG     and aluNegative     = '1') or
                (op_code = JMP_CODE_MEM) then 
                 
                    return st_JMP;
                
                else
                    return st_NOP;                        
                end if;
                               
                               
        elsif op_type = MOV then
            if  op_code = MOV_CODE_READ_PORT    or
                op_code = MOV_CODE_ACC          or
                op_code = MOV_CODE_MOVZ then
                
                return st_WRITE_RAM;
            
            elsif op_code = MOV_CODE_WRITE_PORT then
                return st_READ_RAM_TO_WRITE_PORT;
                
            else
                return st_RST;
            end if;
            
                       
        else
            return st_RST;          
        end if;
    end next_op;
    
    
    function    next_op_output ( 
                    op_type:        std_logic_vector; 
                    op_code:        std_logic_vector; 
                    op_alu_code:    std_logic;
                    aluZero:        std_logic;
                    aluOverflow:    std_logic;
                    aluCarryBorrow: std_logic;
                    aluNegative:    std_logic) 
                return std_logic_vector is            
     begin
     
        if op_type = NOP then
            return "10000";
    
    
        elsif op_type = ALU then
        
            if op_alu_code = ALU_CODE_LIT then
                return "10100";
                
            else
                return "00000";
            end if;
            
            
        elsif op_type = JMP then
        
            if  (op_code = JMP_CODE_ZERO    and aluZero         = '1') or
                (op_code = JMP_CODE_OV      and aluOverflow     = '1') or
                (op_code = JMP_CODE_CB      and aluCarryBorrow  = '1') or
                (op_code = JMP_CODE_NEG     and aluNegative     = '1') or
                (op_code = JMP_CODE_MEM) then 
                 
                return "01000";
            
            else
                return "10000";                        
            end if; 
                    
                                   
        elsif op_type = MOV then
            if (op_code = MOV_CODE_READ_PORT    or
                op_code = MOV_CODE_ACC          or
                op_code = MOV_CODE_MOVZ) then
                
                return "10010";
            
            else
                return "00000";  
            end if;   
                                         
        else
            return "00000";                
        end if;
        
     end next_op_output;
    
end functions;
