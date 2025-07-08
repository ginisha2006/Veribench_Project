module tb_ram_dual;

	// Inputs
	reg [7:0] data;
	reg [5:0] read_addr, write_addr;
	reg we, read_clock, write_clock;

	// Output
	wire [7:0] q;

	// Instantiate the DUT
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
		$display("Time	data	read_addr	write_addr	we	read_clock	write_clock	q");
		// Monitor changes to inputs and outputs
		$monitor("%0d	%b	%b	%b	%b	%b	%b	%b", $time, data, read_addr, write_addr, we, read_clock, write_clock, q);

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
		@(negedge write_clock) data = 8'hAA; write_addr = 6'h01; we = 1; @(posedge write_clock); we = 0;
		@(negedge read_clock) read_addr = 6'h01; @(posedge read_clock);

		// Test case 2: Write with different address then Read
		@(negedge write_clock) data = 8'hBB; write_addr = 6'h02; we = 1; @(posedge write_clock); we = 0;
		@(negedge read_clock) read_addr = 6'h02; @(posedge read_clock);

		// Test case 3: Write with same address then Read
		@(negedge write_clock) data = 8'hCC; write_addr = 6'h01; we = 1; @(posedge write_clock); we = 0;
		@(negedge read_clock) read_addr = 6'h01; @(posedge read_clock);

		// Test case 4: No write, just read from initial state
		@(negedge read_clock) read_addr = 6'h00; @(posedge read_clock);

		// Finish the simulation
		$finish;
	end
endmodule