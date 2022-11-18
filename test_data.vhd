----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2022 08:10:37 AM
-- Design Name: 
-- Module Name: test_data - Behavioral
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

entity test_data is
--  Port ( );
end test_data;

architecture Behavioral of test_data is
      constant clk_period: time := 20ns;

        signal t_clk: std_logic := '0';

        signal t_operation :std_logic;

        signal t_address, t_write_data, t_data: std_logic_vector(31 downto 0);

        file f_test_cases: text;

        component data_memory
        port (
           clk : in STD_LOGIC;
           operation: in STD_LOGIC;
           address: in STD_LOGIC_VECTOR(31 DOWNTO 0);
           write_data: in STD_LOGIC_VECTOR(31 DOWNTO 0);
           data : out STD_LOGIC_VECTOR(31 DOWNTO 0)
        );
        end component;
begin

        data_instance: data_memory
        port map(
                        clk => t_clk,
                        operation => t_operation,
                        address => t_address,
                        write_data => t_write_data,
                        data => t_data
                );

        clk_process: process begin
            wait for clk_period/2;
            t_clk <= not t_clk;
        end process;

        process
            variable f_operation : std_logic;
            variable f_address, f_write_data, f_data: std_logic_vector(31 downto 0);
            variable f_line: line;
            variable f_comma: character;
        begin

            file_open(f_test_cases,"data_cases.csv", read_mode);
            while not endfile(f_test_cases) loop
                readline(f_test_cases, f_line);
                read(f_line, f_operation);
                read(f_line, f_comma);
                read(f_line, f_address);
                read(f_line, f_comma);
                read(f_line, f_write_data);
                read(f_line, f_comma);
                read(f_line, f_data);

                t_operation <= f_operation;
                t_address <= f_address;
                t_write_data <= f_write_data;
                

                wait until t_clk = '1';
                wait until t_clk = '0';

                assert t_data = f_data report "data doesn't match, test case failed" severity failure;
             end loop;

            file_close(f_test_cases);

            report "Testbench was successfull" severity failure;
        end process;


end Behavioral;
