module param_multiplier(
  input [WIDTH-1:0] a,
  input [WIDTH-1:0] b,
  output [2*WIDTH-1:0] product
);

  parameter WIDTH = 8;

  dsp48e #(
    .ACASE(0),
    .ALUMODERE(0),
    .BYPASS(0),
    .CINV(0),
    .CINVEN(0),
    .DIVIDE(0),
    .IS_SBOX_4x4(0),
    .IS_SBOX_5x3(0),
    .IS_SBOX_6x2(0),
    .MODE(0),
    .MULTSIGN(0),
    .NARROWER(0),
    .PEXT(0),
    .PIPELINE(0),
    .ROUNDING(0),
    .SIGN(0),
    .USE_PATTERN(0),
    .WIDTHA(WIDTH),
    .WIDTHB(WIDTH),
    .WIDTHC(2*WIDTH)
  ) mult_inst (
    .A(a),
    .B(b),
    .P(product)
  );

endmodule