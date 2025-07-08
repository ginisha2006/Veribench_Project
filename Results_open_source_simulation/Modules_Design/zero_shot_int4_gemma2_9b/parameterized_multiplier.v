module param_multiplier(
  input [WIDTH-1:0] a,
  input [WIDTH-1:0] b,
  output [2*WIDTH-1:0] product
);

  parameter WIDTH = 8;

  dsp48 #(
    .AC_WIDTH(WIDTH),
    .A_WIDTH(WIDTH),
    .B_WIDTH(WIDTH),
    .C_WIDTH(2*WIDTH)
  ) multiplier (
    .A(a),
    .B(b),
    .P(product)
  );

endmodule