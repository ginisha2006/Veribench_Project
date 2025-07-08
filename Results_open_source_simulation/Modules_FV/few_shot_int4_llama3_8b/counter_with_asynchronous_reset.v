module tb_counter();

  // Inputs
  reg clk;
  reg reset;
  reg ena;

  // Output
  wire [7:0] result;

  // Instantiate the DUT
  counter UUT (
   .clk(clk),
   .reset(reset),
   .result(result),
   .ena(ena)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if counter resets correctly
  property p_reset;
    @(posedge clk) ($rose(reset) |=> result == 0);
  endproperty
  assert property (p_reset);

  // Property: Check if counter increments when enabled
  property p_increment;
    @(posedge clk) ((ena &&!reset) |=> result == result + 1);
  endproperty
  assert property (p_increment);

  // Property: Check if counter does not increment when disabled
  property p_no_incr;
    @(posedge clk) (!ena |=> result == result);
  endproperty
  assert property (p_no_incr);

endmodule