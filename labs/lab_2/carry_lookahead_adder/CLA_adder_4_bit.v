module CLA_adder_4_bit(
input wire [3:0] a,b,
input wire C0,clk,
output wire [3:0] s,
output wire G,P,C_out
);

wire [3:0] p,g;
wire [2:0]Cout;

CLA cla_module(C0,p,g,Cout,C_out,G,P);

CLA_adder adder1(a[0],b[0],C0,clk,s[0],p[0],g[0]);
CLA_adder adder2(a[1],b[1],Cout[0],clk,s[1],p[1],g[1]);
CLA_adder adder3(a[2],b[2],Cout[1],clk,s[2],p[2],g[2]);
CLA_adder adder4(a[3],b[3],Cout[2],clk,s[3],p[3],g[3]);
endmodule