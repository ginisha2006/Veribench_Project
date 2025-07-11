module tb_ram_simple;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

input clk;
input we;
input [ADDR_WIDTH-1:0] addr;
input [DATA_WIDTH-1:0] data_in;
output reg [DATA_WIDTH-1:0] data_out;

reg [DATA_WIDTH-1:0] mem [(1<<ADDR_WIDTH)-1:0];

initial
    #100 $finish;

endmodule