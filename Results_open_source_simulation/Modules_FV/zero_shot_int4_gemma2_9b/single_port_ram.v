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

  property p_write;
    @(posedge clk)
      $past(we) && !we ? ram[addr] == $past(ram[addr]) : ram[addr] == data;
  endproperty

  property p_read;
    @(posedge clk)
      q == ram[addr];
  endproperty

  assert property (p_write);
  assert property (p_read);

endmodule