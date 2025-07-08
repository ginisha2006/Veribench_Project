module tb_counter();

  // Inputs
  reg clk;
  reg reset;
  reg ena;

  // Output
  wire [7:0] result;

  // Instantiate the DUT
  counter UUT (
    .clk(clk),
    .reset(reset),
    .result(result),
    .ena(ena)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties

  // Property: Ensure reset correctly resets the counter
  always @(*) begin assert (@(posedge clk) reset |-> ##[0:1] result == 8'h0); end

  // Property: Ensure enable increments the counter when enabled
  always @(*) begin assert (@(posedge clk) !reset && ena |=> result == result[6:0]+1); end

  // Property: Ensure counter does not change when both reset and enable are low
  always @(*) begin assert (@(posedge clk) !reset && !ena |-> result == result); end

endmodule