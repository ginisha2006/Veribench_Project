module tb_binary_adder_tree();

  // Inputs
  reg clk;
  reg [15:0] A, B, C, D, E;

  // Outputs
  wire [15:0] out;

  // Instantiate the DUT
  binary_adder_tree UUT (
   .A(A),
   .B(B),
   .C(C),
   .D(D),
   .E(E),
   .clk(clk),
   .out(out)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if sum1 is correct
  always @(*) begin assert (@(posedge clk) (sum1 == A + B)); end

  // Property: Check if sum2 is correct
  always @(*) begin assert (@(posedge clk) (sum2 == C + D)); end

  // Property: Check if sum3 is correct
  always @(*) begin assert (@(posedge clk) (sum3 == A + B + C + D)); end

  // Property: Check if sum4 is correct
  always @(*) begin assert (@(posedge clk) (sum4 == A + B + C + D + E)); end

  // Property: Check if out is correct
  always @(*) begin assert (@(posedge clk) (out == A + B + C + D + E)); end

endmodule