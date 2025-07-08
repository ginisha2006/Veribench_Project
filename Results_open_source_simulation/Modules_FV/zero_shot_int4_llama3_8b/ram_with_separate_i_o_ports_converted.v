module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

logic clk;
logic we;
logic [ADDR_WIDTH-1:0] addr;
logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] data_out;

ram_separate_io #(
   .DATA_WIDTH(DATA_WIDTH),
   .ADDR_WIDTH(ADDR_WIDTH)
) dut (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
);

always @(*) begin assert (@(posedge clk) disable iff (!we) data_out == dut.ram[addr]); end
always @(*) begin assert (@(posedge clk) disable iff (we) data_out == dut.ram[addr]); end
always @(*) begin assert (($onehot0(addr) |=> $distinct0(dut.ram[addr]))); end
always @(*) begin assert (($onehot0(data_in) |=> $distinct0(dut.ram[addr]))); end
always @(*) begin assert (($rose(we) && addr >= (1 << ADDR_WIDTH - 1)) |=> assert false); end
always @(*) begin assert (($fell(we) && addr < 0) |=> assert false); end

endmodule