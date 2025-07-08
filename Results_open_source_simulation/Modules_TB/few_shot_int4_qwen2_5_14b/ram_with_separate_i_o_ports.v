module tb_ram_separate_io;
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
ram_separate_io #(
    .DATA_WIDTH(DATA_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH)
) uut (
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

    // Initial state
    we = 0;
    addr = 0;
    data_in = 0;

    // Test case 1: Write to address 0
    we = 1; addr = 0; data_in = 8'hAA; #15;
    we = 0; #15;

    // Test case 2: Read from address 0
    we = 0; addr = 0; #15;

    // Test case 3: Write to address 1
    we = 1; addr = 1; data_in = 8'hBB; #15;
    we = 0; #15;

    // Test case 4: Read from address 1
    we = 0; addr = 1; #15;

    // Test case 5: Write to address 2
    we = 1; addr = 2; data_in = 8'hCC; #15;
    we = 0; #15;

    // Test case 6: Read from address 2
    we = 0; addr = 2; #15;

    // Finish the simulation
    $finish;
end
endmodule