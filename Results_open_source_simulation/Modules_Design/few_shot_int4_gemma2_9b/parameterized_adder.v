module param_adder #(parameter WIDTH=8) (
    input [WIDTH-1:0] a, b,
    output [WIDTH-1:0] sum,
    output carry
);

  dsp48  adder_inst (
    .a(a),
    .b(b),
    .c(1'b0),
    .p(sum),
    .cin(carry)
  );

endmodule