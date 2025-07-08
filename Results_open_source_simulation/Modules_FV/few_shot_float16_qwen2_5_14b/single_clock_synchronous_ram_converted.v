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
  assert (@(posedge clk) disable iff (!we)
      ##[1:$] (write_addr == read_addr) |-> 
      $past(data, 1) == q);

  assert (@(posedge clk) disable iff (we)
      !($changed(read_addr)) |-> !($changed(q)));

  assert (@(posedge clk) disable iff (!we)
      ##[2:$] (write_addr == $past(write_addr, 2)) |-> 
      $stable(data));

endmodule