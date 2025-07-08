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
  property p_write_access;
    @(posedge clk)
      $past(we) && !we ? data_out == ram[addr] : true;
  endproperty
  assert property (p_write_access);
  property p_read_access;
    @(posedge clk)
      !we && data_out == ram[addr];
  endproperty
  assert property (p_read_access);
  property p_address_range;
    @(posedge clk)
      addr >= 0 && addr < 2**ADDR_WIDTH;
  endproperty
  assert property (p_address_range);
  property p_data_range;
    @(posedge clk)
      data_in >= 0 && data_in < 2**DATA_WIDTH;
  endproperty
  assert property (p_data_range);
endmodule