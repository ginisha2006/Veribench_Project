module tb_full_adder;

  logic a, b, cin, sum, cout;

  full_adder dut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
  );

  property p_sum;
    a ^ b ^ cin == sum;
  endproperty

  property p_cout;
    (a & b) | (b & cin) | (a & cin) == cout;
  endproperty

  assert property (p_sum);
  assert property (p_cout);

endmodule