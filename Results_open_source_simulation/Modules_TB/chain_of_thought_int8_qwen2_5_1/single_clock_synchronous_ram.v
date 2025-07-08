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
	forever #5 clk = ~clk; // Generate clock signal
end

initial begin
	data = 8'b0;
	read_addr = 6'b0;
	write_addr = 6'b0;
	we = 0;
	
	#10 we = 1; write_addr = 6'b000000; data = 8'hAA; // Write operation at address 0 with value AA
	#10 we = 0; read_addr = 6'b000000; // Read operation from address 0
	
	#10 we = 1; write_addr = 6'b000001; data = 8'hBB; // Write operation at address 1 with value BB
	#10 we = 0; read_addr = 6'b000001; // Read operation from address 1
	
	#10 we = 1; write_addr = 6'b000010; data = 8'hCC; // Write operation at address 2 with value CC
	#10 we = 0; read_addr = 6'b000010; // Read operation from address 2
	
	#10 we = 1; write_addr = 6'b000000; data = 8'hDD; // Overwrite address 0 with value DD
	#10 we = 0; read_addr = 6'b000000; // Read operation from address 0 after overwrite
	
	#10 we = 1; write_addr = 6'b111111; data = 8'hFF; // Write operation at max address with value FF
	#10 we = 0; read_addr = 6'b111111; // Read operation from max address
	
	$stop;
end

initial begin
	$monitor($time, " ns | q=%b", q);
end

endmodule