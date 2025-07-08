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
end

initial begin
    // Display the header for the output
    $display("Time	clk	we	addr	data_in	data_out");

    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b", $time, clk, we, addr, data_in, data_out);

    // Apply initial values
    we = 0;
    addr = 0;
    data_in = 0;
    #10;

    // Write operation at address 0 with data 8'hAA
    we = 1;
    addr = 0;
    data_in = 8'hAA;
    #10;

    // Read from address 0
    we = 0;
    addr = 0;
    #10;

    // Write operation at address 1 with data 8'hBB
    we = 1;
    addr = 1;
    data_in = 8'hBB;
    #10;

    // Read from address 1
    we = 0;
    addr = 1;
    #10;

    // Read from an un-written address (address 2)
    we = 0;
    addr = 2;
    #10;

    // Finish the simulation
    $finish;
end
endmodule