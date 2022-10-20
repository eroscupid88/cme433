module CLA_adder_16_bit(
input wire [15:0] a,b,
input wire C0,clk,
output wire [15:0]s,
output wire Cout,G,P
);

wire [3:0] p,g;
wire [2:0]C_out;

CLA cla_module(C0,p,q,C_out,Cout,G,P);

CLA_adder_4_bit adder1(a[3:0],b[3:0],C0,clk,s[3:0],p[0],g[0]);
CLA_adder_4_bit adder2(a[7:4],b[7:4],C_out[0],clk,s[7:4],p[1],g[1]);
CLA_adder_4_bit adder3(a[11:8],b[11:8],C_out[1],clk,s[11:8],p[2],g[2]);
CLA_adder_4_bit adder4(a[15:12],b[15:12],C_out[2],clk,s[15:12],p[3],g[3]);


endmodule