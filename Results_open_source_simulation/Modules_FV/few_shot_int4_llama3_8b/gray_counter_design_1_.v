module tb_gray_count();

  // Inputs
  reg clk, enable, reset;

  // Outputs
  wire [7:0] gray_count;

  // Instantiate the DUT
  gray_count UUT (
   .clk(clk),
   .enable(enable),
   .reset(reset),
   .gray_count(gray_count)
  );

  // Clock generation for properties
  integer i;
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if the counter resets correctly
  property p_reset_correct;
    @(posedge clk) ($rose(reset) => (gray_count == 8'h00));
  endproperty
  assert property (p_reset_correct);

  // Property: Check if the counter increments correctly
  property p_increment_correct;
    @(posedge clk) (enable &&!reset => (gray_count == gray_count + 1));
  endproperty
  assert property (p_increment_correct);

  // Property: Check if the counter decrements correctly
  property p_decrement_correct;
    @(posedge clk) (!enable &&!reset => (gray_count == gray_count - 1));
  endproperty
  assert property (p_decrement_correct);

  // Property: Check if the counter stops when disable is low
  property p_stop_on_disable;
    @(posedge clk) (!enable => (gray_count === gray_count));
  endproperty
  assert property (p_stop_on_disable);

endmodule