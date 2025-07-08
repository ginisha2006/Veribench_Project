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

property no_negative_addr;
 @(posedge clk) disable iff (!clk || !reset)
 addr >= 0;
endproperty

assert property(no_negative_addr);

property write_read_consistency;
 @(posedge clk) disable iff (!clk || !reset)
 ($rose(we)) |-> ##1 q == data;
endproperty

assert property(write_read_consistency);

property address_bounds;
 @(posedge clk) disable iff (!clk || !reset)
 addr < 64;
endproperty

assert property(address_bounds);

property read_after_write;
 @(posedge clk) disable iff (!clk || !reset)
 ($rose(we) && (##1 we === 1'b0)) |-> ##2 q == data;
endproperty

assert property(read_after_write);

property no_data_change_during_read;
 @(posedge clk) disable iff (!clk || !reset)
 (~we) |=> q != data;
endproperty

assert property(no_data_change_during_read);

property consecutive_writes;
 @(posedge clk) disable iff (!clk || !reset)
 ($rose(we) && (##1 we === 1'b1)) |-> ##2 q == data;
endproperty

assert property(consecutive_writes);

endmodule