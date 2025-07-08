module param_multiplier #(parameter WIDTH=8) (
    input [WIDTH-1:0] a, b,
    output [2*WIDTH-1:0] product
);
  dsp48e1 #(
    .AC_WIDTH(WIDTH),
    .P_WIDTH(WIDTH),
    .A_WIDTH(WIDTH),
    .B_WIDTH(WIDTH)
  ) mult_inst (
    .A(a),
    .B(b),
    .C(product)
  );
endmodule