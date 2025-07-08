module tb_param_adder;

  parameter WIDTH = 8;

  reg [WIDTH-1:0] a;
  reg [WIDTH-1:0] b;
  wire [WIDTH-1:0] sum;
  wire carry;

  param_adder dut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  property p_sum_correct;
    @(posedge clk) sum == a + b;
  endproperty

  property p_overflow;
    @(posedge clk) !(sum == {WIDTH{1'b1}} | sum == {WIDTH{1'b0}});
  endproperty

  property p_underflow;
    @(posedge clk) !(sum == {WIDTH{1'b0}});
  endproperty

  assert property (p_sum_correct);
  assert property (p_overflow);
  assert property (p_underflow);

endmodule