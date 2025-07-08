module tb_param_adder;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  wire [WIDTH-1:0] sum;
  wire carry;

  param_adder #(WIDTH) dut (a, b, sum, carry);

  property p_add_correct;
    @(posedge clk) sum == a + b;
  endproperty

  property p_overflow;
    (a == 2**WIDTH - 1) && (b == 1) -> sum != 2**(WIDTH) - 1;
  endproperty

  property p_underflow;
    (a == 0) && (b == -1) -> sum != -1;
  endproperty

  assert property (p_add_correct);
  assert property (p_overflow);
  assert property (p_underflow);

endmodule