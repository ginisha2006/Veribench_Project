module tb_ram_separate_io (
);
  parameter DATA_WIDTH = 8;
  parameter ADDR_WIDTH = 8;
  reg clk;
  reg we;
  reg [ADDR_WIDTH-1:0] addr;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;
  ram_separate_io dut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
  );
  always #5 clk = ~clk;
  property write_access;
    @(posedge clk)
      (we && !we) |-> (data_out == ram[addr]);
  assert property(write_access);
  property read_access;
    @(posedge clk)
      (!we) |-> (data_out == ram[addr]);
  assert property(read_access);
  property address_range;
    @(posedge clk)
      0 <= addr < 2**ADDR_WIDTH;
  assert property(address_range);
  property data_width;
    @(posedge clk)
      $bitwise(data_in) == 0 || $bitwise(data_in) == 2**DATA_WIDTH - 1;
  assert property(data_width);
endmodule