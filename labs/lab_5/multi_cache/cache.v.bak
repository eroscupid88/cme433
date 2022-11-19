module cache(
	input clk,wren,
	input [7:0] data,
	input [4:0]rdoffset, wroffset,
	output reg [7:0] q);
	
	
	reg [31:0] byteena_a;
	wire [255:0] q_tmp;
	
	always @ *
		byteena_a = 32'b1 << wroffset;
		
	two_port_ram two_port_ram(.byteena_a(byteena_a),
										.clock(~clk),
										.data({32{data}}),
										.rdaddress(1'b0),
										.wraddress(1'b0),
										.q(q_tmp),
										.wren(wren));
										
	always  @ *
		begin
			case(rdoffset)
			31'd0: q = q_tmp[7:0];
			31'd1: q = q_tmp[15:8];
			31'd2: q = q_tmp[23:16];
			31'd3: q = q_tmp[31:24];
			31'd4: q = q_tmp[39:32];
			31'd5: q = q_tmp[47:40];
			31'd6: q = q_tmp[55:48];
			31'd7: q = q_tmp[63:56];
			31'd8: q = q_tmp[71:64];
			31'd9: q = q_tmp[79:72];
			31'd10: q = q_tmp[87:80];
			31'd11: q = q_tmp[95:88];
			31'd12: q = q_tmp[103:96];
			31'd13: q = q_tmp[111:104];
			31'd14: q = q_tmp[119:112];
			31'd15: q = q_tmp[127:120];
			31'd16: q = q_tmp[135:128];
			31'd17: q = q_tmp[143:136];
			31'd18: q = q_tmp[151:144];
			31'd19: q = q_tmp[159:152];
			31'd20: q = q_tmp[167:160];
			31'd21: q = q_tmp[175:168];
			31'd22: q = q_tmp[183:176];
			31'd23: q = q_tmp[191:184];
			31'd24: q = q_tmp[199:192];
			31'd25: q = q_tmp[207:200];
			31'd26: q = q_tmp[215:208];
			31'd27: q = q_tmp[223:216];
			31'd28: q = q_tmp[231:224];
			31'd29: q = q_tmp[239:232];
			31'd30: q = q_tmp[247:240];
			31'd31: q = q_tmp[255:248];
			
			default: q = 8'b0;
			endcase
		end
									
endmodule
