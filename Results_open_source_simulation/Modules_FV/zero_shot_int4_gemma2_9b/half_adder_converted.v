module tb_half_adder;

  reg a;
  reg b;
  wire sum;
  wire carry;

  half_adder dut (a, b, sum, carry);

  always @(*) begin assert (@(posedge clk) sum == a ^ b); end
  always @(*) begin assert (@(posedge clk) carry == a & b); end

endmodule