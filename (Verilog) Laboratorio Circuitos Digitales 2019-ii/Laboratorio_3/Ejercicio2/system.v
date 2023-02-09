`timescale 1 ns / 1 ps

//Módulo que genera una señal de un cuarto la frecuencia
//que la señal de reloj del sistema
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

module RAM_PORT #( parameter DATA_WIDTH = 12, parameter ADDR_WIDTH = 6, parameter MEM_SIZE = 64) (
	input wire 						clk,
	input wire 						iWriteEnable,
	input wire [ADDR_WIDTH-1:0] 	iReadAddress,
	input wire [ADDR_WIDTH-1:0] 	iWriteAddress,
	input wire [DATA_WIDTH-1:0]		iDataIn,
	output reg [DATA_WIDTH-1:0] 	oDataOut
);

	reg [DATA_WIDTH-1:0] RAM [MEM_SIZE-1:0];
	

	always @(posedge clk) begin
	
		if (iWriteEnable) begin
			RAM[iWriteAddress] <= iDataIn;
		end
		oDataOut <= RAM[iReadAddress];
	end

endmodule




module system(
	input            clk,
	input            resetn,
	input right,
	input left,
	input up,
	input down,
	output trap,
	output reg 		[3:0] RED,
	output reg  	[3:0] BLUE,
	output reg 		[3:0] GREEN,
	output  		 HS,
	output           VS,
	output reg out_byte_en,
	output reg [7:0] out_byte
    );

	wire [3:0] RED_, BLUE_, GREEN_;
     
	// set this to 0 for better timing but less performance/MHz
	parameter FAST_MEMORY = 1;

	// 4096 32bit words = 16kB memory
	parameter MEM_SIZE = 4096;

	wire mem_valid;
	wire mem_instr;
	reg mem_ready;
	wire [31:0] mem_addr;
	wire [31:0] mem_wdata;
	wire [3:0] mem_wstrb;
	reg [31:0] mem_rdata;

	wire mem_la_read;
	wire mem_la_write;
	wire [31:0] mem_la_addr;
	wire [31:0] mem_la_wdata;
	wire [3:0] mem_la_wstrb;


	
	picorv32 #(.ENABLE_MUL(1)) picorv32_core  (
		.clk         (clk         ),
		.resetn      (resetn      ),
		.trap        (trap        ),
		.mem_valid   (mem_valid   ),
		.mem_instr   (mem_instr   ),
		.mem_ready   (mem_ready   ),
		.mem_addr    (mem_addr    ),
		.mem_wdata   (mem_wdata   ),
		.mem_wstrb   (mem_wstrb   ),
		.mem_rdata   (mem_rdata   ),
		.mem_la_read (mem_la_read ),
		.mem_la_write(mem_la_write),
		.mem_la_addr (mem_la_addr ),
		.mem_la_wdata(mem_la_wdata),
		.mem_la_wstrb(mem_la_wstrb)
	);

	reg [31:0] memory [0:MEM_SIZE-1];

`ifdef SYNTHESIS
    initial $readmemh("../firmware/firmware.hex", memory);
`else
	initial $readmemh("firmware.hex", memory);
`endif

	reg [31:0] m_read_data;
	reg m_read_en;

	//Luis
	reg [11:0] pixelColor;
	reg [5:0] pixelPosition;
	reg pixelControl;
	reg [5:0] index;

	
    wire clk_hf;
    wire [10:0] currentRow; 
    wire [10:0] currentCol;
	
    clkDiv clk_D(clk, resetn, clk_hf);
    cntrHS c_HS(clk_hf, resetn, HS, currentCol);
    cntrVS c_VS(resetn, HS, VS, currentRow);

	always @(*) begin
		//Se cambia los valores de columna real por el valor a memoria ram equivalente
		if (0 <= currentCol && currentCol <= 79) begin
			index[5:3] = 3'b000;
		end
		if (80 <= currentCol && currentCol <= 159) begin
			index[5:3] = 'b001;
		end
		if (160 <= currentCol && currentCol <= 239) begin
			index[5:3] = 'b010;
		end
		if (240 <= currentCol && currentCol <= 319) begin
			index[5:3] = 'b011;
		end
		if (320 <= currentCol && currentCol <= 399) begin
			index[5:3] = 'b100;
		end
		if (400 <= currentCol && currentCol <= 479) begin
			index[5:3] = 'b101;
		end
		if (480 <= currentCol && currentCol <= 559) begin
			index[5:3] = 'b110;
		end
		if (560 <= currentCol && currentCol <= 639) begin
			index[5:3] = 'b111;
		end

		//Se cambia los valores de fila real por el valor a memoria ram equivalente
		if (0 <= currentRow && currentRow <= 59) begin
			index[2:0] = 'b000;
		end
		if (60 <= currentRow && currentRow <= 119) begin
			index[2:0] = 'b001;
		end
		if (120 <= currentRow && currentRow <= 179) begin
			index[2:0] = 'b010;
		end
		if (180 <= currentRow && currentRow <= 239) begin
			index[2:0] = 'b011;
		end
		if (240 <= currentRow && currentRow <= 299) begin
			index[2:0] = 'b100;
		end
		if (300 <= currentRow && currentRow <= 359) begin
			index[2:0] = 'b101;
		end
		if (360 <= currentRow && currentRow <= 419) begin
			index[2:0] = 'b110;
		end
		if (420 <= currentRow && currentRow <= 479) begin
			index[2:0] = 'b111;
		end
	end 	

	
	RAM_PORT #(12, 6, 64) ram_inst (
		clk,
		pixelControl,
		index,
		pixelPosition,
		pixelColor,{RED_[3:0],GREEN_[3:0],BLUE_[3:0]});


    //Luis

	localparam time_to_wait = 2500000 * 3; // cantidad de ciclos con el reloj de 40ns 100ms = 2500000
	reg [2:0] pos_filas = 0;
	reg [2:0] pos_colum = 0;
	reg [24:0] timer = 0;  // reg [21:0] timer = 0; 
	always @(posedge clk_hf ) begin
	   
		if (resetn) begin
		    out_byte[7:5] <= pos_filas ;
		    out_byte[2:0] <= pos_colum ;
			if (timer < time_to_wait) begin	// Contador hasta 100ms  (cambiar para simulacion
				timer <= timer + 1;	
			end
			if (timer >= time_to_wait) begin // Si han pasado 100ms desde la ultima pulsacion (evitando rebotes)
					if (up) begin
						if (pos_filas != 0) begin
							pos_filas <= pos_filas - 1;
							timer <= 0;
						end					
					end
					else if (down) begin
						if (pos_filas != 7) begin
							pos_filas <= pos_filas + 1;
							timer <= 0;
						end
					end
					else if (left) begin
						if (pos_colum != 0) begin
							pos_colum <= pos_colum - 1;
							timer <= 0;
						end
					end
					else if (right) begin
						if (pos_colum != 7) begin
							pos_colum <= pos_colum + 1;
							timer <= 0;
						end
					end	
			end
		end
		else begin
		  out_byte <= 0;
		end
	end

	always @(*) begin
		//Si se encuentra actualmente en el back porch o front porch
		//se hace 0 los colores
		if ((currentRow == 'h7FF) || (currentCol == 'h7FF)) begin
			RED = 'h0;
			GREEN = 'h0;
			BLUE = 'h0;
		end else begin
				if (index[5:3] == pos_colum & index[2:0] == pos_filas) begin	// Pinta el cuadro de la posicion actual de otro color
					RED = 15;
					GREEN = 0;
					BLUE = 0;				
				end
				else begin
					RED = RED_;
					GREEN = GREEN_;
					BLUE = BLUE_;						
				end
			end
	end
	
	generate if (FAST_MEMORY) begin
		always @(posedge clk) begin
            
			mem_ready <= 1;
			out_byte_en <= 0;
			mem_rdata <= memory[mem_la_addr >> 2];
			if (mem_la_write && (mem_la_addr >> 2) < MEM_SIZE) begin
				if (mem_la_wstrb[0]) memory[mem_la_addr >> 2][ 7: 0] <= mem_la_wdata[ 7: 0];
				if (mem_la_wstrb[1]) memory[mem_la_addr >> 2][15: 8] <= mem_la_wdata[15: 8];
				if (mem_la_wstrb[2]) memory[mem_la_addr >> 2][23:16] <= mem_la_wdata[23:16];
				if (mem_la_wstrb[3]) memory[mem_la_addr >> 2][31:24] <= mem_la_wdata[31:24];
			end
			else begin
				//Luis
				if (mem_la_write && mem_la_addr == 32'h1000_0000) begin
					out_byte_en <= 1;
					pixelPosition <= mem_la_wdata;
				end
				if (mem_la_write && mem_la_addr == 32'h1000_0004) begin
					out_byte_en <= 1;
					pixelColor <= mem_la_wdata;
				end
				if (mem_la_write && mem_la_addr == 32'h1000_0008) begin
					out_byte_en <= 1;
					pixelControl <= mem_la_wdata;
				end
				//Luis				
			end

		end
	end else begin
		always @(posedge clk) begin
			m_read_en <= 0;
			mem_ready <= mem_valid && !mem_ready && m_read_en;

			m_read_data <= memory[mem_addr >> 2];
			mem_rdata <= m_read_data;

			out_byte_en <= 0;

			(* parallel_case *)
			case (1)
				mem_valid && !mem_ready && !mem_wstrb && (mem_addr >> 2) < MEM_SIZE: begin
					m_read_en <= 1;
				end
				mem_valid && !mem_ready && |mem_wstrb && (mem_addr >> 2) < MEM_SIZE: begin
					if (mem_wstrb[0]) memory[mem_addr >> 2][ 7: 0] <= mem_wdata[ 7: 0];
					if (mem_wstrb[1]) memory[mem_addr >> 2][15: 8] <= mem_wdata[15: 8];
					if (mem_wstrb[2]) memory[mem_addr >> 2][23:16] <= mem_wdata[23:16];
					if (mem_wstrb[3]) memory[mem_addr >> 2][31:24] <= mem_wdata[31:24];
					mem_ready <= 1;
				end
				mem_valid && !mem_ready && |mem_wstrb && mem_addr == 32'h1000_0000: begin
					out_byte_en <= 1;
					//out_byte <= mem_wdata;
					mem_ready <= 1;
				end
			endcase
		end
	end endgenerate
endmodule
