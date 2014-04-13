#### Run a process only once
The process should have no inputs (sensitivities) and end with a wait statement. Run once is great for *setup* style functionality. In this example the reset button is LOW for 100ns and then HIGH forever.
```VHDL
run_once : process
begin
    reset <= '0';
    wait for clock_period;
    reset <= '1';
    -- wait forever
    wait; 
end process;
```

#### Run a process repeatedly
This example is not dependant on sensitivities. The signal will toggle every 50ns.
```VHDL
run_repeatedly : process
begin
    clock <= '0';
    wait for clock_period/2;
    clock <= '1';
    wait for clock_period/2;
end process;
```

Both examples are using the following clock definition:
```VHDL
constant clock_period : time := 100ns;
```
