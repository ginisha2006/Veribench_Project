module tb_param_counter #(parameter MAX_COUNT = 255)();

  // Inputs
  reg clk;
  reg rst;

  // Output
  wire [$clog2(MAX_COUNT+1)-1:0] count;

  // Instantiate the DUT
  param_counter #( .MAX_COUNT(MAX_COUNT) ) UUT (
    .clk(clk),
    .rst(rst),
    .count(count)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  property p_count_increment;
    @(posedge clk) (count != count - 1);
  endproperty
  assert property (p_reset_to_zero);

  property p_count_range;
    @(posedge clk) (count >= 0 && count <= MAX_COUNT);
  endproperty
  assert property (p_count_range);

endmodule