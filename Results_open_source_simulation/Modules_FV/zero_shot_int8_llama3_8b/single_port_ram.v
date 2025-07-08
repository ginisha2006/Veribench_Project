module tb_single_port_ram;

reg [7:0] data;
reg [5:0] addr;
reg we;
wire [7:0] q;

single_port_ram dut (.data(data),.addr(addr),.we(we),.clk(clk),.q(q));

property p_write_data;
	@(posedge clk) disable iff (!we) => ($onehot(addr));
endproperty

property p_read_data;
	@(posedge clk) disable iff (!we) => (q == dut.ram[dut.addr]);
endproperty

property p_overflow;
	@(posedge clk) disable iff (!we) => (addr > 6'd62);
endproperty

property p_underflow;
	@(posedge clk) disable iff (!we) => (addr < 6'd0);
endproperty

assert property (p_write_data);
assert property (p_read_data);
assert property (p_overflow);
assert property (p_underflow);

endmodule