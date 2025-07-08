module tb_full_adder;

  logic a, b, cin, sum, cout;

  full_adder dut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
  );

  always @(*) begin assert (a ^ b ^ cin == sum); end
  always @(*) begin assert (((a & b) | (b & cin) | (a & cin)) == cout); end

endmodule