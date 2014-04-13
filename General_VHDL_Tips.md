# General VHDL tips
[Source](http://ece.wpi.edu/~wrm/Courses/EE3810/geninfo/Welcome%20to%20the%20VHDL%20Language.pdf)

###### Use standardized data types
- Use std_logic instead of bit
- Use std_logic_vector instead of bit_vector

##### Set a design as Top Design
Right click on the desired .vhdl file and select *Set as Top Design* from the context menu.


##### Sweet and short VHDL reference
[VHDL Reference](https://www.ics.uci.edu/~jmoorkan/vhdlref/vhdl.html)

##### Signals are for connecting modules

```
One source of this confusion is that vhdl signals
(or verilog wires) are only strictly needed to wire up
entity/module instances in a structural design.

Signals/Wires are always required in a testbench
to hook up the UUT instance.
```
[Source](http://www.velocityreviews.com/forums/t516632-what-is-the-meaning-of-a-signal-in-vhdl.html)

###### Testing with Testbenches
It is possible to test code with manual simulations. However this is impractical when there are many variables to test. Add a Testbench (Right-Click > New Module > Testbench) as any other module. Remove all references to <clock> if no clocks are to be used. Our testing code goes in the section called **Stimulus process**.


###### Conditional signal assignment
The function of the comparator is defined using a simple concurrent assignment to 
port EQ. The type of statement used in the assignment to EQ is called a conditional 
signal assignment.
 
Conditional signal assignments make use of the when-else language feature and 
allow complex conditional logic to be described. The following VHDL description of a 
multiplexer makes the use of the conditional signal assignment more clear:

```VHDL 
architecture mux1 of mux is 
begin
 Y <= A when (Sel = "00") else
 B when (Sel = "01") else
 C when (Sel = "10") else
 D when (Sel = "11");
end mux1;
```
 
###### Selected signal assignment
Another form of signal assignment can be used as an alternative to the conditional 
signal assignment. The selected signal assignment has the following general form 
(again, using a multiplexer as an example):

```VHDL 
architecture mux2 of mux is
begin
 with Sel select
 Y <= A when "00",
 B when "01",
 C when "10",
 D when "11";
end mux2;
```
 
Choosing between a conditional or selected signal assignment for circuits such as this 
is largely a matter of taste. For most designs, there is no difference in the results 
obtained with either type of assignment statement. For some circuits, however, the 
conditional signal assignment can imply priorities that result in additional logic being 
required.

# Processes
The easiest way to think of a VHDL process such as this is to relate it to a small 
software program that executes (in simulation) any time there is an event on one of 
the process inputs, as specified in the sensitivity list. A process describes the 
sequential execution of statements that are dependent on one or more events 
occurring. A flip-flop is a perfect example of such a situation; it remains idle, not 
changing state, until there is a significant event (either a rising edge on the clock input 
or an asynchronous reset event) that causes it to operate and potentially change its 
state.
 
Although there is a definite order of operations within a process (from top to bottom), 
you can think of a process as executing in zero time. This means that (a) a process 
can be used to describe circuits functionally, without regard to their actual timing, and 
(b) multiple processes can be "executed" in parallel with little or no concern for which 
processes complete their operations first.

Let’s see how the process for our shifter operates. For your reference, the process is 
shown below:
 
```VHDL
reg: process(Rst,Clk)
begin
    if Rst = ‘1’ then -- Async reset
        Qreg <= "00000000";
    elsif (Clk = ‘1’ and Clk’event) then
        if (Load = ‘1’) then
            Qreg <= Data;
        else
            Qreg <= Qreg(1 to 7) & Qreg(0);
        end if;
    end if;
end process;
```
 
As written, the process is dependent on (or sensitive to) the asynchronous inputs Rst 
and Clk. These are the only signals that can have events directly affecting the 
operation of the circuit; in the absence of any event on either of these signals, the 
circuit described by the process will simply hold its current value (that is, the process 
will remain suspended).
 
Now let’s examine what happens when an event occurs on either one of these asynchronous inputs. First, consider what happens when the input Rst has an event in 
which it transitions to a high state (represented by the std_ulogic value of ‘1’). In this 
case, the process will begin execution and the first if statement will be evaluated. 
Because the event was a transition to ‘1’, the simulator will see that the specified 
condition (Rst = ‘1’) is true and the assignment of signal Qreg to the reset value of 
"00000000" will be performed. The remaining statements of the if-then-elsif 
expression (those that are dependent on the elsif condition) will be ignored. (The 
assignment statement immediately following the process, the assignment of output 
signal Q to the value of Qreg, is not subject to the if-then-elsif expression of the 
process or its sensitivity list, and is therefore valid at all times.) Finally, the process 
suspends, all signals that were assigned values in the process (in this case Qreg) are 
updated, and the process waits for another event on Clk or Rst.

asynchronous inputs. First, consider what happens when the input Rst has an event in 
which it transitions to a high state (represented by the std_ulogic value of ‘1’). In this 
case, the process will begin execution and the first if statement will be evaluated. 
Because the event was a transition to ‘1’, the simulator will see that the specified 
condition (Rst = ‘1’) is true and the assignment of signal Qreg to the reset value of 
"00000000" will be performed. The remaining statements of the if-then-elsif 
expression (those that are dependent on the elsif condition) will be ignored. (The 
assignment statement immediately following the process, the assignment of output 
signal Q to the value of Qreg, is not subject to the if-then-elsif expression of the 
process or its sensitivity list, and is therefore valid at all times.) Finally, the process 
suspends, all signals that were assigned values in the process (in this case Qreg) are 
updated, and the process waits for another event on Clk or Rst.

**VHDL requires that all processes include either a sensitivity list, or one or more wait statements to suspend the process. (It is not legal to have both a sensitivity list and a wait statement.)**

# Concurrent and sequential VHDL
Understanding the fundamental difference between concurrent and sequential 
statements in VHDL is important to making effective use of the language.
 
Concurrent statements are those statements that appear between the begin and end 
statements of a VHDL architecture. This area of your VHDL architecture is what is 
known as the concurrent area. In VHDL, all statements in the concurrent area are 
executed at the same time, and there is no significance to the order in which the 
statements are entered.
 
Sequential statements are executed one after the other in the order that they appear 
between the begin and end statements of a VHDL process, procecure or function.
 
The interaction of concurrent and sequential statements is illustrated in the example 
below. While the if-elsif-end-if statements in the body of the process are executed 
sequentially (i.e., one after the other), the body of the process is treated by VHDL as a 
single concurrent statement and is executed at the same time as all other concurrent 
statements in the simulation.

```VHDL
architecture rotate2 of rotate is
    signal Qreg: std_logic_vector(0 to 7);
begin -- Concurrent section starts here
    reg: process(Rst,Clk)
    begin -- Sequential section starts here
        if Rst = ‘1’ then -- Async reset
            Qreg <= "00000000";
        elsif (Clk = ‘1’ and Clk’event) then
            if (Load = ‘1’) then
            Qreg <= Data;
        else
            Qreg <= Qreg(1 to 7) & Qreg(0);
        end if;
    end if;
    end process; -- Sequential section ends here
    Q <= Qreg;
end rotate2; -- Concurrent section ends here
```

**Note:** Writing a description of a circuit using the sequential programming features of 
VHDL (statements entered within processes and subprograms) does not necessarily 
mean that the circuit being described is sequential in its operation. Sequential circuits 
require some sort of internal memory (such as one or more flip-flops or latches) to 
operate, and a VHDL process or subprogram may or may not imply such memory 
elements. As we will see in later chapters, it is actually quite common to describe 
strictly combinational circuits—circuits having no memory and, hence, no sequential 
behavior—using sequential statements within processes and subprograms.

# Design hierarchy
When you write structural VHDL, you are in essence writing a textual description of a 
schematic netlist (a description of how the components on the schematic are 
connected by wires, or nets). In the world of schematic entry tools, such netlists are 
usually created for you automatically by the schematic editor. When writing VHDL, you 
enter the same sort of information by hand. (Note: many schematic capture tools in 
existence today are capable of writing netlist information in the form of a VHDL source 
file. This can save you a lot of time if you are used to drawing block diagrams in a 
schematic editor.)
 
When you use components and wires (signals, in VHDL) to connect multiple circuit 
elements together, it is useful to think of your new, larger circuit in terms of a hierarchy 
of components. In this view, the top-level drawing (or top-level VHDL entity and 
architecture) can be seen as the highest level in a hierarchy.
 
In this example, we have introduced a new top-level component (called shiftcomp) 
that references the two lower-level components shift and compare. Because the new 
shiftcomp design entity can itself be viewed as a component, and considering the fact 
that any component can be referenced more than once, we quickly see how very large 
circuits can be constructed from smaller building blocks.
 
The following VHDL source file describes our complete circuit using structural VHDL 
statements (component declarations and component instantiations) to connect 
together the compare and shift portions of the circuit:

```VHDL 
library ieee;
use ieee.std_logic_1164.all;
entity shiftcomp is port(Clk, Rst, Load: in std_ulogic;
                        Init: in std_ulogic_vector(0 to 7);
                        Test: in std_ulogic_vector(0 to 7);
                        Limit: out std_ulogic);
end shiftcomp;

architecture structure of shiftcomp is

    component compare
        port(A, B: in std_ulogic_vector(0 to 7); EQ: out std_ulogic);
    end component;

    component shift
        port(Clk, Rst, Load: in std_ulogic;
            Data: in std_ulogic_vector(0 to 7);
            Q: out std_ulogic_vector(0 to 7));
    end component;

    signal Q: std_ulogic_vector(0 to 7);

begin

    COMP1: compare port map (A=>Q, B=>Test, EQ=>Limit);
    SHIFT1: shift port map (Clk=>Clk, Rst=>Rst, Load=>Load, Data=>Init, Q=>Q);

end structure;
```

Note: In the above context, the VHDL symbol => is used to associate the signals 
within an architecture to ports defined within the lower-level component.
 
There are many ways to express the interconnection of components and to improve 
the portability and reusability of those components. We will examine these more 
advanced uses of components in a later chapter.

# Test benches
At this point, our sample circuit is complete and ready to be processed by a synthesis 
tool. Before processing the design, however, we should take the time to verify that it 
actually does what it is intended to do, by running a simulation.

Simulating a circuit such as this one requires that we provide more than just the 
design description itself. To verify the proper operation of the circuit over time in 
response to input stimulus, we will need to write a test bench.
 
The easiest way to understand the concept of a test bench is to think of it as a virtual 
circuit tester. This tester, which you will describe in VHDL, applies stimulus to your 
design description and (optionally) verifies that the simulated circuit does what it is 
intended to do.
 
To apply stimulus to your design, your test bench will probably be written using one or 
more sequential processes, and it will use a series of signal assignments and wait 
statements to describe the actual stimulus. You will probably use VHDL’s looping 
features to simplify the description of repetitive stimulus (such as the system clock), 
and you may also use VHDL’s file and record features to apply stimulus in the form of 
test vectors.
 
To check the results of simulation, you will probably make use of VHDL’s assert 
feature, and you may also use the text I/O features to write the simulation results to a 
disk file for later analysis.
 
For complex design descriptions, developing a comprehensive test bench can be a 
large-scale project in itself. In fact, it is not unusual for the test bench to be larger and 
more complex than the underlying design description. For this reason, you should plan 
your project so that you have the time required to develop the test bench in addition to 
developing the circuit being tested. You should also plan to create test benches that 
are re-usable, perhaps by developing a master test bench that reads test data from a 
file.
 
When you create a test bench for your design, you use the structural level of 
abstraction to connect your lower-level (previously top-level) design description to the 
other parts of the test bench.

## Sample test bench
The following VHDL source statements, with explanatory comments, describe a 
simple test bench for our sample circuit:

```VHDL 
library ieee;
use ieee.std_logic_1164.all;
entity testbnch is -- No ports needed in a 
end testbnch; -- testbench 

use work.shiftcomp;
architecture behavior of testbnch is
    component shiftcomp is -- Declares the lower-level 
        port(Clk, Rst, Load: in std_logic; -- component and its ports
            Init: in std_logic_vector(0 to 7);
            Test: in std_logic_vector(0 to 7);
            Limit: out std_logic);
    end component;
    
    signal Clk, Rst, Load: std_logic; -- Introduces top-level signals 
    signal Init: std_logic_vector(0 to 7); -- to use when testing the 
    signal Test: std_logic_vector(0 to 7); -- lower-level circuit
    signal Limit: std_logic;
    
begin
    DUT: shiftcomp port map -- Creates an instance of the 
        (Clk, Rst, Load, Init, Test, Limit); -- lower-level circuit (the 
        -- unit under test)
    clock: process
        variable clktmp: std_logic := ‘0’; -- This process sets up a 
    begin -- background clock of 100 ns 
        clktmp := not clktmp; -- period.
        Clk <= clktmp;
        wait for 50 ns;
    end process;

    stimulus: process -- This process applies 
    begin -- stimulus to the design 
        Rst <= ‘0’; -- inputs, then waits for some 
        Load <= ‘1’; -- amount of time so we can 
        Init <= "00001111"; -- observe the results during 
        Test <= "11110000"; -- simulation.
        wait for 100 ns;
        Load <= ‘0’;
        wait for 600 ns;
    end process;
end behavior;
```
