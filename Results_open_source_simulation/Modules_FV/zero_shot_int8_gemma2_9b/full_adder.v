module tb_full_adder;

  reg a;
  reg b;
  reg cin;
  wire sum;
  wire cout;

  full_adder dut (
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
  );

  property p_sum;
    @(posedge clk) sum == a ^ b ^ cin;
  endproperty

  property p_cout;
    @(posedge clk) cout == (a & b) | (b & cin) | (a & cin);
  endproperty

  assert property (p_sum);
  assert property (p_cout);

endmodule