
vlib work
vlog -sv +acc  "seven_segment_display.v"
vlog -sv +acc  "seven_segment_display_tb.v"

vsim -novopt -t 1ps -lib work seven_segment_display_tb
#do {seven_segment_display_wave.do}
view wave
view structure
view signals
log -r *
do seven_segment_display_wave.do
run 400ns
WaveRestoreZoom {0 ps} {100 ns}