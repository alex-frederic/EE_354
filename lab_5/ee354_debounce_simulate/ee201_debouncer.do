# File name: ee201_debouncer.do

vlib work
vlog +acc  ee201_debounce_DPB_SCEN_CCEN_MCEN.v
vlog +acc  ee201_debounce_DPB_SCEN_CCEN_MCEN_tb.v

vsim -novopt -t 1ps -lib work ee201_debounce_DPB_SCEN_CCEN_MCEN_tb 
do ee201_debouncer_wave.do 
run 1us

 