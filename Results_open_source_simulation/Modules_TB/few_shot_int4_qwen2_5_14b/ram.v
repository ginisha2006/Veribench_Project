module tb_ram_simple;
// Parameters
parameter DATA_WIDTH = 8;
parameter ADDR_WIDTH = 8;

// Inputs
reg clk;
reg we;
reg [ADDR_WIDTH-1:0] addr;
reg [DATA_WIDTH-1:0] data_in;

// Outputs
wire [DATA_WIDTH-1:0] data_out;

// Instantiate the RAM module
ram_simple #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) uut (
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

    // Display the header for the output
    $display("Time	clk	we	addr	data_in	data_out");

    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b", $time, clk, we, addr, data_in, data_out);

    // Initial delay before starting tests
    #10;

    // Test Case 1: Write to address 0 with value 10h
    we = 1; addr = 0; data_in = 8'h10; #10;
    we = 0; addr = 0; #10;

    // Test Case 2: Read from address 0 after write
    we = 0; addr = 0; #10;

    // Test Case 3: Write to address 1 with value 20h
    we = 1; addr = 1; data_in = 8'h20; #10;
    we = 0; addr = 1; #10;

    // Test Case 4: Read from address 1 after write
    we = 0; addr = 1; #10;

    // Test Case 5: Write to max address with value FFh
    we = 1; addr = {(ADDR_WIDTH){1'b1}} - 1; data_in = 8'hFF; #10;
    we = 0; addr = {(ADDR_WIDTH){1'b1}} - 1; #10;

    // Test Case 6: Read from max address after write
    we = 0; addr = {(ADDR_WIDTH){1'b1}} - 1; #10;

    // Finish the simulation
    $finish;
end
endmodule