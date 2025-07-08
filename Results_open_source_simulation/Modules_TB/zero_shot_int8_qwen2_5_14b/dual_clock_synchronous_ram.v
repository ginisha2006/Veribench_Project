module tb_ram_dual;

	reg [7:0] data_in;
	reg [5:0] read_address, write_address;
	reg write_enable, read_clk, write_clk;
	wire [7:0] q_out;

	ram_dual dut (
		.data(data_in),
		.read_addr(read_address),
		.write_addr(write_address),
		.we(write_enable),
		.read_clock(read_clk),
		.write_clock(write_clk),
		.q(q_out)
	);
	
	initial begin
		data_in = 8'b0;
		read_address = 6'b0;
		write_address = 6'b0;
		write_enable = 0;
		read_clk = 0;
		write_clk = 0;
		
		#10; // Initial delay
		
		for(int i=0; i<2; i=i+1) begin
			@(negedge read_clk);
			@(negedge write_clk);
			
			// Write operation
			data_in = 8'hAA + i;
			write_address = 6'h10 + i;
			write_enable = 1;
			@(negedge write_clk);
			write_enable = 0;
			
			// Read operation
			read_address = 6'h10 + i;
			@(negedge read_clk);
			$display("Read Address %b, Expected Data %h, Actual Data %h", read_address, 8'hAA+i, q_out);
		end
		
		// Edge case - simultaneous read/write on same address
		data_in = 8'hFF;
		read_address = 6'h1F;
		write_address = 6'h1F;
		write_enable = 1;
		@(negedge write_clk);
		write_enable = 0;
		@(negedge read_clk);
		$display("Simultaneous RW at addr %b, Expected Data %h, Actual Data %h", read_address, 8'hFF, q_out);
		
		// Corner case - reading before writing
		read_address = 6'h20;
		@(negedge read_clk);
		$display("Reading before writing at addr %b, Expected Data %h, Actual Data %h", read_address, 8'h00, q_out);
		
		// Corner case - writing beyond max address
		data_in = 8'hAB;
		write_address = 6'h3F;
		write_enable = 1;
		@(negedge write_clk);
		write_enable = 0;
		@(negedge read_clk);
		read_address = 6'h3F;
		@(negedge read_clk);
		$display("Writing beyond max addr %b, Expected Data %h, Actual Data %h", read_address, 8'hAB, q_out);
		
		// Final check for initial state
		read_address = 6'h00;
		@(negedge read_clk);
		$display("Initial state check at addr %b, Expected Data %h, Actual Data %h", read_address, 8'h00, q_out);
		
		$finish;
	end
	
	always #5 read_clk = ~read_clk;
	always #10 write_clk = ~write_clk;
	
endmodule