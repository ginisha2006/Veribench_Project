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
	@(posedge clk) disable iff (!we) ($rose(we) => $distinct(data, 8'h00));
endproperty

property p_read_data;
	@(posedge clk) disable iff (!we) ($fell(clk) => $distinct(q, 8'hzz));
endproperty

property p_addr_range;
	@(posedge clk) disable iff (!we) ((addr < 6'd0) | (addr > 6'd63));
endproperty

property p_clk_domain;
	@(posedge clk) disable iff (!we) ($stable(clk));
endproperty

property p_we_edge;
	@(posedge clk) disable iff (!we) ($fell(we));
endproperty

property p_we_level;
	@(posedge clk) disable iff (!we) (!$stable(we));
endproperty

assert property (p_write_data);
assert property (p_read_data);
assert property (p_addr_range);
assert property (p_clk_domain);
assert property (p_we_edge);
assert property (p_we_level);

endmodule