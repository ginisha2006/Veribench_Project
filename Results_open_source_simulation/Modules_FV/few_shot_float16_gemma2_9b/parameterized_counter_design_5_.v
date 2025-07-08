module tb_param_counter #(parameter MAX_COUNT = 255);

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

  // Reset signal
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Assertions
  property p_count_increment;
    @(posedge clk) (count != count - 1);
  endproperty
  assert property (p_count_increment);

  property p_count_reset;
    @(posedge clk) (rst && count == 0);
  endproperty
  assert property (p_count_reset);

  property p_count_limit;
    @(posedge clk) (count == MAX_COUNT || count != count + 1);
  endproperty
  assert property (p_count_limit);

endmodule