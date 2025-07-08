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

assert (@(posedge clk) disable iff (!we)
	q_wire == data ##1 addr == addr_reg);

assert (@(posedge clk) disable iff (we)
	q_wire !== data);

assert (@(posedge clk)
	addr inside {[0:63]});

assert (@(posedge clk)
	!($isunknown(addr)) && !($isunknown(data)));

endmodule