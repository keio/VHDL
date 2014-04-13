#### Example of a loop
Note that the loop might not synthesize but works for Testbench. There are other types of loops that will synthesize. Check Stack Overlow for more information.

```VHDL
stim_proc: process
	-- Variables in process must be declared BEFORE begin
	variable loopnum : std_logic_vector (3 downto 0);
	   begin	
		
			-- Note that this loop might not synthesize
			for i in 0 to 9 loop
				Digit <= loopnum;
				loopnum := loopnum + '1';
				wait for 100 ns;
			end loop;
			
			-- Reset our counter
			-- loopnum := "0000";
			-- Not neccessary to reset counter since variables are destroyed
			-- after process is finished. 
end process;
```
Also note that there has to be some changes to the libraries used in order to do logical arithmetics.

```VHDL
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- These two libraries enable arithmetic operations like
-- loopnum := loopnum + '1';
USE ieee.std_logic_arith.all;
use ieee.STD_LOGIC_UNSIGNED.all;

-- Enables to convert std_logic_vector to integer for arithmetical operations
-- https://stackoverflow.com/questions/854684/why-cant-i-increment-this-std-logic-vector
-- Note that the syntax for operations is different

-- loopnum <= std_logic_vector(unsigned(loopnum) + 1);
-- use ieee.numeric_std.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
```
