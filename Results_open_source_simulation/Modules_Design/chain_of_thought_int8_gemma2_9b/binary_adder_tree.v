module binary_adder_tree (
  input [15:0] A,
  input [15:0] B,
  input [15:0] C,
  input [15:0] D,
  input [15:0] E,
  input clk,
  output reg [15:0] out
);

  wire [15:0] sum1;
  wire [15:0] sum2;
  wire [15:0] sum3;

  full_adder fa1 (A, B, sum1);
  full_adder fa2 (C, D, sum1, sum2);
  full_adder fa3 (E, sum2, sum3);

  always @(posedge clk) begin
    out <= sum3;
  end

endmodule