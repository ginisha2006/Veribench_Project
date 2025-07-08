module tb_digital_filter;

// Parameters
parameter DATA_WIDTH = 16;
parameter COEFF_WIDTH = 16;
parameter NUM_TAPS = 32;

// Clock generation
reg clk;
always #5 clk = ~clk;

// Inputs
reg rst;
reg [DATA_WIDTH-1:0] data_in;
reg [COEFF_WIDTH-1:0] coeff[NUM_TAPS-1:0];

// Outputs
wire [DATA_WIDTH-1:0] data_out;

// Instantiate the Digital Filter
digital_filter #(
    .DATA_WIDTH(DATA_WIDTH),
    .COEFF_WIDTH(COEFF_WIDTH),
    .NUM_TAPS(NUM_TAPS)
) uut (
    .clk(clk),
    .rst(rst),
    .data_in(data_in),
    .data_out(data_out),
    .coeff(coeff)
);

initial begin
    // Initialize clock
    clk = 0;
    
    // Display the header for the output
    $display("Time	rst	data_in	data_out");
    
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b", $time, rst, data_in, data_out);
    
    // Reset the system
    rst = 1;
    @(posedge clk);
    rst = 0;
    
    // Apply some coefficients and data points
    coeff[0] = 16'd1;
    coeff[1] = 16'd2;
    coeff[2] = 16'd3;
    coeff[3] = 16'd4;
    // Fill remaining taps with zeros
    for(int i=4; i<NUM_TAPS; i++) coeff[i] = 16'd0;
    
    // Test case 1: Input sequence
    data_in = 16'd1; @(posedge clk); // First sample
    data_in = 16'd2; @(posedge clk); // Second sample
    data_in = 16'd3; @(posedge clk); // Third sample
    
    // Additional test cases can be added here
    
    // Finish the simulation
    $finish;
end
endmodule