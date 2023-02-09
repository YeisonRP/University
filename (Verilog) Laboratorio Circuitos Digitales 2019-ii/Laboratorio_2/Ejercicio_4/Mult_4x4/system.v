`timescale 1 ns / 1 ps

module LUTmux(
    input [3:0] A,
    input [1:0] B,
    input reset_L,
    output reg [7:0] mul);
 
    always @(*) begin
        if (reset_L) begin
            if(B == 'b00) begin
                mul = 0; 
            end
            if(B == 'b01) begin
                mul = A; 
            end
            if(B == 'b10) begin
                mul = A<<1;
            end
            if(B == 'b11) begin
                mul = (A<<1) + A;
            end     
        end 
        else begin
            mul = 'b0;
        end        
    end
endmodule


module system(
	input            clk,
	input            resetn,
	output           trap,
	output reg [7:0] out_byte,
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

	// Luis
	reg [7:0] A; 
    reg [7:0] B;
	//Luis

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

	//LUT
	wire [7:0] mul1, mul2;
    
    LUTmux mux1(A[3:0], B[1:0], resetn, mul1);
    LUTmux mux2(A[3:0], B[3:2], resetn, mul2);

    always @(*) begin
		temp = mul2 << 2;
        if (resetn) begin
            out_byte = mul1 + (mul2 << 2);  
        end else begin
            out_byte = 0;     
        end  
    end
	//LUT

	generate if (FAST_MEMORY) begin
		always @(posedge clk) begin

			if (!resetn) begin
				A <= 0;
				B <= 0;
			end	

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
				if (mem_la_write && mem_la_addr == 32'h0FFF_FFF0) begin
					out_byte_en <= 1;
					A <= mem_la_wdata;
				end
				if (mem_la_write && mem_la_addr == 32'h0FFF_FFF4) begin
					out_byte_en <= 1;
					B <= mem_la_wdata;
				end
				if (mem_la_read && mem_la_addr == 32'h0FFF_FFF8) begin
					out_byte_en <= 1;
					mem_rdata <= out_byte;
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
