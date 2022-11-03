module program_sequencer(
input clk, sync_reset, jump,conditional_jump,dont_jump_flag,
input [3:0] jump_addr,
output reg [7:0] pm_address,
output reg [7:0] from_PS,
output reg [7:0] pc,
output reg run,
output reg [1:0] pc_count
);
//reg [1:0] pc_count;
always @ *
	from_PS = 8'h00;
always @ (posedge clk)
	pc <= pm_address;
	
	
always @ (posedge clk)
		if (sync_reset)
			pc_count = 0;
		else
			pc_count = pc_count + 1;

    		
			
always @*
	if (pc_count == 2)
		run = 1'b1;
	else
		run = 1'b0;

always @ *
	if(sync_reset == 1'b1)
		pm_address  <= 8'h00;
	else if (pc_count == 3)
		begin
			if(jump == 1'b1)
				pm_address <= {jump_addr,4'h0};
			else if ((conditional_jump == 1'b1) && (dont_jump_flag ==1'b0))
				pm_address <= {jump_addr,4'h0};
			else if (((jump == 1'b0) && (conditional_jump == 1'b0)) || (dont_jump_flag ==1'b1))
				pm_address <= pc + 8'h01;
			else
				pm_address <= pc + 8'h01;
		end
	else
		pm_address = pc;
endmodule









