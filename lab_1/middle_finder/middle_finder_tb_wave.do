onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /middle_finder_tb/A_tb
add wave -noupdate -radix unsigned /middle_finder_tb/B_tb
add wave -noupdate -radix unsigned /middle_finder_tb/C_tb
add wave -noupdate -radix unsigned /middle_finder_tb/MIDDLE_tb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 2} {14000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 48
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
WaveRestoreZoom {0 ps} {33200 ps}
