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

// Instantiate the RAM
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
    
    // Initialize memory
    reg [DATA_WIDTH-1:0] mem [(1<<(ADDR_WIDTH))-1:0];
    initial begin
        foreach (mem[i])
            mem[i] = 0;
    end
    
    // Display the header for the output
    $display("Time	addr	data_in	data_out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b", $time, addr, data_in, data_out);
    
    // Test Case 1: Read from empty location
    addr = 0; data_in = 0; we = 0; #20;
    // Test Case 2: Write to location and read back
    addr = 1; data_in = 8'hFF; we = 1; #10;
    addr = 1; data_in = 0; we = 0; #10;
    // Test Case 3: Write to multiple locations and read back
    addr = 2; data_in = 8'hAA; we = 1; #10;
    addr = 3; data_in = 8'h55; we = 1; #10;
    addr = 2; data_in = 0; we = 0; #10;
    addr = 3; data_in = 0; we = 0; #10;
    // Finish the simulation
    $finish;
end
endmodule