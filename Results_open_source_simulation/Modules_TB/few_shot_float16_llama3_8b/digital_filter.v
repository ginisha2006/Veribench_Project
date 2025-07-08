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
    #20 rst = 0;
    #100;
    // Test with some sample coefficients
    coeff[0] = 16'd1; coeff[1] = 16'd2; coeff[2] = 16'd3; //...
    // Generate some random input data
    repeat(100) begin
        data_in = $random();
        #10;
    end
    // Finish the simulation
    $finish;
end

always #5 clk = ~clk;

endmodule