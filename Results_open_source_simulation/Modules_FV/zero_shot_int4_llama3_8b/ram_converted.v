module tb_ram_simple;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

logic clk;
logic we;
logic [ADDR_WIDTH-1:0] addr;
logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] data_out;

ram_simple #(
   .DATA_WIDTH(DATA_WIDTH),
   .ADDR_WIDTH(ADDR_WIDTH)
) dut (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
);

always @(*) begin assert (@(posedge clk) disable iff (!we) data_out == dut.data_in); end
always @(*) begin assert (@(posedge clk) disable iff (we) data_out == dut.mem[addr]); end
always @(*) begin assert (($onehot0(addr) |-> $rose(we))); end
always @(*) begin assert (($size(data_in) == DATA_WIDTH)); end
always @(*) begin assert (($onehot0({{[DATA_WIDTH-1:0] 1'b1}} |=>!we))); end
always @(*) begin assert (($onehot0({{[DATA_WIDTH-1:0] 1'b0}} |=>!we))); end

endmodule