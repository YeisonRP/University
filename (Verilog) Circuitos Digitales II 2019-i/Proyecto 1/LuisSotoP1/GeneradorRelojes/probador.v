//Generador de señales y monitor de datos
module probador( 	
	input						clkf_C,
	input						clk2f_c,
	input						clk4f_c,
	input						clkf_s,
	input						clk2f_s,
	input						clk4f_s,
	output reg 					clk8f,
	output reg 					reset);

	
	initial begin
		$dumpfile("proy1.vcd"); //Archivo de dump
		$dumpvars;				//Ordena dumpear variables a demux.vcd
		
		$display ("\t\t\tclk,\tclks");	//Mensaje inicial que se imprime en consola
		
		$monitor($time,"\t%b\t%b\t\t%b\t\t%b\t%b", clk8f, reset); //Valores que se imprimen con cada cambio 

					 					//A continuaci�n, se generan las se�ales de prueba a usar para la simulaci�n	
		reset = 0;
		@(posedge clk8f);

		@(posedge clk8f);
		
		@(posedge clk8f);
		reset <= 1;
		@(posedge clk8f);
		
		@(posedge clk8f);
		
		@(posedge clk8f);

		@(posedge clk8f);
		
		@(posedge clk8f);
		
		@(posedge clk8f);
		
		@(posedge clk8f);
		
		@(posedge clk8f);

		@(posedge clk8f);
		
		@(posedge clk8f);
		
		@(posedge clk8f);
		
		@(posedge clk8f);
		
		@(posedge clk8f);

		@(posedge clk8f);
		
		@(posedge clk8f);
		reset <= 0;
		@(posedge clk8f);
		
		@(posedge clk8f);
		
		$finish;						// Termina de almacenar se�ales
	end
	// Reloj
	initial	clk8f 	<= 0;				// Valor inicial al reloj, sino siempre ser� indeterminado
	always	#45 clk8f 	<= ~clk8f;		// Hace "toggle" cada 2*10ns
	
endmodule
