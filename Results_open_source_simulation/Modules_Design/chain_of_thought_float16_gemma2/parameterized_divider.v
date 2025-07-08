module param_divider (
  input [WIDTH-1:0] dividend,
  input [WIDTH-1:0] divisor,
  output [WIDTH-1:0] quotient,
  output [WIDTH-1:0] remainder
);

  dsp48e #(
    .ACASCADEOUT(0),
    .ALUMODEREG(0),
    .BYPASSREG(0),
    .CARRYIN(0),
    .CASCOUT(0),
    .CIN(0),
    .CLOCK(0),
    .COMBO(0),
    .DATA_A(dividend),
    .DATA_B(divisor),
    .DATA_C(0),
    .DATA_D(0),
    .DENORM(0),
    .DIVIDE(1),
    .INVERTER(0),
    .MODULUS(0),
    .MULTIPLIER_MODE(0),
    .NARROWER(0),
    .OPERATION(0),
    .OVERFLOW(0),
    .ROUNDING(0),
    .SIGN(0),
    .SIGNED(0),
    .USE_PATTERN(0),
    .WIDTH(WIDTH)
  ) dsp_inst (
    .ACASCOUT(),
    .ALRES(),
    .ARES(),
    .BCIN(),
    .BCOUT(),
    .CACO(),
    .CARRYOUT(),
    .CE(),
    .CLK(),
    .COUT(),
    .DIN(),
    .DOUT(),
    .EN(),
    .ERR(),
    .EXTENDED_RESULT(),
    .FRAC(),
    .INT(),
    .MULTSIGN(),
    .OPSEL(),
    .P(),
    .Q(),
    .RD(),
    .RST(),
    .S(),
    .SIGNOUT()
  );

  assign quotient = dsp_inst.Q;
  assign remainder = dsp_inst.P;

endmodule