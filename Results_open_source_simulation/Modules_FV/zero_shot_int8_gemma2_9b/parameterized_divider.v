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

  property p_correct_division;
    @(posedge clk)
    integer i;
    for (i = 0; i < 2**WIDTH; i++) begin
      dividend = i;
      divisor = 1;
      #1
      assert (quotient == i && remainder == 0);
    end
  endproperty

  property p_overflow;
    @(posedge clk)
    assert (!(quotient == 0 && remainder == 0));
  endproperty

  property p_underflow;
    @(posedge clk)
    assert (!(quotient == 0 && remainder == 0));
  endproperty

  assert property (p_correct_division);
  assert property (p_overflow);
  assert property (p_underflow);

  always #5 clk = ~clk;

endmodule