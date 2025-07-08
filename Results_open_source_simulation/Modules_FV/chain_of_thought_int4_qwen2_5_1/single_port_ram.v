module tb_single_port_ram (
    input [7:0] data,
    input [5:0] addr,
    input we,
    input clk,
    output [7:0] q
);
    
wire [7:0] q_wire;
single_port_ram dut (
    .data(data),
    .addr(addr),
    .we(we),
    .clk(clk),
    .q(q_wire)
);

reg clk;
always #5 clk = ~clk;

property write_read_correctness;
	@(posedge clk) disable iff (!we)
	q_wire == data ##1 addr == addr_reg;
endproperty

assert property(write_read_correctness);

property no_data_change_when_not_writing;
	@(posedge clk) disable iff (we)
	q_wire !== data;
endproperty

assert property(no_data_change_when_not_writing);

property address_bounds_check;
	@(posedge clk)
	addr inside {[0:63]};
endproperty

assert property(address_bounds_check);

property no_overflow_underflow;
	@(posedge clk)
	!($isunknown(addr)) && !($isunknown(data));
endproperty

assert property(no_overflow_underflow);

endmodule