module tb_fft_module #(parameter DATA_WIDTH = 16, parameter FFT_POINTS = 1024)();

  // Inputs
  reg clk;
  reg rst;
  reg start;
  reg [DATA_WIDTH-1:0] data_in;

  // Outputs
  wire [DATA_WIDTH-1:0] data_out;
  wire done;

  // Instantiate the FFT module
  fft_module #(
    .DATA_WIDTH(DATA_WIDTH),
    .FFT_POINTS(FFT_POINTS)
  ) UUT (
    .clk(clk),
    .rst(rst),
    .start(start),
    .data_in(data_in),
    .data_out(data_out),
    .done(done)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Reset sequence
  initial begin
    rst = 1;
    #10 rst = 0;
  end

  // Assertions
  // Add your assertions here based on the expected behavior of the FFT module.
  // For example, you might assert on:
  // - Correctness of the output data after completion
  // - Proper handling of start signal
  // - Completion signal timing
  // - Data range constraints


endmodule