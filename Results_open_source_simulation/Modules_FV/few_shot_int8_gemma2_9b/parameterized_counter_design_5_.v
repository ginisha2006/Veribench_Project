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

  // Reset assertion
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Property: Count should reach MAX_COUNT
  property p_reach_max_count;
    eventually count == MAX_COUNT;
  endproperty
  assert property (p_reach_max_count);

  // Property: Count should reset to 0 after reaching MAX_COUNT
  property p_reset_on_overflow;
    @(posedge clk)
      (count == MAX_COUNT) |-> eventually count == 0;
  endproperty
  assert property (p_reset_on_overflow);

  // Property: Count should increment correctly
  property p_correct_increment;
    @(posedge clk)
      (rst == 0) |-> count != count - 1;
  endproperty
  assert property (p_correct_increment);


endmodule