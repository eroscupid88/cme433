onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /microprocessor_tb/clk
add wave -noupdate -radix hexadecimal /microprocessor_tb/reset
add wave -noupdate -color Yellow -radix hexadecimal /microprocessor_tb/sync_reset_1
add wave -noupdate -radix hexadecimal /microprocessor_tb/i_pins
add wave -noupdate -radix unsigned /microprocessor_tb/hold_count
add wave -noupdate -radix hexadecimal /microprocessor_tb/cache_rdoffset
add wave -noupdate -radix hexadecimal /microprocessor_tb/cache_wroffset
add wave -noupdate -radix hexadecimal /microprocessor_tb/o_reg
add wave -noupdate -radix hexadecimal /microprocessor_tb/ir
add wave -noupdate -radix hexadecimal /microprocessor_tb/pc
add wave -noupdate -radix hexadecimal /microprocessor_tb/start_hold
add wave -noupdate -radix hexadecimal /microprocessor_tb/end_hold
add wave -noupdate -radix hexadecimal /microprocessor_tb/hold_out
add wave -noupdate -radix hexadecimal /microprocessor_tb/cache_wren
add wave -noupdate -radix hexadecimal /microprocessor_tb/reset_1shot
add wave -noupdate -radix hexadecimal /microprocessor_tb/rom_address
add wave -noupdate -radix hexadecimal /microprocessor_tb/cache_data
add wave -noupdate -color Blue -radix hexadecimal /microprocessor_tb/hold
add wave -noupdate -radix hexadecimal /microprocessor_tb/pm_address
add wave -noupdate /microprocessor_tb/run
add wave -noupdate /microprocessor_tb/pc_count
add wave -noupdate -radix hexadecimal /microprocessor_tb/pm_data
add wave -noupdate /microprocessor_tb/pc_count
add wave -noupdate /microprocessor_tb/sync_reset
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {77407749 ps} 0}
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
configure wave -timelineunits ps
update
WaveRestoreZoom {2500 ns} {1052500 ns}
