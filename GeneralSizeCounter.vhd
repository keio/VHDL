-- GENERAL SIZE COUNTER

-- Change N to desired counter size
-- No need for Karnaugh Diagrams

entity counter3c is
    generic (N : integer := 8);
    Port ( clk : in STD_LOGIC;
           clr : in STD_LOGIC;
            q  : out STD_LOGIC_VECTOR (N-1 downto 0));
end counter3c;

architecture Behavioral of counter3c is
signal count: STD_LOGIC_VECTOR (N-1 downto 0);
begin
process (clk, clr)
    begin
        if clr = '1' then
            count <= (others => '0');
        elsif clk'event and clk = '1' then
            count <= count + 1;
        end if;
    end process;
    q <= count;
end Behavioral;
