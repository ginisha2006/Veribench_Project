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

  // Property: Check reset functionality
  property p_reset;
    @(posedge clk or posedge reset)
    disable iff (!reset)
    (reset |-> result === 0);
  endproperty
  assert property (p_reset);

  // Property: Check enable functionality
  property p_enable;
    @(posedge clk)
    disable iff (!ena)
    (ena && !reset |=> result == result[6:0]+1'd1);
  endproperty
  assert property (p_enable);

  // Property: Check non-increment when disabled
  property p_disable;
    @(posedge clk)
    disable iff (!ena || reset)
    (!ena && !reset |-> result !== result + 1);
  endproperty
  assert property (p_disable);

endmodule