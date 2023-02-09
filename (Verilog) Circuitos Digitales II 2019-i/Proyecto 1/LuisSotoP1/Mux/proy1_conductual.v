`include "clkgen.v"
`include "mux.v"

module proy1_conductual (
	output 	[7:0]				data_out_c,
	output 						valid_out_c,
	input	[7:0]				data_in_0,
	input	[7:0]				data_in_1,
	output 						valid_in_0,
	output 						valid_in_1,
	input 						reset,
	input 						clk8f,
	output						clkf_c,
	output 						clk2f_c,
	output 						clk4f_c);

	wire	clk2f_mid;

	clkgen generador_de_relojes(clkf_c, clk2f_mid, clk4f_c, clk8f, reset);

	mux mux_(
		data_out_c, 
		valid_out_c, 
		data_in_0, 
		valid_in_0, 
		data_in_1, 
		valid_in_1,
		reset, 
		clk2f_mid,
		clk8f);

endmodule
