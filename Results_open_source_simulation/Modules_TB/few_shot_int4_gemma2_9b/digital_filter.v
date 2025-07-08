module tb_digital_filter;
// Parameters
parameter DATA_WIDTH = 16;
parameter COEFF_WIDTH = 16;
parameter NUM_TAPS = 32;
// Clock and Reset
reg clk;
reg rst;
// Input Data
reg [DATA_WIDTH-1:0] data_in;
// Coefficients
reg [COEFF_WIDTH-1:0] coeff [NUM_TAPS-1:0];
// Output Data
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
    // Initialize coefficients
    for (int i = 0; i < NUM_TAPS; i++) begin
        coeff[i] = 16'hAAAA; // Example coefficient value
    end
    // Clock generation
    clk = 0;
    forever #5 clk = ~clk;
    // Reset pulse
    rst = 1;
    #10 rst = 0;
    // Apply input data
    data_in = 16'h0000;
    #10 data_in = 16'hFFFF;
    #10 data_in = 16'h00FF;
    #10 data_in = 16'hF000;
    // Monitor output data
    $monitor("Time %0d clk %b data_in %h data_out %h", $time, clk, data_in, data_out);
    // Keep simulation running
    #1000;
    $finish;
end
endmodule