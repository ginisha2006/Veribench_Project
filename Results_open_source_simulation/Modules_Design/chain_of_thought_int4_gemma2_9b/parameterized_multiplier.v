module param_multiplier (
  input [WIDTH-1:0] a,
  input [WIDTH-1:0] b,
  output [2*WIDTH-1:0] product
);

  parameter WIDTH = 8;

  dsp48 mul_inst (
    .a(a),
    .b(b),
    .p(product)
  );

endmodule