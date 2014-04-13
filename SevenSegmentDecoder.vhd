-- 7 SEGMENT DECODER    

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity segmentdecoder is
    Port ( Digit : in  STD_LOGIC_VECTOR (3 downto 0);
           segmentA : out  STD_LOGIC;
           segmentB : out  STD_LOGIC;
           segmentC : out  STD_LOGIC;
           segmentD : out  STD_LOGIC;
           segmentE : out  STD_LOGIC;
           segmentF : out  STD_LOGIC;
		   segmentG : out  STD_LOGIC);
end segmentdecoder;

architecture Behavioral of segmentdecoder is

begin

process(Digit)
	variable Decode_data : std_logic_vector(6 downto 0);
	
	begin 
	
	case Digit is
		when "0000" => Decode_Data := "1111110"; --0
		when "0001" => Decode_Data := "0110000"; --1
		when "0010" => Decode_Data := "1101101"; --2
		when "0011" => Decode_Data := "1111001"; --3
		when "0100" => Decode_Data := "0110011"; --4
		when "0101" => Decode_Data := "1011011"; --5
		when "0110" => Decode_Data := "1011111"; --6
		when "0111" => Decode_Data := "1110000"; --7
		when "1000" => Decode_Data := "1111111"; --8
		when "1001" => Decode_Data := "1111011"; --9
		when "1010" => Decode_Data := "1110111"; --A
		when "1011" => Decode_Data := "0011111"; --B
		when "1100" => Decode_Data := "1001110"; --C
		when "1101" => Decode_Data := "0111101"; --D
		when "1110" => Decode_Data := "1001111"; --E
		when "1111" => Decode_Data := "1000111"; --F
		when others => Decode_Data := "0111110"; --H ERROR
	end case;
	
		segmentA <= not Decode_Data(6);
		segmentB <= not Decode_Data(5);
		segmentC <= not Decode_Data(4);
		segmentD <= not Decode_Data(3);
		segmentE <= not Decode_Data(2);
		segmentF <= not Decode_Data(1);
		segmentG <= not Decode_Data(0);
		
end process;

end Behavioral;
