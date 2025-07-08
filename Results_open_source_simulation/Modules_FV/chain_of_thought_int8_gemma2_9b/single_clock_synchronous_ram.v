module tb_ram_infer;

  logic [7:0] data;
  logic [5:0] read_addr, write_addr;
  logic we, clk;
  logic [7:0] q;

  ram_infer dut (
    .data(data),
    .read_addr(read_addr),
    .write_addr(write_addr),
    .we(we),
    .clk(clk),
    .q(q)
  );

  always #5 clk = ~clk;

  property ram_write_prop;
    @(posedge clk)
    $past(we) && !we ? ram[write_addr] == $past(data) : 1;
  endproperty

  property ram_read_prop;
    @(posedge clk)
    q == ram[read_addr];
  endproperty

  assert property(ram_write_prop);
  assert property(ram_read_prop);

endmodule