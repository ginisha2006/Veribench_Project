module tb_true_dpram_sclk();

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

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if read operation returns correct value from port A
  property p_read_a_correct;
    @(posedge clk) ((we_a &&!we_b) => (q_a == ram[addr_a]));
  endproperty
  assert property (p_read_a_correct);

  // Property: Check if write operation updates value correctly in port A
  property p_write_a_correct;
    @(posedge clk) ((we_a &&!we_b) => (ram[addr_a] == data_a));
  endproperty
  assert property (p_write_a_correct);

  // Property: Check if read operation returns correct value from port B
  property p_read_b_correct;
    @(posedge clk) ((we_b &&!we_a) => (q_b == ram[addr_b]));
  endproperty
  assert property (p_read_b_correct);

  // Property: Check if write operation updates value correctly in port B
  property p_write_b_correct;
    @(posedge clk) ((we_b &&!we_a) => (ram[addr_b] == data_b));
  endproperty
  assert property (p_write_b_correct);

endmodule