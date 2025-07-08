module tb_ram_separate_io;

parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

reg clk;
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data_out;

ram_separate_io #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) dut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    // Initialize signals
    we = 0;
    addr = 0;
    data_in = 0;

    // Wait for initial setup
    #10;

    // Test case 1: Write and read back at address 0
    we = 1; addr = 0; data_in = 8'hAA; #10;
    we = 0; addr = 0; #10;
    
    // Monitor output
    $monitor($time," Data out is %h", data_out);

    // Edge case: Write beyond max address
    we = 1; addr = {ADDR_WIDTH{1'b1}}; data_in = 8'hFF; #10;
    we = 0; addr = {ADDR_WIDTH{1'b1}}; #10;

    // Corner case: Read from un-initialized memory location
    we = 0; addr = 4; #10;

    // Normal operation: Multiple writes and reads
    we = 1; addr = 3; data_in = 8'hBB; #10;
    we = 1; addr = 2; data_in = 8'hCC; #10;
    we = 0; addr = 3; #10;
    we = 0; addr = 2; #10;

    // Final check after all operations
    we = 0; addr = 0; #10;
    we = 0; addr = 2; #10;
    we = 0; addr = 3; #10;

    // End simulation
    $finish;
end

endmodule