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
		data_a = 8'hAA; addr_a = 6'b000000; we_a = 1;
		data_b = 8'hBB; addr_b = 6'b000001; we_b = 1;
		#10;
		addr_a = 6'b000000; we_a = 0;
		addr_b = 6'b000001; we_b = 0;
		#10;
		addr_a = 6'b000001; we_a = 0;
		addr_b = 6'b000000; we_b = 0;
		#10;
		addr_a = 6'b000010; we_a = 1;
		data_a = 8'hCC;
		addr_b = 6'b000011; we_b = 1;
		data_b = 8'hDD;
		#10;
		addr_a = 6'b000010; we_a = 0;
		addr_b = 6'b000011; we_b = 0;
		#10;
		addr_a = 6'b000011; we_a = 0;
		addr_b = 6'b000010; we_b = 0;
		#10;
		$stop;
	end

	initial begin
		$monitor($time," ns: data_a=%h, addr_a=%h, we_a=%b, q_a=%h, data_b=%h, addr_b=%h, we_b=%b, q_b=%h",data_a,addr_a,we_a,q_a,data_b,addr_b,we_b,q_b);
	end
endmodule