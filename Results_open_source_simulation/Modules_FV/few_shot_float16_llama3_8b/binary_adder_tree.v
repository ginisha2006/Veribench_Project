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
  property p_correct_sum1;
    @(posedge clk) (sum1 == A + B);
  endproperty
  assert property (p_correct_sum1);

  // Property: Check if sum2 is correct
  property p_correct_sum2;
    @(posedge clk) (sum2 == C + D);
  endproperty
  assert property (p_correct_sum2);

  // Property: Check if sum3 is correct
  property p_correct_sum3;
    @(posedge clk) (sum3 == A + B + C + D);
  endproperty
  assert property (p_correct_sum3);

  // Property: Check if sum4 is correct
  property p_correct_sum4;
    @(posedge clk) (sum4 == A + B + C + D + E);
  endproperty
  assert property (p_correct_sum4);

  // Property: Check if out is correct
  property p_correct_out;
    @(posedge clk) (out == A + B + C + D + E);
  endproperty
  assert property (p_correct_out);

endmodule