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
    clk = 0; forever #5 clk = ~clk;
  end

  initial begin
    // Stimulus for Port A
    data_a = 8'hAA; addr_a = 6'h00; we_a = 1; #10;
    data_a = 8'hBB; addr_a = 6'h01; we_a = 1; #10;
    we_a = 0; #10;
    $display("Port A Readback: %h", q_a);

    // Stimulus for Port B
    data_b = 8'hCC; addr_b = 6'h02; we_b = 1; #10;
    data_b = 8'hDD; addr_b = 6'h03; we_b = 1; #10;
    we_b = 0; #10;
    $display("Port B Readback: %h", q_b);

    // Simultaneous write
    data_a = 8'hEE; addr_a = 6'h04; we_a = 1; data_b = 8'hFF; addr_b = 6'h04; we_b = 1; #10;
    we_a = 0; we_b = 0; #10;
    $display("Simultaneous Write Readback: %h %h", q_a, q_b);
  end

endmodule