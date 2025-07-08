module tb_ram_infer;

    reg [7:0] data;
    reg [5:0] read_addr, write_addr;
    reg we, clk;
    wire [7:0] q;

    ram_infer dut (
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

        // Test case 1: Write and Read at different addresses
        @(negedge clk);
        data = 8'hAA; write_addr = 6'h0F; we = 1; 
        @(negedge clk); we = 0; read_addr = 6'h0F;
        @(negedge clk);
        
        // Test case 2: Write and Read at same address
        @(negedge clk);
        data = 8'hBB; write_addr = 6'h0A; we = 1; 
        @(negedge clk); we = 0; read_addr = 6'h0A;
        @(negedge clk);
        
        // Test case 3: Multiple writes followed by reads
        @(negedge clk);
        data = 8'hCC; write_addr = 6'h0B; we = 1; 
        @(negedge clk);
        data = 8'hDD; write_addr = 6'h0C; we = 1; 
        @(negedge clk);
        data = 8'hEE; write_addr = 6'h0D; we = 1; 
        @(negedge clk); we = 0; read_addr = 6'h0B;
        @(negedge clk);
        read_addr = 6'h0C;
        @(negedge clk);
        read_addr = 6'h0D;
        @(negedge clk);
        
        // Edge Case: Writing beyond max address
        @(negedge clk);
        data = 8'hFF; write_addr = 6'h3F; we = 1; 
        @(negedge clk); we = 0; read_addr = 6'h3F;
        @(negedge clk);
        
        // Corner Case: Reading before writing
        @(negedge clk);
        read_addr = 6'h0E;
        @(negedge clk);
        data = 8'h55; write_addr = 6'h0E; we = 1; 
        @(negedge clk); we = 0;
        @(negedge clk);
        
        // Final check for all written values
        @(negedge clk);
        read_addr = 6'h0F;
        @(negedge clk);
        read_addr = 6'h0A;
        @(negedge clk);
        read_addr = 6'h0B;
        @(negedge clk);
        read_addr = 6'h0C;
        @(negedge clk);
        read_addr = 6'h0D;
        @(negedge clk);
        read_addr = 6'h3F;
        @(negedge clk);
        read_addr = 6'h0E;
        @(negedge clk);
        
        $finish;
    end
    
    always @(posedge clk) begin
        $monitor("Time %t: Data=%h, WriteAddr=%b, ReadAddr=%b, We=%b, Q=%h", $time, data, write_addr, read_addr, we, q);
    end

endmodule