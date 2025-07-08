module tb_param_divider;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] dividend;
  reg [WIDTH-1:0] divisor;
  wire [WIDTH-1:0] quotient;
  wire [WIDTH-1:0] remainder;

  param_divider #(WIDTH)(dividend, divisor, quotient, remainder);

  property p_quotient_correct;
    @(posedge clk) dividend / divisor == quotient;
  endproperty

  property p_remainder_correct;
    @(posedge clk) dividend % divisor == remainder;
  endproperty

  property p_divisor_non_zero;
    divisor != 0;
  endproperty

  property p_overflow;
    (dividend == 2**WIDTH - 1) && (quotient == 2**(WIDTH-1)-1);
  endproperty

  property p_underflow;
    (dividend == 0) && (quotient == 0);
  endproperty

  assert property (p_quotient_correct);
  assert property (p_remainder_correct);
  assert property (p_divisor_non_zero);
  assert property (p_overflow);
  assert property (p_underflow);


endmodule