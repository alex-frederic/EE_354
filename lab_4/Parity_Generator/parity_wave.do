# This is invoked by parity.do
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned -radixshowbase 0 /parity_tb/X_tb
add wave -noupdate -divider Parity_values
add wave -noupdate -color White -height 20 -radix binary /parity_tb/p_tb
add wave -noupdate -color {Spring Green} -height 20 -radix binary /parity_tb/p_expected
add wave -noupdate -divider Just_a_Divider
add wave -noupdate -radix unsigned -radixshowbase 0 /parity_tb/i_tb
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {2525 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {2500 ns} {2570 ns}
