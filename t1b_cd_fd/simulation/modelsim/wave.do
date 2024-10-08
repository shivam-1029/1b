onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb/clk_1MHz
add wave -noupdate /tb/cs_out
add wave -noupdate /tb/filter
add wave -noupdate /tb/exp_filter
add wave -noupdate /tb/color
add wave -noupdate /tb/exp_color
add wave -noupdate /tb/error_count
add wave -noupdate /tb/i
add wave -noupdate /tb/j
add wave -noupdate /tb/fw
add wave -noupdate /tb/tp
add wave -noupdate /tb/k
add wave -noupdate /tb/l
add wave -noupdate /tb/m
add wave -noupdate /tb/counter
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9999999338 ps} 0}
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {10500 us}
