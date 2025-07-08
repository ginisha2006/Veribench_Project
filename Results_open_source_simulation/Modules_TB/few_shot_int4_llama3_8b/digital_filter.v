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
   .coeff(coeff[0], coeff[1], coeff[2], coeff[3], coeff[4], coeff[5], coeff[6], coeff[7],
           coeff[8], coeff[9], coeff[10], coeff[11], coeff[12], coeff[13], coeff[14], coeff[15],
           coeff[16], coeff[17], coeff[18], coeff[19], coeff[20], coeff[21], coeff[22], coeff[23],
           coeff[24], coeff[25], coeff[26], coeff[27], coeff[28], coeff[29], coeff[30], coeff[31])
);

initial begin
    // Initialize clock and reset
    clk = 0;
    rst = 1;
    #100;
    rst = 0;
    // Generate clock pulses
    forever begin
        clk = ~clk;
        #5;
    end
    // Stimulus
    data_in = 0; #10;
    data_in = 1; #10;
    data_in = 2; #10;
    // Observe output
    $monitor($time, "data_out=%h", data_out);
    // Finish the simulation
    $finish;
end
endmodule