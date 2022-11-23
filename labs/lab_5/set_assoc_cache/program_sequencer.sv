module program_sequencer(
input clk, sync_reset, jump,conditional_jump,dont_jump_flag,
input [3:0] jump_addr,
output reg [7:0] rom_address,pm_address,
output reg [7:0] from_PS,
output reg [7:0] pc,
output reg hold_out,start_hold,end_hold,hold,cache_wren,sync_reset_1,reset_1shot,
output reg [2:0] cache_rdoffset,cache_wroffset,hold_count,
output reg [1:0] cache_wrline,cache_rdline,
output reg cache_rdentry,
output reg cache_wrentry

//output reg [2:0]tagID[3:0],
//output reg valid [3:0]
);
//wire start_hold,
//		end_hold,
//		hold;
//wire [4:0] hold_count;
//wire cache_rdentry,
//wire cache_wrentry

reg [3:0] tagID [1:0][1:0];
reg valid [1:0][1:0];

always @ *
	cache_wroffset = hold_count;
always @*
	cache_rdoffset = pm_address[2:0];
always @*
	cache_wren = hold;
	
	
always @ (posedge clk)
	if (reset_1shot) 
		begin
			tagID[0][0] = 4'd0;
		   tagID[0][1] = 4'd0;
			tagID[1][0] = 4'd0;
			tagID[1][1] = 4'd0;
		end
   else if (start_hold)
      tagID[pm_address[3]] [~lastused[pm_address[3]]] <= pm_address[7:4];
	else
		begin
			tagID[0][0] = tagID[0][0];
		   tagID[0][1] = tagID[0][1];
			tagID[1][0] = tagID[1][0];
			tagID[1][1] = tagID[1][1];
		end

always @ (posedge clk)
	if (reset_1shot)
		begin
			valid[0][0] <= 1'b0;
			valid[0][1] <= 1'b0;
			valid[1][0] <= 1'b0;
			valid[1][1] <= 1'b0;
		end
	else if (end_hold)
		valid[pm_address[3]][~lastused[pm_address[3]]] = 1'b1;
	else
		begin
			valid[0][0] <= valid[0][0];
			valid[0][1] <= valid[0][1];
			valid[1][0] <= valid[1][0];
			valid[1][1] <= valid[1][1];
		end
		
// search for current entry
(* keep *)reg currdentry;
always @ *
	begin
		if(pm_address[3] == 1'b0)
			begin
				if(tagID[0][0] == pm_address[7:4])
				currdentry <= 1'b0;
				else
				currdentry <= 1'b1;
			end
		else
			begin
				if(tagID[1][0] == pm_address[7:4])
					currdentry <= 1'b0;
				else
					currdentry <= 1'b1;
			end
	end
	
// last used
(* noprune *)reg lastused[0:1];
always @ (posedge clk)
	begin
		if(reset_1shot == 1'b1)
			lastused[0] <= 1'b1;
		else if(pm_address[3] == 1'b0 && hold == 1'b0 && start_hold == 1'b0)
			lastused[0] <= currdentry;
		else if(pm_address[3] == 1'b0 && end_hold == 1'b1)
			lastused[0] <= ~lastused[0];
		else
			lastused[0] <= lastused[0];
	end
	
always @ (posedge clk)
	begin
		if(reset_1shot == 1'b1)
			lastused[1] <= 1'b1;
		else if(pm_address[3] == 1'b1 && hold == 1'b0 && start_hold == 1'b0)
			lastused[1] <= currdentry;
		else if(pm_address[3] == 1'b1 && end_hold == 1'b1)
			lastused[1] <= ~lastused[1];
		else
			lastused[1] <= lastused[1];
	end
			

always @*
	cache_wrline <= pc[3:3];
always @*
	cache_rdline <= pm_address[3:3];
always @*
	cache_rdentry <= currdentry;
always @*
	cache_wrentry <= ~lastused[pm_address[3]];
	
	
always @ (posedge clk)
	sync_reset_1 = sync_reset;

always @*
	if ((sync_reset) && (sync_reset_1 == 1'b0))
		reset_1shot = 1'b1;
	else
		reset_1shot = 1'b0;
	
always @ *
	begin
		from_PS = 8'h00;
		if (reset_1shot)
			start_hold <= 1'b1;
		else if (tagID [pm_address[3]][currdentry] != pm_address[7:4])
			start_hold <= 1'b1;
		else if ((hold == 1'b0) && (valid [pm_address[3]][currdentry] == 1'b0))
			start_hold <= 1'b1;
		else 
			start_hold <= 1'b0;
	end
	
always @*
	if (reset_1shot)
		rom_address = 8'd0;
	else if (start_hold)
		rom_address = {pm_address[7:3],3'd0};
	else if (sync_reset)
		rom_address = {5'd0,hold_count+3'd1};
	else
		rom_address = {tagID [pc[3]][~lastused[pc[3]]] ,pc[3], hold_count + 3'd1};

always @(posedge clk)
	if (reset_1shot == 1'b1)
		hold_count = 3'd0;
	else if (hold == 1'b1)
		hold_count = hold_count + 1;
	else if  (hold_count == 3'd7)
		hold_count = 3'd0;
	else
		hold_count = hold_count;
		

always @*
	if ((hold_count == 3'd7) && (hold == 1'b1))
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
	if (((start_hold == 1'b1) || (hold ==1'b1)) && (end_hold == 1'b0))	
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








