module tb_ram_simple;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

reg clk;
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

ram_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) uut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk; // Clock generation with period of 10 time units
end

initial begin
    // Initialize inputs
    we = 0;
    addr = 0;
    data_in = 0;

    // Wait for initial setup
    #20;

    // Test case 1: Write then read back
    we = 1;
    addr = 3'h0;
    data_in = 8'b10101010;
    #10;
    we = 0;
    #10;
    
    // Monitor the output
    $monitor("Time %d: data_out=%b", $time, data_out);
    
    // Edge case testing - write beyond address range
    we = 1;
    addr = 8'd256; // Out-of-range address
    data_in = 8'b11111111;
    #10;
    we = 0;
    #10;
    
    // Corner case testing - multiple writes at same address
    we = 1;
    addr = 3'h4;
    data_in = 8'b00001111;
    #10;
    data_in = 8'b11110000;
    #10;
    we = 0;
    #10;
    
    // Read from different addresses
    we = 0;
    addr = 3'h0;
    #10;
    addr = 3'h4;
    #10;
    
    // Final check after all operations
    #20;
    $finish;
end

endmodule