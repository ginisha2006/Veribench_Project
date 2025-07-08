module tb_param_shift_reg;
// Parameters
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
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    // Display the header for the output
    $display("Time	rst	load	data_in	data_out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b", $time, rst, load, data_in, data_out);
    // Initialize signals
    rst = 1; load = 0; data_in = 0; #10;
    // Reset active
    rst = 0; #10;
    // Load data with different values
    load = 1; data_in = 8'hAA; #10;
    load = 0; data_in = 8'hFF; #10;
    load = 1; data_in = 8'h55; #10;
    load = 0; data_in = 8'h0F; #10;
    // Toggle reset again
    rst = 1; #10;
    rst = 0; #10;
    // Final check
    load = 1; data_in = 8'hAB; #10;
    // Finish the simulation
    $finish;
end
endmodule