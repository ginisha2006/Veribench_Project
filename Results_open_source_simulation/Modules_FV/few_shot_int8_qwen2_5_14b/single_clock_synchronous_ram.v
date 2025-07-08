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
  property p_read_after_write;
    @(posedge clk)
    disable iff (!we)
    ($past(we) && $past(write_addr) == read_addr) |=> (q == $past(data));
  endproperty
  assert property (p_read_after_write);

  property p_no_change_on_non_write_cycle;
    @(posedge clk)
    disable iff (we)
    !we |-> (q == $stable(q));
  endproperty
  assert property (p_no_change_on_non_write_cycle);

  property p_stable_when_not_written;
    @(posedge clk)
    disable iff (we)
    (!$past(we) && $past(write_addr) != read_addr) |-> (q == $past(q));
  endproperty
  assert property (p_stable_when_not_written);

endmodule