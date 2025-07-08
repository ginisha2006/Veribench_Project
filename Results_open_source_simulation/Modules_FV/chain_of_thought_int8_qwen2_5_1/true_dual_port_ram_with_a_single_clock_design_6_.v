module tb_true_dpram_sclk (
    input [7:0] data_a, data_b,
    input [5:0] addr_a, addr_b,
    input we_a, we_b, clk,
    output reg [7:0] q_a, q_b
);

reg [7:0] ram[63:0];

property p_read_write_consistency_a;
	@(posedge clk)
	(we_a |-> ##1 q_a == data_a) else (q_a == ram[addr_a]);
endproperty

assert property(p_read_write_consistency_a);

property p_read_write_consistency_b;
	@(posedge clk)
	(we_b |-> ##1 q_b == data_b) else (q_b == ram[addr_b]);
endproperty

assert property(p_read_write_consistency_b);

property p_address_bounds_a;
	@(posedge clk)
	addr_a inside {[0:63]};
endproperty

assert property(p_address_bounds_a);

property p_address_bounds_b;
	@(posedge clk)
	addr_b inside {[0:63]};
endproperty

assert property(p_address_bounds_b);

property p_no_overwrite_without_write_enable_a;
	@(posedge clk)
	(!we_a |=> q_a == ram[addr_a]);
endproperty

assert property(p_no_overwrite_without_write_enable_a);

property p_no_overwrite_without_write_enable_b;
	@(posedge clk)
	(!we_b |=> q_b == ram[addr_b]);
endproperty

assert property(p_no_overwrite_without_write_enable_b);

property p_concurrent_writes;
	@(posedge clk)
	(we_a && we_b |-> ##1 {q_a == data_a, q_b == data_b});
endproperty

assert property(p_concurrent_writes);

property p_single_clock_sync;
	@(posedge clk)
	($past(q_a) == ram[$past(addr_a)]) || ($past(q_b) == ram[$past(addr_b)]);
endproperty

assert property(p_single_clock_sync);

endmodule