`timescale 1 ns / 1 ps

module system (
	input            clk,
	input            resetn,
	output           trap,
	output reg [7:0] out_byte,
	output reg       out_byte_en,
	output reg [7:0] out_enable_digit
);
	// set this to 0 for better timing but less performance/MHz
	parameter FAST_MEMORY = 1;

	// 4096 32bit words = 16kB memory
	parameter MEM_SIZE = 16384;

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

	// Yeison
	reg [10:0] contador1;
	reg [15:0] out_byte_aux;
	reg [3:0] num_en_disp;
	reg [2:0] contador_hasta_5 = 0;
	reg [15:0] datos_impares [2:0]; // 15 columnas, 5 datos (sobran 3)

	reg [28:0] contador_5_segundos;
	reg [2:0] contador_5_segundos_hasta_4;

	picorv32 picorv32_core (
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

	generate if (FAST_MEMORY) begin
		always @(posedge clk) begin
			//CONTADOR PARA logica de salida
			if (resetn == 0) begin
				out_enable_digit <= 'b11111100;
				contador1 <= 'b11111100;
				contador_hasta_5 <= 7;
				contador_5_segundos <= 0;
				contador_5_segundos_hasta_4 <= 0;
			end
			else begin
				contador1 <= contador1 + 1;
				if(contador1  < 512) begin
					out_enable_digit <= 'b11111110;
					num_en_disp <= out_byte_aux[3:0];
				end
				if(contador1 > 512 & contador1 < 1024) begin
					out_enable_digit <= 'b11111101;	
					num_en_disp <= out_byte_aux[7:4];
				end
				if(contador1  > 1024 & contador1 < 1536) begin
					out_enable_digit <= 'b11111011;
					num_en_disp <= out_byte_aux[11:8];
				end
				if(contador1  > 1536 & contador1 < 2048) begin
					out_enable_digit <= 'b11110111;	
					num_en_disp <= out_byte_aux[15:12];
				end
			end
			
			// Logica para mandar los 5 numeros //
			contador_5_segundos <= contador_5_segundos + 1; 
			if (contador_5_segundos == 0) begin
				contador_5_segundos_hasta_4 <= contador_5_segundos_hasta_4 + 1;
			end
			if (contador_5_segundos_hasta_4 == 6) begin
				contador_5_segundos_hasta_4 <= 0;
			end	
			out_byte_aux <= datos_impares[contador_5_segundos_hasta_4]; //Guarda el dato que toca cada 5 seg en oout_byte_aux

			case (num_en_disp)
				4'b0000  : out_byte <= 'b00000011;
				4'b0001  : out_byte <= 'b10011111;
				4'b0010  : out_byte <= 'b00100101;
				4'b0011  : out_byte <= 'b00001101;
				4'b0100  : out_byte <= 'b10011001;
				4'b0101  : out_byte <= 'b01001001;
				4'b0110  : out_byte <= 'b01000001;
				4'b0111  : out_byte <= 'b00011111;
				4'b1000  : out_byte <= 'b00000001;
				4'b1001  : out_byte <= 'b00001001;
				4'b1010  : out_byte <= 'b00010001;
				4'b1011  : out_byte <= 'b11000001;
				4'b1100  : out_byte <= 'b01100011;
				4'b1101  : out_byte <= 'b10000101;
				4'b1110  : out_byte <= 'b01100001;
				4'b1111  : out_byte <= 'b01110001;
				default : out_byte <= 'b00010000; 
			endcase
		

			mem_ready <= 1;
			out_byte_en <= 0;
			mem_rdata <= memory[mem_la_addr >> 2];
			if (mem_la_write && (mem_la_addr >> 2) < MEM_SIZE) begin
				if (mem_la_wstrb[0]) memory[mem_la_addr >> 2][ 7: 0] <= mem_la_wdata[ 7: 0];
				if (mem_la_wstrb[1]) memory[mem_la_addr >> 2][15: 8] <= mem_la_wdata[15: 8];
				if (mem_la_wstrb[2]) memory[mem_la_addr >> 2][23:16] <= mem_la_wdata[23:16];
				if (mem_la_wstrb[3]) memory[mem_la_addr >> 2][31:24] <= mem_la_wdata[31:24];
			end
			else
			if (mem_la_write && mem_la_addr == 32'h1000_0000) begin
			    datos_impares[contador_hasta_5] <= mem_la_wdata; // Guardando el dato 0 inpar
		      	contador_hasta_5 <= contador_hasta_5 + 1;        // Contador para saber cual dato sigue
				out_byte_en <= 1;
				//out_byte_aux <= mem_la_wdata;
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
					out_byte_aux <= mem_wdata;
					mem_ready <= 1;
				end
			endcase
		end
	end endgenerate
endmodule
