# UART
The default VHDL settings for UART are:
- 9600bps
- Odd parity (leaves only 7 bits for data)

### Echo back 
A change in rx is immediately sent to tx.
```VHDL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( rxd : in  STD_LOGIC;
           txd : out  STD_LOGIC);
end top;

architecture Behavioral of top is

begin

  txd <= rxd;

end Behavioral;
```
