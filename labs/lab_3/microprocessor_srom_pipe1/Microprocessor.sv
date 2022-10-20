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
output reg [7:0] pm_data_out,pm_address_out,pc,from_PS,from_ID,from_CU,ir,
output reg [8:0] register_enables,
output reg NOPC8,
output reg NOPCF,
output reg NOPD8,
output reg NOPDF,
output reg zero_flag
);


reg sync_reset,flush_pipeline;
wire jump,conditional_jump,i_mux_select,y_reg_select,x_reg_select;

wire [3:0] LS_nibble_ir,source_select,dm;
wire [7:0] pm_address,pm_data,data_pipe,pm_data_delay;

always @(posedge clk)
		sync_reset <= reset;
		
always @ (posedge clk)
	data_pipe <= pm_data;
	
always @ (*)
	if (flush_pipeline)
		pm_data_out = 8'HC8;
	else
		pm_data_out = pm_data_delay;
	
always @ (*)
	if ( jump || conditional_jump)
		flush_pipeline = 1;
	else
		flush_pipeline = 0;
	

program_sequencer prog_sequencer(.clk(clk),
											.sync_reset(sync_reset),
											.dont_jump_flag(zero_flag),
											.jump(jump),
											.conditional_jump(conditional_jump),
											.jump_addr(LS_nibble_ir),
											.pm_address(pm_address),
											.pc(pc),
											.from_PS(from_PS));
											
comb_logic comb_logic1(
								.output_data_out(pm_address_out),
								.input_data_in(pm_address)
								);								
											
program_memory prog_mem(.clock(~clk),
								.address(pm_address_out),
								.q(pm_data)
								);
								
comb_logic comb_logic2(.output_data_out(pm_data_delay),
								.input_data_in(data_pipe)
								);								
								
instruction_decoder instr_decoder(.clk(clk),
											 .sync_reset(sync_reset),
											 .pm_data(pm_data_out),
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
