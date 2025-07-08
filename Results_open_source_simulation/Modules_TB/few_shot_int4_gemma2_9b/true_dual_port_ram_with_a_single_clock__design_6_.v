module tb_true_dpram_sclk;
  reg [7:0] data_a, data_b;
  reg [5:0] addr_a, addr_b;
  reg we_a, we_b;
  reg clk;
  wire [7:0] q_a, q_b;
  // Instantiate the True Dual-Port RAM
  true_dpram_sclk uut (
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
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    // Initialize data and addresses
    data_a = 8'h00;
    data_b = 8'hFF;
    addr_a = 6'h00;
    addr_b = 6'h10;
    we_a = 1;
    we_b = 1;
    #10; // Wait for first clock cycle

    // Test Cases
    // ... Your test cases here ...

    // Example Test Case
    we_a = 0;
    we_b = 0;
    #10;
    $display("Addr A: %h, Data A: %h, Q A: %h", addr_a, data_a, q_a);
    $display("Addr B: %h, Data B: %h, Q B: %h", addr_b, data_b, q_b);
    $finish;
  end
endmodule