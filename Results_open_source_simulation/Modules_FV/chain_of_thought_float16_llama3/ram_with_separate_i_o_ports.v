module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

input clk;
input we;
input [ADDR_WIDTH-1:0] addr;
input [DATA_WIDTH-1:0] data_in;
output reg [DATA_WIDTH-1:0] data_out;

reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

property P_write_enable;
    @(posedge clk) disable iff (!we) ($rose(we));
endproperty

property P_read_enable;
    @(posedge clk) disable iff (!we) ($fell(we));
endproperty

property P_addr_range;
    ([ADDR_WIDTH-1:0] addr) [$size(ram)-1:0];
endproperty

property P_data_width;
    ([DATA_WIDTH-1:0] data_in) [$bits(data_in)];
endproperty

property P_overflow;
    (|> ram[addr]) == 1'b0;
endproperty

property P_underflow;
    (|< ram[addr]) == 1'b0;
endproperty

property P_write_correctness;
    @(posedge clk) disable iff (!we) ((ram[addr] == data_in) |-> next(ram[addr] == data_in));
endproperty

property P_read_correctness;
    @(posedge clk) disable iff (!we) ((ram[addr] == data_out) |-> next(ram[addr] == data_out));
endproperty

property P_edge_cases;
    @(posedge clk) disable iff (!we) ((we &&!data_in) |-> ##1 (~we));
endproperty

property P_illegal_transition;
    @(posedge clk) disable iff (!we) ((we && data_in) |-> ##1 (!we));
endproperty

assert property (P_write_enable);
assert property (P_read_enable);
assert property (P_addr_range);
assert property (P_data_width);
assert property (P_overflow);
assert property (P_underflow);
assert property (P_write_correctness);
assert property (P_read_correctness);
assert property (P_edge_cases);
assert property (P_illegal_transition);

ram_separate_io uut (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
);

endmodule