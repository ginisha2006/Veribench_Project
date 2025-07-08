module tb_true_dpram_sclk;
  // Inputs
  reg [7:0] data_a, data_b;
  reg [5:0] addr_a, addr_b;
  reg we_a, we_b, clk;
  // Outputs
  wire [7:0] q_a, q_b;
  // Instantiate the True Dual-Port RAM
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
  initial begin
    // Clock generation
    clk = 0;
    forever #5 clk = ~clk;
    // Test Cases
    // ... Insert your test cases here ...
    $finish;
  end
endmodule