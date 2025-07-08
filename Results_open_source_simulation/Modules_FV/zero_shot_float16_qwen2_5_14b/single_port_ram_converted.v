module tb_single_port_ram (
    input [7:0] data,
    input [5:0] addr,
    input we,
    input clk,
    output [7:0] q
);
    
wire clk_wire;
reg clk_gen;

single_port_ram dut (
    .data(data),
    .addr(addr),
    .we(we),
    .clk(clk_wire),
    .q(q)
);

always #5 clk_gen = ~clk_gen;
assign clk_wire = clk_gen;

assert (@(posedge clk) disable iff (!clk || !reset)
 addr >= 0);

assert (@(posedge clk) disable iff (!clk || !reset)
 ($rose(we)) |-> ##1 q == data);

assert (@(posedge clk) disable iff (!clk || !reset)
 addr < 64);

assert (@(posedge clk) disable iff (!clk || !reset)
 ($rose(we) && (##1 we === 1'b0)) |-> ##2 q == data);

assert (@(posedge clk) disable iff (!clk || !reset)
 (~we) |=> q != data);

assert (@(posedge clk) disable iff (!clk || !reset)
 ($rose(we) && (##1 we === 1'b1)) |-> ##2 q == data);

endmodule