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

  always @(*) begin assert (@(posedge clk) sum == a ^ b ^ cin); end
  always @(*) begin assert (@(posedge clk) cout == (a & b) | (b & cin) | (a & cin)); end

endmodule