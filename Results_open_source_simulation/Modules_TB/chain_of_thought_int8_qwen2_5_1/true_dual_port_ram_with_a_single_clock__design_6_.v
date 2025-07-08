module tb_true_dpram_sclk;

    reg [7:0] data_a, data_b;
    reg [5:0] addr_a, addr_b;
    reg we_a, we_b;
    reg clk;
    wire [7:0] q_a, q_b;

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
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
        addr_a = 6'h0F;
        we_a = 1;
        @(posedge clk);
        we_a = 0;
        @(posedge clk);
        addr_a = 6'h0F;
        @(posedge clk);
        $display("Test Case 1 - Read from Port A after write: %b", q_a);

        // Test case 2: Write to port B, read from port B
        @(negedge clk);
        data_b = 8'hBB;
        addr_b = 6'h1E;
        we_b = 1;
        @(posedge clk);
        we_b = 0;
        @(posedge clk);
        addr_b = 6'h1E;
        @(posedge clk);
        $display("Test Case 2 - Read from Port B after write: %b", q_b);

        // Test case 3: Write to port A, then read from port B at same address
        @(negedge clk);
        data_a = 8'hCC;
        addr_a = 6'h0A;
        we_a = 1;
        @(posedge clk);
        we_a = 0;
        @(negedge clk);
        addr_b = 6'h0A;
        we_b = 0;
        @(posedge clk);
        $display("Test Case 3 - Read from Port B after writing to Port A: %b", q_b);

        // Test case 4: Write to port B, then read from port A at same address
        @(negedge clk);
        data_b = 8'hDD;
        addr_b = 6'h0B;
        we_b = 1;
        @(posedge clk);
        we_b = 0;
        @(negedge clk);
        addr_a = 6'h0B;
        we_a = 0;
        @(posedge clk);
        $display("Test Case 4 - Read from Port A after writing to Port B: %b", q_a);

        // Test case 5: Concurrent writes to both ports
        @(negedge clk);
        data_a = 8'hEE;
        data_b = 8'hFF;
        addr_a = 6'h0C;
        addr_b = 6'h0D;
        we_a = 1;
        we_b = 1;
        @(posedge clk);
        we_a = 0;
        we_b = 0;
        @(negedge clk);
        addr_a = 6'h0C;
        addr_b = 6'h0D;
        @(posedge clk);
        $display("Test Case 5 - Reads after concurrent writes: Port A: %b, Port B: %b", q_a, q_b);

        // Test case 6: Edge case - out-of-bounds addresses
        @(negedge clk);
        data_a = 8'hAB;
        addr_a = 6'h3F; // Out of bounds
        we_a = 1;
        @(posedge clk);
        we_a = 0;
        @(negedge clk);
        addr_a = 6'h3F;
        @(posedge clk);
        $display("Test Case 6 - Reading invalid address: %b", q_a);

        // Test case 7: No write, just read
        @(negedge clk);
        addr_a = 6'h00;
        we_a = 0;
        @(posedge clk);
        $display("Test Case 7 - Read without write: %b", q_a);

        $finish;
    end

endmodule