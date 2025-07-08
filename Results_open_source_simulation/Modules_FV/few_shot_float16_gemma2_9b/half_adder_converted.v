module tb_half_adder();

  reg a, b;
  wire sum, carry;

  half_adder UUT (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  always @(*) begin assert (a ^ b == sum); end

  always @(*) begin assert (a & b == carry); end

endmodule