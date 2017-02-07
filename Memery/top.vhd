--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   11:59:51 06/10/2015
-- Design Name:   
-- Module Name:   F:/jizu/Memery/top.vhd
-- Project Name:  Memery
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ram
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY top IS
END top;
 
ARCHITECTURE behavior OF top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ram
    PORT(
         clk : IN  std_logic;
         we : IN  std_logic;
         cs : IN  std_logic;
         reset : IN  std_logic;
         data : INOUT  std_logic_vector(3 downto 0);
         adr : IN  std_logic_vector(9 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal we : std_logic := '0';
   signal cs : std_logic := '0';
   signal reset : std_logic := '0';
   signal adr : std_logic_vector(9 downto 0) := (others => '0');

	--BiDirs
   signal data : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ram PORT MAP (
          clk => clk,
          we => we,
          cs => cs,
          reset => reset,
          data => data,
          adr => adr
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
		reset <= '0';
		wait for clk_period/2;
		reset <= '1';
		wait for clk_period/2;
		reset <= '0';
		
		--write
		cs <= '0';
		we <= '0';
		adr <= b"0000001000";
		data <= b"0001";
		
		wait for clk_period*4;
		
		adr <= b"0000010000";
		data <= b"0010";
		
		wait for clk_period*4;
		adr <= b"0000011000";
		data <= b"0011";
		
		wait for clk_period*4;
		adr <= b"0000100000";
		data <= b"0100";
		
		wait for clk_period*4;
		cs <= '1';
		we <= '1';
		data <= "ZZZZ";
		
		--read
		wait for clk_period*4;
		cs <= '0';
		we <= '1';
		adr <= b"0000001000";
		
		wait for clk_period*4;
		
		adr <= b"0000010000";
		
		wait for clk_period*4;
		
		adr <= b"0000010000";
		
		wait for clk_period*4;
		adr <= b"0000011000";
		
      -- insert stimulus here 
		wait for clk_period*4;
		cs <= '1';
		we <= '1';
      wait;
   end process;

END;
