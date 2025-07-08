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
      $past(we) == 1 && addr >= 0 && addr <= 63 && data >= 0 && data <= 255;
  endproperty

  property read_operation;
    @(posedge clk)
      $past(we) == 0 && addr >= 0 && addr <= 63;
  endproperty

  property address_range;
    addr >= 0 && addr <= 63;
  endproperty

  assert property (write_operation);
  assert property (read_operation);
  assert property (address_range);

  always #5 clk = ~clk;

endmodule