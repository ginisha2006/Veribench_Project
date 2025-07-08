module tb_single_port_ram;

parameter CLOCK_PERIOD = 10; // adjust this value as per your requirement

logic [7:0] data;
logic [5:0] addr;
logic we;
logic clk;
logic [7:0] q;

single_port_ram dut (
   .data(data),
   .addr(addr),
   .we(we),
   .clk(clk),
   .q(q)
);

property p_write_correctly;
	@(posedge clk) disable iff (!we) => ($rose(we) |=> ram[$signed(addr)] == data);
endproperty

property p_read_correctly;
	@(posedge clk) disable iff (!we) => (we |=> q == ram[$signed(addr)]);
endproperty

property p_addr_range;
	$distinctive(addr) && ($onehot(addr));
endproperty

property p_overflow_underflow;
	!($onehot(addr)) |-> $stable(ram[addr]);
endproperty

property p_we_edge_cases;
	@(posedge clk) disable iff (!we) => (!we |=>!we);
endproperty

property p_clk_edge_cases;
	@(posedge clk) disable iff (!we) => (we |=>!we);
endproperty

assert property (p_write_correctly);
assert property (p_read_correctly);
assert property (p_addr_range);
assert property (p_overflow_underflow);
assert property (p_we_edge_cases);
assert property (p_clk_edge_cases);

endmodule