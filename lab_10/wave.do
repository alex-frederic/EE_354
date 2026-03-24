onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ee354_GCD_CEN_tb_v/Clk
add wave -noupdate -radix unsigned -radixshowbase 0 /ee354_GCD_CEN_tb_v/clk_cnt
add wave -noupdate /ee354_GCD_CEN_tb_v/Reset
add wave -noupdate /ee354_GCD_CEN_tb_v/Start
add wave -noupdate /ee354_GCD_CEN_tb_v/Ack
add wave -noupdate -radix ascii -radixshowbase 0 /ee354_GCD_CEN_tb_v/state_string
add wave -noupdate -radix unsigned -radixshowbase 0 /ee354_GCD_CEN_tb_v/Ain
add wave -noupdate -radix unsigned -radixshowbase 0 /ee354_GCD_CEN_tb_v/Bin
add wave -noupdate -radix unsigned -radixshowbase 0 /ee354_GCD_CEN_tb_v/start_clock_cnt
add wave -noupdate -radix unsigned -radixshowbase 0 /ee354_GCD_CEN_tb_v/clocks_taken
add wave -noupdate /ee354_GCD_CEN_tb_v/CEN
add wave -noupdate /ee354_GCD_CEN_tb_v/i_count
add wave -noupdate -radix unsigned -radixshowbase 0 /ee354_GCD_CEN_tb_v/A
add wave -noupdate -radix unsigned -radixshowbase 0 /ee354_GCD_CEN_tb_v/B
add wave -noupdate -radix unsigned -radixshowbase 0 /ee354_GCD_CEN_tb_v/AB_GCD
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {315 ns}
