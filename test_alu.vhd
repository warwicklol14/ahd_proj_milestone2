----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/17/2022 02:27:51 PM
-- Design Name: 
-- Module Name: test_alu - Behavioral
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
use IEEE.std_logic_textio.all;
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity test_alu is
--  Port ( );
end test_alu;

architecture Behavioral of test_alu is
    component alu is
        Port ( input1 : in STD_LOGIC_VECTOR(31 DOWNTO 0);
           input2 : in STD_LOGIC_VECTOR(31 DOWNTO 0);
           operation : in STD_LOGIC_VECTOR(3 DOWNTO 0);
           calc_output : out STD_LOGIC_VECTOR(31 DOWNTO 0));
    end component;
    
    
    signal t_input1, t_input2, t_calc_output : std_logic_vector(31 DOWNTO 0);
    signal t_operation: std_logic_vector(3 DOWNTO 0);

    file f_test_cases: text;
begin
    alu_instance: alu
    port map(
        input1 => t_input1,
        input2 => t_input2,
        operation => t_operation,
        calc_output => t_calc_output
    );
    
    process
        variable f_line: line;
        variable f_input1, f_input2, f_calc_output: std_logic_vector(31 DOWNTO 0);
        variable f_operation: std_logic_vector(3 DOWNTO 0);
        variable f_comma: character;
    begin
        file_open(f_test_cases,"alu_cases.csv", read_mode);

        while not endfile(f_test_cases) loop
            readline(f_test_cases, f_line);
            read(f_line, f_input1);
            read(f_line, f_comma);
            read(f_line, f_input2);
            read(f_line, f_comma);
            read(f_line, f_operation);
            read(f_line, f_comma);
            read(f_line, f_calc_output);
            
            t_input1 <= f_input1;
            t_input2 <= f_input2;
            t_operation <= f_operation;
            
            wait for 10ns;

            assert t_calc_output = f_calc_output report "ALU case failed" severity failure;
         end loop;

         file_close(f_test_cases);

         report "Testbench was successfull" severity failure;
    end process;

end Behavioral;
