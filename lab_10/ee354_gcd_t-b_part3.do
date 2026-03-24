# ee254_gcd_tb_Part1.do 
vlib work 
vlog +acc  "ee354_GCD.v" 
vlog +acc  "ee354_GCD_tb_part3.v" 
vsim -t 1ps -lib ee354_GCD_CEN_tb_v
view objects 
view wave 
do {wave.do} 
log -r * 
run 580900ns