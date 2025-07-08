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

  always #5 clk = ~clk;

  property p_write_data;
    @(posedge clk)
      (we_a && (addr_a >= 0 && addr_a <= 63))  ->  $past(q_a) == data_a;
  endproperty

  property p_read_data;
    @(posedge clk)
      (!we_a && (addr_a >= 0 && addr_a <= 63))  ->  $past(q_a) == ram[addr_a];
  endproperty

  property p_write_data_b;
    @(posedge clk)
      (we_b && (addr_b >= 0 && addr_b <= 63))  ->  $past(q_b) == data_b;
  endproperty

  property p_read_data_b;
    @(posedge clk)
      (!we_b && (addr_b >= 0 && addr_b <= 63))  ->  $past(q_b) == ram[addr_b];
  endproperty

  assert property (p_write_data);
  assert property (p_read_data);
  assert property (p_write_data_b);
  assert property (p_read_data_b);

endmodule