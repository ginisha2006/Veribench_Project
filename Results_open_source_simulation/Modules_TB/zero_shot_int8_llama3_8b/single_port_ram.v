module single_port_ram_tb();

reg [7:0] data;
reg [5:0] addr;
wire [7:0] q;
wire clk;
wire we;

single_port_ram dut (
	.data(data),
	.addr(addr),
	.we(we),
	.clk(clk),
	.q(q)
);

initial begin
	clk = 0;
	forever #10 clk = ~clk;

	data = 8'h12;
	addr = 6'h00;
	we = 1'b1;
	@(posedge clk);
	$monitor($time, "Addr: %h, Data: %h, Q: %h", addr, data, q);

	data = 8'h34;
	addr = 6'h01;
	we = 1'b1;
	@(posedge clk);
	$monitor($time, "Addr: %h, Data: %h, Q: %h", addr, data, q);

	data = 8'h56;
	addr = 6'h02;
	we = 1'b0;
	@(posedge clk);
	$monitor($time, "Addr: %h, Data: %h, Q: %h", addr, data, q);

	data = 8'h78;
	addr = 6'h03;
	we = 1'b1;
	@(posedge clk);
	$monitor($time, "Addr: %h, Data: %h, Q: %h", addr, data, q);

	#100 $stop;
end

endmodule