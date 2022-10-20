module CLA_adder(
input wire a,b,Cin,clk,
output reg s,p,g
);

always @(posedge clk) 
begin
	 p = a^b;
	 g = a&b;
	 s = p ^Cin;
end
endmodule