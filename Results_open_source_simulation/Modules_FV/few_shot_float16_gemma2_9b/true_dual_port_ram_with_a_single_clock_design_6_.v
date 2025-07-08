module tb_true_dpram_sclk ();

  // Inputs
  reg clk;
  reg [7:0] data_a, data_b;
  reg [5:0] addr_a, addr_b;
  reg we_a, we_b;

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

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  property p_write_port_a;
    @(posedge clk) (we_a && (ram[addr_a] == data_a));
  endproperty
  assert property (p_write_port_a);

  property p_read_port_a;
    @(posedge clk) (!we_a && (q_a == ram[addr_a]));
  endproperty
  assert property (p_read_port_a);

  property p_write_port_b;
    @(posedge clk) (we_b && (ram[addr_b] == data_b));
  endproperty
  assert property (p_write_port_b);

  property p_read_port_b;
    @(posedge clk) (!we_b && (q_b == ram[addr_b]));
  endproperty
  assert property (p_read_port_b);


endmodule