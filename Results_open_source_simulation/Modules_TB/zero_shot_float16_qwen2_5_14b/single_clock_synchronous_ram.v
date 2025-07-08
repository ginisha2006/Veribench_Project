module tb_ram_infer;

	reg [7:0] data;
	reg [5:0] read_addr, write_addr;
	reg we, clk;
	wire [7:0] q;

	ram_infer dut (
		.data(data),
		.read_addr(read_addr),
		.write_addr(write_addr),
		.we(we),
		.clk(clk),
		.q(q)
	);
	
	initial begin
		clk = 0;
		forever #5 clk = ~clk; // Generate clock
	end
	
	initial begin
		data = 8'b0;
		read_addr = 6'b0;
		write_addr = 6'b0;
		we = 0;
		
		#20 data = 8'hAA; write_addr = 6'h0F; we = 1; @(posedge clk); // Write operation
		#10 data = 8'hBB; write_addr = 6'h1E; we = 1; @(posedge clk); // Write operation
		#10 read_addr = 6'h0F; we = 0; @(posedge clk); // Read from address 0F
		#10 read_addr = 6'h1E; @(posedge clk); // Read from address 1E
		
		$stop;
	end
	
	initial begin
		$monitor($time," ns | Data = %h, Read Addr = %h, Write Addr = %h, We = %b, Q = %h", data, read_addr, write_addr, we, q);
	end
	
endmodule