library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Clocks is
    Port (  clk  : in   STD_LOGIC;
			LED0 : out  STD_LOGIC;
			LED1 : out  STD_LOGIC;
			LED2 : out  STD_LOGIC;
			LED3 : out  STD_LOGIC;
			LED4 : out  STD_LOGIC
		);
end Clocks;

architecture Behavioral of Clocks is


-- Global values
signal Hz1trigger : std_logic := '0'; --LED0
signal Hz2trigger : std_logic := '0'; --LED1
signal Hz4trigger : std_logic := '0'; --LED2
signal Hz8trigger : std_logic := '0'; --LED3
signal Hz16trigger : std_logic := '0'; --LED4
constant clock_freq : integer := 50000000;

begin

LED0_1Hz : process (clk)
	-- Local values
  	variable count : integer;
	constant desired_freq : integer := 1;	
begin
   if rising_edge(clk) then
       count := count + 1;
       if count = (clock_freq / desired_freq) / 2 then
          Hz1trigger <= not Hz1trigger;
          count := 0;
       end if;
    end if;
end process;
LED0 <= Hz1trigger;



LED1_2Hz : process (clk)
	-- Local values
	variable count : integer;
	constant desired_freq : integer := 2;	
begin
   if rising_edge(clk) then
       count := count + 1;
       if count = (clock_freq / desired_freq) / 2 then
          Hz2trigger <= not Hz2trigger;
          count := 0;
       end if;
    end if;
end process;
LED1 <= Hz2trigger;


LED2_4Hz : process (clk)
	-- Local values
	variable count : integer := 0;
	constant desired_freq : integer := 4;	
begin
   if (rising_edge(clk)) then
       count := count + 1;
       if count >= (clock_freq / desired_freq) / 2 then
          Hz4trigger <= not Hz4trigger;
          count := 0;
       end if;
    end if;
end process;
LED2 <= Hz4trigger;


LED3_8Hz : process (clk)
	-- Local values
	variable count : integer := 0;
	constant desired_freq : integer := 8;	
begin
   if (rising_edge(clk)) then
       count := count + 1;
       if count >= (clock_freq / desired_freq) / 2 then
          Hz8trigger <= not Hz8trigger;
          count := 0;
       end if;
    end if;
end process;
LED3 <= Hz8trigger;


LED4_16Hz : process (clk)
	-- Local values
	variable count : integer := 0;
	constant desired_freq : integer := 16;	
begin
   if (rising_edge(clk)) then
       count := count + 1;
       if count >= (clock_freq / desired_freq) / 2 then
          Hz16trigger <= not Hz16trigger;
          count := 0;
       end if;
    end if;
end process;
LED4 <= Hz16trigger;


end Behavioral;
