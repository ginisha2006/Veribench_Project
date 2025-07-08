module binary_adder_tree (
  input [15:0] A,
  input [15:0] B,
  input [15:0] C,
  input [15:0] D,
  input [15:0] E,
  input clk,
  output [15:0] out
);

  wire [15:0] sum1;
  wire [15:0] sum2;
  wire [15:0] sum3;

  full_adder fa1 (A, B, sum1);
  full_adder fa2 (sum1, C, sum2);
  full_adder fa3 (sum2, D, sum3);
  full_adder fa4 (sum3, E, out);

endmodule