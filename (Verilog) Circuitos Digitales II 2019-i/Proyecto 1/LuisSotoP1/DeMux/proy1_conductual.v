`include "clkgen.v"
`include "mux.v"
`include "demux.v"

module proy1_conductual (
	output 	[7:0]				data_out_0_c,
	output 						valid_out_0_c,
	output 	[7:0]				data_out_1_c,
	output 						valid_out_1_c,
	input	[7:0]				data_in_0,
	output 						valid_in_0,
	input	[7:0]				data_in_1,
	output 						valid_in_1,
	input 						reset,
	input 						clk8f,
	output						clkf_c,
	output 						clk2f_c,
	output 						clk4f_c);
	
	wire [7:0]			data_mid_c;
	wire 				valid_mid_c;


	clkgen generador_de_relojes(clkf_c, clk2f_c, clk4f_c, clk8f, reset);

	mux mux_(
		data_mid_c, 
		valid_mid_c, 
		data_in_0, 
		valid_in_0, 
		data_in_1, 
		valid_in_1,
		reset, 
		clk2f_c,
		clk8f);

	demux demux_(
		data_out_0_c,
		valid_out_0_c,
		data_out_1_c,
		valid_out_1_c,
		data_mid_c,
		valid_mid_c,
		reset,
		clk2f_c,
		clk8f);

endmodule
