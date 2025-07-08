module tb_true_dpram_sclk;

  logic clk;
  logic we_a, we_b;
  logic [7:0] data_a, data_b;
  logic [5:0] addr_a, addr_b;
  logic [7:0] q_a, q_b;

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

  always #5 clk = ~clk;

  property write_read_match;
    @(posedge clk)
      $past(we_a) && addr_a == addr_a ? q_a == data_a : q_a == $past(ram[addr_a]);
  endproperty

  property write_read_match_b;
    @(posedge clk)
      $past(we_b) && addr_b == addr_b ? q_b == data_b : q_b == $past(ram[addr_b]);
  endproperty

  assert property(write_read_match);
  assert property(write_read_match_b);

endmodule