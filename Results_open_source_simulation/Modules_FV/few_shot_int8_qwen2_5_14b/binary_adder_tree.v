module tb_binary_adder_tree();

  // Inputs
  reg [15:0] A, B, C, D, E;
  reg clk;

  // Output
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

  // Properties
  property p_sum1;
    @(posedge clk) (sum1 === A + B);
  endproperty
  assert property (p_sum1);

  property p_sum2;
    @(posedge clk) (sum2 === C + D);
  endproperty
  assert property (p_sum2);

  property p_sum3;
    @(posedge clk) (sum3 === sumreg1 + sumreg2);
  endproperty
  assert property (p_sum3);

  property p_sum4;
    @(posedge clk) (sum4 === sumreg3 + E);
  endproperty
  assert property (p_sum4);

  property p_out;
    @(posedge clk) (out === sumreg4);
  endproperty
  assert property (p_out);

endmodule