module tb_digital_filter;
// Parameters
parameter DATA_WIDTH = 16;
parameter COEFF_WIDTH = 16;
parameter NUM_TAPS = 32;

// Clock and reset signals
reg clk;
reg rst;

// Input data
reg [DATA_WIDTH-1:0] data_in;

// Output data
wire [DATA_WIDTH-1:0] data_out;

// Coefficients
reg [COEFF_WIDTH-1:0] coeff [NUM_TAPS-1:0];

// Instantiate the Digital Filter
digital_filter #(.DATA_WIDTH(DATA_WIDTH),.COEFF_WIDTH(COEFF_WIDTH),.NUM_TAPS(NUM_TAPS)) uut (
   .clk(clk),
   .rst(rst),
   .data_in(data_in),
   .data_out(data_out),
   .coeff(coeff)
);

initial begin
    // Initialize clock and reset
    clk = 0;
    rst = 1;
    #20;
    rst = 0;

    // Display the header for the output
    $display("Time	data_in	data_out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%h	%h", $time, data_in, data_out);

    // Test Case 1: Single cycle operation
    data_in = 16'h0001; #100;
    data_in = 16'h0002; #100;
    data_in = 16'h0003; #100;
    // Test Case 2: Multiple cycles operation
    data_in = 16'h0001; #50;
    data_in = 16'h0002; #50;
    data_in = 16'h0003; #50;
    // Test Case 3: Edge case - all zeros
    data_in = 16'h0000; #100;
    // Test Case 4: Edge case - all ones
    data_in = 16'hFFFF; #100;
    // Finish the simulation
    $finish;
end

always #5 clk = ~clk;
endmodule