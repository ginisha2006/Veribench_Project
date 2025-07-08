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
    // Reset and Load signals
    rst = 1; #10 rst = 0;
    load = 0; #10 load = 1;
    // Data Input
    data_in = 8'hAA;
    #10;
    // Monitor the output
    $display("Time	data_in	data_out");
    $monitor("%0d	%b	%b", $time, data_in, data_out);
    // Keep the simulation running
    $finish;
end
endmodule