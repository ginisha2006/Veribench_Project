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

  // Properties
  always @(*) begin assert (@(posedge clk) (UUT.sum1 === A + B)); end

  always @(*) begin assert (@(posedge clk) (UUT.sum2 === C + D)); end

  always @(*) begin assert (@(posedge clk) (UUT.sum3 === UUT.sumreg1 + UUT.sumreg2)); end

  always @(*) begin assert (@(posedge clk) (UUT.sum4 === UUT.sumreg3 + E)); end

  always @(*) begin assert (@(posedge clk) (out === UUT.sumreg4)); end

endmodule