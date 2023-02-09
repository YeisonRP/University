`timescale 1 ns / 1 ps

module system_tb;
	reg clk = 1;
	reg mouse_clk = 0;
	reg mouse_data = 0;

	always #5 clk = ~clk;
	always #30000 mouse_clk = ~mouse_clk;

	reg resetn = 0;
	initial begin
		if ($test$plusargs("vcd")) begin
			$dumpfile("system.vcd");
			$dumpvars(0, system_tb);
		end

		
		repeat (400) @(posedge clk);
		

		resetn <= 1;
		repeat (400) @(posedge clk) begin
			
		end

		@(negedge mouse_clk);
			mouse_data <= 1;

	//   $finish;	
		
	end

	wire [15:0] out_byte;
	wire [3:0] RED,GREEN,BLUE;
	wire HS,VS;

	system uut (
		.clk        	(clk        ),
		.resetn     	(resetn     ),
		.mouse_clk		(mouse_clk),
		.mouse_data		(mouse_data),
		.out_byte   	(out_byte   ),
		.RED	    	(RED),
		.GREEN			(GREEN),
		.BLUE			(BLUE),
		.HS				(HS),
		.VS				(VS)
	);

endmodule
