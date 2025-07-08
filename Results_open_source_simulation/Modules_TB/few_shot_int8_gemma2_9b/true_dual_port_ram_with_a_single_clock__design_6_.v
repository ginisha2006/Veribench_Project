module tb_true_dpram_sclk;
  reg clk;
  reg [7:0] data_a, data_b;
  reg [5:0] addr_a, addr_b;
  reg we_a, we_b;
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
    // Initialize data and addresses
    data_a = 8'hAA;
    data_b = 8'hBB;
    addr_a = 6'h00;
    addr_b = 6'h10;
    we_a = 0;
    we_b = 0;

    // Test Case 1: Write to both ports
    #10; we_a = 1; we_b = 1;
    #10; 
    $display("Time	addr_a	data_a	q_a	addr_b	data_b	q_b");
    $display("%0d	%h	%h	%h	%h	%h	%h", $time, addr_a, data_a, q_a, addr_b, data_b, q_b);
    #10; we_a = 0; we_b = 0;

    // Test Case 2: Read from both ports
    #10; 
    $display("%0d	%h	%h	%h	%h	%h	%h", $time, addr_a, data_a, q_a, addr_b, data_b, q_b);
    #10; 

    // Test Case 3: Write to port A, read from port B
    #10; we_a = 1; we_b = 0;
    #10; data_a = 8'hCC;
    $display("%0d	%h	%h	%h	%h	%h	%h", $time, addr_a, data_a, q_a, addr_b, data_b, q_b);
    #10; we_a = 0;

    // Test Case 4: Write to port B, read from port A
    #10; we_b = 1; we_a = 0;
    #10; data_b = 8'hDD;
    $display("%0d	%h	%h	%h	%h	%h	%h", $time, addr_a, data_a, q_a, addr_b, data_b, q_b);
    #10; we_b = 0;

    $finish;
  end
endmodule