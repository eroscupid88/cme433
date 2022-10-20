`timescale 1 ns / 1 ps  // compiler directive that must be included
			// the first time listed is used for the unit
			// of time on waveform plots
			// the second time listed indicates precision.
			// All delays are rounded to the ??precision time??.
			// allowable units of time are ms, us, ns, and ps
			// allowable numbers are 1, 10, 100

module lab1_parity_davio_tb();

reg [6:0]D;
reg F;
reg F_conventional;

initial
#150 $stop;


parity_davio parity_davio(
		 .D(D),
		 .F(F),
		 .F_conventional(F_conventional)
);
endmodule;