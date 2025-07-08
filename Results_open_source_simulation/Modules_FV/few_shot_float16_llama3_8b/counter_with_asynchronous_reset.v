module tb_counter();

  // Inputs
  reg clk, reset, ena;

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
    @(posedge clk) disable iff (!reset) (result == 0);
  endproperty
  assert property (p_reset);

  // Property: Check if counter increments when enabled
  property p_increment;
    @(posedge clk) disable iff (!ena) ((result == $past(result)) + 1);
  endproperty
  assert property (p_increment);

  // Property: Check if counter does not increment when disabled
  property p_no_incr_when_disabled;
    @(posedge clk) disable iff (ena) (result == $past(result));
  endproperty
  assert property (p_no_incr_when_disabled);

endmodule