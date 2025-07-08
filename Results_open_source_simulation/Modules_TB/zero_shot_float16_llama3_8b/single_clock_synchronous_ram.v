module ram_infer_tb;

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
	#100; // wait for clock to stabilize
	clk = 0;
	forever #5 clk = ~clk; // generate clock

	data = 8'h12;
	write_addr = 6'b000010;
	we = 1;
	@(posedge clk);
	$monitor($time, "data=0x%x, write_addr=0x%x, we=%b", data, write_addr, we);
	@(posedge clk);
	data = 8'h34;
	write_addr = 6'b000011;
	we = 1;
	@(posedge clk);
	$monitor($time, "data=0x%x, write_addr=0x%x, we=%b", data, write_addr, we);
	data = 8'h56;
	write_addr = 6'b000100;
	we = 1;
	@(posedge clk);
	$monitor($time, "data=0x%x, write_addr=0x%x, we=%b", data, write_addr, we);
	data = 8'h78;
	write_addr = 6'b000101;
	we = 1;
	@(posedge clk);
	$monitor($time, "data=0x%x, write_addr=0x%x, we=%b", data, write_addr, we);

	read_addr = 6'b000110;
	@(posedge clk);
	$display($time, "q=0x%x", q);
	read_addr = 6'b000111;
	@(posedge clk);
	$display($time, "q=0x%x", q);
	read_addr = 6'b001000;
	@(posedge clk);
	$display($time, "q=0x%x", q);
	read_addr = 6'b001001;
	@(posedge clk);
	$display($time, "q=0x%x", q);

	#200 $finish;
end

endmodule