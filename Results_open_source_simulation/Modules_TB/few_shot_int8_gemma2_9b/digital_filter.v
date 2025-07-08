module tb_digital_filter;
  // Parameters
  parameter DATA_WIDTH = 16;
  parameter COEFF_WIDTH = 16;
  parameter NUM_TAPS = 32;

  // Clock and Reset Signals
  reg clk;
  reg rst;

  // Input Data
  reg [DATA_WIDTH-1:0] data_in;

  // Output Data
  wire [DATA_WIDTH-1:0] data_out;

  // Coefficients
  reg [COEFF_WIDTH-1:0] coeff [NUM_TAPS-1:0];

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
    // Initialize coefficients (example values)
    for (integer i = 0; i < NUM_TAPS; i++) begin
      coeff[i] = 16'hAAAA; // Replace with desired coefficients
    end

    // Clock and reset generation
    clk = 0;
    forever #5 clk = ~clk;
    rst = 1;
    #10 rst = 0;

    // Stimulus
    data_in = 0;
    #10 data_in = 1;
    #10 data_in = 2;
    #10 data_in = 3;
    #10 data_in = 4;
    #10 data_in = 5;
    #10 data_in = 6;
    #10 data_in = 7;
    #10 data_in = 8;
    #10 data_in = 9;
    #10 data_in = 10;
    #10 data_in = 11;
    #10 data_in = 12;
    #10 data_in = 13;
    #10 data_in = 14;
    #10 data_in = 15;

    // Monitor output
    $monitor("Time %0d: data_in %b, data_out %b", $time, data_in, data_out);

    // Keep simulation running
    $finish;
  end
endmodule