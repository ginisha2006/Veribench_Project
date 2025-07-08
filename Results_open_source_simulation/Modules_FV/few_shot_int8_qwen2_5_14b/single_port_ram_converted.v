module tb_single_port_ram();

  // Inputs
  reg [7:0] data;
  reg [5:0] addr;
  reg we, clk;

  // Output
  wire [7:0] q;

  // Instantiate the DUT
  single_port_ram UUT (
    .data(data),
    .addr(addr),
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
    (##1 q == data) |-> ##1 (q == data));

  assert (@(posedge clk)
    disable iff (we)
    !($past(we))
    |=> q == $past(q));

  assert (@(posedge clk)
    addr < 64);

endmodule