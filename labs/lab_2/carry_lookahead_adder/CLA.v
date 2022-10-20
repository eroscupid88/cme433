module CLA(
input wire C0,
input wire [3:0]p,g,
output wire [2:0]C_out,
output wire Cout,
output wire G,P
);
wire G_wire; 
wire P_wire;
assign	 C_out[0] = g[0] | (p[0] & C0);
assign	 C_out[1] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & C0);
assign	 C_out[2] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) |(p[2] & p[1] & p[0] & C0);
assign	 P_wire = p[3] & p[2] & p[1] & p[0];
assign	 G_wire = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1] ) | (p[3] & p[2] & p[1] & g[0]);
assign	 Cout = G_wire | (P_wire & C0);
assign	 P = P_wire;
assign	 G = G_wire;

endmodule