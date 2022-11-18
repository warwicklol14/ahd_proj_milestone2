----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/17/2022 12:29:31 PM
-- Design Name: 
-- Module Name: test_led - Behavioral
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

entity test_led is
--  Port ( );
end test_led;

architecture Behavioral of test_led is

      constant clk_period: time := 20ns;

        signal t_clk: std_logic := '0';
        
        signal t_operation :std_logic;

        signal t_led_state: std_logic_vector(31 downto 0);
        signal t_led_write, t_LED: std_logic_vector(15 downto 0);

        file f_test_cases: text;

        component led_registers
        port (
           clk : in STD_LOGIC;
           operation: in STD_LOGIC;
           led_write: in STD_LOGIC_VECTOR(15 DOWNTO 0);
           LED: out STD_LOGIC_VECTOR(15 DOWNTO 0);
           led_state : out STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
        end component;

begin

        led_instance: led_registers
        port map(
                        clk => t_clk,
                        operation => t_operation,
                        led_write => t_led_write,
                        LED => t_LED,
                        led_state => t_led_state
                );

        clk_process: process begin
            wait for clk_period/2;
            t_clk <= not t_clk;
        end process;

        process
            variable f_operation : std_logic;
            variable f_led_state: std_logic_vector(31 downto 0);
            variable f_LED, f_led_write: std_logic_vector(15 downto 0);
            variable f_line: line;
            variable f_comma: character;
        begin

            file_open(f_test_cases,"led_cases.csv", read_mode);
    
            while not endfile(f_test_cases) loop
                readline(f_test_cases, f_line);
                read(f_line, f_operation);
                read(f_line, f_comma);
                read(f_line, f_led_write);
                read(f_line, f_comma);
                read(f_line, f_LED);
                read(f_line, f_comma);
                read(f_line, f_led_state);

                t_operation <= f_operation;
                t_led_write <= f_led_write;
                
                wait until t_clk = '1';
                wait until t_clk = '0';
    
                if (f_operation = '0') then 
                    assert t_led_state = f_led_state report "LED register doesn't match, test case failed" severity failure;
                    assert t_LED = f_LED report "LED register doesn't match, test case failed" severity failure;
                else 
                    assert t_led_state = f_led_state report "LED register doesn't match, test case failed" severity failure;
                end if;
             end loop;
    
            file_close(f_test_cases);
    
            report "Testbench was successfull" severity failure;
        end process;




end Behavioral;
