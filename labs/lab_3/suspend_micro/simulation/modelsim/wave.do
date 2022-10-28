onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /microprocessor_tb/clk
add wave -noupdate /microprocessor_tb/reset
add wave -noupdate /microprocessor_tb/i_pins
add wave -noupdate /microprocessor_tb/hold_count
add wave -noupdate /microprocessor_tb/o_reg
add wave -noupdate /microprocessor_tb/ir
add wave -noupdate /microprocessor_tb/pc
add wave -noupdate /microprocessor_tb/hold_out
add wave -noupdate /microprocessor_tb/start_hold
add wave -noupdate /microprocessor_tb/end_hold
add wave -noupdate /microprocessor_tb/hold
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0} {{Cursor 2} {16789668 ps} 0}
quietly wave cursor active 2
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
WaveRestoreZoom {0 ps} {52306273 ps}
