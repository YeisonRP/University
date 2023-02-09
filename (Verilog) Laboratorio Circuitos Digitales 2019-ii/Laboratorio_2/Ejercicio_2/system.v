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
	output [7:0] 	out_byte,
	output reg       out_byte_en
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
    reg [3:0] a; 
    reg [3:0] b;

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

    wire [11:0] c;
    wire [5:0] ld; //line down

    // entrada 1 , entrada 2, carry entrada, resultado, carry resultado

    assign out_byte[0] = a[0] & b[0]; // R0
    sumador R1(a[0] & b[1], a[1] & b[0],1'b0, out_byte[1],c[0]);   //R1 
    sumador x0(a[2] & b[0] ,a[1] & b[1] , c[0] ,ld[0] , c[1] );  
    sumador x1(a[3] & b[0], a[2] & b[1] ,c[1] ,ld[1], c[2]);  
    sumador x2( 1'b0 , a[3] & b[1] , c[2] , ld[2] , c[3]);  
    sumador R2( ld[0] , a[0] & b[2] , 1'b0 , out_byte[2] , c[4] );  //R2
    sumador y0( ld[1] , a[1] & b[2] , c[4] , ld[3] , c[5] );  
    sumador y1( ld[2] , a[2] & b[2] , c[5] , ld[4] , c[6] );  
    sumador y2( a[3] & b[2] , c[3] , c[6] , ld[5] , c[7] );  
    sumador R3( ld[3] , a[0] & b[3] , 1'b0 , out_byte[3] , c[8] );  
    sumador R4( ld[4], a[1] & b[3] , c[8] , out_byte[4] , c[9] );  
    sumador R5( ld[5] , a[2] & b[3] , c[9] , out_byte[5] , c[10] );  
    sumador R6( c[7] , a[3] & b[3] , c[10] , out_byte[6] , out_byte[7] );  

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
