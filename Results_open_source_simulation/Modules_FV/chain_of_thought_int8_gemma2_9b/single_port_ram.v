module tb_single_port_ram;

  reg [7:0] data;
  reg [5:0] addr;
  reg we;
  reg clk;
  wire [7:0] q;

  single_port_ram dut (
    .data(data),
    .addr(addr),
    .we(we),
    .clk(clk),
    .q(q)
  );

  property write_operation;
    @(posedge clk)
    $past(we) && we == 1'b1
      ? ram[addr] == data
      : ram[addr] == $past(ram[addr]);
  endproperty

  property read_operation;
    @(posedge clk)
    $past(we) && we == 1'b0
      ? ram[addr] == q
      : ram[addr] == $past(ram[addr]);
  endproperty

  property address_range;
    0 <= addr && addr <= 63;
  endproperty

  assert property(write_operation);
  assert property(read_operation);
  assert property(address_range);

  always #5 clk = ~clk;

endmodule