module tb_ram_infer;

	// Inputs
	reg [7:0] data;
	reg [5:0] read_addr, write_addr;
	reg we, clk;
	
	// Output
	wire [7:0] q;
	
	// Instantiate the RAM module
	ram_infer uut (
		.data(data),
		.read_addr(read_addr),
		.write_addr(write_addr),
		.we(we),
		.clk(clk),
		.q(q)
	);
	
	initial begin
		// Display the header for the output
		$display("Time	data	read_addr	write_addr	we	q");
		// Monitor changes to inputs and outputs
		$monitor("%0d	%b	%b	%b	%b	%b", $time, data, read_addr, write_addr, we, q);
		
		clk = 0;
		forever #5 clk = ~clk;
		
		// Initialize signals
		data = 8'hAA;
		read_addr = 6'h00;
		write_addr = 6'h00;
		we = 0;
		
		#10;
		we = 1;
		write_addr = 6'h0F;
		#10;
		we = 0;
		read_addr = 6'h0F;
		#10;
		read_addr = 6'hFF;
		#10;
		data = 8'hBB;
		write_addr = 6'h0A;
		we = 1;
		#10;
		read_addr = 6'h0A;
		#10;
		read_addr = 6'h0B;
		#10;
		$finish;
	end
	
endmodule