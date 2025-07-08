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
  property p_port_a_read_write;
    @(posedge clk)
    disable iff (!we_a)
    (we_a |-> ##1 q_a == data_a);
  endproperty
  assert property (p_port_a_read_write);

  property p_port_a_no_write;
    @(posedge clk)
    disable iff (we_a)
    (!we_a |-> ##1 q_a == ram[addr_a]);
  endproperty
  assert property (p_port_a_no_write);

  property p_port_b_read_write;
    @(posedge clk)
    disable iff (!we_b)
    (we_b |-> ##1 q_b == data_b);
  endproperty
  assert property (p_port_b_read_write);

  property p_port_b_no_write;
    @(posedge clk)
    disable iff (we_b)
    (!we_b |-> ##1 q_b == ram[addr_b]);
  endproperty
  assert property (p_port_b_no_write);

  // Cross-port consistency check
  property p_cross_port_consistency;
    @(posedge clk)
    (addr_a == addr_b && we_a && !we_b |-> ##1 q_a == data_a && q_b == data_a);
  endproperty
  assert property (p_cross_port_consistency);

  property p_cross_port_conflict;
    @(posedge clk)
    (addr_a == addr_b && we_a && we_b |-> ##1 q_a == data_a && q_b == data_b);
  endproperty
  assert property (p_cross_port_conflict);

endmodule