# Four types of concurrent statements
These types represent the tools we use to implement digital circuits in VHDL. 
- Concurrent 
- Conditional 
- Selected
- Process

### 1. Concurrent Signal Assignment Statements
General construction
```VHDL
<target> <= <expression>;
```
Used in a program
```VHDL
1 -- library declaration
2 library IEEE;
3 use IEEE.std_logic_1164.all;
4 -- entity
5 entity my_nand3 is
6 port ( A,B,C : in std_logic;
7 F : out std_logic);
8 end my_nand3;
9 -- architecture
10 architecture exa_nand3 of my_nand3 is
11 begin
12 F <= NOT(A AND B AND C);
13 end exa_nand3;
```

### 2. Conditional Signal Assignment Statements
General construction
```VHDL
<target> <= <expression> when <condition> else
            <expression> when <condition> else
            <expression>;
```
Used in a program
```VHDL
-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity my_4t1_mux is
port(D3,D2,D1,D0 : in std_logic;
SEL: in std_logic_vector(1 downto 0);
MX_OUT : out std_logic);
end my_4t1_mux;
-- architecture
architecture mux4t1 of my_4t1_mux is
begin
MX_OUT <= D3 when (SEL = "11") else
D2 when (SEL = "10") else
D1 when (SEL = "01") else
D0 when (SEL = "00") else
'0';
end mux4t1;
```

### 3. Selected Signal Assignment Statements 
General construction
```VHDL
with <choose_expression> select
target <= <expression> when <choices>,
          <expression> when <choices>;
```
Used in a program
```VHDL
-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
-- entity
entity my_4t1_mux is
port (D3,D2,D1,D0 : in std_logic;
SEL : in std_logic_vector(1 downto 0);
MX_OUT : out std_logic);
end my_4t1_mux;
-- architecture
architecture mux4t1_2 of my_4t1_mux is
begin
with SEL select
MX_OUT <= D3 when "11",
D2 when "10",
D1 when "01",
D0 when "00",
'0' when others;
end mux4t1_2;
```

### 4. Process Statement
Now just remember that the process statement is a statement which contains a certain number of instructions that, when the process statement is executed, are executed sequentially. In other words, the process statement is a tool that you can use any time you want to execute a certain number of instructions in a sequential manner (one instruction after the other, from top to bottom). Do not forget, however, that the process statement in itself is a concurrent statement and therefore will be executed together with the other concurrent statements in the body of the architecture where it sits.

General construction
```VHDL
-- this is my first process
my_label: process(sensitivity_list) is
<item_declaration>
begin
<sequential_statements>
end process my_label;
```
Used in a program
```VHDL
1 -- library declaration
2 library IEEE;
3 use IEEE.std_logic_1164.all;
4 -- entity
5 entity my_system is
6 port ( A,B,C : in std_logic;
7 F,Q : out std_logic);
8 end my_system;
9 -- architecture
10 architecture behav of my_system is
11 signal A1 : std_logic;
12 begin
13 some_proc: process(A,B,C) is
14 variable a,b : integer;
15 begin
16 a:=74;
17 b:=67;
18 A1 <= A and B and C;
19 if a>b then
20 F <= A1 or B;
21 end if;
22 end process some_proc;
23 -- we are outside the process body
24 Q <= not A;
25 end behav;
```
You should strive to keep your process statements simple. Divide up your intended functionality into several process statements that communicate with each other rather than one giant, complicated, bizarre process statement. Remember, process statements are concurrent statements: they all can be executed concurrently. Try to take advantage of this feature in order to simplify your circuit descriptions.

# Three Types of Sequential Statements
- Signal Assignment Statement
- If Statement
- Case Statement

### 1. Signal Assignment Statement
General construction
```VHDL
<=
```
Used in a program
```VHDL
A <= B;
```
The sequential style of a signal assignment statement is syntactically equivalent to the concurrent signal assignment statement. Another way to look at it is that if a signal assignment statement appears inside of a process then it is a sequential statement; otherwise, it is a concurrent signal assignment statement.

### 2. If Statement
General construction
```VHDL
<=
```
Used in a program
```VHDL
A <= B XOR C;
```

### 3. Case Statement
General construction
```VHDL
<=
```
Used in a program
```VHDL
A <= B;
```
