# TIMER IP VIA APB PROTOCOL
Timer is an essential module for every chip.
This is used to generate accurate timing interval or controlling the timing of various operations within the circuit. Timer can be used in various application: pulse generation, delay generation, event generation, PWM generation, Interrupt generation ….
In this project, a timer module is customized from CLINT module of industrial RISC-V architecture. It is used to generate interrupt based on user settings.
The spec of CLINT can be referred at: https://chromitem-soc.readthedocs.io/en/latest/clint.html
The timer has following features:
64-bit count-up
12-bit address
Register set is configured via APB bus (IP is APB slave)
Support wait state (1 cycle is enough) and error handling
Support byte access
Support halt (stop) in debug mode
Timer uses active low async reset
Counter can be counted based on the system clock or divided up to 256
Support timer interrupt (can be enabled or disabled)
Coverage achieved is 100%
