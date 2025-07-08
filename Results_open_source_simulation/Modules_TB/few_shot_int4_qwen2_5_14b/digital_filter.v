module tb_digital_filter;

// Parameters
parameter DATA_WIDTH = 16;
parameter COEFF_WIDTH = 16;
parameter NUM_TAPS = 32;

// Inputs
reg clk;
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
    // Initialize inputs
    clk = 0;
    rst = 1;
    data_in = 0;
    for(int i=0; i<NUM_TAPS; i++) begin
        coeff[i] = i+1;
    end
    
    // Display the header for the output
    $display("Time	rst	data_in	data_out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%b	%b	%b", $time, rst, data_in, data_out);
    
    // Clock generation process
    forever #5 clk = ~clk;
    
    // Reset deassertion after initial reset pulse
    @(negedge clk);
    rst = 0;
    
    // Apply some sample data points
    @(posedge clk);
    data_in = 10'd1; // Sample 1
    @(posedge clk);
    data_in = 10'd2; // Sample 2
    @(posedge clk);
    data_in = 10'd3; // Sample 3
    @(posedge clk);
    data_in = 10'd4; // Sample 4
    
    // Wait for a few more clock cycles to observe behavior
    repeat(10) @(posedge clk);
    
    // Finish the simulation
    $finish;
end

endmodule