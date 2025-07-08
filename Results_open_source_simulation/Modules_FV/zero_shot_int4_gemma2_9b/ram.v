module tb_ram_simple;

  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 8;

  reg clk;
  reg we;
  reg [ADDR_WIDTH-1:0] addr;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;

  ram_simple dut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
  );

  always #5 clk = ~clk;

  property write_read_match;
    @(posedge clk)
      $past(we) && addr != 0 && data_in != 0 ? data_out == data_in : 1;
  endproperty

  property address_range;
    @(posedge clk)
      addr >= 0 && addr < (1 << ADDR_WIDTH);
  endproperty

  assert property (write_read_match);
  assert property (address_range);

endmodule