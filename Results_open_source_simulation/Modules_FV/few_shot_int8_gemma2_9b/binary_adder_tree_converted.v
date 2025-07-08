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

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties
  always @(*) begin assert (@(posedge clk) (out == (A + B + C + D + E))); end

endmodule