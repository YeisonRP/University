 `timescale 1 ns / 1 ps


/*
 * clk: Es el reloj de entrada
 * resetn: Senal de reset
 * signal: Senal a contar los flancos crecientes
 * contador: Registro que lleva la cuenta de los flancos encontrados
 */
module detector_flanco_creciente(
	input clk,
	input resetn,
	input signal,
	output reg [19:0] contador
);

	reg [2:0] estado, estado_proximo;

	parameter ENTRADA_BAJA = 0;
	parameter PULSO = 2;
	parameter ENTRADA_ALTA = 4;
	 

	// Logica secuencial que maneja
	always @(posedge clk ) begin
		if (resetn == 0) begin
			estado <= 0;
			contador <= 0;
		end
		else begin
		  if(estado == PULSO) begin
		      contador <= contador + 1;
		  end
			estado <= estado_proximo;
		end
	end

	always @(*) begin
		if (resetn == 0) begin
			
			estado_proximo = 0;
		end

		estado_proximo = estado;
		case (estado) 
			ENTRADA_BAJA: begin
				if (signal) begin
					estado_proximo= PULSO;
				end
			end

			PULSO: begin
				if (signal) begin
					estado_proximo = ENTRADA_ALTA;
				end
				else begin
					estado_proximo = ENTRADA_BAJA;
				end
			end

			ENTRADA_ALTA: begin
				if (!signal) begin
					estado_proximo = ENTRADA_BAJA;
				end
			end

			default:
				estado_proximo = ENTRADA_BAJA;
		endcase
	end


endmodule


/*	
 * input mem_valid: CUando se levanta esta senal el procesador escribe el dato que esta en mem_wdata en la direccion mem_addr. SOLO DEBE ACTIVARSE UN CICLO DE RELOJ ESTA SENAL   
 * input mem_addr: Direccion a leer o escribir el dato
 * input mem_wdata: Dato a escribir en la memoria
 * input mem_wrstrb: Si es 0 es una lectura, otro valor es una escritura
 * input mem_wdata: Dato a escribir
 * output mem_rdata: Dato que se leyo de la memoria 
 * output mem_ready: Manda un pulso cuando se escribe un dato en mem_wdata 
 */
module RAM_PORT #( parameter DATA_WIDTH = 32, parameter ADDR_WIDTH = 32, parameter MEM_SIZE = 64) (
	input wire 						clk,
	input wire 						mem_valid, 	// Valido para escribir el dato
	input wire [ADDR_WIDTH-1:0] 	mem_addr, 	// direccion escritura o lectura
	input wire [DATA_WIDTH-1:0]		mem_wdata, 	// Dato a escribir
	input wire [3:0]				mem_wrstrb, // 
	output reg [DATA_WIDTH-1:0] 	mem_rdata, // dato leido
	output reg 						mem_ready  // dato listo
); 

	reg [DATA_WIDTH-1:0] RAM [MEM_SIZE-1:0];
	

	always @(posedge clk) begin
		mem_ready <= 0;

		if (mem_wrstrb == 0) begin // lectura
			mem_rdata <= RAM[mem_addr];
		end
		else begin   // escritura
			if (mem_valid) begin
				RAM[mem_addr] <= mem_wdata;
			end
			mem_ready <= 1; 	
		end
	end

endmodule


module cache(
	input 			clk,
	input			resetn,
	output  		[31:0] hit,
	output 		  	[31:0] miss,
	input 			[31:0] address,
	input 			valid,
	input 			instr,
	output reg 		ready,
	input [31:0] 	wdata,
	input [3:0] 		wstrb,
	output reg [31:0] 		rdata,

	output reg		[31:0] address_mp,
	output reg 		valid_mp,
	output reg 		instr_mp,
	input	 		ready_mp,
	output reg [31:0] wdata_mp,
	output reg [3:0] wstrb_mp,
	input [31:0] 	rdata_mp
);

	parameter CACHE_SIZE = 4;
	parameter BLOCK_SIZE = 8;
	parameter INDEX_SIZE = CACHE_SIZE*1024/(BLOCK_SIZE*2*4);
	parameter OFFSET_BITS = $clog2((BLOCK_SIZE)/4);
	parameter INDEX_BITS = $clog2((INDEX_SIZE)/4);
	
	//Datos para guardar la entrada
	reg 			[31:0] address_;
	reg 			instr_;
	reg [31:0] 		wdata_;
	reg [3:0] 		wstrb_;
	reg [5:0]        test;

	//Datos de la cache
	reg [31:0] cacheData1 [BLOCK_SIZE-1:0] [INDEX_SIZE-1:0];
	reg [31:0] cacheData2 [BLOCK_SIZE-1:0] [INDEX_SIZE-1:0];

	//Tags de la cache
	reg [31:0] tag1 [INDEX_SIZE-1:0];
	reg [31:0] tag2 [INDEX_SIZE-1:0];
	
	//Bits de LRU
	reg cacheLRU[INDEX_SIZE-1:0];

	//Bits de dirty
	reg cacheDirty1[INDEX_SIZE-1:0];
	reg cacheDirty2[INDEX_SIZE-1:0];

	
	reg [OFFSET_BITS-1:0] offset; 
	reg [INDEX_BITS-1:0] index;
	reg [31-INDEX_BITS-OFFSET_BITS:0] tag;
	reg [OFFSET_BITS:0] mod;
	reg [OFFSET_BITS:0] mod_temp;
	reg replace;
	reg gotHit, gotMiss;
	reg [OFFSET_BITS:0] i;
	reg waitData;
	reg [5:0] ST, NXT_ST;

	integer j,k;



	parameter IDLE = 0;
	parameter CHECK_HIT = 1;
	parameter WRITE_MEM = 2;
	parameter LOAD_MISS1 = 4;
	parameter LOAD_MISS2 = 8;
	parameter READ_WRITE = 16;
	

	
	always @(posedge clk) begin

		if(!resetn) begin
			ST <= IDLE;
		end else begin
			ST <= NXT_ST;
		end	
	end 

	detector_flanco_creciente detec_hit(clk, resetn, gotHit, hit);
	detector_flanco_creciente detec_miss(clk, resetn, gotMiss, miss);
	

	always @(*) begin	

		if(!resetn) begin

			mod = 'b0;	//Se actualizan variables
			ready = 'b0;
			test = 'b0;
			address_ = 'b0;
			wdata_ = 'b0;
            gotHit = 'b0;
            gotMiss = 'b0;
            rdata = 'b0;
            valid_mp = 'b0;
            wdata_mp = 'b0;
            wstrb_mp  = 'b0;
            instr_mp  = 'b0;
            waitData  = 'b0;
            
            
			for (k = 0; k < INDEX_SIZE; k=k+1) begin
				tag1[i] = 'b0;
				tag2[i] = 'b0;
				cacheLRU[i] = 'b1;
				for (j = 0; j < BLOCK_SIZE; j=j+1) begin
					cacheData1[i][j] = 'b0;
					cacheData2[i][j] = 'b0; 
				end
			end			
		end else begin

			case(ST)

				IDLE: begin		//Estado IDLE
				    ready = 0;		//Inicializa ready
					if (valid == 'b1) begin		//Si se tiene bit de valid, secontinua a Check hit
						address_ = address;
						wdata_ = wdata;
						wstrb_ = wstrb;
						instr_ = instr;
						NXT_ST = CHECK_HIT;
					end
				end	


				//////////////BEGIN/////////////////////CHECK_HIT//////////////////BEGIN////////////////////

				CHECK_HIT: begin //Sección de lógica para verificación de hit

					offset = address_[OFFSET_BITS-1:0];
					index = address_[INDEX_SIZE+OFFSET_BITS-1:OFFSET_BITS];
					tag = address_[31:INDEX_SIZE+OFFSET_BITS];
		

					if (tag == cacheData1[index][offset]) begin //Se verifica si hay hit en cache1
			
						cacheLRU[index] = 'b0;					//Se actualizan las banderas
						gotHit = 'b1;				 
						gotMiss = 'b0;
						if (wstrb_ == 'b0000) begin				//En caso de read se envía el dato de lectura
							rdata = cacheData1[index][offset];
							ready = 'b1;
						end	else begin 
							cacheData1[index][offset] = wdata_;	//En caso de write se escribe en caché y se actualiza el dirty
							cacheDirty1[index] = 'b1;
						end		
						NXT_ST = IDLE;							//Siguiente estado es idle

					end else begin
						if (tag == cacheData2[index][offset]) begin	//Se verifica si hay hit en cache2

							cacheLRU[index] = 'b1;					//Se actualizan las banderas
							gotHit = 'b1;
							gotMiss = 'b0;
							if (wstrb_ == 'b0000) begin				//En caso de read se envía el dato de lectura
								rdata = cacheData2[index][offset];
								ready = 'b1;
							end	else begin 				
								cacheData2[index][offset] = wdata_;  //En caso de write se escribe en caché y se actualiza el dirty
								cacheDirty2[index] = 'b1;
							end		
							NXT_ST = IDLE;							//Siguiente estado es idle


						end else begin								//Si no hay hits se actualizan banderas de miss
						    gotMiss = 'b1;
						    gotHit = 'b0;
						    mod = address/4 % (BLOCK_SIZE/4);		//Se calcula el modulo del address a buscar
						    NXT_ST = WRITE_MEM;						//SIguiente estado es escritura de memoria
		        		end
					end
				end ///////////////END////////////////////CHECK_HIT//////////////////END////////////////////


				///////////////BEGIN////////////////////WRITE_MEM//////////////////BEGIN////////////////////

				WRITE_MEM: begin

					if(cacheDirty2[index] && !cacheLRU[index]) begin //Si se debe reemplazar y la cache a reemplazar (2) está en dirty
															 	 //se envian los datos a la memoria principal		
						if(!ready_mp) begin
							address_mp = {tag2[index],index,i};	//Dirección de datos a guardar
							valid_mp = 'b1;							//Valid a MP
							wdata_mp = cacheData2[index][i];	//Datos a guardar
							instr_mp = instr;
							wstrb_mp = 'b1111;							//Comando de escritura

							i = i + 1;									//Se suma 1 a i
				
							if(i == BLOCK_SIZE/4-1) begin				//Si ya se envió todo el bloque, se limpia dirty y el siguiente estado es load miss
								cacheDirty2[index] = 0;
								NXT_ST = LOAD_MISS2;
							end

							if(i>=BLOCK_SIZE/4)	begin					//Si ya se envió todo el bloque, el contador se reinicia
								i = 'b0;
							end
						end
					end

					if(cacheDirty1[index] && cacheLRU[index]) begin //Si se debe reemplazar y la cache a reemplazar (1) está en dirty
															  	//se envian los datos a la memoria principal		
						if(!ready_mp) begin
							address_mp = {tag1[index],index,i};	//Dirección de datos a guardar
							valid_mp = 'b1;							//Valid a MP
							wdata_mp = cacheData1[index][i];	//Datos a guardar
							instr_mp = instr;
							wstrb_mp = 'b1111;							//Comando de escritura

							i = i + 1;									//Se suma 1 a i
				
							if(i == BLOCK_SIZE/4-1) begin				//Si ya se envió todo el bloque, se limpia dirty y el siguiente estado es load miss
								cacheDirty1[index] = 0;
								NXT_ST = LOAD_MISS1;
							end

							if(i>=BLOCK_SIZE/4)	begin				//Si ya se envió todo el bloque, el contador se reinicia
								i = 'b0;
							end
						end
					end
				end		///////////////END////////////////////WRITE_MEM//////////////////END////////////////////
		

				///////////////BEGIN////////////////////LOAD_MISS//////////////////BEGIN////////////////////

				LOAD_MISS2: begin

					if(!cacheDirty2[index] && !cacheLRU[index]) begin //Se debe traer el bloque solicitado de mp		
	
						if(!ready_mp && !waitData) begin						//Si mem ready, se solicita 1 dato
							address_mp = address-mod+i;
							valid_mp = 'b1;
							instr_mp = instr;
							wstrb_mp = 'b0000;

							i = i + 1;							//Se itera al siguiente dato

							if(i == BLOCK_SIZE/4-1) begin    	//Si es el último dato, se actualiza lru y se da nxt st
								cacheLRU[index] = 1;
								tag2[index] = tag; 
								NXT_ST = READ_WRITE;			//Siguiente estado es el de enviar los datos al CPU
							end

							if(i>=BLOCK_SIZE/4)	begin			//Si es el último, se reinicia el contador
								i = 'b0;
							end
						end

						if(!ready_mp) begin						//Si la memoria no está lista, se activa wait
				 			waitData = 'b1;
						end

						if (ready_mp && waitData) begin			//Si está lista y wait esta activada, se carga el dato desde mp
							cacheData2[index][(BLOCK_SIZE/4)-mod-1+i] = rdata_mp;		//Y se termina la espera
							waitData = 'b0;
						end		
					end
				end


				LOAD_MISS1: begin 

					if(!cacheDirty1[index] && cacheLRU[index]) begin //Se debe traer el bloque solicitado de mp		

						if(!ready_mp && !waitData) begin						//Si mem ready, se solicita 1 dato
							address_mp = address-mod+i;
							valid_mp = 'b1;
							instr_mp = instr;
							wstrb_mp = 'b0000;

							i = i + 1;							//Se itera al siguiente dato

							if(i == BLOCK_SIZE/4-1) begin    	//Si es el último dato, se actualiza lru y se da nxt st
								cacheLRU[index] = 0;
								NXT_ST = READ_WRITE;			//Siguiente estado es el de enviar los datos al CPU
							end

							if(i>=BLOCK_SIZE/4)	begin			//Si es el último, se reinicia el contador
								i = 'b0;
							end
						end

						if(!ready_mp) begin						//Si la memoria no está lista, se activa wait
				 			waitData = 'b1;
						end

						if (ready_mp && waitData) begin			//Si está lista y wait esta activada, se carga el dato desde mp
							cacheData1[index][(BLOCK_SIZE/4)-mod-1+i] = rdata_mp;		//Y se termina la espera
							waitData = 'b0;
						end		
					end
				end

				READ_WRITE: begin

					if (tag == cacheData1[index][offset]) begin //Se verifica si hay hit en cache1
			
						cacheLRU[index] = 'b0;					//Se actualizan las banderas
					
						if (wstrb == 'b0000) begin				//En caso de read se envía el dato de lectura
							rdata = cacheData1[index][offset];
							ready = 'b1;
						end else begin 
							cacheData1[index][offset] = wdata;	//En caso de write se escribe en caché y se actualiza el dirty
							cacheDirty1[index] = 'b1;
						end		
						NXT_ST = IDLE;							//Siguiente estado es idle
					end else begin
						if (tag == cacheData2[index][offset]) begin	//Se verifica si hay hit en cache2

							cacheLRU[index] = 'b1;					//Se actualizan las banderas

							if (wstrb == 'b0000) begin				//En caso de read se envía el dato de lectura
								rdata = cacheData2[index][offset];
								ready = 'b1;
							end	else begin 				
								cacheData2[index][offset] = wdata;  //En caso de write se escribe en caché y se actualiza el dirty
								cacheDirty2[index] = 'b1;
							end		
							NXT_ST = IDLE;							//Siguiente estado es idle
						end						
					end
				end

				default: begin
				    test = test + 2;
					NXT_ST = ST;
			     end
			endcase
		end
	end
endmodule

module system(
	input            clk,
	input            resetn,
	output trap,
	
	output reg out_byte_en,
	output reg [7:0] out_byte
    );

	// set this to 0 for better timing but less performance/MHz
	parameter FAST_MEMORY = 0;

	// 4096 32bit words = 16kB memory
	parameter MEM_SIZE = 16384;
	
    wire [31:0] hit;
	wire [31:0] miss;

	wire mem_valid;
	wire mem_instr;
	reg mem_ready;
	wire [31:0] mem_addr;
	wire [31:0] mem_wdata;
	wire [3:0] mem_wstrb;
	reg [31:0] mem_rdata;

	wire mem_valid_cache;
	wire mem_instr_cache;
	wire mem_ready_cache;
	wire [31:0] mem_addr_cache;
	wire [31:0] mem_wdata_cache;
	wire [3:0] mem_wstrb_cache;
	wire [31:0] mem_rdata_cache;

	wire mem_la_read;
	wire mem_la_write;
	wire [31:0] mem_la_addr;
	wire [31:0] mem_la_wdata;
	wire [3:0] mem_la_wstrb;

	reg [31:0] totalAccess;
	reg	[31:0] hitRate;
	reg [31:0] missRate;

	//Se calcula el total de los accesos. el hitRate y missRate



	cache cache_mem(
	.clk			(clk),
	.resetn			(resetn),
	.hit 			(hit),
	.miss   		(miss),

	.address		(mem_addr_cache),
	.valid			(mem_valid_cache),	
	.instr 			(mem_instr_cache),
	.ready 			(mem_ready_cache),
	.wdata			(mem_wdata_cache),
	.rdata 			(mem_rdata_cache),
	.wstrb			(mem_wstrb_cache),

	.address_mp		(mem_addr),
	.valid_mp		(mem_valid),	
	.instr_mp 		(mem_instr),
	.ready_mp 		(mem_ready),
	.wdata_mp		(mem_wdata),
	.rdata_mp 		(mem_rdata),
	.wstrb_mp		(mem_wstrb)
	);

	
	picorv32 #(.ENABLE_MUL(1)) picorv32_core  (
		.clk         (clk         ),
		.resetn      (resetn      ),
		.trap        (trap        ),
		.mem_valid   (mem_valid_cache   ),
		.mem_instr   (mem_instr_cache   ),
		.mem_ready   (mem_ready_cache   ),
		.mem_addr    (mem_addr_cache    ),
		.mem_wdata   (mem_wdata_cache   ),
		.mem_wstrb   (mem_wstrb_cache   ),
		.mem_rdata   (mem_rdata_cache   ),
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

	



	generate if (FAST_MEMORY) begin
		always @(posedge clk) begin
		  if(resetn == 0) begin
		  
	totalAccess <= hit + miss;
	hitRate <= hit/totalAccess;
	missRate <= miss/totalAccess;		  
		  end
            out_byte <= 0;
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
				if (mem_la_write && mem_la_addr == 32'h1000_0000) begin
					out_byte_en <= 1;

				end
				if (mem_la_write && mem_la_addr == 32'h1000_0004) begin
					out_byte_en <= 1;
				end
				if (mem_la_write && mem_la_addr == 32'h1000_0008) begin
					out_byte_en <= 1;
				end
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
				mem_valid && !mem_ready && mem_wstrb == 'b1111 && ((mem_addr >= 32'h0000_0000) || (mem_addr < 32'h1000_4000)): begin
					out_byte_en <= 1;
					memory[mem_addr] <= mem_wdata;
					mem_ready <= 1;
				end
				mem_valid && !mem_ready && mem_wstrb == 'b0000 && ((mem_addr >= 32'h0000_0000) || (mem_addr < 32'h1000_4000)): begin
					out_byte_en <= 1;
					mem_rdata <= memory[mem_addr];
					mem_ready <= 1;
				end
			endcase
		end
	end endgenerate
endmodule
