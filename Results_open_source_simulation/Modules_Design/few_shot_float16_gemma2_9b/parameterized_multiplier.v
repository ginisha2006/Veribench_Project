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
    .COMBO(0),
    .DATA_A(a),
    .DATA_B(b),
    .DATA_C(0),
    .DATA_D(0),
    .INMODE(0),
    .MULTSIGN(0),
    .OPMODE(0),
    .OVERFLOW(0),
    .P(product)
  ) mult_inst;
endmodule