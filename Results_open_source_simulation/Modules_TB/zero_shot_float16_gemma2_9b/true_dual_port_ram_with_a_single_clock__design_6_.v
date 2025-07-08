module true_dpram_sclk_tb;

  reg [7:0] data_a, data_b;
  reg [5:0] addr_a, addr_b;
  reg we_a, we_b, clk;
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

  initial begin
    clk = 0; forever #5 clk = ~clk; end

  initial begin
    $monitor("Time: %t, addr_a: %h, addr_b: %h, data_a: %h, data_b: %h, we_a: %b, we_b: %b, q_a: %h, q_b: %h", $time, addr_a, addr_b, data_a, data_b, we_a, we_b, q_a, q_b);

    // Test case 1
    addr_a = 0;
    addr_b = 1;
    data_a = 8'hAA;
    data_b = 8'hBB;
    we_a = 1;
    we_b = 1;
    #10;

    // Test case 2
    addr_a = 1;
    addr_b = 0;
    data_a = 8'hCC;
    data_b = 8'hDD;
    we_a = 1;
    we_b = 1;
    #10;

    // Test case 3
    addr_a = 0;
    addr_b = 0;
    data_a = 8'hEE;
    data_b = 8'hFF;
    we_a = 1;
    we_b = 1;
    #10;

    // Test case 4
    addr_a = 32;
    addr_b = 32;
    data_a = 8'h00;
    data_b = 8'h00;
    we_a = 1;
    we_b = 1;
    #10;

    // Test case 5
    addr_a = 63;
    addr_b = 63;
    data_a = 8'h11;
    data_b = 8'h22;
    we_a = 1;
    we_b = 1;
    #10;

    $finish;
  end

endmodule