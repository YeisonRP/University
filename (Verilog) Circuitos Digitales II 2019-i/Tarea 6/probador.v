module probador( // M�dulo probador: generador de se�ales y monitor de datos
    input [3:0] data_out0_ESTRUC_layer1,    //  Frecuencia Norm
    input [3:0] data_out1_ESTRUC_layer1,    //  Frecuencia Norm
    input [3:0] data_out0_COND_layer1,      //  Frecuencia Norm
    input [3:0] data_out1_COND_layer1,      //  Frecuencia Norm
    input [3:0] data_out0_ESTRUC_layer2,    //  Frecuencia media
    input [3:0] data_out1_ESTRUC_layer2,    //  Frecuencia media
    input [3:0] data_out0_COND_layer2,      //  Frecuencia media
    input [3:0] data_out1_COND_layer2,      //  Frecuencia media
    input [3:0] data_out00_ESTRUC_layer3,   //  Circuito total
    input [3:0] data_out01_ESTRUC_layer3,   //  Circuito total
    input [3:0] data_out10_ESTRUC_layer3,   //  Circuito total
    input [3:0] data_out11_ESTRUC_layer3,   //  Circuito total
    input [3:0] data_out00_COND_layer3,     //  Circuito total
    input [3:0] data_out01_COND_layer3,     //  Circuito total
    input [3:0] data_out10_COND_layer3,     //  Circuito total
    input [3:0] data_out11_COND_layer3,     //  Circuito total
    output reg [3:0] data_in,               //  Entrada
    output reg  reset_L,                    //  Reset
    output reg clk,                         //  CLk
    output reg valid_in                     //  Bit valido entrada
    );
        
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////// INICIO: GENERACION DE PRUEBAS /////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////
		
        initial begin
		$dumpfile("banco_pruebas.vcd");	// Nombre de archivo del "dump"
		$dumpvars;			            // Directiva para "dumpear" variables

        data_in <= 'h0;
        reset_L <= 0;
        valid_in <= 0;
        

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        reset_L <= 0;   
		data_in <= 'hF; 

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'hA;

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        reset_L <= 1;
        valid_in <= 1;
        

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h8;

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h4;

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'hE;

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h7;

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'hA;

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h5;
        
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h6;

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h3;
        
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'hD;

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h9;

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'hA;

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h4;
        valid_in <= 0;
        
        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        
        data_in <= 'hF;

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h5;
        

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'hE;
        valid_in <= 1;

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'hC;        
        

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h9;  

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h7;  
         

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h2;   
           

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'hA;   
        

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'hB;   

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'h1;   
          

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'hC;   
        reset_L <= 0;

        @(posedge clk);	// Espera/sincroniza con el flanco positivo del reloj
        data_in <= 'hA;   


		$finish;			// Termina de almacenar se�ales
	end

	// Reloj
	initial	clk 	<= 0;			// Valor inicial al reloj, sino siempre ser� indeterminado
	always	#300 clk 	<= ~clk;		////41  //125



        //////////////////////////////////////////////////////////////////////////////////////////////////////////
        ////////////////////////////////////// INICIO: MONITOR DE PRUEBAS    /////////////////////////////////////
        //////////////////////////////////////////////////////////////////////////////////////////////////////////


    /////////////////////// checker:
    always @ (posedge clk) 
        begin
            if((data_out0_ESTRUC_layer1 != data_out0_COND_layer1) | (data_out1_ESTRUC_layer1 != data_out1_COND_layer1) )
                begin
                  $display ("La salida conductual del layer 1 es distinta a la estructural.");
                  $finish;
                end
            if((data_out0_ESTRUC_layer2 != data_out0_COND_layer2)| (data_out1_ESTRUC_layer2 != data_out1_COND_layer2))
                begin
                  $display ("La salida conductual del layer 2 es distinta a la estructural.");
                  $finish;
                end

            if((data_out00_ESTRUC_layer3 != data_out00_COND_layer3)| (data_out01_ESTRUC_layer3 != data_out01_COND_layer3) | (data_out10_ESTRUC_layer3 != data_out10_COND_layer3) | ((data_out11_ESTRUC_layer3 != data_out11_COND_layer3)) )
                begin
                  $display ("La salida conductual del layer 3 es distinta a la estructural.");
                  $finish;
                end
        end 


endmodule