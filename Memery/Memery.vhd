----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:57:20 06/10/2015 
-- Design Name: 
-- Module Name:    Memery - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


entity Ram is
	PORT(
		clk: in STD_LOGIC;
		we: in STD_LOGIC;
		cs: in STD_LOGIC;
		reset: in STD_LOGIC;
		data: inout STD_LOGIC_VECTOR(3 downto 0);
		adr: in STD_LOGIC_VECTOR(9 downto 0)
	);
end Ram;

architecture Behavioral of Ram is
	type A is array (63 downto 0) of STD_LOGIC_VECTOR(63 downto 0);
	signal data_i: STD_LOGIC_VECTOR(3 downto 0);
	signal data_o: STD_LOGIC_VECTOR(3 downto 0);
	signal  sram : A;
	signal ccs: std_logic; 
	signal cwe : std_logic;
	signal addr_r: std_logic_vector(5 downto 0);
	signal addr_c: std_logic_vector(3 downto 0);
begin
	ccs <= cs;
	cwe <= we;
	addr_r <= adr(8 downto 3);
	addr_c <= adr(9) & adr(2 downto 0);
	--write
	process(clk, reset)
		begin
			if clk'event and clk='1' then
				if(ccs='0' and cwe='0') then
					sram(conv_integer(addr_r))(conv_integer(addr_c)) <= data_i(0);
					sram(conv_integer(addr_r))(conv_integer(addr_c)+16) <= data_i(1);
					sram(conv_integer(addr_r))(conv_integer(addr_c)+32) <= data_i(2);
					sram(conv_integer(addr_r))(conv_integer(addr_c)+48) <= data_i(3);
				end if;
			end if;
			if reset = '1' then
				data_o <= (others => '0');
			elsif clk'event and clk='1' then
				if cs='0' and we='1' then
						data_o(3) <= sram(conv_integer(addr_r))(conv_integer(addr_c)+48); 
						data_o(2) <= sram(conv_integer(addr_r))(conv_integer(addr_c)+32); 
						data_o(1) <= sram(conv_integer(addr_r))(conv_integer(addr_c)+16); 
						data_o(0) <= sram(conv_integer(addr_r))(conv_integer(addr_c));
				end if;
			end if;
	end process;

	data_i <= data;
	data <= data_o when cs='0' and we = '1' else
					(others =>'Z');
end Behavioral;
