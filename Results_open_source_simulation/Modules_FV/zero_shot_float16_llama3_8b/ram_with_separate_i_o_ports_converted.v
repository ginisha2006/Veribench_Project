module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

logic clk;
logic we;
logic [ADDR_WIDTH-1:0] addr;
logic [DATA_WIDTH-1:0] data_in;
logic [DATA_WIDTH-1:0] data_out;

ram_separate_io #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) dut (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
);

always @(*) begin assert (@(posedge clk) disable iff (!we) ((dut.data_out == dut.ram[dut.addr]) && (dut.ram[dut.addr] == data_in))); end
always @(*) begin assert (@(posedge clk) disable iff (we) (dut.data_out == dut.ram[dut.addr])); end
always @(*) begin assert (@(posedge clk) ($fell(dut.addr) |=> $rose(dut.addr) |=> (dut.addr < (1 << ADDR_WIDTH - 1) || dut.addr >= (1 << ADDR_WIDTH)))); end
always @(*) begin assert (@(posedge clk) disable iff (!we)!we); end
always @(*) begin assert (@(posedge clk) disable iff (we) we); end

endmodule