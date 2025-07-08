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
        data = 8'hBB; write_addr = 6'b000001; we = 1; @(negedge clk);
        read_addr = 6'b000000; we = 0; @(negedge clk); $display("Read after writing AA at addr 0x00: %h", q);
        read_addr = 6'b000001; @(negedge clk); $display("Read after writing BB at addr 0x01: %h", q);

        // Test case 2: Overwrite existing value
        data = 8'hCC; write_addr = 6'b000000; we = 1; @(negedge clk);
        read_addr = 6'b000000; @(negedge clk); $display("Read after overwriting with CC at addr 0x00: %h", q);

        // Test case 3: Edge case - max address
        data = 8'hDD; write_addr = 6'b111111; we = 1; @(negedge clk);
        read_addr = 6'b111111; @(negedge clk); $display("Read after writing DD at max addr 0x3F: %h", q);

        // Test case 4: Corner case - simultaneous read/write to different addresses
        data = 8'hEE; write_addr = 6'b000001; we = 1; @(negedge clk);
        read_addr = 6'b000000; @(negedge clk); $display("Simultaneous read from addr 0x00 while writing EE to addr 0x01: %h", q);

        // Test case 5: Corner case - simultaneous read/write to same address
        data = 8'hFF; write_addr = 6'b000000; we = 1; @(negedge clk);
        read_addr = 6'b000000; @(negedge clk); $display("Simultaneous read from addr 0x00 while writing FF to addr 0x00: %h", q);

        // End of tests
        $finish;
    end

endmodule