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
  always @(*) begin assert (@(posedge clk) ($rose(reset) => (gray_count == 8'h00))); end

  // Property: Check if the counter increments correctly
  always @(*) begin assert (@(posedge clk) (enable &&!reset => (gray_count == gray_count + 1))); end

  // Property: Check if the counter decrements correctly
  always @(*) begin assert (@(posedge clk) (!enable &&!reset => (gray_count == gray_count - 1))); end

  // Property: Check if the counter stops when disable is low
  always @(*) begin assert (@(posedge clk) (!enable => (gray_count === gray_count))); end

endmodule