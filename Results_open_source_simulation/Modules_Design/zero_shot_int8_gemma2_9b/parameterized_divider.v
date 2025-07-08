module param_divider #(parameter WIDTH = 8) (
  input [WIDTH-1:0] dividend,
  input [WIDTH-1:0] divisor,
  output reg [WIDTH-1:0] quotient,
  output reg [WIDTH-1:0] remainder
);

  assign quotient = dividend / divisor;
  assign remainder = dividend % divisor;

endmodule