//Generador de señales y monitor de datos
module probador( 	
	input 		     			data_out_c,
	input 	 	[7:0]			data2send_c,
	//input 		     			data_out_e,
	//input 	 	[7:0]			data2send_e,
	output reg	[7:0]			data_in,
	output reg 					valid_in,
	output reg 					clk_f,
	output reg 					clk_8f,
	output reg 					reset);

	
	initial begin
		$dumpfile("S_P.vcd");   //Archivo de dump
		$dumpvars;				//Ordena dumpear variables a demux.vcd
		
		$display ("\t\t\tclk_8f   clk_f   valid_in     data_in    data2send_c");	//Mensaje inicial que se imprime en consola
		
		$monitor($time,"\t  %b\t  %b\t  %b\t\t%h\t     %h", clk_8f, clk_f, valid_in, data_in, data2send_c); //Valores que se imprimen con cada cambio 

		data_in = 0;		//A continuaci�n, se generan las se�ales de prueba a usar para la simulaci�n	
		valid_in = 0;
		clk_f = 0;
		reset = 0;
		//reset = 0;
		@(posedge clk_8f);
		reset <= 'b1;
		data_in <= 'h11;
		valid_in <= 'b0;
		clk_f <= 'b1;       //Se pone en alto el clk_f
		@(posedge clk_8f);
		data_in <= 'h11;
		valid_in <= 'b0;
		@(posedge clk_8f);
		data_in  <= 'h11;
		valid_in <= 'b0;		
		@(posedge clk_8f);
		data_in  <= 'h11;
		valid_in <= 'b0;
		@(posedge clk_8f);
		data_in <= 'h11;
		valid_in <= 'b0;
		clk_f <= 'b0;         // Se pone en bajo el clk_f
		@(posedge clk_8f);
		data_in  <= 'h11;
		valid_in <= 'b0;
		@(posedge clk_8f);
		data_in  <= 'h11;
		valid_in <= 'b0;
		@(posedge clk_8f);
		data_in  <= 'h11;
		valid_in <= 'b0;
		@(posedge clk_8f);
		clk_f <= 'b1;       //Se pone en alto el clk_f
		@(posedge clk_8f);
		@(posedge clk_8f);
		@(posedge clk_8f);
		
		@(posedge clk_8f);
		clk_f <= 'b0;       //Se pone en bajo el clk_f
		@(posedge clk_8f);
		@(posedge clk_8f);
		@(posedge clk_8f);
		
		@(posedge clk_8f);
		clk_f <= 'b1;       //Se pone en alto el clk_f
		@(posedge clk_8f);
		@(posedge clk_8f);
		@(posedge clk_8f);
		
		@(posedge clk_8f);
		clk_f <= 'b0;       //Se pone en bajo el clk_f
		@(posedge clk_8f);
		@(posedge clk_8f);
		@(posedge clk_8f);
		
		@(posedge clk_8f);
		clk_f <= 'b1;       //Se pone en alto el clk_f
		@(posedge clk_8f);
		@(posedge clk_8f);
		@(posedge clk_8f);
		
		@(posedge clk_8f);
		clk_f <= 'b0;       //Se pone en bajo el clk_f
		@(posedge clk_8f);
		@(posedge clk_8f);
		@(posedge clk_8f);
			
		@(posedge clk_8f);
		data_in  <= 'hff;
		valid_in <= 'b1;
		clk_f <= 'b1;       // Se pone en alto clk_f
		@(posedge clk_8f);
		data_in  <= 'hff;
		valid_in <= 'b1;
		@(posedge clk_8f);
		data_in  <= 'hff;
		valid_in <= 'b1;
		@(posedge clk_8f);
		data_in  <= 'hff;
		valid_in <= 'b1;
		@(posedge clk_8f);
		data_in  <= 'hff;
		valid_in <= 'b1;
		clk_f <= 'b0;       // Se pone en bajo clk_f
		@(posedge clk_8f);
		data_in  <= 'hff;
		valid_in <= 'b1;
		@(posedge clk_8f);
		data_in  <= 'hff;
		valid_in <= 'b1;
		@(posedge clk_8f);
		data_in  <= 'hff;
		valid_in <= 'b1;
		@(posedge clk_8f);
		data_in  <= 'hee;
		valid_in <= 'b1;
		clk_f <='b1;         // Se pone en alto clk_f
		@(posedge clk_8f);
		data_in <= 'hee;
		@(posedge clk_8f);
		data_in <= 'hee;
		@(posedge clk_8f);
		data_in <= 'hee;
		@(posedge clk_8f);
		data_in <= 'hee;
		clk_f <= 'b0;        // Se pone en bajo clk_f
		@(posedge clk_8f);
		data_in <= 'hee;
		@(posedge clk_8f);
		data_in <= 'hee;
		@(posedge clk_8f);
		data_in <= 'hee;
		@(posedge clk_8f);
		data_in  <= 'h4e;
		clk_f <='b1;         // Se pone en alto clk_f
		@(posedge clk_8f);
		data_in <= 'h4e;
		@(posedge clk_8f);
		data_in <= 'h4e;
		@(posedge clk_8f);
		data_in <= 'h4e;
		@(posedge clk_8f);
		data_in <= 'h4e;
		clk_f <= 'b0;        // Se pone en bajo clk_f
		@(posedge clk_8f);
		data_in <= 'h4e;
		@(posedge clk_8f);
		data_in <= 'h4e;
		@(posedge clk_8f);
		data_in <= 'h4e;
		@(posedge clk_8f);
		data_in  <= 'h44;
		valid_in <= 'b0;
		clk_f <='b1;         // Se pone en alto clk_f
		@(posedge clk_8f);
		data_in <= 'h44;
		@(posedge clk_8f);
		data_in <= 'h44;
		@(posedge clk_8f);
		data_in <= 'h44;
		@(posedge clk_8f);
		data_in <= 'h44;
		clk_f <= 'b0;        // Se pone en bajo clk_f
		@(posedge clk_8f);
		data_in <= 'h44;
		@(posedge clk_8f);
		data_in <= 'h44;
		@(posedge clk_8f);
		data_in <= 'h44;
		@(posedge clk_8f);
		data_in <= 'h44;
		@(posedge clk_8f);
		data_in  <= 'ha2;
		valid_in <= 'b1;
		clk_f <='b1;         // Se pone en alto clk_f
		@(posedge clk_8f);
		@(posedge clk_8f);
		@(posedge clk_8f);
		@(posedge clk_8f);
		clk_f <= 'b0;        // Se pone en bajo clk_f
		@(posedge clk_8f);
		@(posedge clk_8f);
		@(posedge clk_8f);
		@(posedge clk_8f);
		clk_f <='b1;         // Se pone en alto clk_f
		data_in <= 'h90;
		valid_in <=1;
		@(posedge clk_8f);
		@(posedge clk_8f);
		@(posedge clk_8f);
		@(posedge clk_8f);


		#9 $finish;						// Termina de almacenar se�ales
	end
	// Reloj
	initial	clk_8f 	<= 0;				// Valor inicial al reloj, sino siempre ser� indeterminado
	always	#2 clk_8f 	<= ~clk_8f;		// Hace "toggle" cada 2*10ns
	
endmodule
