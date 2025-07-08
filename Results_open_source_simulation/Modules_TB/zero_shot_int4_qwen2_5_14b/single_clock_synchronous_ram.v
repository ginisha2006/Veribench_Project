module tb_ram_infer;
    reg [7:0] data;
    reg [5:0] read_addr, write_addr;
    reg we, clk;
    wire [7:0] q;

    ram_infer uut (
        .data(data),
        .read_addr(read_addr),
        .write_addr(write_addr),
        .we(we),
        .clk(clk),
        .q(q)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        // Initialize signals
        data = 8'b0;
        read_addr = 6'b0;
        write_addr = 6'b0;
        we = 0;

        // Reset phase
        @(negedge clk);
        
        // Test case 1: Write then Read
        data = 8'hAA; write_addr = 6'b000000; we = 1; @(negedge clk);
        read_addr = 6'b000000; @(negedge clk); $display("Test Case 1 - Expected: AA, Actual: %h", q);
        
        // Test case 2: Overwrite existing value
        data = 8'hBB; write_addr = 6'b000000; we = 1; @(negedge clk);
        read_addr = 6'b000000; @(negedge clk); $display("Test Case 2 - Expected: BB, Actual: %h", q);
        
        // Test case 3: Write different address
        data = 8'hCC; write_addr = 6'b000001; we = 1; @(negedge clk);
        read_addr = 6'b000001; @(negedge clk); $display("Test Case 3 - Expected: CC, Actual: %h", q);
        
        // Test case 4: Read from non-written address
        read_addr = 6'b000010; @(negedge clk); $display("Test Case 4 - Expected: 00, Actual: %h", q);
        
        // Test case 5: Multiple writes in sequence
        data = 8'hDD; write_addr = 6'b000001; we = 1; @(negedge clk);
        data = 8'hEE; write_addr = 6'b000000; we = 1; @(negedge clk);
        read_addr = 6'b000000; @(negedge clk); $display("Test Case 5 - Expected: EE, Actual: %h", q);
        read_addr = 6'b000001; @(negedge clk); $display("Test Case 5 - Expected: DD, Actual: %h", q);
        
        // Test case 6: Edge case with max addresses
        data = 8'hFF; write_addr = 6'b111111; we = 1; @(negedge clk);
        read_addr = 6'b111111; @(negedge clk); $display("Test Case 6 - Expected: FF, Actual: %h", q);
        
        // End of tests
        $finish;
    end
endmodule