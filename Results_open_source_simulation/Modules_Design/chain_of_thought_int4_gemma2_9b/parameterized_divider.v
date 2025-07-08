module param_divider(
  input [WIDTH-1:0] dividend,
  input [WIDTH-1:0] divisor,
  output [WIDTH-1:0] quotient,
  output [WIDTH-1:0] remainder
);

  assign quotient = dividend / divisor;
  assign remainder = dividend % divisor;

endmodule