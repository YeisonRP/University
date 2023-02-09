/* `timescale 1 ns / 1 ps

module system_tb; //No necesita entradas o salidas porque es un testbench
	reg clk = 1;
	always #5 clk = ~clk;

    reg clk_key = 1;
	reg resetn = 0;
	reg [1:0] data_key = 0;

	initial begin
		if ($test$plusargs("vcd")) begin
			$dumpfile("system.vcd");
			$dumpvars(0, system_tb);
		end
		@(posedge clk);
		resetn <= 0;
		@(posedge clk);
		resetn <= 0;
		@(posedge clk);
		resetn <= 1;
		@(posedge clk);
		repeat (11) @(posedge clk) begin
		  data_key <= data_key + 1;
		  clk_key <= ~clk_key;
		end
		
	       clk_key <= 1;
	       
	       @(posedge clk)
	        data_key <= data_key + 1;
	        
	       @(posedge clk)
	        data_key <= data_key + 1;
	       @(posedge clk)
		
		repeat (11) @(posedge clk) begin
		  data_key <= data_key + 1;
		  clk_key <= ~clk_key;
		end		  
		  
		@(posedge clk)
		
		@(posedge clk)
		@(posedge clk)

		$finish;
	end

	wire tec_se;
	wire [7:0] tec_hex;

	system uut (   //Unit under test
		.clk_keyboard        (clk_key        ),
		.data_keyboard     (data_key[1]     ),
		.reset       (resetn       ),
		.tec_serial   (tec_se   ),
		.tec_hex(tec_hex)
	);


endmodule
*/


`timescale 1 ns / 1 ps

module system_tb;
	reg clk = 1;
	always #5 clk = ~clk;

	reg resetn = 0;
	initial begin
		if ($test$plusargs("vcd")) begin
			$dumpfile("system.vcd");
			$dumpvars(0, system_tb);
		end
		repeat (100) @(posedge clk);
		resetn <= 1;
	end

	wire trap;
	wire [7:0] out_byte;
	wire out_byte_en;
	wire [3:0] RED,GREEN,BLUE;
	wire HS,VS;

	system uut (
		.clk        (clk        ),
		.resetn     (resetn     ),
		.trap       (trap       ),
		.out_byte   (out_byte   ),
		.out_byte_en(out_byte_en),
		.RED	    (RED),
		.GREEN		(GREEN),
		.BLUE		(BLUE),
		.HS			(HS),
		.VS			(VS)
	);

	always @(posedge clk) begin
		if (resetn && out_byte_en) begin
			$write("%c", out_byte);
			$fflush;
		end
		if (resetn && trap) begin
			$finish;
		end
	end
endmodule
