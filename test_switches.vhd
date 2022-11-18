----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/17/2022 12:43:46 PM
-- Design Name: 
-- Module Name: test_switches - Behavioral
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

entity test_switches is
--  Port ( );
end test_switches;

architecture Behavioral of test_switches is

      constant clk_period: time := 20ns;

        signal t_clk: std_logic := '0';

        signal t_state: std_logic_vector(31 downto 0);
        signal t_sw: std_logic_vector(15 downto 0);

        file f_test_cases: text;

        component switch_registers
        port (
           clk : in STD_LOGIC;
           sw: in STD_LOGIC_VECTOR(15 DOWNTO 0);
           state : out STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
        end component;

begin


        switch_instance: switch_registers
        port map(
                        clk => t_clk,
                        sw => t_sw,
                        state => t_state
                );

        clk_process: process begin
            wait for clk_period/2;
            t_clk <= not t_clk;
        end process;

        process
            variable f_state: std_logic_vector(31 downto 0);
            variable f_sw: std_logic_vector(15 downto 0);
            variable f_line: line;
            variable f_comma: character;
        begin

            file_open(f_test_cases,"switch_cases.csv", read_mode);
    
            while not endfile(f_test_cases) loop
                readline(f_test_cases, f_line);
                read(f_line, f_sw);
                read(f_line, f_comma);
                read(f_line, f_state);
    
                t_sw <= f_sw;
                
    
                wait until t_clk = '1';
                wait until t_clk = '0';
    
                assert t_state = f_state report "Switch register doesn't match, test case failed" severity failure;
             end loop;
    
            file_close(f_test_cases);
    
            report "Testbench was successfull" severity failure;
        end process;



end Behavioral;
