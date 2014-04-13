## Questions

#### What does others mean in the following snippet?
```VHDL
--Inputs
signal Digit : std_logic_vector(3 downto 0) := (others => '0');
```

#### Answer
```VHDL
A is a 16-bit vector
A <= (others => '0');   -- set all bits of A to '0'
```
The keyword "others" in the last example indicates that all elements of A not explicitly listed are to be set to '0'. What doe explicitly listed mean?

#### Which way is the best?
```VHDL
-- These two libraries enable arithmetic operations like
-- loopnum := loopnum + '1';
USE ieee.std_logic_arith.all;
use ieee.STD_LOGIC_UNSIGNED.all;

-- Enables to convert std_logic_vector to integer for arithmetical operations
-- https://stackoverflow.com/questions/854684/why-cant-i-increment-this-std-logic-vector
-- Note that the syntax for operations is different

-- loopnum <= std_logic_vector(unsigned(loopnum) + 1);
use ieee.numeric_std.all;
```
