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
ram_separate_io #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH)) uut (
    .clk(clk),
    .we(we),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out)
);

initial begin
    // Display the header for the output
    $display("Time	clk	we	addr	data_in	data_out");

    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;

    // Apply stimuli
    #10 we = 1; addr = 0; data_in = 8'hAA; #10;
    #10 we = 1; addr = 1; data_in = 8'hBB; #10;
    #10 we = 1; addr = 2; data_in = 8'hCC; #10;
    #10 we = 0; addr = 0; data_in = 8'hFF; #10;
    #10 we = 0; addr = 1; data_in = 8'hEE; #10;
    #10 we = 0; addr = 2; data_in = 8'hDD; #10;
    #10 we = 0; addr = 0; #10;
    #10 we = 0; addr = 1; #10;
    #10 we = 0; addr = 2; #10;

    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b", $time, clk, we, addr, data_in, data_out);

    // Finish the simulation after some time
    #100 $finish;
end
endmodule