module tb_ram_infer();

  // Inputs
  reg [7:0] data;
  reg [5:0] read_addr, write_addr;
  reg we, clk;

  // Output
  wire [7:0] q;

  // Instantiate the DUT
  ram_infer UUT (
    .data(data),
    .read_addr(read_addr),
    .write_addr(write_addr),
    .we(we),
    .clk(clk),
    .q(q)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties
  assert (@(posedge clk)
    disable iff (!we)
    ($past(we) && $past(write_addr) == read_addr) |=> (q == $past(data)));

  assert (@(posedge clk)
    disable iff (we)
    !we |-> (q == $stable(q)));

  assert (@(posedge clk)
    disable iff (we)
    (!$past(we) && $past(write_addr) != read_addr) |-> (q == $past(q)));

endmodule