module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

reg clk;
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

ram_separate_io #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) uut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk; // Clock generation
end

initial begin
    // Initialize signals
    we = 0;
    addr = 0;
    data_in = 0;

    // Wait for initial setup
    #10;

    // Test case 1: Write and read back single value
    we = 1;
    addr = 3;
    data_in = 8'hAA;
    #10;
    we = 0;
    addr = 3;
    #10;

    // Test case 2: Write multiple values and read them back in sequence
    we = 1;
    addr = 4;
    data_in = 8'hBB;
    #10;
    we = 1;
    addr = 5;
    data_in = 8'hCC;
    #10;
    we = 0;
    addr = 4;
    #10;
    we = 0;
    addr = 5;
    #10;

    // Test case 3: Edge case - write beyond address range
    we = 1;
    addr = 256;
    data_in = 8'hDD;
    #10;
    we = 0;
    addr = 256;
    #10;

    // Test case 4: Read before writing
    we = 0;
    addr = 7;
    #10;

    // Test case 5: Continuous writes and reads at different addresses
    we = 1;
    addr = 1;
    data_in = 8'hEE;
    #10;
    we = 1;
    addr = 2;
    data_in = 8'hFF;
    #10;
    we = 0;
    addr = 1;
    #10;
    we = 0;
    addr = 2;
    #10;

    // Monitor outputs
    $monitor($time, " %t Data Out = %b", $realtime, data_out);
    
    // End simulation after all tests
    #100 $finish;
end

endmodule