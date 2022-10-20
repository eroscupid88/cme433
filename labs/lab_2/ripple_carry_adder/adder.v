module adder(A,B,C_in,clk,S,C_out);
input wire A,B,C_in,clk;
output reg S,C_out;
always @ (posedge clk) 
	begin
		S = (A ^ B) ^ C_in;
		C_out = ((A ^ B) & C_in ) | (A & B);
	end
endmodule
