8/22/20, 9/10/2023

In Fall 2023, we started adding files to support the use of the A7 board besides the N4 board.
In an year, we will move to all A7 board.
While the .xdc file has several changes needed to port to A7 from N4,
the top Verilog file need a single change of removing "MemOE, MemWR, RamCS" while moving from the _N4 to _A7  top file.

The zip file should contain the following 9 files (3 common, 3+3=6 for N4 and A7 files):

ee354_detour_sm.v (the core design in verilog)
ee354_detour_sm_tb.v (the testbench for the core design)
ee354_detour_top_N4.v (the top design in verilog for the N4 board)
ee354_detour_top_A7.v (the top design in verilog for the A7 board)
ee354_detour_top_N4.xdc (the Xilinx Design Constraints file for the N4 board)
ee354_detour_top_A7.xdc (the Xilinx Design Constraints file for the A7 board)
TA_ee354_detour_top_N4.bit (the .bit file with the dot points constantly on)
TA_ee354_detour_top_A7.bit (the .bit file with the dot points constantly on)
README.txt (this file)