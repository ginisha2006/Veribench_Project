module tb_param_divider;

  parameter WIDTH = 8;

  logic [WIDTH-1:0] dividend;
  logic [WIDTH-1:0] divisor;
  logic [WIDTH-1:0] quotient;
  logic [WIDTH-1:0] remainder;

  param_divider dut (
    .dividend(dividend),
    .divisor(divisor),
    .quotient(quotient),
    .remainder(remainder)
  );

  always @(*) begin assert (@(posedge clk) dividend >= 0 && divisor > 0 && quotient == dividend / divisor); end
  always @(*) begin assert (@(posedge clk) dividend >= 0 && divisor > 0 && remainder == dividend % divisor); end

endmodule