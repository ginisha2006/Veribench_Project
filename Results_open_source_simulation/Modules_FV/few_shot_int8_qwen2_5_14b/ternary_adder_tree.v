module tb_ternary_adder_tree();

  // Inputs
  reg [15:0] A, B, C, D, E;
  reg CLK;

  // Output
  wire [15:0] OUT;

  // Instantiate the DUT
  ternary_adder_tree UUT (
    .A(A),
    .B(B),
    .C(C),
    .D(D),
    .E(E),
    .CLK(CLK),
    .OUT(OUT)
  );

  // Clock generation for properties
  initial CLK = 0;
  always #5 CLK = ~CLK;

  // Properties
  property p_correct_sum1;
    @(posedge CLK) (A + B + C === sum1);
  endproperty
  assert property (p_correct_sum1);

  property p_correct_sum2;
    @(posedge CLK) (sum1 + D + E === sum2);
  endproperty
  assert property (p_correct_sum2);

  property p_correct_out;
    @(posedge CLK) (sumreg2 === OUT);
  endproperty
  assert property (p_correct_out);

endmodule