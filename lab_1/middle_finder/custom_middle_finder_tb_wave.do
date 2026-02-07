onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /middle_finder_tb/A_tb
add wave -noupdate /middle_finder_tb/B_tb
add wave -noupdate /middle_finder_tb/C_tb
add wave -noupdate /middle_finder_tb/MIDDLE_tb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 96
configure wave -valuecolwidth 40
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {31500 ps}
