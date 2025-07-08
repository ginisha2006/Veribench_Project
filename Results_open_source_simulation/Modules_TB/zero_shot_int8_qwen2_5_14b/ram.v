module tb_ram_simple;
    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 8;

    reg clk;
    reg we;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;

    ram_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );

    initial begin
        // Initialize signals
        clk = 0;
        we = 0;
        addr = 0;
        data_in = 0;

        // Monitor outputs
        $monitor($time, " ns: clk=%b, we=%b, addr=%d, data_in=%h, data_out=%h", clk, we, addr, data_in, data_out);

        // Test vectors
        #10 clk = 1; we = 1; addr = 5; data_in = 8'hAA; 
        #10 clk = ~clk; we = 1; addr = 3; data_in = 8'hBB; 
        #10 clk = ~clk; we = 0; addr = 5; data_in = 8'hCC; 
        #10 clk = ~clk; we = 0; addr = 7; data_in = 8'hDD; 
        #10 clk = ~clk; we = 1; addr = 2; data_in = 8'hEE; 
        #10 clk = ~clk; we = 0; addr = 2; data_in = 8'hFF; 

        // Check corner case with max address
        #10 clk = ~clk; we = 1; addr = (1<<ADDR_WIDTH)-1; data_in = 8'h55; 
        #10 clk = ~clk; we = 0; addr = (1<<ADDR_WIDTH)-1; data_in = 8'h66; 

        // Read back written values
        #10 clk = ~clk; we = 0; addr = 5; data_in = 8'h00; 
        #10 clk = ~clk; we = 0; addr = 3; data_in = 8'h00; 
        #10 clk = ~clk; we = 0; addr = 7; data_in = 8'h00; 
        #10 clk = ~clk; we = 0; addr = 2; data_in = 8'h00; 
        #10 clk = ~clk; we = 0; addr = (1<<ADDR_WIDTH)-1; data_in = 8'h00; 

        // Finish simulation
        #10 $finish;
    end

    always #5 clk = ~clk;
endmodule