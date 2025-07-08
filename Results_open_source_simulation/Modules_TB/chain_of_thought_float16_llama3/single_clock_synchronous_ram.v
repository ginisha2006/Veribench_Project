module tb_ram_infer;

reg [7:0] data;
reg [5:0] read_addr, write_addr;
reg we;
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
	$monitor($time, "data = %h, read_addr = %h, write_addr = %h, we = %b, q = %h", data, read_addr, write_addr, we, q);
	
	data = 8'h12; write_addr = 6'b000010; we = 1; #20;
	data = 8'h34; write_addr = 6'b000100; we = 1; #20;
	read_addr = 6'b000010; #10;
	read_addr = 6'b000110; #10;
	write_addr = 6'b111111; we = 0; #20;
	read_addr = 6'b111111; #10;
	#50 $finish;
end

always #10 clk = ~clk;

initial clk = 0;

endmodule