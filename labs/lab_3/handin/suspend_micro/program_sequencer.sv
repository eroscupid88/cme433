module program_sequencer(
input clk, sync_reset, jump,conditional_jump,dont_jump_flag,
input [3:0] jump_addr,
output reg [7:0] pm_address,
output reg [7:0] from_PS,
output reg [7:0] pc,
output reg hold_out,start_hold,end_hold,hold,
output reg [5:0] hold_count
);
//wire start_hold,
//		end_hold,
//		hold;
//wire [4:0] hold_count;

	
always @ *
	begin
		from_PS = 8'h00;
		if (pc[7:5] != pm_address[7:5])
			start_hold <= 1'b1;
		else 
			start_hold <= 1'b0;
	end

always @(posedge clk)
	if (sync_reset == 1'b1)
		hold_count <= 6'd0;
	else if (hold == 1'b1)
		hold_count = hold_count + 1;
	else if  (hold_count == 6'd31)
		hold_count = 6'd0;
	else
		hold_count = hold_count;
		

always @*
	if ((hold_count == 6'd30) && (hold == 1'b1))
		end_hold <= 1'b1;
	else
		end_hold <= 1'b0;

always @ ( posedge clk)
	if (sync_reset == 1'b1)
		hold = 1'b0;
	else if (start_hold == 1'b1)
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








