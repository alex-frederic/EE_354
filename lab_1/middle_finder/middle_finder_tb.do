# middle_finder_tb.do 

vlib work
vlog +acc  "middle_finder.v"   
vlog +acc  "middle_finder_tb.v" 
vsim -novopt -t 1ps -lib work middle_finder_tb

view wave 
view structure
view signals
# add wave -r /*
do middle_finder_tb_wave.do 
log -r *

run 30 ns