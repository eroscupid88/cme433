module Microprocessor(
input clk, 
input reset,
input [3:0] i_pins,
output reg [3:0] o_reg,
						x0,
						x1,
						y0,
						y1,
						r,
						m,
						i,
						data_bus,
output reg [7:0] pc,from_PS,from_ID,from_CU,ir,rom_address,cache_data,pm_data,pm_address,
output reg [8:0] register_enables,
output reg NOPC8,
output reg NOPCF,
output reg NOPD8,
output reg NOPDF,
output reg zero_flag,start_hold,end_hold,hold,hold_out,cache_wren,reset_1shot,sync_reset_1,run,sync_reset,
output reg [4:0] cache_wroffset,cache_rdoffset,
output reg [6:0] hold_count,
output reg [1:0] pc_count
);


//reg sync_reset;
wire jump,conditional_jump,i_mux_select,y_reg_select,x_reg_select;

wire [3:0] LS_nibble_ir,source_select,dm;

always @(posedge clk)
		sync_reset <= reset;		
		
cache cache(.clk(clk),
				.wren(cache_wren),
				.data(pm_data),
				.rdoffset(cache_rdoffset),
				.wroffset(cache_wroffset),
				.q(cache_data)
				);
program_sequencer prog_sequencer(.clk(clk),
											.sync_reset(sync_reset),
											.dont_jump_flag(zero_flag),
											.jump(jump),
											.run(run),
											.pc_count(pc_count),
											.conditional_jump(conditional_jump),
											.jump_addr(LS_nibble_ir),
											.rom_address(rom_address),
											.pm_address(pm_address),
											.pc(pc),
											.from_PS(from_PS),
											.hold_out(hold_out),
											.start_hold(start_hold),
											.end_hold(end_hold),
											.hold(hold),
											.hold_count(hold_count),
											.cache_wren(cache_wren),
											.cache_rdoffset(cache_rdoffset),
											.cache_wroffset(cache_wroffset),
											.sync_reset_1(sync_reset_1),
											.reset_1shot(reset_1shot)
											);
								
											
program_memory prog_mem(.clock(~clk),
								.address(rom_address),
								.q(pm_data)
								);
								
							
								
instruction_decoder instr_decoder(.clk(clk),
											 .sync_reset(sync_reset),
											 .hold_out(hold_out),
											 .pm_data(cache_data),
											 .jump(jump),
											 .conditional_jump(conditional_jump),
											 .LS_nibble_of_ir(LS_nibble_ir),
											 .i_mux_select(i_mux_select),
											 .y_mux_select(y_reg_select),
											 .x_mux_select(x_reg_select),
											 .source_register_select(source_select),
											 .register_enables(register_enables),
											 .ir(ir),
											 .from_ID(from_ID),
											 .NOPC8(NOPC8),
											 .NOPCF(NOPCF),
											 .NOPD8(NOPD8),
											 .NOPDF(NOPDF));
												 
computational_unit comp_unit(.clk(clk),
									  .sync_reset(sync_reset),
									  .i_pins(i_pins),
									  .nibble_ir(LS_nibble_ir),
									  .i_sel(i_mux_select),
									  .y_sel(y_reg_select),
									  .x_sel(x_reg_select),
									  .source_sel(source_select),
									  .reg_en(register_enables),
									  .dm(dm),							
									  .r_eq_0(zero_flag),
									  .data_bus(data_bus),
									  .o_reg(o_reg),
									  .i(i),  
									  .x0(x0),
									  .x1(x1),
									  .y0(y0),
									  .y1(y1),
									  .r(r),
									  .m(m),
									  .from_CU(from_CU),
									  .NOPC8(NOPC8),
									  .NOPCF(NOPCF),
									  .NOPD8(NOPD8),
									  .NOPDF(NOPDF)
									  );

									  
data_memory data_mem(.clock(~clk),
							.address(i),
							.data(data_bus),
							.wren(register_enables[7]),
							.q(dm));

							
							
endmodule
