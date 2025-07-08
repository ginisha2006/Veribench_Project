module binary_adder_tree (
  input [15:0] A,
  input [15:0] B,
  input [15:0] C,
  input [15:0] D,
  input [15:0] E,
  input clk,
  output reg [15:0] out
);

  reg [15:0] sum1;
  reg [15:0] sum2;
  reg [15:0] sum3;

  always @(posedge clk) begin
    sum1 <= A + B;
    sum2 <= sum1 + C;
    sum3 <= sum2 + D;
    out <= sum3 + E;
  end

endmodule