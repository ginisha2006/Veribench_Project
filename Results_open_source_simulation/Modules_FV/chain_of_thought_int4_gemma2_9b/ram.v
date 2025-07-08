module tb_ram_simple(
  );

  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 8;

  reg clk;
  reg we;
  reg [ADDR_WIDTH-1:0] addr;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;

  ram_simple #(DATA_WIDTH, ADDR_WIDTH) dut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
  );

  always #5 clk = ~clk;

  property write_operation;
    @(posedge clk)
      (we == 1) -> (data_out == data_in);
  endproperty

  property read_operation;
    @(posedge clk)
      (we == 0) -> (data_out == mem[addr]);
  endproperty

  property address_range;
    @(posedge clk)
      0 <= addr < (1 << ADDR_WIDTH);
  endproperty

  assert property (write_operation);
  assert property (read_operation);
  assert property (address_range);


endmodule