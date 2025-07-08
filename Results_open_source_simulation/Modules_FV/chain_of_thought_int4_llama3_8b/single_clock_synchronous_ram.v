module tb_ram_infer;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 6;

logic [DATA_WIDTH-1:0] data;
logic [ADDR_WIDTH-1:0] read_addr, write_addr;
logic we, clk;
logic [DATA_WIDTH-1:0] q;

ram_infer dut (
	.data(data),
	.read_addr(read_addr),
	.write_addr(write_addr),
	.we(we),
	.clk(clk),
	.q(q)
);

property p_data_width;
	@(posedge clk) disable iff (!we);
	$rose(we) |=> ($onehotb(ram[63:0][DATA_WIDTH-1:0]));
endproperty

property p_read_write;
	@(posedge clk) disable iff (!we);
	$rose(we) |=> (q == ram[read_addr]);
endproperty

property p_write_addr_range;
	@(posedge clk) disable iff (!we);
	$rose(we) |=> ($isunknown(ram[63:0][DATA_WIDTH-1:0]) || $onehotb(ram[63:0][DATA_WIDTH-1:0])[write_addr]);
endproperty

property p_read_addr_range;
	@(posedge clk) disable iff (!we);
	$rose(we) |=> ($isunknown(ram[63:0][DATA_WIDTH-1:0]) || $onehotb(ram[63:0][DATA_WIDTH-1:0])[read_addr]);
endproperty

property p_clk_domain;
	@(posedge clk) disable iff (!clk);
	$stable(clk);
endproperty

property p_we_edge_cases;
	@(posedge clk) disable iff (!we);
	$rose(we) |=> (!$fell(we));
endproperty

property p_we_fall_cases;
	@(posedge clk) disable iff (!we);
	$fell(we) |=> (!$rose(we));
endproperty

property p_q_stable;
	@(posedge clk) disable iff (!we);
	$stable(q);
endproperty

assert property (p_data_width);
assert property (p_read_write);
assert property (p_write_addr_range);
assert property (p_read_addr_range);
assert property (p_clk_domain);
assert property (p_we_edge_cases);
assert property (p_we_fall_cases);
assert property (p_q_stable);

endmodule