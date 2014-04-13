# Clocks
#### Figure out the timing divisor for a clock
Start by defining how often you want the clock to trigger. Let's say that we want our clock to trigger every 250ms. This corresponds to 4Hz (1/0.25). Since our input clock is 50MHz we divide this value by our desired output frequency. The result of this division is our divisor.
```VHDL
-- 50MHz / 4Hz = dec 12500000 = bin 101111101011110000100000
constant ms240 : STD_LOGIC_VECTOR (23 downto 0) := "101111101011110000100000";
```
If we want to update our signal once every 250.1 ms we do the same math:
```
1 / (250.1*10^-3) = 3.998400639744 = 3.9984Hz

50MHz / 3.9984Hz = 12505002.0008 = 101111101100111110101010
```

#### Connect the 50MHz clock to a project

#### Update a trigger based on two clock values
```VHDL
if output_counter > ms250 and output_counter < ms250And100us) then
    trigger <= '1';
else
    trigger <= '0';
endif;
```

#### Clock and .ucf
The default name for the 50MHz clock in the .ucf file is "clk". The clock is defined as a bit input:
```VHDL
clk : in STD_LOGIC;
```

#### Tell ISE that a pulse pin connected to H15 is not a clock pin in the NET list
```VHDL
NET "pulse_pin" CLOCK_DEDICATED_ROUTE = FALSE;

NET "pulse_pin" LOC = "H15";
```
