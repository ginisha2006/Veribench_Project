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

  // Property: Check if reset correctly resets the counter
  always @(*) begin assert (@(posedge reset) (reset |-> result === 8'h0)); end

  // Property: Check if enable increments the counter correctly
  always @(*) begin assert (@(posedge clk) disable iff (!ena) (ena && !reset |=> result === result[7:0] + 1)); end

endmodule