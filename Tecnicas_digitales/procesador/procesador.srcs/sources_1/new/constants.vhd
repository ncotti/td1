library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package constants is

    ---------------------------------------------------------------------------
    --  Códigos de operación de la ALU
    ---------------------------------------------------------------------------
    constant AND_CODE :         std_logic_vector (3 downto 0) := "0000";
    constant OR_CODE :          std_logic_vector (3 downto 0) := "0001";
    constant XOR_CODE :         std_logic_vector (3 downto 0) := "0010";
    constant ADD_CODE :         std_logic_vector (3 downto 0) := "0011";
    constant SUB_CODE :         std_logic_vector (3 downto 0) := "0100";
    constant ROT_CODE :         std_logic_vector (3 downto 0) := "0101";
    constant EQUAL_CODE :       std_logic_vector (3 downto 0) := "0110";
    constant CARRY_CLR_CODE :   std_logic_vector (3 downto 0) := "0111";
    constant CARRY_SET_CODE :   std_logic_vector (3 downto 0) := "1000";
    
    ---------------------------------------------------------------------------
    --  Tipos de operación en la UC (op_type)
    ---------------------------------------------------------------------------
    constant NOP: std_logic_vector (1 downto 0) := "00";
    constant ALU: std_logic_vector (1 downto 0) := "01";
    constant JMP: std_logic_vector (1 downto 0) := "10";
    constant MOV: std_logic_vector (1 downto 0) := "11";
    
    ---------------------------------------------------------------------------
    --  Códigos de operación en la UC (op_code)
    ---------------------------------------------------------------------------
    constant JMP_CODE_ZERO:         std_logic_vector(3 downto 0) := "0000";
    constant JMP_CODE_OV:           std_logic_vector(3 downto 0) := "0001";
    constant JMP_CODE_CB:           std_logic_vector(3 downto 0) := "0010";
    constant JMP_CODE_NEG:          std_logic_vector(3 downto 0) := "0011";
    constant JMP_CODE_MEM:          std_logic_vector(3 downto 0) := "0100";
    constant MOV_CODE_READ_PORT:    std_logic_vector(3 downto 0) := "0000";
    constant MOV_CODE_WRITE_PORT:   std_logic_vector(3 downto 0) := "0001";
    constant MOV_CODE_ACC:          std_logic_vector(3 downto 0) := "0010";
    constant MOV_CODE_MOVZ:         std_logic_vector(3 downto 0) := "0011";
    
    ---------------------------------------------------------------------------
    --  Códigos de operación en la UC referidos a la ALU (op_alu_code)
    ---------------------------------------------------------------------------
    constant ALU_CODE_LIT:          std_logic := '1';
    constant ALU_CODE_MEM:          std_logic := '0';
    
end constants;

package body constants is
    --Empty
end constants;
