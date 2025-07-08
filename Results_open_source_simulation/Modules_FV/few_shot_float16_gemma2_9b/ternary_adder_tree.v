module tb_ternary_adder_tree #(parameter WIDTH = 16)();

  // Inputs
  reg clk;
  reg [WIDTH-1:0] A, B, C, D, E;

  // Outputs
  wire [WIDTH-1:0] OUT;

  // Instantiate the DUT
  ternary_adder_tree UUT (
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
  property p_sum1_correct;
    @(posedge clk) (sum1 == A + B + C);
  endproperty
  assert property (p_sum1_correct);

  property p_sum2_correct;
    @(posedge clk) (sum2 == sumreg1 + D + E);
  endproperty
  assert property (p_sum2_correct);

  property p_out_correct;
    @(posedge clk) (OUT == sumreg2);
  endproperty
  assert property (p_out_correct);

endmodule