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
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    $monitor("Time: %t, addr_a: %b, addr_b: %b, data_a: %h, data_b: %h, we_a: %b, we_b: %b, q_a: %h, q_b: %h", $time, addr_a, addr_b, data_a, data_b, we_a, we_b, q_a, q_b);

    // Test case 1: Write to both ports
    addr_a = 0;
    addr_b = 1;
    data_a = 8'hAA;
    data_b = 8'hBB;
    we_a = 1;
    we_b = 1;
    #10;

    // Test case 2: Read from both ports
    we_a = 0;
    we_b = 0;
    #10;

    // Test case 3: Write to port A, read from port B
    addr_a = 2;
    data_a = 8'hCC;
    we_a = 1;
    addr_b = 4;
    we_b = 0;
    #10;

    // Test case 4: Write to port B, read from port A
    addr_b = 6;
    data_b = 8'hDD;
    we_b = 1;
    addr_a = 8;
    we_a = 0;
    #10;

    // ... Add more test cases as needed ...

  end

endmodule