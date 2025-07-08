module tb_rom_simple(
  );

  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 8;

  logic [ADDR_WIDTH-1:0] addr;
  logic [DATA_WIDTH-1:0] data_out;

  rom_simple dut (
    .addr(addr),
    .data_out(data_out)
  );

  always @(*) begin assert (@(posedge clk) addr >= 0 && addr < (1 << ADDR_WIDTH)); end
  always @(*) begin assert (@(posedge clk) data_out == mem[addr]); end

endmodule