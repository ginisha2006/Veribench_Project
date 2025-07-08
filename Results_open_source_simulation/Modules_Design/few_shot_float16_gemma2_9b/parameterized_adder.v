module param_adder #(parameter WIDTH=8) (
    input [WIDTH-1:0] a, b,
    output [WIDTH-1:0] sum,
    output carry
);
  dsp48e1 #(
    .ACASCADEOUT(0),
    .ALUMODEREG(0),
    .BYPASSREG(0),
    .CARRYIN(0),
    .CIN(0),
    .COMBO(0),
    .INITVAL(0),
    .MODULUS(0),
    .OPERATION(0),
    .OVERFLOW(0),
    .ROUNDING(0),
    .SBOXMODE(0),
    .SIGNED(0),
    .USE_PATTERN(0)
  ) adder_inst (
    .A(a),
    .B(b),
    .CI(1'b0),
    .O(sum),
    .CO(carry)
  );
endmodule