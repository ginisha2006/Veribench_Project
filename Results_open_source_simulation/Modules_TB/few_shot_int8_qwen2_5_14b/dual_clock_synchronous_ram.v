module tb_ram_dual;

	// Inputs
	reg [7:0] data;
	reg [5:0] read_addr, write_addr;
	reg we, read_clock, write_clock;

	// Output
	wire [7:0] q;

	// Instantiate the RAM module
	ram_dual uut (
		.data(data),
		.read_addr(read_addr),
		.write_addr(write_addr),
		.we(we),
		.read_clock(read_clock),
		.write_clock(write_clock),
		.q(q)
	);

	initial begin
		// Display the header for the output
		$display("Time	data	read_addr	write_addr	we	read_clk	write_clk	q");
		// Monitor changes to inputs and outputs
		$monitor("%0d	%b	%d	%d	%b	%b	%b	%b", $time, data, read_addr, write_addr, we, read_clock, write_clock, q);

		// Initialize signals
		read_clock = 0;
		write_clock = 0;

		forever begin
			#5 read_clock = ~read_clock;
			#5 write_clock = ~write_clock;
		end
	end

	initial begin
		// Test case 1: Write then Read
		data = 8'hAA;
		write_addr = 6'd10;
		we = 1;
		#10;
		read_addr = 6'd10;
		we = 0;
		#10;

		// Test case 2: Write with different address
		data = 8'hBB;
		write_addr = 6'd20;
		we = 1;
		#10;

		// Test case 3: Read from previous write
		read_addr = 6'd20;
		we = 0;
		#10;

		// Test case 4: Write again with same address
		data = 8'hCC;
		write_addr = 6'd10;
		we = 1;
		#10;

		// Test case 5: Read from first write
		read_addr = 6'd10;
		we = 0;
		#10;

		// Test case 6: Read from second write
		read_addr = 6'd20;
		we = 0;
		#10;

		// Finish the simulation
		$finish;
	end
endmodule