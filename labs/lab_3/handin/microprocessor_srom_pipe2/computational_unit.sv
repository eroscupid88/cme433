module computational_unit(
input wire clk,
input wire sync_reset,
input wire i_sel,
input wire y_sel,
input wire x_sel, 
input wire NOPC8,NOPCF,NOPD8,NOPDF,
input wire [3:0] nibble_ir,
input wire [3:0] source_sel,
input wire [8:0] reg_en,
input wire [3:0] i_pins,
input wire [3:0] dm,
output reg [3:0] i, 
output reg [3:0] data_bus,
output reg [3:0] o_reg,
output reg r_eq_0,
output reg  [3:0] x0,
output reg  [3:0] x1,
output reg  [3:0] y0,
output reg  [3:0] y1,
output reg  [3:0] m,
output reg  [3:0] r,
output reg [7:0] from_CU

);



always @ *
	from_CU <= 8'H00;
	
reg  alu_out_eq_0;
reg [7:0] multiple_result;
reg [3:0] d_i,x,y,alu_out,pm_data;
			 
// pm_data

always @ *
	pm_data <= nibble_ir;			 
			 
		
// x0  

always @ (posedge clk)
	if (reg_en[0] == 1'b1)
		x0 <= data_bus;
	else
		x0 <= x0;	
		
		
// x1  


always @ (posedge clk)
	if (reg_en[1] == 1'b1)
		x1 <= data_bus;
	else
		x1 <= x1;
		
		
// y0  	

always @ (posedge clk)
	if (reg_en[2] == 1'b1)
		y0 <= data_bus;
	else
		y0 <= y0;


// y1  	


always @ (posedge clk)
	if (reg_en[3] == 1'b1)
		y1 <= data_bus;
	else
		y1 <= y1;


//x

always @ *
	case(x_sel)
	1'b0: x <= x0;
	1'b1: x <= x1;
	endcase
		
//y

always @ *
	case(y_sel)
	1'b0: y <= y0;
	1'b1: y <= y1;
	endcase
		
		

/*********** ALU   ***********/	


always @ *
	multiple_result <= x * y;
	
always @ *
	if (alu_out == 4'H0)
		alu_out_eq_0 <= 1'b1;
	else
		alu_out_eq_0 <= 1'b0;
		


always @ *
	// sync_reset button	
	if(sync_reset == 1'b1)
		alu_out<= 4'H0;	
	else if(nibble_ir == 4'b0000)
		alu_out <= -x;
	else if (nibble_ir == 4'b1000)
		alu_out <= r;
	else if (nibble_ir[2:0] == 3'b001)
		alu_out <= x-y;
	else if (nibble_ir[2:0] == 3'b010)
		alu_out <= x+y;
	else if (nibble_ir[2:0] == 3'b011)
		alu_out <= multiple_result [7:4];
	else if (nibble_ir[2:0] == 3'b100)
		alu_out <= multiple_result [3:0];
	else if  (nibble_ir[2:0] == 3'b101)
		alu_out <= x^y;
	else if  (nibble_ir[2:0] == 3'b110)
		alu_out <= x&y;
	else if (nibble_ir == 4'b0111)
		alu_out <= ~x;
	else if (nibble_ir == 4'b1111)
		alu_out <= r;
	else
		alu_out <=r;		
		
		
	
// data_bus								  

always @ *
	case(source_sel)
	4'd00: data_bus <= x0;
	4'd01: data_bus <= x1;
	4'd02: data_bus <= y0;
	4'd03: data_bus <= y1;
	4'd04: data_bus <= r;
	4'd05: data_bus <= m;
	4'd06: data_bus <= i;
	4'd07: data_bus <= dm;
	4'd08: data_bus <= pm_data;
	4'd09: data_bus <= i_pins;
	default: data_bus <= 4'H0;
	endcase
	


//o_reg							  

always @ (posedge clk)
	if (reg_en[8] == 1'b1)
		o_reg <= data_bus;
	else
		o_reg <= o_reg;
		
//d_i  & i
		
		
always @ *
	case (i_sel)
	1'b0: d_i <= data_bus;
	1'b1: d_i <= i + m;
	endcase
		
always @ (posedge clk)
	if (reg_en[6] == 1'b1)
		i <= d_i;
	else
		i <= i;

		
//m	
			
always @ (posedge clk)
	if (reg_en[5] == 1'b1)
		m <= data_bus;
	else
		m <= m;
		
//r
			
always @ (posedge clk)
	if (reg_en[4] == 1'b1)
		r <= alu_out;
	else
		r <= r;

// r_eq_0	
			
always @ (posedge clk)
	if (reg_en[4] == 1'b1)
		r_eq_0 <= alu_out_eq_0;
	else
		r_eq_0 <= r_eq_0;


		
endmodule
		

