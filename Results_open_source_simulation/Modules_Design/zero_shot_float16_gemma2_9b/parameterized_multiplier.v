module param_multiplier(
  input [WIDTH-1:0] a,
  input [WIDTH-1:0] b,
  output [2*WIDTH-1:0] product
);

  parameter WIDTH = 8;

  dsp48e #(
    .ACASCADEOUT(0),
    .ALUMODEREG(0),
    .BYPASSREG(0),
    .CARRYIN(0),
    .CASCOUT(0),
    .CIN(0),
    .CLOCK(0),
    .COMBO(0),
    .DATA_A(a),
    .DATA_B(b),
    .DATA_C(0),
    .DATA_D(0),
    .INMODE(0),
    .MULTSIGN(0),
    .OPMODE(0),
    .OVERFLOW(0),
    .P(product),
    .S(0),
    .SIGND(0),
    .SIGNED(0),
    .USE_PATTERN(0)
  ) dsp_inst;

endmodule