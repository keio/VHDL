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

# Clock example 1
[Source](https://electronics.stackexchange.com/questions/61422/how-to-divide-50mhz-down-to-2hz-in-vhdl-on-xilinx-fpga)
##### How do I change the 50MHz clock to 2Hz?
Basically, there are two ways of doing this. The first is to use the Xilinx native clock synthesizer core. One of the advantages of this is that the Xlinx tools will recognise the clock as such and route it through the required pathways. The tools will also handle any timing constraints (not really applicable in this case, since it's a 2Hz clock)

The second way is to use a counter to count the number of faster clock pulses until half of your slower clock period has passed. For example, for your case, the number of fast clock pulses that make up one clock period of a slow clock cycle is 50000000/2 = 25000000. Since we want half a clock period, that's 25000000/2 = 12500000 for each half-cycle. (the duration of each high or low).

Here's what it looks like in VHDL:
```VHDL
entity scale_clock is
  port (
    clk_50Mhz : in  std_logic;
    rst       : in  std_logic;
    clk_2Hz   : out std_logic);
end scale_clock;

architecture Behavioral of scale_clock is

  signal prescaler : unsigned(23 downto 0);
  signal clk_2Hz_i : std_logic;
begin

  gen_clk : process (clk_50Mhz, rst)
  begin  -- process gen_clk
    if rst = '1' then
      clk_2Hz_i   <= '0';
      prescaler   <= (others => '0');
    elsif rising_edge(clk_50Mhz) then   -- rising clock edge
      if prescaler = X"BEBC20" then     -- 12 500 000 in hex
        prescaler   <= (others => '0');
        clk_2Hz_i   <= not clk_2Hz_i;
      else
        prescaler <= prescaler + "1";
      end if;
    end if;
  end process gen_clk;

clk_2Hz <= clk_2Hz_i;

end Behavioral;
```
Things to note:

- The generated clock is zero during reset. This is ok for some applications, and not for others, it just depends what you need the clock for.
- The generated clock is going to be routed as a normal signal by the Xilinx synthesis tools.
- 2Hz is very slow. Simulating for a second is going to take a while. It's a small amount of code, so it should be relatively quick to simulate even for 1 second, but if you start adding code, the time taken to simulate a clock cycle of 2 Hz could be significantly long.
- 
EDIT: clk_2Hz_i is used to buffer the output signal. VHDL doesn't like to use a signal on the right of an assignment when it is also an output.

# Clock example 2
[Source](https://electronics.stackexchange.com/questions/61422/how-to-divide-50mhz-down-to-2hz-in-vhdl-on-xilinx-fpga)
##### How do I change the 50MHz clock to 2Hz?
Use a clock prescaler.

Your prescaler value will be your (clock_speed/desired_clock_speed)/2 so (50Mhz(50,000,000)/2hz(2))/2 = 12,500,000 which in binary would be 101111101011110000100000.

More simply: (50,000,000)/2)/2 = 12,500,000 convert to binary -> 101111101011110000100000

Here is some code of what to do: Use newClock for whatever you need 2hz for...
```VHDL
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClockPrescaler is
    port(
        clock   : in STD_LOGIC; -- 50 Mhz
        Led     : out STD_LOGIC
    );
end ClockPrescaler;

architecture Behavioral of ClockPrescaler is
    -- prescaler should be (clock_speed/desired_clock_speed)/2 because you want a rising edge every period
    signal prescaler: STD_LOGIC_VECTOR(23 downto 0) := "101111101011110000100000"; -- 12,500,000 in binary
    signal prescaler_counter: STD_LOGIC_VECTOR(23 downto 0) := (others => '0');
    signal newClock : std_logic := '0';
begin

    Led <= newClock;

    countClock: process(clock, newClock)
    begin
        if rising_edge(clock) then
            prescaler_counter <= prescaler_counter + 1;
            if(prescaler_counter > prescaler) then
                -- Iterate
                newClock <= not newClock;

                prescaler_counter <= (others => '0');
            end if;
        end if;
    end process;

end Behavioral;
```

# Clock example 3
[Source](https://electronics.stackexchange.com/questions/61422/how-to-divide-50mhz-down-to-2hz-in-vhdl-on-xilinx-fpga)
##### How do I change the 50MHz clock to 2Hz?
You usually don't actually want to clock anything that slow, just create an enable at the correct rate and use that in the logic:
```VHDL
if rising_edge(50MHz_clk) and enable = '1' then
```
you can create the enable thus:
```VHDL
process 
   variable count : natural;
begin
   if rising_edge(50MHz_clk) then
       enable <= '0';
       count := count + 1;
       if count = clock_freq/desired_freq then
          enable <= '1';
          count := 0;
       end if;
    end if;
end process;
```
create a couple of constants with your clock frequency and desired enable frequency and away you go, with self-documenting code to boot.
