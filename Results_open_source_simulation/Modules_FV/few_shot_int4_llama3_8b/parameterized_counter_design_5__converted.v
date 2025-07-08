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
  always @(*) begin assert (@(posedge clk) (rst && count == 0)); end

  // Property: Count increments correctly when reset is low
  always @(*) begin assert (@(posedge clk) (count < $clog2(MAX_COUNT+1)-1) |-> (count + 1 == count)); end

  // Property: Count wraps around to zero when it reaches MAX_COUNT
  always @(*) begin assert (@(posedge clk) (count == $clog2(MAX_COUNT+1)-1) |=> (count == 0)); end

endmodule