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
  always @(*) begin assert (@(posedge clk) disable iff (!rst) (count == 0)); end

  // Property: Check if counter increments correctly
  always @(*) begin assert (@(posedge clk) disable iff (!rst) ((count < MAX_COUNT) => (count + 1 == count + 1'd1))); end

  // Property: Check if counter wraps around when it reaches MAX_COUNT
  always @(*) begin assert (@(posedge clk) disable iff (!rst) ((count == MAX_COUNT) => (count == 0))); end

endmodule