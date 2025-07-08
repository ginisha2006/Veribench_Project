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
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_true_dpram_sclk);

        // Test case 1: Write to port A then read from port B
        data_a = 8'hAA;
        addr_a = 6'h01;
        we_a = 1'b1;
        @(posedge clk);
        
        data_b = 8'hBB;
        addr_b = 6'h01;
        we_b = 1'b0;
        @(posedge clk);
        
        $monitor($time," ns: q_a=%h, q_b=%h", q_a, q_b);
        
        // Test case 2: Write to both ports simultaneously
        data_a = 8'hCC;
        data_b = 8'hDD;
        addr_a = 6'h02;
        addr_b = 6'h02;
        we_a = 1'b1;
        we_b = 1'b1;
        @(posedge clk);
        
        $monitor($time," ns: q_a=%h, q_b=%h", q_a, q_b);
        
        // Test case 3: Read from both ports without writing
        we_a = 1'b0;
        we_b = 1'b0;
        @(posedge clk);
        
        $monitor($time," ns: q_a=%h, q_b=%h", q_a, q_b);
        
        // Test case 4: Edge case - write beyond address range
        data_a = 8'hEE;
        addr_a = 6'h3F;
        we_a = 1'b1;
        @(posedge clk);
        
        data_b = 8'hFF;
        addr_b = 6'h3F;
        we_b = 1'b1;
        @(posedge clk);
        
        $monitor($time," ns: q_a=%h, q_b=%h", q_a, q_b);
        
        // Test case 5: Corner case - simultaneous writes to different addresses
        data_a = 8'hAB;
        addr_a = 6'h03;
        data_b = 8'hCD;
        addr_b = 6'h04;
        we_a = 1'b1;
        we_b = 1'b1;
        @(posedge clk);
        
        $monitor($time," ns: q_a=%h, q_b=%h", q_a, q_b);
        
        // Test case 6: Simultaneous reads after writes
        we_a = 1'b0;
        we_b = 1'b0;
        @(posedge clk);
        
        $monitor($time," ns: q_a=%h, q_b=%h", q_a, q_b);
        
        // End simulation
        $finish;
    end

endmodule