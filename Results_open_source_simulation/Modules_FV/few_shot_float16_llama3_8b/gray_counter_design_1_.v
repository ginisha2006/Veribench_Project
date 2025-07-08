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

  // Property: Check if gray_count is updated correctly
  property p_correct_gray_count;
    @(posedge clk) ($stable(gray_count) && (gray_count == {{~gray_count[0], gray_count}});
  endproperty
  assert property (p_correct_gray_count);

  // Property: Check if gray_count is reset correctly
  property p_reset_gray_count;
    @(posedge reset) ($rose(reset) && $stable(gray_count) && gray_count == 8'h00);
  endproperty
  assert property (p_reset_gray_count);

  // Property: Check if gray_count increments correctly when enabled
  property p_enable_gray_count;
    @(posedge clk) ((enable &&!reset) => $rising_edge(gray_count));
  endproperty
  assert property (p_enable_gray_count);

endmodule