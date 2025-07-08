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

  // Properties

  // Property: Ensure reset correctly resets the counter
  property p_reset;
    @(posedge clk) reset |-> ##[0:1] result == 8'h0;
  endproperty
  assert property (p_reset);

  // Property: Ensure enable increments the counter when enabled
  property p_enable_increment;
    @(posedge clk) !reset && ena |=> result == result[6:0]+1;
  endproperty
  assert property (p_enable_increment);

  // Property: Ensure counter does not change when both reset and enable are low
  property p_no_change_when_disabled;
    @(posedge clk) !reset && !ena |-> result == result;
  endproperty
  assert property (p_no_change_when_disabled);

endmodule