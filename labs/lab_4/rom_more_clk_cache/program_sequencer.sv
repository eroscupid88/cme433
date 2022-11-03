module program_sequencer(
input clk, sync_reset, jump,conditional_jump,dont_jump_flag,
input [3:0] jump_addr,
output reg [7:0] rom_address,pm_address,
output reg [7:0] from_PS,
output reg [7:0] pc,
output reg hold_out,start_hold,end_hold,hold,cache_wren,run,
output reg [1:0] pc_count,
output reg [4:0] cache_rdoffset,cache_wroffset,sync_reset_1,reset_1shot,
output reg [6:0] hold_count
);
//wire start_hold,
//		end_hold,
//		hold;
//wire [4:0] hold_count;
//wire [1:0] pc_count;
always @ *
	cache_wroffset = hold_count[6:2];
	
always @*
	cache_rdoffset = pm_address[4:0];
	
always @*
	if (hold == 1'b1 && run == 1'b1)
		cache_wren = 1'b1;
	else
		cache_wren = 1'b0;
	
always @ (posedge clk)
	sync_reset_1 = sync_reset;
	
always @ (posedge clk)
	if (reset_1shot)
		pc_count = 0;
	else if (hold)
		pc_count = pc_count + 1;
	else
		pc_count = pc_count;
		
always @ *
	if (pc_count == 3)
		run = 1'b1;
	else
		run = 1'b0;

always @*
	if ((sync_reset) && (sync_reset_1 == 1'b0))
		reset_1shot = 1'b1;
	else
		reset_1shot = 1'b0;
	
always @ *
	begin
		from_PS = 8'h00;
		if ((pc[7:5] != pm_address[7:5]) || (reset_1shot))
			start_hold <= 1'b1;
		else 
			start_hold <= 1'b0;
	end
	
always @*
	if (reset_1shot)
		rom_address = 0;
//	else if (start_hold)
//		rom_address = {pm_address[7:5],5'd0};
	else if (sync_reset)
		rom_address = {3'd0,hold_count[6:2]};
	else
		rom_address = {pc[7:5],hold_count[6:2]};

always @(posedge clk)
	if (reset_1shot == 1'b1)
		hold_count = 7'd0;
	else if (hold == 1'b1)
		hold_count = hold_count + 1;
	else if  (hold_count == 7'd127)
		hold_count = 7'd0;
	else
		hold_count = hold_count;
		

always @*
	if ((hold_count == 7'd127) && (hold == 1'b1))
		end_hold <= 1'b1;
	else
		end_hold <= 1'b0;

always @ ( posedge clk)
	if (start_hold == 1'b1)
		hold = 1'b1;
	else if (end_hold == 1'b1)
		hold = 1'b0;
	else
		hold = hold;
	
always @ (posedge clk)
	pc <= pm_address;
	
always @ *
	if ((start_hold == 1'b1) || (hold ==1'b1) && (end_hold == 1'b0))	
		hold_out = 1'b1;
	else
		hold_out = 1'b0;
		
		
always @ *
	if(sync_reset == 1'b1)
		pm_address  <= 8'h00;
	else if(jump == 1'b1)
		pm_address <= {jump_addr,4'h0};
	else if ((conditional_jump == 1'b1) && (dont_jump_flag ==1'b0))
		pm_address <= {jump_addr,4'h0};
	else if (hold == 1'b1)
		pm_address <= pc;
	else if (((jump == 1'b0) && (conditional_jump == 1'b0)) || (dont_jump_flag ==1'b1))
		pm_address <= pc + 8'h01;
	else
		pm_address <= pc + 8'h01;			
endmodule








