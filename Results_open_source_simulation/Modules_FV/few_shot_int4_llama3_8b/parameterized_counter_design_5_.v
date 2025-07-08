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
  always #10 clk = ~clk;

  // Property: Reset should set the counter to zero
  property p_reset_zero;
    @(posedge clk) (rst && count == 0);
  endproperty
  assert property (p_reset_zero);

  // Property: Count increments correctly when reset is low
  property p_count_incr;
    @(posedge clk) (count < $clog2(MAX_COUNT+1)-1) |-> (count + 1 == count);
  endproperty
  assert property (p_count_incr);

  // Property: Count wraps around to zero when it reaches MAX_COUNT
  property p_wrap_around;
    @(posedge clk) (count == $clog2(MAX_COUNT+1)-1) |=> (count == 0);
  endproperty
  assert property (p_wrap_around);

endmodule