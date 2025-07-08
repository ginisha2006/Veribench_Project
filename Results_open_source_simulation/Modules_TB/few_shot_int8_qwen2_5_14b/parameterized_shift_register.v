module tb_param_shift_reg;
// Parameters
parameter WIDTH = 8;

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
    // Initialize clock
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    // Display the header for the output
    $display("Time	rst	load	data_in	data_out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b	%b", $time, rst, load, data_in, data_out);

    // Apply stimuli
    rst = 1; #10;
    rst = 0; #10;
    load = 0; data_in = 8'b0000_0001; #20;
    load = 1; data_in = 8'b1010_1010; #10;
    load = 0; data_in = 8'b1111_1111; #20;
    load = 1; data_in = 8'b0101_0101; #10;
    load = 0; data_in = 8'b0000_0000; #20;
    load = 1; data_in = 8'b1111_0000; #10;

    // Finish the simulation
    $finish;
end
endmodule