module param_multiplier #(parameter WIDTH=8) (
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output [2*WIDTH-1:0] product
);
  dsp48e1 #(
    .ACASCADEOUT(0),
    .ALUMODEREG(0),
    .BYPASSREG(0),
    .CARRYIN(0),
    .CASCOUT(0),
    .CIN(0),
    .CLOCK(0),
    .DATA_A(a),
    .DATA_B(b),
    .DATA_C(0),
    .DATA_D(0),
    .MODE(0),
    .MULT_HIGH(0),
    .MULT_LOW(0),
    .OPMODE(0),
    .P_OUT(product),
    .S_OUT(0),
    .SEL_MASK(0),
    .SIG_IN(0),
    .USE_PATTERN(0)
  ) multiplier_inst;
endmodule