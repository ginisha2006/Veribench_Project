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

        // Reset phase
        @(negedge clk);
        @(negedge clk);

        // Test write operation
        data = 8'hAA;
        addr = 6'b000000;
        we = 1;
        @(posedge clk);
        we = 0;

        // Read back written value
        addr = 6'b000000;
        @(posedge clk);
        $monitor("Time %dns: Data read from address %b is %h", $time, addr, q);

        // Edge case - write at max address
        data = 8'hBB;
        addr = 6'b111111;
        we = 1;
        @(posedge clk);
        we = 0;

        // Read back written value
        addr = 6'b111111;
        @(posedge clk);
        $monitor("Time %dns: Data read from address %b is %h", $time, addr, q);

        // Corner case - multiple writes in sequence
        data = 8'hCC;
        addr = 6'b000001;
        we = 1;
        @(posedge clk);
        data = 8'hDD;
        @(posedge clk);
        we = 0;

        // Read back last written value
        addr = 6'b000001;
        @(posedge clk);
        $monitor("Time %dns: Data read from address %b is %h", $time, addr, q);

        // Finish simulation
        $finish;
    end
endmodule