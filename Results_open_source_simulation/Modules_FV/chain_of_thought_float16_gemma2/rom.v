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

  property valid_address;
    @(posedge clk) addr >= 0 && addr < (1 << ADDR_WIDTH);
  endproperty

  property correct_data;
    @(posedge clk) data_out == mem[addr];
  endproperty

  assert property(valid_address);
  assert property(correct_data);

endmodule