onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned -radixshowbase 1 /largest_num_divisible_by_7_tb/Max_tb
add wave -noupdate -radix binary -radixshowbase 0 /largest_num_divisible_by_7_tb/Start_tb
add wave -noupdate -radix binary -radixshowbase 0 /largest_num_divisible_by_7_tb/Ack_tb
add wave -noupdate -radix binary -radixshowbase 0 /largest_num_divisible_by_7_tb/Clk_tb
add wave -noupdate -radix binary -radixshowbase 0 /largest_num_divisible_by_7_tb/Reset_tb
add wave -noupdate -radix binary -radixshowbase 0 /largest_num_divisible_by_7_tb/Qi_tb
add wave -noupdate -radix binary -radixshowbase 0 /largest_num_divisible_by_7_tb/Ql_tb
add wave -noupdate -radix binary -radixshowbase 0 /largest_num_divisible_by_7_tb/Qdiv_tb
add wave -noupdate -radix binary -radixshowbase 0 /largest_num_divisible_by_7_tb/Qdf_tb
add wave -noupdate -radix binary -radixshowbase 0 /largest_num_divisible_by_7_tb/Qdnf_tb
add wave -noupdate -radix ascii -radixshowbase 0 /largest_num_divisible_by_7_tb/state_string
add wave -noupdate -radix unsigned -radixshowbase 1 /largest_num_divisible_by_7_tb/Clk_cnt
add wave -noupdate -radix unsigned -radixshowbase 0 /largest_num_divisible_by_7_tb/test_number
add wave -noupdate -radix unsigned /largest_num_divisible_by_7_tb/UUT/X
add wave -noupdate -radix unsigned /largest_num_divisible_by_7_tb/UUT/I
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {95 ns} 0} {{Cursor 2} {11950 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
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
WaveRestoreZoom {0 ps} {14000 ns}
