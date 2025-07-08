module tb_half_adder();

  reg a, b;
  reg clk;
  wire sum, carry;

  half_adder UUT (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  always @(*) begin assert (@(posedge clk) (sum == (a ^ b))); end

  always @(*) begin assert (@(posedge clk) (carry == (a & b))); end

endmodule