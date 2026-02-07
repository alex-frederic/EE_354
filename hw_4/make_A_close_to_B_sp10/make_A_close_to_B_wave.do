onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /make_A_close_to_B_tb/Ain_tb
add wave -noupdate -radix unsigned /make_A_close_to_B_tb/Bin_tb
add wave -noupdate -radix unsigned /make_A_close_to_B_tb/A_tb
add wave -noupdate -radix binary -radixshowbase 0 /make_A_close_to_B_tb/Start_tb
add wave -noupdate -radix binary -radixshowbase 0 /make_A_close_to_B_tb/Ack_tb
add wave -noupdate -radix binary -radixshowbase 0 /make_A_close_to_B_tb/Clk_tb
add wave -noupdate -radix binary -radixshowbase 0 /make_A_close_to_B_tb/Reset_tb
add wave -noupdate -radix binary -radixshowbase 0 /make_A_close_to_B_tb/Flag_tb
add wave -noupdate -radix binary -radixshowbase 0 /make_A_close_to_B_tb/Qi_tb
add wave -noupdate -radix binary -radixshowbase 0 /make_A_close_to_B_tb/Qc_tb
add wave -noupdate -radix binary -radixshowbase 0 /make_A_close_to_B_tb/Qd_tb
add wave -noupdate -radix ascii -radixshowbase 0 /make_A_close_to_B_tb/state_string
add wave -noupdate -radix unsigned -radixshowbase 0 /make_A_close_to_B_tb/Clk_cnt
add wave -noupdate -radix unsigned -radixshowbase 0 /make_A_close_to_B_tb/test_number
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {700 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 85
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
WaveRestoreZoom {0 ns} {935 ns}
