module tb_ram_separate_io;
// Parameters
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

// Clock
reg clk;
// Write Enable
reg we;
// Address
reg [ADDR_WIDTH-1:0] addr;
// Data In
reg [DATA_WIDTH-1:0] data_in;
// Data Out
wire [DATA_WIDTH-1:0] data_out;

// Instantiate the RAM
ram_separate_io #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) uut (
   .clk(clk),
   .we(we),
   .addr(addr),
   .data_in(data_in),
   .data_out(data_out)
);

initial begin
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;
    
    // Initialize address and data
    addr = 0;
    data_in = 0;
    
    // Display the header for the output
    $display("Time	addr	data_in	data_out");
    
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%h	%h", $time, addr, data_in, data_out);
    
    // Test Case 1: Write and read
    addr = 0; data_in = 12; we = 1; #20; we = 0; #10;
    addr = 0; #10;
    $display("Expected: %h", 12);
    assert(data_out == 12);
    
    // Test Case 2: Write and read different value
    addr = 1; data_in = 15; we = 1; #20; we = 0; #10;
    addr = 1; #10;
    $display("Expected: %h", 15);
    assert(data_out == 15);
    
    // Test Case 3: Read un-written location
    addr = 2; #10;
    $display("Expected: x");
    assert(data_out === 'x);
    
    // Finish the simulation
    $finish;
end
endmodule