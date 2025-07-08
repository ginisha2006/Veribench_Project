module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

input clk;
input we;
input [ADDR_WIDTH-1:0] addr;
input [DATA_WIDTH-1:0] data_in;
output reg [DATA_WIDTH-1:0] data_out;

reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

always @(*) begin assert (@(posedge clk) disable iff (!we) ($rose(we))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ($fell(we))); end
always @(*) begin assert (([ADDR_WIDTH-1:0] addr) [$size(ram)-1:0]); end
always @(*) begin assert (([DATA_WIDTH-1:0] data_in) [$bits(data_in)]); end
always @(*) begin assert ((|> ram[addr]) == 1'b0); end
always @(*) begin assert ((|< ram[addr]) == 1'b0); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ((ram[addr] == data_in) |-> next(ram[addr] == data_in))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ((ram[addr] == data_out) |-> next(ram[addr] == data_out))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ((we &&!data_in) |-> ##1 (~we))); end
always @(*) begin assert (@(posedge clk) disable iff (!we) ((we && data_in) |-> ##1 (!we))); end

ram_separate_io uut (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
);

endmodule