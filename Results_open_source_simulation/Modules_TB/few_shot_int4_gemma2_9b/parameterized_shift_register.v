module tb_param_shift_reg;
// Parameter
parameter WIDTH = 8;  // Default width is 8 bits
// Inputs
reg clk;
reg rst;
reg load;
reg [WIDTH-1:0] data_in;
// Outputs
wire [WIDTH-1:0] data_out;
// Instantiate the Parameterized Shift Register
param_shift_reg #(.WIDTH(WIDTH)) uut (
    .clk(clk), 
    .rst(rst), 
    .load(load), 
    .data_in(data_in), 
    .data_out(data_out)
);
initial begin
    // Clock generation
    clk = 0; forever #5 clk = ~clk;
    // Initialize reset and load signals
    rst = 1; #10 rst = 0;
    load = 0;
    // Display the header for the output
    $display("Time	clk	rst	load	data_in	data_out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b	%b", $time, clk, rst, load, data_in, data_out);
    // Test Case 1: Reset state
    data_in = 0; #10;
    // Test Case 2: Load data
    data_in = 8'hAA; load = 1; #10;
    // Test Case 3: Shift data
    load = 0; #10;
    // Test Case 4: Shift data again
    #10;
    // Finish the simulation
    $finish;
end
endmodule