module tb_true_dpram_sclk;

parameter TIME_UNIT = 10; // Time unit in ns

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

property p_write_same_addr;
@(posedge clk) disable iff (!we_a &&!we_b) ($onehot(addr_a == addr_b));
assert property (p_write_same_addr);

property p_read_same_addr;
@(posedge clk) disable iff (!we_a &&!we_b) ($onehot(addr_a == addr_b));
assert property (p_read_same_addr);

property p_write_data;
@(posedge clk) disable iff (!we_a ||!we_b) ($distinct(data_a, data_b));
assert property (p_write_data);

property p_read_data;
@(posedge clk) disable iff (!we_a ||!we_b) ($distinct(q_a, q_b));
assert property (p_read_data);

property p_no_write_on_read;
@(posedge clk) disable iff (!we_a &&!we_b) (!$stable(q_a) |!$stable(q_b));
assert property (p_no_write_on_read);

property p_no_write_on_write;
@(posedge clk) disable iff (we_a || we_b) (!$stable(q_a) &!$stable(q_b));
assert property (p_no_write_on_write);

endmodule