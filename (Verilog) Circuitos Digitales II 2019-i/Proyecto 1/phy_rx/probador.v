//Generador de señales y monitor de datos
module probador(
    output reg 	data_in_c_0,
    output reg 	data_in_c_1,
    output reg 	clk_f,
    output reg 	clk_2f,
    output reg 	clk_8f,
    output reg 	reset,
	input 		[7:0] data_out_c_0,
	input 		[7:0] data_out_c_1,
    input 		valid_out_c_0,
    input 		valid_out_e_0,
    input 		valid_out_c_1,
    input 		valid_out_e_1,
	input 		[7:0] data_out_e_0,
	input 		[7:0] data_out_e_1);

	
	initial begin
		$dumpfile("banco_pruebas.vcd");   //Archivo de dump
		$dumpvars;				//Ordena dumpear variables a demux.vcd
		
		//$display ("\t\t\tclk_8f   //clk_f   valid_in     data_in    data2send_c");	//Mensaje inicial que se imprime en consola
		
		//$monitor($time,"\t  %b\t  %b\t  %b\t\t%h\t     %h", clk_8f, //clk_f); //Valores que se imprimen con cada cambio 

		data_in_c_0 = 0;		//A continuaci�n, se generan las se�ales de prueba a usar para la simulaci�n	
		data_in_c_1 = 0;
		clk_f = 0;
		clk_2f = 0;
		reset = 0;
		clk_8f = 0;
		
		@(posedge clk_8f);
		//clk_f <= 'b1;       
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		@(posedge clk_8f);
		//clk_2f <= 'b0;
		@(posedge clk_8f);
		@(posedge clk_8f);
		//clk_f <= 'b0;  
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		@(posedge clk_8f);
		//clk_2f <= 'b0;
		@(posedge clk_8f);
		@(posedge clk_8f);
		reset <= 'b1;
		data_in_c_0 <= 1;
		data_in_c_1 <= 1;
		//clk_f <= 'b1;       
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		//clk_2f <= 'b0;		
		@(posedge clk_8f);
		@(posedge clk_8f);
		data_in_c_1 <= 1;
		//clk_f <= 'b0;         // Se pone en bajo el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_1 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		//clk_2f <= 'b0;
		@(posedge clk_8f);
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		//clk_f <= 'b1;       //Se pone en alto el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		//clk_2f <= 'b0;		
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 1;
		//clk_f <= 'b0;         // Se pone en bajo el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		//clk_2f <= 'b0;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 1;
		//clk_f <= 'b1;       //Se pone en alto el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		//clk_2f <= 'b0;		
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 1;
		//clk_f <= 'b0;         // Se pone en bajo el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		//clk_2f <= 'b0;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 1;
		//clk_f <= 'b1;       //Se pone en alto el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		//clk_2f <= 'b0;		
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 1;
		//clk_f <= 'b0;         // Se pone en bajo el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		//clk_2f <= 'b0;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;///////////////////////////////////Terminan bcs@(posedge clk_8f);
		
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 1;
		//clk_f <= 'b1;       //Se pone en alto el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		//clk_2f <= 'b0;		
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 1;
		//clk_f <= 'b0;         // Se pone en bajo el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 1;
		//clk_2f <= 'b0;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		//clk_f <= 'b1;       //Se pone en alto el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		//clk_2f = 'b0;		
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 0;
		//clk_f <= 'b0;         // Se pone en bajo el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 0;
		//clk_2f <= 'b0;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		//clk_f <= 'b1;       //Se pone en alto el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		//clk_2f <= 'b0;		
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 1;	
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 1;
		//clk_f <= 'b0;         // Se pone en bajo el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		//clk_2f <= 'b0;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 1;
		//clk_f <= 'b1;       //Se pone en alto el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		//clk_2f <= 'b0;		
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 0;
		//clk_f <= 'b0;         // Se pone en bajo el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		//clk_2f <= 'b0;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		//clk_f <= 'b1;       //Se pone en alto el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		//clk_2f <= 'b0;		
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 1;
		//clk_f <= 'b0;         // Se pone en bajo el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		//clk_2f <= 'b0;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		//clk_f <= 'b1;       //Se pone en alto el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		//clk_2f <= 'b0;		
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 1;
		//clk_f <= 'b0;         // Se pone en bajo el //clk_f
		//clk_2f <= 'b1;
		@(posedge clk_8f);
		data_in_c_0 <= 1;
		data_in_c_1 <= 0;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		//clk_2f <= 'b0;
		@(posedge clk_8f);
		data_in_c_0 <= 0;
		data_in_c_1 <= 1;
		@(posedge clk_8f);
		reset <= 0;
		@(posedge clk_8f);
		


		#9 $finish;						// Termina de almacenar se�ales
	end
	// Reloj
	initial	clk_8f 	<= 1;				// Valor inicial al reloj, sino siempre ser� indeterminado
	always	#2 clk_8f 	<= ~clk_8f;		// Hace "toggle" cada 2*10ns

	initial	clk_2f 	<= 1;				// Valor inicial al reloj, sino siempre ser� indeterminado
	always	#8 clk_2f 	<= ~clk_2f;		// Hace "toggle" cada 2*10ns

	initial	clk_f 	<= 1;				// Valor inicial al reloj, sino siempre ser� indeterminado
	always	#16 clk_f 	<= ~clk_f;		// Hace "toggle" cada 2*10ns

endmodule
