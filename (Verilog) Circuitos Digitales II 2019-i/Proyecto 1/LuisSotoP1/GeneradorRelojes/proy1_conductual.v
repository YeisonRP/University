`include "clkgen.v"

module proy1_conductual (		
	input 						clk8f,
	output						clk2f_c,
	output 						clk4f_c,
	output 						clkf_c,
	input 						reset);
	
	clkgen generador_de_relojes(clkf_c, clk2f_c, clk4f_c, clk8f, reset);

endmodule
