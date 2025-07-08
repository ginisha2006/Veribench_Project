module param_adder(
  input [WIDTH-1:0] a,
  input [WIDTH-1:0] b,
  output [WIDTH-1:0] sum,
  output carry
);

  assign sum = a + b;
  assign carry = a[WIDTH-1] & b[WIDTH-1];

endmodule