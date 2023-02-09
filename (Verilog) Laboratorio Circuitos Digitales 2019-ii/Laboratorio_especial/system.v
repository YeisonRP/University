`timescale 1 ns / 1 ps


// ----------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------
// ------------------------------------ MODULO clkDiv -------------------------------------
// ----------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------
// Módulo que genera una señal de un cuarto la frecuencia
// que la señal de reloj del sistema
module clkDiv(
        input clk,
        input resetn,
        output reg clk_hf
    );

        reg [1:0] cont;

    always @(posedge clk) begin
            
        if (resetn) begin
            cont <= cont + 1;                 
        end 
        else begin
                cont <= 0;  
        end   
    end
	
	always @(*) begin
        if (resetn) begin
            clk_hf = cont[1];                 
        end 
        else begin
        	clk_hf = 0;  
        end   
    end
endmodule





// ----------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------
// ------------------------------------ MODULO cntrHS -------------------------------------
// ----------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------

//Módulo que genera la señal de HS
//Esta debe tener la siguiente secuencia:
//Pulso: 		96 clks - 3.84us - Estado en bajo
//Back porch: 	48 clks - 1.92us - Estado en alto
//Display: 		640 clks - 25.6us - Estado en alto
//Front porch: 	48 clks - 1.92us - Estado en alto

module cntrHS(
        input clk,
        input resetn,
        output reg HS,
        output reg [10:0] currentCol
    );

    reg     [10:0] cntH;

    always @(posedge clk) begin
        if (resetn) begin
            if (cntH < 'h31F) begin
                cntH <= cntH + 1;
            end else begin
                cntH <= 0;
            end
        end else begin
            cntH <= 0;
        end
    end

    always @(*) begin
        if (resetn) begin  
            if (cntH == 0) begin
                HS = 0;
            end
            if (cntH == 96) begin
                HS = 1;
            end
            
            currentCol = cntH - 144;
            if(currentCol < 0 || currentCol > 639) begin
                currentCol = 'hFFF;
            end
         end else begin
            HS = 0;
            currentCol = 'hFFF;
         end
    end
endmodule


// ----------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------
// ------------------------------------ MODULO cntrVS -------------------------------------
// ----------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------

module cntrVS(
        input resetn,
        input HS,
        output reg VS,
        output reg [10:0] currentRow 
    );

    reg     [10:0] cntV;

    always @(negedge HS) begin
        if (resetn) begin
            if (cntV < 'h208) begin
                cntV <= cntV + 1;    
            end else begin
                cntV <= 0;
            end
        end else begin
            cntV <= 0;
        end
    end

    always @(*) begin
        if (resetn) begin  
            if (cntV == 0) begin
                VS = 0;
            end
            if (cntV == 2) begin
                VS = 1;
            end
            
            currentRow = cntV - 31;
            if(currentRow < 0 || currentRow > 479) begin
                currentRow = 'hFFF;
            end
         end else begin
            VS = 0;
            currentRow = 'hFFF;
         end
    end
endmodule




// ----------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------
// -------------------------------- MODULO TOP SYSTEM -------------------------------------
// ----------------------------------------------------------------------------------------
// ----------------------------------------------------------------------------------------

module system(
	input            clk,
	input            resetn,
	input mouse_clk,
	input mouse_data,
	output reg 		[3:0] RED,
	output reg  	[3:0] BLUE,
	output reg 		[3:0] GREEN,
	output  		 HS,
	output           VS,
	output reg [15:0] out_byte // VARIABLE PARA DEBUGEAR CON LEDS
    );



// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
// --------- INSTANCIAS DE MODULOS DE TEMPORIZACION DEL VGA -------------
// ----------------------------------------------------------------------
// ---------------------------------------------------------------------- 
	
    wire clk_hf;
    wire [10:0] currentRow; 
    wire [10:0] currentCol;


    clkDiv clk_D(clk, resetn, clk_hf);
    cntrHS c_HS(clk_hf, resetn, HS, currentCol);
    cntrVS c_VS(resetn, HS, VS, currentRow);


// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
// ------------ FUTURA LOGICA DEL CONTROL PARA EL MOUSE -----------------
// ----------------------------------------------------------------------
// ---------------------------------------------------------------------- 
reg [10:0] MOUSE_DATA_INTERCEPT [2:0];  // Donde se guardan todos los bits del teclado


	// Controlador para el teclado
	reg DATA_ENABLE_FLAG = 0;        // FLAG QUE INDICA QUE YA SE RECIBIO TODA LA TRAMA DEL MOUSE
	reg DATA_ENALBLE_DELAY_FLAG = 0; // FLAG RETRASADO SIMILAR A DATA_ENABLE_FLAG 
	reg [3:0] MOUSE_DATA_COUNTER = 0; // Es un contador que va hasta 33 guardando bit por bit los datos enviados por el mouse
	reg [11:0] MOUSE_DATA_INTERCEPT_AUX [2:0]; // Es un registro
	
	reg [9:0] CONT_REB_DE_MOUSE_CLK = 0;  // controlador para saber que el pulso no era una fluctuacion, llega hasta 10.2us 
	reg [1:0] CONTADOR_PALABRAS_MOUSE = 0;
	// VARIABLES DEL MOUSE
	
	always @(posedge clk_hf ) begin
		if (!resetn) begin
			DATA_ENABLE_FLAG <= 0;
			CONT_REB_DE_MOUSE_CLK <= 0;
			MOUSE_DATA_COUNTER <= 0;
			MOUSE_DATA_INTERCEPT_AUX [0] <= 0;
            MOUSE_DATA_INTERCEPT_AUX [1] <= 0;
            MOUSE_DATA_INTERCEPT_AUX [2] <= 0;
			MOUSE_DATA_INTERCEPT [0] <= 0;
            MOUSE_DATA_INTERCEPT [1] <= 0;
            MOUSE_DATA_INTERCEPT [2] <= 0;
                       
            CONTADOR_PALABRAS_MOUSE <= 0;
		end
		else begin // contador para controlar rebotes de la se;al del clk 
		    DATA_ENABLE_FLAG <= 0;
			if (mouse_clk == 0) begin
				CONT_REB_DE_MOUSE_CLK <= CONT_REB_DE_MOUSE_CLK + 1;
			end else begin
				CONT_REB_DE_MOUSE_CLK <= 0;
			end

			// Controlador para saber si un dato del teclado si se esta enviando
			if (CONT_REB_DE_MOUSE_CLK == 250) begin // se puede sacar el primer dato
				MOUSE_DATA_COUNTER <= MOUSE_DATA_COUNTER + 1;
				MOUSE_DATA_INTERCEPT_AUX[CONTADOR_PALABRAS_MOUSE][MOUSE_DATA_COUNTER] <= mouse_data;		//guardando el dato
			end 
			 // SI NO SIRVE PASAR A 33
			if (MOUSE_DATA_COUNTER >= 11) begin	// reseteando contador de datos cuando ya se sacaron todos
				MOUSE_DATA_COUNTER <= 0;
                CONTADOR_PALABRAS_MOUSE <= CONTADOR_PALABRAS_MOUSE + 1;
                
                MOUSE_DATA_INTERCEPT[CONTADOR_PALABRAS_MOUSE][7:0] <= MOUSE_DATA_INTERCEPT_AUX[CONTADOR_PALABRAS_MOUSE][8:1];
                if(CONTADOR_PALABRAS_MOUSE != 0) begin
                    if(MOUSE_DATA_INTERCEPT_AUX[0][5]) begin // Si el signo de X es negativo
                        MOUSE_DATA_INTERCEPT[1][10:8] <= 'b111;  
                    end
                    else begin  // Si el signo de X es positivo
                        MOUSE_DATA_INTERCEPT[1][10:8] <= 'b000;
                    end
                    if(MOUSE_DATA_INTERCEPT_AUX[0][6]) begin // Si el signo de X es negativo
                       MOUSE_DATA_INTERCEPT[2][10:8] <= 'b111;     
                    end
                    else begin  // Si el signo de X es positivo
                        MOUSE_DATA_INTERCEPT[2][10:8] <= 'b000;
                    end                    
                end
                
                if (CONTADOR_PALABRAS_MOUSE >= 3) begin //Cuando llega la palabra 3 se reinicia
                    CONTADOR_PALABRAS_MOUSE <= 0;
                    DATA_ENABLE_FLAG <= 1;
                end
            end			
		end
		DATA_ENALBLE_DELAY_FLAG <= DATA_ENABLE_FLAG;
	end




// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
// ------ Maquina de estados que controla la logica del juego -----------
// ----------------------------------------------------------------------
// ---------------------------------------------------------------------- 
	
reg [11:0] COLORES [11:0]; // colores en columnas / fila es cada color
reg [11:0] color_enable; // Habilita los colores en la pantalla
integer i;

always @(posedge clk_hf) begin

    if(!resetn) begin
    for(i = 0; i < 12; i = i + 1) begin
        COLORES [i] <= 0;
    end     
    end else begin
       COLORES [0] <= 'h088;   // BLANCO
       COLORES [1] <= 'h0F0;   // VERDE
       COLORES [2] <= 'h00F;   // AZUL
       COLORES [3] <= 'hF00;   // ROJO
       COLORES [4] <= 'h00F;   // AZUL 
       COLORES [5] <= 'h083;   // CYAN
       COLORES [6] <= 'hF0F;   // VIOLETA
       COLORES [7] <= 'h088;   // BLANCO
       COLORES [8] <= 'h083;   // CYAN
       COLORES [9] <= 'hF00;   // ROJO
       COLORES [10] <= 'h0F0;  // VERDE  
       COLORES [11] <= 'hF0F;  // VIOLETA
    end
end




parameter IDLE = 1;
parameter FIRST_CLICK = 2;
parameter SECOND_CLICK = 4;
parameter FAIL = 8;

reg [5:0] ST, NXT_ST; 

reg [3:0] PRIMER_COLOR_COORDENADA;

reg [3:0] SEGUNDO_COLOR_COORDENADA;


    reg [10:0] pos_act_mouse_filas;
    reg [10:0] pos_act_mouse_columnas;
    
    reg [26:0] contador_2_seg;
    
always @(posedge clk_hf) begin

    if(!resetn) begin
        contador_2_seg <= 0;
        ST <= IDLE;
    for(i = 0; i < 12; i = i + 1) begin
        color_enable[i] <= 0;
    end          
    
    end else begin
        out_byte <= color_enable;
        ST <= NXT_ST;
        
        if(NXT_ST == FIRST_CLICK && ST != FIRST_CLICK) begin // Guardando coordenada primer color
            PRIMER_COLOR_COORDENADA <= (pos_act_mouse_filas / 160)*4 + (pos_act_mouse_columnas / 160);
        end

        if(ST == FIRST_CLICK) begin // // Si hubo otro click, habilito el segundo color para desplegarlo en la pantalla
            color_enable[PRIMER_COLOR_COORDENADA] <= 1;
        end
         
 
        
        if(NXT_ST == SECOND_CLICK && ST != SECOND_CLICK) begin // Guardando coordenada segundo color
            SEGUNDO_COLOR_COORDENADA <= (pos_act_mouse_filas / 160)*4 + (pos_act_mouse_columnas / 160);
        end
            
        if(ST == SECOND_CLICK) begin // Si hubo otro click, habilito el segundo color para desplegarlo en la pantalla
            color_enable[SEGUNDO_COLOR_COORDENADA] <= 1;
        end
        
        
        if(ST == FAIL) begin // si estoy en estado fail, se empieza a aumentar el contador
            contador_2_seg <= contador_2_seg + 1;
        end
        else begin
            contador_2_seg <= 0;
        end
        
        if(ST == FAIL &&  NXT_ST != FAIL) begin // si voy a salir de estado FAIL porque pasaron 2 segundos, se desactivan los colores
            color_enable[PRIMER_COLOR_COORDENADA] <= 0;
            color_enable[SEGUNDO_COLOR_COORDENADA] <= 0;
        end
        
      /*  if(ST == FAIL) begin
            if(NXT_ST == IDLE) begin // Si vengo de un error y voy a IDLE, borro los colores desplegados anteriormente
                color_enable[PRIMER_COLOR_COORDENADA] <= 0;
                color_enable[SEGUNDO_COLOR_COORDENADA] <= 0;
            end
            //color_enable[PRIMER_COLOR_COORDENADA] <= 1;
        end */
                
        
    end
end



always @(*) begin 

    if(resetn) begin

        case (ST)
            IDLE: begin
                NXT_ST = IDLE;  // ESTADO DEFAULT, SI NO SE HACE NADA, NO SE HACE NADA
                if(DATA_ENABLE_FLAG && MOUSE_DATA_INTERCEPT_AUX[0][1] && (color_enable[(pos_act_mouse_filas / 160)*4 + (pos_act_mouse_columnas / 160)] == 0) ) begin      // Si hubo un clic
                    NXT_ST = FIRST_CLICK;  
                end
            end
            
            FIRST_CLICK: begin 
                NXT_ST = FIRST_CLICK;
                if(DATA_ENABLE_FLAG && MOUSE_DATA_INTERCEPT_AUX[0][1] && ( ((pos_act_mouse_filas / 160)*4 + (pos_act_mouse_columnas / 160)) != (PRIMER_COLOR_COORDENADA) ) && (color_enable[(pos_act_mouse_filas / 160)*4 + (pos_act_mouse_columnas / 160)] == 0) ) begin      // Si hubo un clic
                    NXT_ST = SECOND_CLICK;  
                end               
            end   
        
            SECOND_CLICK: begin
                NXT_ST = SECOND_CLICK;
                if(COLORES[PRIMER_COLOR_COORDENADA] == COLORES[SEGUNDO_COLOR_COORDENADA]) begin
                   NXT_ST = IDLE;  
                end
                else begin
                    NXT_ST = FAIL;
                end
            end
        
            FAIL: begin
                NXT_ST = FAIL;
                if(contador_2_seg >= 50000000) begin
                    NXT_ST = IDLE;
                end
            end
         
            default:       ; 
        endcase
        
    end
end 

    reg [3:0] RED_,GREEN_,BLUE_;

    
    reg [3:0] currentCasilla;
    reg [5:0] gotColor;
  
  

// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
// ----------- IMPRESION DE LOS COLORES EN LA PANTALLA   ----------------
// ----------------------------------------------------------------------
// ---------------------------------------------------------------------- 
	  
    integer j;
	always @(*) begin


        gotColor = 'b111111;
        
        currentCasilla = (currentCol/160) + (currentRow/160)*4;
		{RED_[3:0],GREEN_[3:0],BLUE_[3:0]} = 'h777;

        //Vertical izquierda negra
		if( ((currentCol%160) > 3 && (currentCol%160) < 8) && ((currentRow%160) > 3 && (currentRow%160) < 156) ) begin
			{RED_[3:0],GREEN_[3:0],BLUE_[3:0]} = 'hFFF;
		end

        //Vertical derecha negra
        if( ((currentCol%160) > 151 && (currentCol%160) < 156) && ((currentRow%160) > 3 && (currentRow%160) < 156) ) begin
			{RED_[3:0],GREEN_[3:0],BLUE_[3:0]} = 'hFFF;
		end

        
        //Horizontal superior negra 
		if((currentRow%160 > 3 && currentRow%160 < 8) && (currentCol%160 > 3 && currentCol%160 < 156)) begin
			{RED_[3:0],GREEN_[3:0],BLUE_[3:0]} = 'hFFF;
		end

        //Horizontal inferior negra 
		if((currentRow%160 > 151 && currentRow%160 < 156) && (currentCol%160 > 3 && currentCol%160 < 156)) begin
			{RED_[3:0],GREEN_[3:0],BLUE_[3:0]} = 'hFFF;
		end
        
        //Borde blanco
		if(((currentCol%160 < 4) || (currentCol%160 > 155)) || ((currentRow%160 < 4) || (currentRow%160 > 155))) begin
			{RED_[3:0],GREEN_[3:0],BLUE_[3:0]} = 'h000;
		end
        
        for(j = 0; j < 12; j = j + 1) begin
            if(color_enable[j]) begin
                if(((currentCol%160 > 7) && (currentCol%160 < 152)) && ((currentRow%160 > 7 ) && (currentRow%160 < 152)) && (currentCasilla == j) && gotColor[0] == 1) begin
			         {RED_[3:0],GREEN_[3:0],BLUE_[3:0]} = COLORES[j];
		        end
            end
        end    
        
        
        
        
		//Si se encuentra actualmente en el back porch o front porch
		//se hace 0 los colores
		if ((currentRow == 'h7FF) || (currentCol == 'h7FF)) begin
			RED = 'h0;
			GREEN = 'h0;
			BLUE = 'h0;
		end
		else begin    // AQUI SE MANDAN LOS COLORES A LA PANTALLA SEGUN CURRENTROW Y CURRENTCOL
			RED = RED_;
			GREEN = GREEN_;
			BLUE = BLUE_;		    
		   // Si la pantalla va a imprimir donde debe ir el mouse
		   if((currentCol > pos_act_mouse_columnas) && (currentCol < (pos_act_mouse_columnas + 30))) begin
		      if((currentRow > pos_act_mouse_filas) && (currentRow < (pos_act_mouse_filas + 30))) begin
			     RED = 'h2;
			     GREEN = 'h5;
			     BLUE = 'hF;	  
			     
			     // Bordes del mouse
			     if(  (currentCol < (pos_act_mouse_columnas + 5)) || (currentCol > (pos_act_mouse_columnas + 25) ) || (currentRow < (pos_act_mouse_filas + 5)) || (currentRow > (pos_act_mouse_filas + 25) ) ) begin
			         	 RED = 'h3;
			             GREEN = 'hF;
			             BLUE = 'h5;
			         			     
			     end
		      end
           end

			
		end 
	end










// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
// ------------ LOGICA DE MOVIMIENTO DEL MOUSE EN PANT  -----------------
// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
//      ----------
//     |         |
//     |         |
//     |         |
//    (X)---------
//
// Lo mostrado anteriormente es como se veria el mouse en pantalla
//
// Donde X es la coordenada (pos_act_mouse_x,pos_act_mouse_y)
// 30 x 30 es el mouse


reg [20:0] contador_a_50ms;



always @(posedge clk_hf) begin
        if (!resetn) begin // Posicionando el mouse inicialmente cerca de la mitad
           pos_act_mouse_filas <= 100; 
           pos_act_mouse_columnas <= 100;  
           contador_a_50ms <= 0;
  
        end
        else begin
           if(contador_a_50ms == 1250000) begin // Se lee el mouse
                if(DATA_ENABLE_FLAG) begin // cuando el dato es leido en el mouse
                    
                    contador_a_50ms <= 0; // reinicia el contador para un nuevo ciclo
                 
                 // ---------------------LOGICA PARA LAS COLUMNAS DEL MOUSE-------------------- arriba- abajo+ 
                    if(MOUSE_DATA_INTERCEPT_AUX[0][5]) begin // Si el signo de X es negativo
                        pos_act_mouse_columnas <= pos_act_mouse_columnas - ~(MOUSE_DATA_INTERCEPT[1] );     
                    end
                    else begin  // Si el signo de X es positivo
                        pos_act_mouse_columnas <= pos_act_mouse_columnas + (MOUSE_DATA_INTERCEPT[1]);
                    end
                    
                   // Logica para que el mouse no se salga de los bordes der e izq de la pantalla:
                    if(pos_act_mouse_columnas > 610 ) begin // Para que no se salga del borde der
                        pos_act_mouse_columnas <= 610;
                    end

                    if(pos_act_mouse_columnas <= 3 || pos_act_mouse_columnas > 700  ) begin  // Para que no se salga del borde izq 
                        pos_act_mouse_columnas <= 4;
                    end
                  
                 // -------------------LOGICA PARA LAS FILAS DEL MOUSE-------------------- der+ 
                    if(MOUSE_DATA_INTERCEPT_AUX[0][6]) begin // Si el signo de Y es negativo
                       pos_act_mouse_filas <= pos_act_mouse_filas + ~(MOUSE_DATA_INTERCEPT[2]);     
                    end
                    else begin  // Si el signo de Y es positivo
                        pos_act_mouse_filas <= pos_act_mouse_filas - (MOUSE_DATA_INTERCEPT[2]);
                    end
                    
                   // Logica para que el mouse no se salga de los bordes der e izq de la pantalla:
                    if(pos_act_mouse_filas > 450 ) begin // Para que no se salga del borde der
                        pos_act_mouse_filas <= 450;
                    end

                    if(pos_act_mouse_filas <= 3 || pos_act_mouse_filas > 650  ) begin  // Para que no se salga del borde izq 
                        pos_act_mouse_filas <= 4;
                    end                                       
                end       
           end 
           else begin
                contador_a_50ms <= contador_a_50ms + 1;
           end
        end
end




// ----------------------------------------------------------------------
// ----------------------------------------------------------------------
// ------------ LOGICA DE DEBUG PARA EL MOUSE CON LEDS  -----------------
// ----------------------------------------------------------------------
// ---------------------------------------------------------------------- 
   // 125 000 000
/*
    reg [28:0] contador_a_5_seg;
    always @(posedge clk_hf) begin
        if (!resetn) begin
        out_byte <= 7;
        contador_a_5_seg <= 0;      
        end
        else begin
            contador_a_5_seg <= contador_a_5_seg + 1;
            if(DATA_ENABLE_FLAG) begin // LEDS VAN DE 0 A 15
                out_byte[15] <= MOUSE_DATA_INTERCEPT_AUX[0][1];  // CLICK IZQ, ENCENDER LED 15
                out_byte[14] <= MOUSE_DATA_INTERCEPT_AUX[0][2];   // CLICK DERECH, ENCENDER LED 14
                out_byte[13] <= MOUSE_DATA_INTERCEPT_AUX[0][5];    // SIGNO DE X, SI ES NEGATIVO SE ENCIENDE EL LED 13
                out_byte[12] <= MOUSE_DATA_INTERCEPT_AUX[0][6];    // SIGNO DE Y, SI ES NEGATIVO SE ENCIENDE EL LED 12
                out_byte[11] <= MOUSE_DATA_INTERCEPT_AUX[0][7];   // overflow de X, LED 11
                out_byte[10] <= MOUSE_DATA_INTERCEPT_AUX[0][8];   // overflow de Y, LED 10  
                out_byte[9:5] <= MOUSE_DATA_INTERCEPT_AUX[1][5:1]; // VELOCIDAD DE X, PRIMEROS 5 BITS, EN LEDS 9 A 5
                out_byte[4:0] <= MOUSE_DATA_INTERCEPT_AUX[2][5:1]; // VELOCIDAD DE Y, PRIMEROS 5 BITS, EN LEDS 9 A 5   
            end
        end
    end
*/


endmodule
