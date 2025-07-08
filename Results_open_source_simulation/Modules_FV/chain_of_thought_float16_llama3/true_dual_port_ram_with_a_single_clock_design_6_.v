module tb_true_dpram_sclk;

logic [7:0] data_a, data_b;
logic [5:0] addr_a, addr_b;
logic we_a, we_b, clk;
logic [7:0] q_a, q_b;

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

property p_write_port_a;
	@(posedge clk) disable iff (!we_a) ($rose(we_a) |=> ram[addr_a] == data_a);
endproperty

property p_read_port_a;
	@(posedge clk) disable iff (!we_a) ($fell(we_a) |=> q_a == ram[addr_a]);
endproperty

property p_write_port_b;
	@(posedge clk) disable iff (!we_b) ($rose(we_b) |=> ram[addr_b] == data_b);
endproperty

property p_read_port_b;
	@(posedge clk) disable iff (!we_b) ($fell(we_b) |=> q_b == ram[addr_b]);
endproperty

property p_no_write_conflict;
	@(posedge clk) disable iff ((we_a && we_b))!(addr_a == addr_b);
endproperty

property p_no_read_conflict;
	@(posedge clk) disable iff ((we_a || we_b))!(q_a == q_b);
endproperty

assert property (p_write_port_a);
assert property (p_read_port_a);
assert property (p_write_port_b);
assert property (p_read_port_b);
assert property (p_no_write_conflict);
assert property (p_no_read_conflict);

endmodule