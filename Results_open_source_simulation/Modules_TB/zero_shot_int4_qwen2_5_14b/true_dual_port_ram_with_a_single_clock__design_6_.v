module tb_true_dpram_sclk;
    reg [7:0] data_a, data_b;
    reg [5:0] addr_a, addr_b;
    reg we_a, we_b;
    reg clk;
    wire [7:0] q_a, q_b;

    initial begin
        // Initialize signals
        clk = 0;
        forever #5 clk = ~clk; // Generate clock signal
        
        // Test vectors
        @(negedge clk)
        data_a = 8'b10101010; addr_a = 6'b000000; we_a = 1; data_b = 8'b11110000; addr_b = 6'b000001; we_b = 0;
        
        @(negedge clk)
        data_a = 8'b01010101; addr_a = 6'b000001; we_a = 1; data_b = 8'b00001111; addr_b = 6'b000010; we_b = 1;
        
        @(negedge clk)
        data_a = 8'b11001100; addr_a = 6'b000010; we_a = 0; data_b = 8'b10101010; addr_b = 6'b000000; we_b = 0;
        
        @(negedge clk)
        data_a = 8'b00110011; addr_a = 6'b000000; we_a = 0; data_b = 8'b01010101; addr_b = 6'b000001; we_b = 0;
        
        @(negedge clk)
        data_a = 8'b11110000; addr_a = 6'b000001; we_a = 1; data_b = 8'b11001100; addr_b = 6'b000010; we_b = 0;
        
        @(negedge clk)
        data_a = 8'b00001111; addr_a = 6'b000010; we_a = 0; data_b = 8'b00110011; addr_b = 6'b000000; we_b = 0;
        
        @(negedge clk)
        data_a = 8'b10101010; addr_a = 6'b000000; we_a = 0; data_b = 8'b11110000; addr_b = 6'b000001; we_b = 0;
        
        @(negedge clk)
        data_a = 8'b01010101; addr_a = 6'b000001; we_a = 0; data_b = 8'b00001111; addr_b = 6'b000010; we_b = 0;
        
        @(negedge clk)
        data_a = 8'b11001100; addr_a = 6'b000010; we_a = 0; data_b = 8'b10101010; addr_b = 6'b000000; we_b = 0;
        
        @(negedge clk)
        data_a = 8'b00110011; addr_a = 6'b000000; we_a = 0; data_b = 8'b01010101; addr_b = 6'b000001; we_b = 0;
        
        @(negedge clk)
        data_a = 8'b11110000; addr_a = 6'b000001; we_a = 0; data_b = 8'b11001100; addr_b = 6'b000010; we_b = 0;
        
        @(negedge clk)
        data_a = 8'b00001111; addr_a = 6'b000010; we_a = 0; data_b = 8'b00110011; addr_b = 6'b000000; we_b = 0;
        
        @(negedge clk)
        $finish;
    end