module tb_half_adder;

  logic a, b;
  logic sum, carry;

  half_adder dut (
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
  );

  always @(*) begin assert (a |-> sum); end
  always @(*) begin assert ((a & b) |-> carry); end

endmodule