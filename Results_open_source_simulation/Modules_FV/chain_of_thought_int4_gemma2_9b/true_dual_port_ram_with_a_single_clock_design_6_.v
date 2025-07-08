module tb_true_dpram_sclk;

  reg [7:0] data_a;
  reg [7:0] data_b;
  reg [5:0] addr_a;
  reg [5:0] addr_b;
  reg we_a;
  reg we_b;
  reg clk;
  wire [7:0] q_a;
  wire [7:0] q_b;

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

  property p_write_read_match;
    @(posedge clk)
      $past(we_a) && addr_a == addr_a && data_a == q_a;
  endproperty

  property p_write_read_match_b;
    @(posedge clk)
      $past(we_b) && addr_b == addr_b && data_b == q_b;
  endproperty

  property p_address_range;
    addr_a >= 0 && addr_a <= 63 && addr_b >= 0 && addr_b <= 63;
  endproperty

  assert property (p_write_read_match);
  assert property (p_write_read_match_b);
  assert property (p_address_range);

  always #5 clk = ~clk;

endmodule