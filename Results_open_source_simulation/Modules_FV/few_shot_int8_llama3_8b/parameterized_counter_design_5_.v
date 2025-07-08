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

  // Property: Check if counter resets correctly
  property p_reset_correct;
    @(posedge clk) disable iff (!rst) (count == 0);
  endproperty
  assert property (p_reset_correct);

  // Property: Check if counter increments correctly
  property p_increment_correct;
    @(posedge clk) disable iff (!rst) ((count < $clog2(MAX_COUNT+1)-1) => (count + 1 == count + 2));
  endproperty
  assert property (p_increment_correct);

  // Property: Check if counter wraps around correctly
  property p_wraparound_correct;
    @(posedge clk) disable iff (!rst) ((count == $clog2(MAX_COUNT+1)-1) => (count == 0));
  endproperty
  assert property (p_wraparound_correct);

endmodule