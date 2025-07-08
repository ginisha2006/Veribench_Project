module tb_ram_simple;
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

// Instantiate the Simple RAM
ram_simple #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) uut (
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
end

initial begin
    // Display the header for the output
    $display("Time	addr	data_in	data_out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%h	%h", $time, addr, data_in, data_out);
    // Test Case 1: Write and read a value
    addr = 0; we = 1; data_in = 12'hA5; #20;
    addr = 0; we = 0; #10;
    addr = 0; #10;
    $display("Expected data_out: %h", 12'hA5);
    assert(data_out == 12'hA5) else $error("Data mismatch!");
    // Test Case 2: Write and read multiple values
    addr = 1; we = 1; data_in = 12'hF2; #20;
    addr = 1; we = 0; #10;
    addr = 1; #10;
    $display("Expected data_out: %h", 12'hF2);
    assert(data_out == 12'hF2) else $error("Data mismatch!");
    // Finish the simulation
    $finish;
end
endmodule