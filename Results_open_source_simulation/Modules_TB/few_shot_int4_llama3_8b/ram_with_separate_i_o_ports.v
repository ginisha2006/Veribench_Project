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
// Data Input
reg [DATA_WIDTH-1:0] data_in;
// Data Output
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
    
    // Initialize address
    addr = 0;
    
    // Initialize data
    data_in = 0;
    
    // Display the header for the output
    $display("Time	addr	data_in	data_out");
    
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b", $time, addr, data_in, data_out);
    
    // Test Case 1: Write and read
    #20; we = 1; data_in = 16#FF; #10;
    #20; we = 0; #10;
    #20; addr = 1; #10;
    #20; $display("Expected: %h", 16#FF); assert(data_out == 16#FF);
    
    // Test Case 2: Write and read different values
    #20; we = 1; data_in = 16#AA; #10;
    #20; we = 0; #10;
    #20; addr = 1; #10;
    #20; $display("Expected: %h", 16#AA); assert(data_out == 16#AA);
    
    // Test Case 3: Write and read multiple times
    #20; we = 1; data_in = 16#55; #10;
    #20; we = 0; #10;
    #20; addr = 1; #10;
    #20; $display("Expected: %h", 16#55); assert(data_out == 16#55);
    #20; we = 1; data_in = 16#11; #10;
    #20; we = 0; #10;
    #20; addr = 1; #10;
    #20; $display("Expected: %h", 16#11); assert(data_out == 16#11);
    
    // Finish the simulation
    $finish;
end
endmodule