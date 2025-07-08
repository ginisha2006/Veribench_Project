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
  assert (@(posedge clk)
      gray_count == {~q[7], q[6], q[5], q[4], q[3], q[2], q[1], q[0]});

  // Property: Check if gray count is reset correctly
  assert (@(posedge reset)
      gray_count == 8'h00);

  // Property: Check if gray count increments correctly when enabled
  assert (@(posedge clk)
      enable &&!reset => gray_count!= gray_count[$past(gray_count)]);

endmodule