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
    @(posedge clk) dividend / divisor == quotient;
  endproperty

  property remainder_correct;
    @(posedge clk) dividend % divisor == remainder;
  endproperty

  property divisor_non_zero;
    divisor != 0;
  endproperty

  assert property quotient_correct;
  assert property remainder_correct;
  assert property divisor_non_zero;

  // Clock Generation
  always #5 clk = ~clk;
  reg clk;

endmodule