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

  always #5 clk = ~clk;

  property write_operation;
    @(posedge clk)
      $past(we) == 1 && $past(addr) == addr && ram[addr] != data ? ram[addr] == data : 1;
  endproperty

  property read_operation;
    @(posedge clk)
      $past(we) == 0 && addr == addr_reg && ram[addr_reg] == q;
  endproperty

  assert property(write_operation);
  assert property(read_operation);

endmodule