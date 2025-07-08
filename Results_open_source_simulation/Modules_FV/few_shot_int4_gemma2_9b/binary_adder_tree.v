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
  property p_sum1_correct;
    @(posedge clk) (sum1 == A + B);
  endproperty
  assert property (p_sum1_correct);

  property p_sum2_correct;
    @(posedge clk) (sum2 == C + D);
  endproperty
  assert property (p_sum2_correct);

  property p_sum3_correct;
    @(posedge clk) (sum3 == sumreg1 + sumreg2);
  endproperty
  assert property (p_sum3_correct);

  property p_sum4_correct;
    @(posedge clk) (sum4 == sumreg3 + E);
  endproperty
  assert property (p_sum4_correct);

  property p_final_sum_correct;
    @(posedge clk) (out == sumreg4);
  endproperty
  assert property (p_final_sum_correct);


endmodule