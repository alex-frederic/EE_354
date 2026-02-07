#parity.do

vlib work
vlog  "parity_ones_count.v"  
vlog  "parity_tb.v" 
vsim -novopt -t 1ps -lib work parity_tb

view wave
view structure
view signals

do {parity_wave.do}
log -r *

run 2560ns



