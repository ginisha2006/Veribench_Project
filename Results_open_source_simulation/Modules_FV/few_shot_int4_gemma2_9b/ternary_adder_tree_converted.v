module tb_ternary_adder_tree #(parameter WIDTH = 16)();

  // Inputs
  reg clk;
  reg [WIDTH-1:0] A, B, C, D, E;

  // Outputs
  wire [WIDTH-1:0] OUT;

  // Instantiate the ternary adder tree
  ternary_adder_tree dut (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .CLK(clk),
    .OUT(OUT)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties
  always @(*) begin assert (@(posedge clk) (sum1 == A + B + C)); end

  always @(*) begin assert (@(posedge clk) (sum2 == sumreg1 + D + E)); end

  always @(*) begin assert (@(posedge clk) (OUT == sumreg2)); end

endmodule