
# ee354_numlock_sm.do

quit -sim

vlib work
vlog +acc  "ee354_numlock_sm.v"
vlog +acc  "ee354_numlock_sm_tb.v"
# vsim  work.ee354_numlock_sm_tb
vsim -novopt -t 1ps -lib work ee354_numlock_sm_tb
do {ee354_numlock_sm_wave.do}
view wave
view structure
view signals
log -r *
run 2 us
WaveRestoreZoom {0 ps} {2000 ns}