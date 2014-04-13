-- 2 TO 1 MUX

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mux2t1 is
    Port ( A : in std_logic;
           B : in std_logic;
           S : in std_logic;
           Y : out std_logic);
end mux2t1;

architecture Behavioral1 of mux2t1 is
begin
    process(A, B, S)
    begin
    if(S = '1') then
        Y <= A;
    else
        Y <= B;
    end if;
    end process;
end Behavioral1;

architecture Behavioral2 of mux2t1 is
begin
    process(A, B, S)
    begin
    case S is
    when '1' =>
        Y <= A;
    when others=>
        Y <= B;
    end case;
    end process;
end Behavioral2;

architecture Behavioral3 of mux2t1 is
begin
    Y <= A when (S = '1') else B;
end Behavioral3;

architecture Behavioral4 of mux2t1 is
begin
with S select
    Y <= A when '1',
         B when others;
end Behavioral4;
