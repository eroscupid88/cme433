module CME341_latest_microprocessor(
input clk, reset,
input [3:0] i_pins,
output reg [3:0] o_reg,
output reg [7:0] pm_data,
output reg [7:0] pm_address,
output reg [7:0] pc,
output reg [7:0] from_PS,
output reg [7:0] ir,
output reg [8:0] reg_enables,
output reg NOPC8,
output reg NOPCF,
output reg NOPD8,
output reg NOPDF,
output reg [7:0]from_CU,
output reg zero_flag

);
reg sync_reset;
wire jump,conditional_jump,i_mux_select,y_reg_select,x_reg_select;

wire [3:0] LS_nibble_ir,source_select,data_mem_addr,data_bus,dm;


always @(posedge clk)
		sync_reset = reset;

 

program_sequencer prog_sequencer(.clk(clk),
											.sync_reset(sync_reset),
											.dont_jmp(zero_flag),
											.jmp(jump),
											.jmp_nz(conditional_jump),
											.jmp_addr(LS_nibble_ir),
											.pm_addr(pm_address),
											.pc(pc),
											.from_PS(from_PS));
											
									

											
program_memory prog_mem(.clock(~clk),
								.address(pm_address),
								.q(pm_data));
								
instruction_decoder instr_decoder(.clk(clk),
											 .sync_reset(sync_reset),
											 .next_instr(pm_data),
											 .jmp(jump),
											 .jmp_nz(conditional_jump),
											 .ir_nibble(LS_nibble_ir),
											 .i_sel(i_mux_select),
											 .y_sel(y_reg_select),
											 .x_sel(x_reg_select),
											 .source_sel(source_select),
											 .reg_en(reg_enables),
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
									  .reg_en(reg_enables),
									  .dm(dm),							
									  .r_eq_0(zero_flag),
									  .data_bus(data_bus),
									  .o_reg(o_reg),
									  .i(data_mem_addr),  // i
									  .x0(x0),.x1(x1),.y0(y0),.y1(y1),.r(r),.m(m),.from_CU(from_CU)
									  );
									  
									  
data_memory data_mem(.clock(~clk),
							.address(data_mem_addr),
							.data(data_bus),
							.wren(reg_enables[7]),
							.q(dm));

							
							
endmodule