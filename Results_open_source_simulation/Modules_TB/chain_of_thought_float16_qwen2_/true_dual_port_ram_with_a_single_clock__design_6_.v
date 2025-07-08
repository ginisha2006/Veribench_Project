module tb_true_dpram_sclk;

    reg [7:0] data_a, data_b;
    reg [5:0] addr_a, addr_b;
    reg we_a, we_b;
    reg clk;
    wire [7:0] q_a, q_b;

    initial begin
        clk = 0;
        forever #5 clk = ~clk; // Generate clock signal
    end

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
        // Initialize signals
        data_a = 8'b0;
        data_b = 8'b0;
        addr_a = 6'b0;
        addr_b = 6'b0;
        we_a = 0;
        we_b = 0;

        // Test case 1: Write to port A, read from port A
        @(negedge clk);
        data_a = 8'hAA;
        addr_a = 6'h01;
        we_a = 1;
        @(posedge clk);
        we_a = 0;
        @(posedge clk);
        addr_a = 6'h01;
        @(posedge clk);
        $display("Test Case 1 - Expected: AA, Actual: %h", q_a);

        // Test case 2: Write to port B, read from port B
        @(negedge clk);
        data_b = 8'hBB;
        addr_b = 6'h02;
        we_b = 1;
        @(posedge clk);
        we_b = 0;
        @(posedge clk);
        addr_b = 6'h02;
        @(posedge clk);
        $display("Test Case 2 - Expected: BB, Actual: %h", q_b);

        // Test case 3: Write to port A, then write to port B at same address, read from both ports
        @(negedge clk);
        data_a = 8'hCC;
        addr_a = 6'h03;
        we_a = 1;
        @(posedge clk);
        we_a = 0;
        @(negedge clk);
        data_b = 8'hDD;
        addr_b = 6'h03;
        we_b = 1;
        @(posedge clk);
        we_b = 0;
        @(posedge clk);
        addr_a = 6'h03;
        addr_b = 6'h03;
        @(posedge clk);
        $display("Test Case 3 - Port A Expected: DD, Actual: %h", q_a);
        $display("Test Case 3 - Port B Expected: DD, Actual: %h", q_b);

        // Test case 4: Read from different addresses simultaneously
        @(negedge clk);
        addr_a = 6'h01;
        addr_b = 6'h02;
        @(posedge clk);
        $display("Test Case 4 - Port A Expected: AA, Actual: %h", q_a);
        $display("Test Case 4 - Port B Expected: BB, Actual: %h", q_b);

        // Test case 5: Edge case - writing beyond max address
        @(negedge clk);
        data_a = 8'hEE;
        addr_a = 6'h3F;
        we_a = 1;
        @(posedge clk);
        we_a = 0;
        @(posedge clk);
        addr_a = 6'h3F;
        @(posedge clk);
        $display("Test Case 5 - Expected: EE, Actual: %h", q_a);

        // Test case 6: Corner case - reading before writing
        @(negedge clk);
        addr_a = 6'hFF;
        @(posedge clk);
        $display("Test Case 6 - Expected: 00, Actual: %h", q_a);

        // End simulation
        $finish;
    end

endmodule