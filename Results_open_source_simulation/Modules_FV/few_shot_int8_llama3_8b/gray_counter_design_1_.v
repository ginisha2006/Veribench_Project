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
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if gray count is updated correctly
  property p_correct_gray_count;
    @(posedge clk)
      gray_count == {~q[7], q[6], q[5], q[4], q[3], q[2], q[1], q[0]};
  endproperty
  assert property (p_correct_gray_count);

  // Property: Check if gray count is reset correctly
  property p_reset_gray_count;
    @(posedge reset)
      gray_count == 8'h00;
  endproperty
  assert property (p_reset_gray_count);

  // Property: Check if gray count increments correctly when enabled
  property p_enable_gray_count;
    @(posedge clk)
      enable &&!reset => gray_count!= gray_count[$past(gray_count)];
  endproperty
  assert property (p_enable_gray_count);

endmodule