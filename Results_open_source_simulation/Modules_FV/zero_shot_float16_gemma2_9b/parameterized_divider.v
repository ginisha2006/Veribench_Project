module tb_param_divider;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] dividend;
  reg [WIDTH-1:0] divisor;
  wire [WIDTH-1:0] quotient;
  wire [WIDTH-1:0] remainder;

  param_divider #(WIDTH) dut (
    .dividend(dividend),
    .divisor(divisor),
    .quotient(quotient),
    .remainder(remainder)
  );

  property quotient_correct;
    @(posedge clk) dividend >= 0 && divisor > 0 && quotient == dividend / divisor;
  endproperty

  property remainder_correct;
    @(posedge clk) dividend >= 0 && divisor > 0 && remainder == dividend % divisor;
  endproperty

  assert property(quotient_correct);
  assert property(remainder_correct);

endmodule