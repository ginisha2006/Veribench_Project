module tb_half_adder;

  logic a, b;
  logic sum, carry;

  half_adder dut (a, b, sum, carry);

  always @(*) begin assert (@(posedge clk) sum == a ^ b); end
  always @(*) begin assert (@(posedge clk) carry == a & b); end

endmodule