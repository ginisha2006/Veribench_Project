module tb_counter();

  // Inputs
  reg clk;
  reg reset;
  reg ena;

  // Output
  wire [7:0] result;

  // Instantiate the counter
  counter UUT (
    .clk(clk),
    .reset(reset),
    .ena(ena),
    .result(result)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  property p_reset_behavior;
    @(posedge clk) (reset == 1'b1) -> result == 8'd0;
  endproperty
  assert property (p_reset_behavior);

  property p_increment_behavior;
    @(posedge clk) (ena == 1'b1) && (reset == 1'b0) -> result == result + 1;
  endproperty
  assert property (p_increment_behavior);

  property p_no_increment_when_disabled;
    @(posedge clk) (ena == 1'b0) -> result == result;
  endproperty
  assert property (p_no_increment_when_disabled);

endmodule