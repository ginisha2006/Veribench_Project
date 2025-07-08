module tb_single_port_ram (
    input [7:0] data,
    input [5:0] addr,
    input we,
    input clk,
    output [7:0] q
);
    
wire clk_wire;
reg clk_gen;

property posedge_clk;
 @(posedge clk) $fell(clk) |-> ##1 $rose(clk);
endproperty

assert property(posedge_clk); 

property write_correctness;
 @(posedge clk) (we && $past(!we)) |-> q == data after 1;
endproperty

assert property(write_correctness);

property read_stability;
 @(posedge clk) (!we && $past(we)) |-> q == $past(q);
endproperty

assert property(read_stability);

property address_bounds;
 @(posedge clk) !(addr >= 64 || addr < 0);
endproperty

assert property(address_bounds);

property no_write_on_same_address;
 reg [7:0] prev_data;
 reg [5:0] prev_addr;
 @(posedge clk) (we && addr === prev_addr) |-> ##1 q !== prev_data;
endproperty

assert property(no_write_on_same_address);

property correct_read_after_write;
 reg [7:0] prev_data;
 reg [5:0] prev_addr;
 @(posedge clk) (we && addr === prev_addr && !we) |-> q == prev_data;
endproperty

assert property(correct_read_after_write);

always #10 clk_gen = ~clk_gen;
assign clk = clk_gen;

single_port_ram dut (
    .data(data),
    .addr(addr),
    .we(we),
    .clk(clk),
    .q(q)
);

endmodule