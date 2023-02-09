`timescale 1 ns / 1 ps

module sumador (
    input wA,
    input wB,
    input in_carry,
    output wResult,
    output wCarry
);

    assign {wCarry, wResult} = wA + wB + in_carry;

endmodule


module system (
	input            clk,
	input            resetn,
	output           trap,
	output reg [31:0] 	out_byte,
	output reg			out_byte_en
);
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

	// Yeison
    reg [15:0] a; 
    reg [15:0] b;

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

// MULTIPLICADOR

    parameter N = 16;

    genvar i, j;
    wire [N:0] wCarry_in [N-2:0];             //  columnas y luego filas
    wire [N:0] resultados_entrada [N-1:0];    //  columnas y luego filas

    assign resultados_entrada [0][0] = 'b0;
    generate 
        for (i = 0; i < N-1 ; i = i + 1 ) begin   
            assign wCarry_in [i][N] = 'b0; // todos carry entrada de la derecha son 0 
            assign resultados_entrada [i+1][0] = wCarry_in [i][0]; // asigna los carry a la barra de entrada//salida
            for (j = 0; j < N ; j = j + 1 ) begin 
                assign resultados_entrada[0][j+1] = a[(N-1) - j] & b[0]; // Las lineas de arriba se les asigna un valor, menos a la 0,0 que se le asigna fuera del generate
                sumador mult( 
                .wA( a[(N-1) - j] & b[i + 1] ) ,                    // Listo
                .wB(resultados_entrada [i][j]),                 // Listo
                .in_carry( wCarry_in [i][j+1] ),                // Listo
                .wResult( resultados_entrada [i + 1][j+1] ),    // Listo
                .wCarry( wCarry_in [i][j] )   );                // Listo 
            end // for de j        
        end // for de i 
    endgenerate

	integer f,c;
	always @(*) begin
		out_byte[0] = a[0] & b[0];
		for(f = 0; f < N-1; f = f + 1) begin
			out_byte[f + 1] = resultados_entrada[f+1][N];
		end
		for(c = 0; c < N; c = c + 1) begin
			out_byte[N + c] = resultados_entrada[N-1][N-1-c];
		end
	end


// MULTIPLICADOR

	generate if (FAST_MEMORY) begin
		always @(posedge clk) begin
		// Yeison	
			if (resetn == 0) begin
				a <= 0;
				b <= 0;
			end	
				

			mem_ready <= 1;
			mem_rdata <= memory[mem_la_addr >> 2];
			if (mem_la_write && (mem_la_addr >> 2) < MEM_SIZE) begin
				if (mem_la_wstrb[0]) memory[mem_la_addr >> 2][ 7: 0] <= mem_la_wdata[ 7: 0];
				if (mem_la_wstrb[1]) memory[mem_la_addr >> 2][15: 8] <= mem_la_wdata[15: 8];
				if (mem_la_wstrb[2]) memory[mem_la_addr >> 2][23:16] <= mem_la_wdata[23:16];
				if (mem_la_wstrb[3]) memory[mem_la_addr >> 2][31:24] <= mem_la_wdata[31:24];
			end
			else
			if (mem_la_write && mem_la_addr == 32'h0FFF_FFF0) begin
				out_byte_en <= 1;
				a <= mem_la_wdata;
			end
			if (mem_la_write && mem_la_addr == 32'h0FFF_FFF4) begin
				out_byte_en <= 1;
				b <= mem_la_wdata;
			end
			if (mem_la_read && mem_la_addr == 32'h0FFF_FFF8) begin
				out_byte_en <= 1;
				mem_rdata <= out_byte;
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
					//out_byte_aux <= mem_wdata;
					mem_ready <= 1;
				end
			endcase
		end
	end endgenerate
endmodule
