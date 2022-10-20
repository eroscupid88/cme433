module CLA_adder_32_bit(
input wire [31:0] a,b,
input wire C0,clk,
output wire [31:0]s,
output wire Cout,G,P
);

wire [7:0] p,g;
wire [6:0]C_out;

CLA_8_bit CLA_module (C0,p,g,C_out,Cout,G,P);

CLA_adder_4_bit adder1(a[3:0],b[3:0],C0,clk,s[3:0],p[0],g[0]);
CLA_adder_4_bit adder2(a[7:4],b[7:4],C_out[0],clk,s[7:4],p[1],g[1]);
CLA_adder_4_bit adder3(a[11:8],b[11:8],C_out[1],clk,s[11:8],p[2],g[2]);
CLA_adder_4_bit adder4(a[15:12],b[15:12],C_out[2],clk,s[15:12],p[3],g[3]);
CLA_adder_4_bit adder5(a[19:16],b[19:16],C_out[3],clk,s[19:16],p[4],g[4]);
CLA_adder_4_bit adder6(a[23:20],b[23:20],C_out[4],clk,s[23:20],p[5],g[5]);
CLA_adder_4_bit adder7(a[27:24],b[27:24],C_out[5],clk,s[27:24],p[6],g[6]);
CLA_adder_4_bit adder8(a[31:28],b[31:28],C_out[6],clk,s[31:28],p[7],g[7]);


endmodule
