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
    // Initialize clock
    clk <= 0;
    forever #5 clk = ~clk;
end

initial begin
    // Reset the system
    rst <= 1;
    repeat(2) @posedge clk;
    rst <= 0;
    
    // Set coefficients
    for(int i=0; i<NUM_TAPS; i=i+1) begin
        coeff[i] <= $random % (2**COEFF_WIDTH);
    end
    
    // Apply some sample data points
    data_in <= 0;
    repeat(2) @posedge clk;
    data_in <= 10'd1;
    repeat(2) @posedge clk;
    data_in <= 10'd2;
    repeat(2) @posedge clk;
    data_in <= 10'd3;
    repeat(2) @posedge clk;
    data_in <= 10'd4;
    repeat(2) @posedge clk;
    data_in <= 10'd5;
    
    // Display the header for the output
    $display("Time	data_in	data_out");
    // Monitor changes to inputs and outputs
    $monitor("%0d	%d	%d", $time, data_in, data_out);
    
    // Finish the simulation
    #100 $finish;
end
endmodule