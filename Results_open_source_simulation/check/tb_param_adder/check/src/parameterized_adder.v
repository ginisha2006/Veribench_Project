module param_adder #(parameter WIDTH=8) (
    input [WIDTH-1:0] a, b,
    output [WIDTH-1:0] sum,
    output carry
);
  dsp48e #(
    .ACASCADEOUT(0),
    .ACIN(0),
    .ALUMODEREG(0),
    .BYPASSREG(0),
    .CARRYIN(0),
    .CARRYOUT(carry),
    .CI(0),
    .CO(0),
    .DATA_A(a),
    .DATA_B(b),
    .MODE(3'b000),
    .OPMODE(3'b000),
    .P(0),
    .S(sum)
  ) adder_inst;
endmodule