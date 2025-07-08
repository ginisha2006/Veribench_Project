module tb_single_port_ram;
    reg [7:0] data;
    reg [5:0] addr;
    reg we, clk;
    wire [7:0] q;

    single_port_ram uut (
        .data(data),
        .addr(addr),
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
        addr = 6'b0;
        we = 0;

        // Wait for some time before starting tests
        #20;

        // Test case 1: Write and read back at address 0
        data = 8'hAA;
        addr = 6'b000000;
        we = 1;
        @(posedge clk);
        we = 0;
        @(posedge clk);
        addr = 6'b000000;
        @(posedge clk);
        $display("Test Case 1 - Expected: AA, Actual: %h", q);

        // Test case 2: Write and read back at max address
        data = 8'hBB;
        addr = 6'b111111;
        we = 1;
        @(posedge clk);
        we = 0;
        @(posedge clk);
        addr = 6'b111111;
        @(posedge clk);
        $display("Test Case 2 - Expected: BB, Actual: %h", q);

        // Test case 3: Write and read back at random addresses
        data = 8'hCC;
        addr = 6'b001101;
        we = 1;
        @(posedge clk);
        we = 0;
        @(posedge clk);
        addr = 6'b001101;
        @(posedge clk);
        $display("Test Case 3 - Expected: CC, Actual: %h", q);

        // Test case 4: Multiple writes followed by reads
        data = 8'hDD;
        addr = 6'b000010;
        we = 1;
        @(posedge clk);
        data = 8'hEE;
        addr = 6'b000011;
        we = 1;
        @(posedge clk);
        we = 0;
        @(posedge clk);
        addr = 6'b000010;
        @(posedge clk);
        $display("Test Case 4 - Expected: DD, Actual: %h", q);
        addr = 6'b000011;
        @(posedge clk);
        $display("Test Case 4 - Expected: EE, Actual: %h", q);

        // Test case 5: Edge case with consecutive writes to same address
        data = 8'hFF;
        addr = 6'b000001;
        we = 1;
        @(posedge clk);
        data = 8'h0F;
        @(posedge clk);
        we = 1;
        @(posedge clk);
        we = 0;
        @(posedge clk);
        addr = 6'b000001;
        @(posedge clk);
        $display("Test Case 5 - Expected: 0F, Actual: %h", q);

        // Finish simulation
        $finish;
    end
endmodule