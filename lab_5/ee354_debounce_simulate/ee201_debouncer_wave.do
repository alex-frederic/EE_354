onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ee201_debounce_DPB_SCEN_CCEN_MCEN_tb/Clk_tb
add wave -noupdate /ee201_debounce_DPB_SCEN_CCEN_MCEN_tb/Reset_tb
add wave -noupdate /ee201_debounce_DPB_SCEN_CCEN_MCEN_tb/PB_tb
add wave -noupdate /ee201_debounce_DPB_SCEN_CCEN_MCEN_tb/DPB_tb
add wave -noupdate /ee201_debounce_DPB_SCEN_CCEN_MCEN_tb/SCEN_tb
add wave -noupdate /ee201_debounce_DPB_SCEN_CCEN_MCEN_tb/MCEN_tb
add wave -noupdate /ee201_debounce_DPB_SCEN_CCEN_MCEN_tb/CCEN_tb
add wave -noupdate -radix ascii /ee201_debounce_DPB_SCEN_CCEN_MCEN_tb/state_string
add wave -noupdate -radix decimal /ee201_debounce_DPB_SCEN_CCEN_MCEN_tb/Clk_cnt
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 115
configure wave -valuecolwidth 50
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1000 ns}
