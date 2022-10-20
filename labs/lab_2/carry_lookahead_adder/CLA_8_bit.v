module CLA_8_bit(
	input wire C0,
	input wire [7:0]p,g,
	output wire [6:0]C_out,
	output wire Cout,
	output wire G,P
);
wire G_wire; 
wire P_wire;
assign	 C_out[0] = g[0] | (p[0] & C0);
assign	 C_out[1] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & C0);
assign	 C_out[2] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) |(p[2] & p[1] & p[0] & C0);
assign	 C_out[3] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) |(p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & C0);
assign	 C_out[4] = g[4] | (p[4] & g[3]) | (p[4] & p[3] & g[2]) |(p[4] & p[3] & p[2] & g[1]) | (p[4] & p[3] & p[2] & p[1] & g[0])| (p[4] & p[3] & p[2] & p[1] & p[0] & C0);
assign	 C_out[5] = g[5] | (p[5] & g[4]) | (p[5] & p[4] & g[3]) |(p[5] & p[4] & p[3] & g[2]) | (p[5] & p[4] & p[3] & p[2] & g[1])| (p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) | (p[5] & p[4] & p[3] & p[2] & p[1] & C0);
assign	 C_out[6] = g[6] | (p[6] & g[5]) | (p[6] & p[5] & g[4]) |(p[6] & p[5] & p[4] & g[3]) | (p[6] & p[5] & p[4] & p[3] & g[2])| (p[6] & p[5] & p[4] & p[3] & p[2] & g[1]) | (p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & g[0]) |  (p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & C0);


assign	 P_wire = p[6] & p[5] & p[4] & p[3] & p[2] & p[1] & p[0];
assign	 G_wire = g[6] | (p[6] & g[5]) | (p[6] & p[5] & g[4] ) | (p[6] & p[5] & p[4] & g[3]) | (p[6] & p[5] & p[4] & p[3] & g[2]) | (p[6] & p[5] & p[4] & p[3] & p[2] & g[1])  | (p[6] & p[5] & p[4] & p[3] & p[2] & p[1]& g[0]);
assign	 Cout = G_wire | (P_wire & C0);
assign	 P = P_wire;
assign	 G = G_wire;

endmodule
