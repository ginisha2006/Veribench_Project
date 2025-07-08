module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

input clk;
input we;
input [ADDR_WIDTH-1:0] addr;
input [DATA_WIDTH-1:0] data_in;
output reg [DATA_WIDTH-1:0] data_out;

reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

ram_separate_io dut (.clk(clk),.we(we),.addr(addr),.data_in(data_in),.data_out(data_out));

property p_write_correctly;
@(posedge clk) disable iff (!we) data_out == ram[addr];
assert property (p_write_correctly);

property p_read_correctly;
@(posedge clk) disable iff (we) data_out == ram[addr];
assert property (p_read_correctly);

property p_addr_range;
$rose(we) |=> $distinct(ram[addr]);
assert property (p_addr_range);

property p_data_width;
$data_in <==> $size(data_in) == DATA_WIDTH;
assert property (p_data_width);

property p_addr_width;
$addr <==> $size(addr) == ADDR_WIDTH;
assert property (p_addr_width);

endmodule