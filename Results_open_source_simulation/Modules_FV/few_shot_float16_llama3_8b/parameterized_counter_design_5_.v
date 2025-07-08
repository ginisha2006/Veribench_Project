module tb_param_counter #(parameter MAX_COUNT = 255);

  // Inputs
  reg clk;
  reg rst;

  // Output
  wire [$clog2(MAX_COUNT+1)-1:0] count;

  // Instantiate the DUT
  param_counter #(.MAX_COUNT(MAX_COUNT)) UUT (
   .clk(clk),
   .rst(rst),
   .count(count)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if counter resets to 0 when reset is asserted
  property p_reset_to_zero;
    @(posedge clk) disable iff (!rst) (count == 0);
  endproperty
  assert property (p_reset_to_zero);

  // Property: Check if counter increments correctly
  property p_increment;
    @(posedge clk) disable iff (!rst) ((count < MAX_COUNT) => (count + 1 == count + 1'd1));
  endproperty
  assert property (p_increment);

  // Property: Check if counter wraps around when it reaches MAX_COUNT
  property p_wrap_around;
    @(posedge clk) disable iff (!rst) ((count == MAX_COUNT) => (count == 0));
  endproperty
  assert property (p_wrap_around);

endmodule