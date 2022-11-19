`timescale 1us / 1ns

module microprocessor_tb;

	// Inputs
	reg clk;
	reg reset;
	reg [3:0] i_pins;

	// Outputs
	wire [2:0]cache_wroffset,cache_rdoffset,hold_count;
	wire [3:0] o_reg;
	wire [7:0] ir,pc,rom_address,cache_data,pm_data,pm_address;
	wire start_hold,end_hold,hold,hold_out,reset_1shot,sync_reset_1,cache_wren;
	wire [1:0] cache_rdline, cache_wrline;
	// Instantiate the Unit Under Test (UUT)
	Microprocessor uut (
		.clk(clk), 
		.reset(reset), 
        .i_pins(i_pins),
        .o_reg(o_reg),
	.ir(ir),
	.pc(pc),
	.start_hold(start_hold),
	.end_hold(end_hold),
	.hold(hold),
	.hold_out(hold_out),
	.hold_count(hold_count),
	.cache_wroffset(cache_wroffset),
	.cache_rdoffset(cache_rdoffset),
	.rom_address(rom_address),
	.cache_data(cache_data),
	.pm_data(pm_data),
	.pm_address(pm_address),
	.reset_1shot(reset_1shot),
	.sync_reset_1(sync_reset_1),
	.cache_wren(cache_wren),
	.cache_rdline(cache_rdline),
	.cache_wrline(cache_wrline)
	);

    // length of simulation
    initial #1000 $stop;

    initial
    begin
        clk = 1'b0;
    end

    always
        #0.5 clk = ~clk;

    initial
    begin
        reset = 1'b1;
        #3.2 reset = 1'b0;
        #63 reset = 1'b1;
        #3 reset = 1'b0;
        #91 reset = 1'b1;
        #3 reset = 1'b0;
        #103 reset = 1'b1;
        #101 reset = 1'b0;
    end

	initial begin
        // i_pins stimulus
        i_pins = 4'd5;
	end

endmodule

