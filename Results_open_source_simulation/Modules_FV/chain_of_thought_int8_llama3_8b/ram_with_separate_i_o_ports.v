module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

input clk;
input we;
input [ADDR_WIDTH-1:0] addr;
input [DATA_WIDTH-1:0] data_in;
output reg [DATA_WIDTH-1:0] data_out;

reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

property p_write_data_correctness;
@(posedge clk) disable iff (!we) ($rose(ram[addr]) |=> ram[addr] == data_in);

property p_read_data_correctness;
@(posedge clk) disable iff (we) ($fell(clk) |=> data_out == ram[addr]);

property p_addr_range;
@(posedge clk) disable iff (!we) ((addr >= 0) && (addr < 2**ADDR_WIDTH));

property p_we_edge;
@(posedge clk) disable iff (!we) (!$rose(we));

property p_clk_frequency;
@(posedge clk) disable iff (!we) ($countones(clk) == 1);

assert property (p_write_data_correctness);
assert property (p_read_data_correctness);
assert property (p_addr_range);
assert property (p_we_edge);
assert property (p_clk_frequency);

endmodule