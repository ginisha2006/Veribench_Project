module tb_single_port_ram (
    input [7:0] data,
    input [5:0] addr,
    input we,
    input clk,
    output [7:0] q
);
    
single_port_ram dut (
    .data(data),
    .addr(addr),
    .we(we),
    .clk(clk),
    .q(q)
);

reg clk;
always #5 clk = ~clk;

assert (@(posedge clk) disable iff (!we)
 addr >= 0);

assert (@(posedge clk) disable iff (!we)
 addr < 64);

assert (@(posedge clk) disable iff (!we)
 ##1 q == data |-> ##1 q == data);

assert (@(posedge clk) disable iff (!we)
 ##1 q == data);

assert (@(posedge clk) disable iff (we)
 q !== data);

endmodule