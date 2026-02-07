onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /seven_segment_display_tb/hex_tb
add wave -noupdate -radix hexadecimal /seven_segment_display_tb/Cout_tb
add wave -noupdate -radix unsigned /seven_segment_display_tb/test_num
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {190000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 252
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {420 ns}
