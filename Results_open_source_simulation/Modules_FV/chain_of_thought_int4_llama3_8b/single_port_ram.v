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

property p_write_data;
	@(posedge clk) disable iff (!we);
	$rose(we) |=> ($stable(ram[$left(addr)]);
endproperty

property p_read_data;
	@(posedge clk) disable iff (!we);
	$rose(we) |=> (!$stable(ram[$left(addr)]);
endproperty

property p_addr_wraparound;
	$rose(addr) |=> ($onehot(addr));
endproperty

property p_clk_domain;
	clk ==!clk; // clock is toggling
endproperty

property p_we_edge_cases;
	$rose(we) |=> ($stable(we);)
endproperty

property p_we_hold_time;
	$stable(we) |=> ($stable(we));
endproperty

property p_we_recover_time;
	$falling(we) |=> ($stable(we));
endproperty

property p_addr_edge_cases;
	$rose(addr) |=> ($stable(addr));
endproperty

property p_addr_hold_time;
	$stable(addr) |=> ($stable(addr));
endproperty

property p_addr_recover_time;
	$falling(addr) |=> ($stable(addr));
endproperty

property p_q_output;
	@(posedge clk) disable iff (!we);
	q == ram[$left(addr)];
endproperty

assert property (p_write_data);
assert property (p_read_data);
assert property (p_addr_wraparound);
assert property (p_clk_domain);
assert property (p_we_edge_cases);
assert property (p_we_hold_time);
assert property (p_we_recover_time);
assert property (p_addr_edge_cases);
assert property (p_addr_hold_time);
assert property (p_addr_recover_time);
assert property (p_q_output);

endmodule