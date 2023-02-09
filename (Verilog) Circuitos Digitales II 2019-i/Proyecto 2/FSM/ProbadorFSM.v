module ProbadorFSM (output reg clk,                          //-- Reloj
                    output reg reset,                        //-- Reset
                    output reg init,                        //-- Init
                    output reg [7:0] UMF,               //-- UMBRAL de la MF
                    output reg [7:0] UVC,               //-- UMBRAL de las VC
                    output reg [7:0] UD,               //-- UMBRAL de las D
                    output reg [4:0] FIFO_ERROR,
                    output reg [4:0] FIFO_EMPTY
    );



 initial begin
		$dumpfile("Banco_Pruebas_FSM.vcd");			// Nombre de archivo del "dump"
		$dumpvars;			            // Directiva para "dumpear" variables
		
		
        reset <= 1'b0;  // Se inicia el reset en cero
		init <= 0;
        UMF <= 0;
        UVC <= 0;
        UD  <= 0;	
        FIFO_EMPTY = 0;
        FIFO_ERROR = 0;
		
        // Generando las señales del enunciado.
			@(posedge clk);
            @(posedge clk);
				reset <= 1;
        	@(posedge clk);		// Espera/sincroniza con el flanco positivo del reloj
				UMF <= 'h2A;
                UVC <= 'h17;
                UD  <= 'h1B;
			@(posedge clk);		
				init <= 1;             
			@(posedge clk);
                init <= 0;
            @(posedge clk);
				FIFO_EMPTY <= 3;    
			@(posedge clk);
            @(posedge clk);
			@(posedge clk);
			    FIFO_ERROR <= 2;
            @(posedge clk);
			@(posedge clk);
				reset <= 0;
            @(posedge clk);
				reset <= 1;
			@(posedge clk);
                UMF <= 'h26;
                UVC <= 'h19;
                UD  <= 'h1c;
            @(posedge clk);
				init <= 1;
            @(posedge clk);
				init <= 0;
            @(posedge clk);
            @(posedge clk);
                FIFO_ERROR <= 0;
                FIFO_EMPTY <= 0;
            @(posedge clk);
				reset <= 0;
            @(posedge clk);
				reset <=1;
                init <= 1;
            @(posedge clk);   
            @(posedge clk);
            @(posedge clk);
            
		#6 $finish;				

    end

    	// Reloj
	initial	clk 	<= 0;			// Valor inicial al reloj, sino siempre ser� indeterminado
	always	#2 clk 	<= ~clk;		// Hace "toggle" cada 2*10ns


    endmodule