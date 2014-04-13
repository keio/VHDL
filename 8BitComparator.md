# VHDL code with description

```VHDL
-- Eight-bit comparator

library ieee; 
use ieee.std_logic_1164.all;
entity compare is
 port (A, B: in std_logic_vector(0 to 7);
 EQ: out std_logic);
end compare;
 
architecture compare1 of compare is
begin
 EQ <= '1' when (A = B) else '0';
end compare1;
```

Let’s take a closer look at this simple VHDL design description. Reading from the top 
of the source file, we see:
 
- A comment field, indicated by the leading double-dash symbol ("--"). VHDL 
allows comments to be embedded anywhere in your source file, provided they 
are prefaced by the two hyphen characters as shown. Comments in VHDL 
extend from the double-dash symbol to the end of the current line. There is no 
block comment facility in VHDL.
 
- A library statement that causes the named library IEEE to be loaded into 
the current compile session. When you use VHDL libraries, it is 
recommended that you include your library statements once at the beginning 
of the source file, before any use clauses or other VHDL statements.
 
- A use clause, specifying which items from the IEEE library are to be made 
available for the subsequent design unit (the entity and its corresponding 
architecture). The general form of a use statement includes three fields 
delimited by a period: the library name (in this case ieee), a design unit within 
the library (normally a package, in this case named std_logic_1164), and the 
specific item within that design unit (or, as in this case, the special keyword 
all, which means everything) to be made visible.
 
- An entity declaration describing the interface to the comparator. Note that 
we have now specified std_logic and std_logic_vector, which are standard 
data types provided in the IEEE 1164 standard and in the associated IEEE 
library.
 
- An architecture declaration describing the actual function of the comparator 
circuit.
