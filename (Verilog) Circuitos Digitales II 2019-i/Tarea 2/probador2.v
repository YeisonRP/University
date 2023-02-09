module probador2( // M�dulo probador: generador de se�ales y monitor de datos
    output reg clk,
    output reg reset_L,
    input [3:0] data_out0,
    input [3:0] data_out1,
    output reg [3:0] data_in);


	initial begin
		$dumpfile("demux.vcd");	// Nombre de archivo del "dump"
		$dumpvars;			// Directiva para "dumpear" variables
		$display ("\t\tclk,\treset_L,\tdata_out0,\tdata_out1,\tdata_in");
		$monitor($time,"\t%b\t%b\t\t%b\t\t%b\t%b", clk, reset_L, data_out0, data_out1, data_in);
        
        data_in = 'h0;
        reset_L = 0;
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
		data_in <= 'hF;
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h6;
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        reset_L <= 1;
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h8;
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'hD;
        reset_L <= 0;
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h2;
        reset_L <= 1;
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h1;
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h7;
        reset_L <= 0;
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h9;
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h4;
        reset_L <= 1;
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'hB;
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        reset_L <= 0;
        data_in <= 'b1101;
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'b1001;
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
		$finish;			// Termina de almacenar se�ales
	end
	// Reloj
	initial	clk 	<= 0;			// Valor inicial al reloj, sino siempre ser� indeterminado
	always	#2 clk 	<= ~clk;		// Hace "toggle" cada 2*10ns
endmodule
