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

property no_negative_address;
 @(posedge clk) disable iff (!we)
 addr >= 0;
endproperty

assert property(no_negative_address);

property address_within_bounds;
 @(posedge clk) disable iff (!we)
 addr < 64;
endproperty

assert property(address_within_bounds);

property write_read_consistency;
 @(posedge clk) disable iff (!we)
 ##1 q == data |-> ##1 q == data;
endproperty

assert property(write_read_consistency);

property read_after_write;
 @(posedge clk) disable iff (!we)
 ##1 q == data;
endproperty

assert property(read_after_write);

property no_data_change_on_no_write;
 @(posedge clk) disable iff (we)
 q !== data;
endproperty

assert property(no_data_change_on_no_write);

endmodule