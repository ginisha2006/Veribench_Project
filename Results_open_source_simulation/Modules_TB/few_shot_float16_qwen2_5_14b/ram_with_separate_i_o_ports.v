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
end

initial begin
    // Display the header for the output
    $display("Time	clk	we	addr	data_in	data_out");

    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b", $time, clk, we, addr, data_in, data_out);

    // Reset signals
    we = 0;
    addr = 0;
    data_in = 0;
    #10;

    // Write operation
    we = 1;
    addr = 4'h0;
    data_in = 8'hAA;
    #10;

    // Read operation from address 0
    we = 0;
    addr = 4'h0;
    data_in = 8'hBB;
    #10;

    // Write operation at different addresses
    we = 1;
    addr = 4'h1;
    data_in = 8'hCC;
    #10;
    we = 1;
    addr = 4'h2;
    data_in = 8'hDD;
    #10;

    // Read operations from different addresses
    we = 0;
    addr = 4'h1;
    data_in = 8'hEE;
    #10;
    we = 0;
    addr = 4'h2;
    data_in = 8'hFF;
    #10;

    // Finish the simulation
    $finish;
end
endmodule