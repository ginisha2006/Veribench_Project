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
  always @(*) begin assert (@(posedge clk) (we_a && (ram[addr_a] == data_a))); end

  always @(*) begin assert (@(posedge clk) (!we_a && (q_a == ram[addr_a]))); end

  always @(*) begin assert (@(posedge clk) (we_b && (ram[addr_b] == data_b))); end

  always @(*) begin assert (@(posedge clk) (!we_b && (q_b == ram[addr_b]))); end


endmodule