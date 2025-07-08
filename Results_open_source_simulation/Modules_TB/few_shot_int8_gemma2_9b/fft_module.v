module tb_fft_module;

  // Parameters
  parameter DATA_WIDTH = 16;
  parameter FFT_POINTS = 1024;

  // Clock and Reset Signals
  reg clk;
  reg rst;

  // Input Signals
  reg start;
  reg [DATA_WIDTH-1:0] data_in;

  // Output Signals
  wire [DATA_WIDTH-1:0] data_out;
  wire done;

  // Instantiate the FFT Module
  fft_module #(
    .DATA_WIDTH(DATA_WIDTH),
    .FFT_POINTS(FFT_POINTS)
  ) uut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .data_in(data_in),
    .data_out(data_out),
    .done(done)
  );

  initial begin
    // Clock Generation
    clk = 0;
    forever #5 clk = ~clk;

    // Reset Pulse
    rst = 1;
    #10 rst = 0;

    // Test Stimulus
    start = 0;
    #10 start = 1;
    data_in = 16'hAAAA; // Example input data
    #100 start = 0; // Stop the FFT process

    // Wait for completion
    while (!done) ;

    // Output Results
    $display("Data Out: %h", data_out);

    $finish;
  end

endmodule