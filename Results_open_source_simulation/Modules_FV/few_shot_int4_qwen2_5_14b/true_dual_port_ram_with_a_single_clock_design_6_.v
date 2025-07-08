module tb_true_dpram_sclk();

  // Inputs
  reg [7:0] data_a, data_b;
  reg [5:0] addr_a, addr_b;
  reg we_a, we_b;
  reg clk;

  // Outputs
  wire [7:0] q_a, q_b;

  // Instantiate the DUT
  true_dpram_sclk UUT (
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

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties
  property p_read_write_consistency_a;
    @(posedge clk)
    disable iff (!we_a)
    (q_a === data_a);
  endproperty
  assert property (p_read_write_consistency_a);

  property p_read_write_consistency_b;
    @(posedge clk)
    disable iff (!we_b)
    (q_b === data_b);
  endproperty
  assert property (p_read_write_consistency_b);

  property p_no_write_conflict;
    @(posedge clk)
    (addr_a != addr_b || !we_a || !we_b);
  endproperty
  assert property (p_no_write_conflict);

  property p_read_after_write_a;
    @(posedge clk)
    (we_a |-> ##1 q_a === data_a);
  endproperty
  assert property (p_read_after_write_a);

  property p_read_after_write_b;
    @(posedge clk)
    (we_b |-> ##1 q_b === data_b);
  endproperty
  assert property (p_read_after_write_b);

endmodule