module tb_single_port_ram;

logic [7:0] data;
logic [5:0] addr;
logic we, clk;
logic [7:0] q;

single_port_ram dut (
	.data(data),
	.addr(addr),
	.we(we),
	.clk(clk),
	.q(q)
);

always @(*) begin assert (@(posedge clk) disable iff (!we); end
	$rose(we) |=> ($stable(ram[$left(addr)]));
always @(*) begin assert (@(posedge clk) disable iff (!we); end
	$rose(we) |=> (!$stable(ram[$left(addr)]));
always @(*) begin assert ($rose(addr) |=> ($onehot(addr))); end
always @(*) begin assert (clk ==!clk; // clock is toggling); end
always @(*) begin assert ($rose(we) |=> ($stable(we); end));
always @(*) begin assert ($stable(we) |=> ($stable(we))); end
always @(*) begin assert ($falling(we) |=> ($stable(we))); end
always @(*) begin assert ($rose(addr) |=> ($stable(addr))); end
always @(*) begin assert ($stable(addr) |=> ($stable(addr))); end
always @(*) begin assert ($falling(addr) |=> ($stable(addr))); end
always @(*) begin assert (@(posedge clk) disable iff (!we); end
	q == ram[$left(addr)]);

endmodule