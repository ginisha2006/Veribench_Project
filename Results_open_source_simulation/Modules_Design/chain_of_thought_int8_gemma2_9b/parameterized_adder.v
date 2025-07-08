module param_adder (
  input  [WIDTH-1:0] a,
  input  [WIDTH-1:0] b,
  output [WIDTH-1:0] sum,
  output        carry
);

  parameter WIDTH = 8;

  dsp48  adder (
    .A(a),
    .B(b),
    .C(1'b0),
    .P(sum),
    .Cin(1'b0),
    .Cout(carry)
  );

endmodule