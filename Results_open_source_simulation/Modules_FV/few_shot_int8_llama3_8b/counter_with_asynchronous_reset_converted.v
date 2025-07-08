module tb_counter();

  // Inputs
  reg clk, reset, ena;

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

  // Property: Check if counter resets correctly
  always @(*) begin assert (@(posedge clk) disable iff (!reset) (result == 0)); end

  // Property: Check if counter increments when enabled
  always @(*) begin assert (@(posedge clk) disable iff (!ena) ((result + 1) == result)); end

  // Property: Check if counter does not increment when disabled
  always @(*) begin assert (@(posedge clk) disable iff (ena) (result == result)); end

endmodule