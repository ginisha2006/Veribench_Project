module tb_ram_simple;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

input clk;
input we;
input [ADDR_WIDTH-1:0] addr;
input [DATA_WIDTH-1:0] data_in;
output reg [DATA_WIDTH-1:0] data_out;

reg [DATA_WIDTH-1:0] mem [(1<<ADDR_WIDTH)-1:0];

property p_write_enable;
    @(posedge clk) disable iff (!we) ($rose(we));
endproperty

property p_read_enable;
    @(posedge clk) disable iff (!we) ($fell(we));
endproperty

property p_addr_range;
    ([ADDR_WIDTH-1:0] addr) [$size(mem)-1:0];
endproperty

property p_data_width;
    ([DATA_WIDTH-1:0] data_in) [$bits(data_in)];
endproperty

property p_write_correctness;
    @(posedge clk) assert property (p_write_enable && we && addr[$size(mem)-1:0] && data_in[$bits(data_in)] => mem[addr] == data_in);
endproperty

property p_read_correctness;
    @(posedge clk) assert property (p_read_enable &&!we && addr[$size(mem)-1:0] => mem[addr] === data_out);
endproperty

property p_overflow;
    @(posedge clk) assert property (!$rose(we) | addr < $size(mem));
endproperty

property p_underflow;
    @(posedge clk) assert property (!$fell(we) | addr >= 0);
endproperty

property p_illegal_transition;
    @(posedge clk) assert property (!we |!we);
endproperty

initial
    #100 $finish;

endmodule