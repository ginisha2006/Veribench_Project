module tb_true_dpram_sclk;

  reg clk;
  reg [7:0] data_a, data_b;
  reg [5:0] addr_a, addr_b;
  reg we_a, we_b;
  wire [7:0] q_a, q_b;

  true_dpram_sclk dut (
    .data_a(data_a),
    .data_b(data_b),
    .addr_a(addr_a),
    .addr_b(addr_b),
    .we_a(we_a),
    .we_b(we_b),
    .clk(clk),
    .q_a(q_a),
    .q_b(q_b)
  );

  assert (@(posedge clk)
      $past(we_a) && addr_a == addr_a ? q_a == data_a : q_a == ram[addr_a];
    @(posedge clk)
      $past(we_b) && addr_b == addr_b ? q_b == data_b : q_b == ram[addr_b]);
  always @(*) begin assert (@(posedge clk) addr_a >= 0 && addr_a <= 63 && addr_b >= 0 && addr_b <= 63); end

  always #5 clk = ~clk;

endmodule