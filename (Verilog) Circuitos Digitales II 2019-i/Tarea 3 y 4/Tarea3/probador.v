module probador( // M�dulo probador: generador de se�ales y monitor de datos
    input Nand,
    input Not,
    input Nor,
    input deMux_0,
    input deMux_1,
    input [3:0] deMux_4_bits_0,
    input [3:0] deMux_4_bits_1,
    output reg [3:0] bus,
    output reg  entrada1,
    output reg  entrada2,
    output reg clk);


	initial begin

		$dumpfile("biblioteca_componentes.vcd");	// Nombre de archivo del "dump"
		$dumpvars;			// Directiva para "dumpear" variables
		// Mensaje que se imprime en consola una vez
		$display ("\t\t\tclk,\tNand,\tNot,\tNor,\tdeMux_0,\tdeMux_1, \tdeMux_4_bits_0, \ttdeMux_4_bits_1,\tbus,\tentrada1,\tentrada2");
		// Mensaje que se imprime en consola cada vez que un elemento de la lista cambia
		$monitor($time,"\t%b\t%b\t%b\t%b\t\t%b\t\t%b\t\t\t%b\t\t\t%b\t%b\t%b\t\t%b", clk, Nand, Not, Nor, deMux_0, deMux_1,deMux_4_bits_0,deMux_4_bits_1,bus,entrada1,entrada2);
        entrada1 = 'b0;
        entrada2 = 'b0;
        bus = 'h0;

        begin	
	
            @(posedge clk);	
            @(posedge clk);	
            entrada2 <= ~entrada2;
            @(posedge clk);
            bus <= 'hF;
            entrada1 <= ~entrada1;
            entrada2 <= ~entrada2;
            @(posedge clk);	
            bus <= 'h3;
            entrada2 <= ~entrada2;
            @(posedge clk);	

            @(posedge clk);	
            bus <= 'h7;
            @(posedge clk);	
            bus <= 'hA;	
			 
		end

		$finish;			// Termina de almacenar se�ales
	end
	// Reloj
	initial	clk 	<= 0;			// Valor inicial al reloj, sino siempre ser� indeterminado
	always	#125 clk 	<= ~clk;		////41  //125

endmodule
