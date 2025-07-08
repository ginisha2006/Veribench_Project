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
    // Initialize signals
    clk = 0;
    rst = 1;
    load = 0;
    data_in = 0;
    // Clock generation process
    forever #5 clk = ~clk;
end

initial begin
    // Display the header for the output
    $display("Time	rst	load	data_in	data_out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b", $time, rst, load, data_in, data_out);
    
    // Reset active
    rst = 1; #10;
    rst = 0; #10;
    
    // Load with different values
    load = 1; data_in = 8'd10; #10;
    load = 0; #10;
    
    // Change data_in while load is low
    data_in = 8'd20; #10;
    
    // Load again with new value
    load = 1; data_in = 8'd30; #10;
    load = 0; #10;
    
    // Perform reset
    rst = 1; #10;
    rst = 0; #10;
    
    // Finalize the simulation
    $finish;
end
endmodule