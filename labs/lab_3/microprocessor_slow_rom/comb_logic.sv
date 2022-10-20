module comb_logic(
	output reg [7:0] output_data_out /* synthesis keep*/,
	input [7:0] input_data_in
);
	wire[7:0] delay [63:0] /* synthesis keep*/;
  
	assign delay[0] = input_data_in;
  
	always @ (delay[63])
		output_data_out = delay[63];
  
	genvar i;
	generate
    for (i = 0; i<63; i=i+1) begin: begin_delay
			always @*
					$display("%d",i);
					not inverter(delay[i+1],delay[i]);
		end
	endgenerate


endmodule
