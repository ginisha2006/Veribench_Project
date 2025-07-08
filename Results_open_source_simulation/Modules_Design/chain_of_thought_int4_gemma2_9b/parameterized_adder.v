module param_adder(
  input [WIDTH-1:0] a,
  input [WIDTH-1:0] b,
  output [WIDTH-1:0] sum,
  output carry
);

  parameter WIDTH = 8;

  dsp48 a_b_sum (
    .a(a),
    .b(b),
    .p(sum),
    .cin(1'b0),
    .cout(carry)
  );

endmodule