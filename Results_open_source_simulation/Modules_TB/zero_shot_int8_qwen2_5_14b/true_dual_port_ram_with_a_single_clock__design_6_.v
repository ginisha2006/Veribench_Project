module tb_true_dpram_sclk;

	reg [7:0] data_a, data_b;
	reg [5:0] addr_a, addr_b;
	reg we_a, we_b;
	reg clk;
	wire [7:0] q_a, q_b;

	true_dpram_sclk dut (
		.data_a(data_a),
		.data_b(data_b),
		.addr_a(addr_a),
		.addr_b(addr_b),
		.we_a(we_a),
		.we_b(we_b),
		.clk(clk),
		.q_a(q_a),
		.q_b(q_b)
	);

	initial begin
		clk = 0;
		forever #5 clk = ~clk;
	end

	initial begin
		data_a = 8'b0; addr_a = 6'b0; we_a = 0;
		data_b = 8'b0; addr_b = 6'b0; we_b = 0;
		#10;

		// Test case 1: Write to port A, read from port B
		data_a = 8'hAA; addr_a = 6'b000000; we_a = 1;
		addr_b = 6'b000000; we_b = 0;
		#10;
		assert(q_b == 8'hAA); $display("Test Case 1 Passed");
		
		// Test case 2: Write to port B, read from port A
		data_b = 8'hBB; addr_b = 6'b000001; we_b = 1;
		addr_a = 6'b000001; we_a = 0;
		#10;
		assert(q_a == 8'hBB); $display("Test Case 2 Passed");

		// Test case 3: Concurrent writes to both ports
		data_a = 8'hCC; addr_a = 6'b000010; we_a = 1;
		data_b = 8'hDD; addr_b = 6'b000011; we_b = 1;
		#10;
		addr_a = 6'b000010; we_a = 0;
		addr_b = 6'b000011; we_b = 0;
		#10;
		assert(q_a == 8'hCC && q_b == 8'hDD); $display("Test Case 3 Passed");

		// Test case 4: Read after write on same address
		data_a = 8'hEE; addr_a = 6'b000100; we_a = 1;
		addr_a = 6'b000100; we_a = 0;
		#10;
		assert(q_a == 8'hEE); $display("Test Case 4 Passed");

		// Test case 5: Edge case - out-of-bounds addresses
		data_a = 8'hFF; addr_a = 6'b111111; we_a = 1;
		addr_a = 6'b111111; we_a = 0;
		#10;
		assert(q_a == 8'hFF); $display("Test Case 5 Passed");

		$stop;
	end

endmodule