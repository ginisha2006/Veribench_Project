module param_divider #(parameter WIDTH=8) (
  input [WIDTH-1:0] dividend,
  input [WIDTH-1:0] divisor,
  output [WIDTH-1:0] quotient,
  output [WIDTH-1:0] remainder
);

  // Internal DSP division
  divarith #(.WIDTH(WIDTH)) div_inst (
    .dividend(dividend),
    .divisor(divisor),
    .quotient(quotient),
    .remainder(remainder)
  );

endmodule