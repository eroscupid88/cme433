module thirtytwo_bit_rc_adder(
input wire [31:0] A,
input wire [31:0] B,
input wire C_in,
input wire clk, 
output reg C_out,
output reg [31:0] S
);



reg [31:0] a_reg, b_reg;
reg c_reg;

wire [31:0] S_out;
wire [31:0] w;


always @(posedge clk) begin
    a_reg <= A;
    b_reg <= B;
    c_reg <= C_in;
  end  
  
always @(posedge clk) begin
	 C_out <= w[31];
    S <= S_out;
  end
  
 

adder adder1(a_reg[0],b_reg[0],c_reg,clk,S_out[0],w[0]);
adder adder2(a_reg[1],b_reg[1],w1,clk,S_out[1],w[1]);
adder adder3(a_reg[2],b_reg[2],w2,clk,S_out[2],w[2]);
adder adder4(a_reg[3],b_reg[3],w3,clk,S_out[3],w[3]);
adder adder5(a_reg[4],b_reg[4],w4,clk,S_out[4],w[4]);
adder adder6(a_reg[5],b_reg[5],w5,clk,S_out[5],w[5]);
adder adder7(a_reg[6],b_reg[6],w6,clk,S_out[6],w[6]);
adder adder8(a_reg[7],b_reg[7],w7,clk,S_out[7],w[7]);
adder adder9(a_reg[8],b_reg[8],w8,clk,S_out[8],w[8]);
adder adder10(a_reg[9],b_reg[9],w9,clk,S_out[9],w[9]);
adder adder11(a_reg[10],b_reg[10],w10,clk,S_out[10],w[10]);
adder adder12(a_reg[11],b_reg[11],w11,clk,S_out[11],w[11]);
adder adder13(a_reg[12],b_reg[12],w12,clk,S_out[12],w[12]);
adder adder14(a_reg[13],b_reg[13],w13,clk,S_out[13],w[13]);
adder adder15(a_reg[14],b_reg[14],w14,clk,S_out[14],w[14]);
adder adder16(a_reg[15],b_reg[15],w15,clk,S_out[15],w[15]);
adder adder17(a_reg[16],b_reg[16],w16,clk,S_out[16],w[16]);
adder adder18(a_reg[17],b_reg[17],w17,clk,S_out[17],w[17]);
adder adder19(a_reg[18],b_reg[18],w18,clk,S_out[18],w[18]);
adder adder20(a_reg[19],b_reg[19],w19,clk,S_out[19],w[19]);
adder adder21(a_reg[20],b_reg[20],w20,clk,S_out[20],w[20]);
adder adder22(a_reg[21],b_reg[21],w21,clk,S_out[21],w[21]);
adder adder23(a_reg[22],b_reg[22],w22,clk,S_out[22],w[22]);
adder adder24(a_reg[23],b_reg[23],w23,clk,S_out[23],w[23]);
adder adder25(a_reg[24],b_reg[24],w24,clk,S_out[24],w[24]);
adder adder26(a_reg[25],b_reg[25],w25,clk,S_out[25],w[25]);
adder adder27(a_reg[26],b_reg[26],w26,clk,S_out[26],w[26]);
adder adder28(a_reg[27],b_reg[27],w27,clk,S_out[27],w[27]);
adder adder29(a_reg[28],b_reg[28],w28,clk,S_out[28],w[28]);
adder adder30(a_reg[29],b_reg[29],w29,clk,S_out[29],w[29]);
adder adder31(a_reg[30],b_reg[30],w30,clk,S_out[30],w[30]);
adder adder32(a_reg[31],b_reg[31],w31,clk,S_out[31],w[31]);


endmodule
