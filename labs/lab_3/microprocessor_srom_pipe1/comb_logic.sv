module comb_logic(
	output reg [7:0] output_data_out /* synthesis keep*/,
	input [7:0] input_data_in
);
	wire[7:0] delay [63:0] /* synthesis keep*/;
  
	assign delay[0] = input_data_in;
  
	always @ (*)
		output_data_out = delay[62];
  
	genvar i;
	generate
    for (i = 1; i<63; i=i+1) begin: begin_delay
			assign delay[i] = ~delay[i-1];
		end
	endgenerate


endmodule
