module probador2( // M�dulo probador: generador de se�ales y monitor de datos
    input [3:0] data_out0_ESTRUC,
    input [3:0] data_out1_ESTRUC,
    input [3:0] data_out0_COND,
    input [3:0] data_out1_COND,
    output reg [3:0] data_in,
    output reg  reset_L,
    output reg clk);

        integer flanc_pos = 0;
		initial begin
		$dumpfile("banco_pruebas.vcd");	// Nombre de archivo del "dump"
		$dumpvars;			// Directiva para "dumpear" variables
		$display ("\t\t\tclk,\treset_L,\t\data_out0_ESTRUC,\t\data_out1_ESTRUC,\t\data_out0_COND,\t\t\ddata_out1_COND,\t \ddata_in,\t\dflanc_pos");
		$monitor($time,"\t%b\t%b\t\t%b\t\t\t%b\t\t\t%b\t\t\t%b\t\t\t%b\t\t%d", clk, reset_L, data_out0_ESTRUC, data_out1_ESTRUC,data_out0_COND,data_out1_COND, data_in,flanc_pos);
        
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
	always	#300 clk 	<= ~clk;		////41  //125

    //MONITOR DE PRUEBAS
    //checker y contador de flancos
    always @ (posedge clk) 
        begin
            flanc_pos = flanc_pos + 1;
            if((data_out0_ESTRUC != data_out0_COND)| (data_out1_ESTRUC != data_out1_COND))
                begin
                  $display ("La salida conductual es distinta a la estructural.");
                  $finish;
                end
        end
    always @ (data_out0_COND or data_out1_COND) 
        begin
            flanc_pos = flanc_pos + 1;
        end
endmodule











