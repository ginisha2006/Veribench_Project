module param_multiplier (
  input [WIDTH-1:0] a,
  input [WIDTH-1:0] b,
  output [2*WIDTH-1:0] product
);

  parameter WIDTH = 8;

  dsp48e #(
    .AC(32'h00000000),
    .AD(32'h00000000),
    .A(32'h00000000),
    .B(32'h00000000),
    .C(32'h00000000),
    .CI(32'h00000000),
    .CO(32'h00000000),
    .D(32'h00000000)
  ) multiplier (
    .A(a),
    .B(b),
    .P(product)
  );

endmodule