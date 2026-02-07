onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ee354_numlock_sm_tb/Clk
add wave -noupdate /ee354_numlock_sm_tb/reset
add wave -noupdate /ee354_numlock_sm_tb/U
add wave -noupdate /ee354_numlock_sm_tb/Z
add wave -noupdate /ee354_numlock_sm_tb/q_I
add wave -noupdate /ee354_numlock_sm_tb/q_G1get
add wave -noupdate /ee354_numlock_sm_tb/q_G1
add wave -noupdate /ee354_numlock_sm_tb/q_G10get
add wave -noupdate /ee354_numlock_sm_tb/q_G10
add wave -noupdate /ee354_numlock_sm_tb/q_G101get
add wave -noupdate /ee354_numlock_sm_tb/q_G101
add wave -noupdate /ee354_numlock_sm_tb/q_G1011get
add wave -noupdate /ee354_numlock_sm_tb/q_G1011
add wave -noupdate /ee354_numlock_sm_tb/q_Opening
add wave -noupdate /ee354_numlock_sm_tb/q_Bad
add wave -noupdate /ee354_numlock_sm_tb/Unlock
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1290000 ps} 0} {{Cursor 2} {1610000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 63
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
WaveRestoreZoom {0 ps} {2 us}
