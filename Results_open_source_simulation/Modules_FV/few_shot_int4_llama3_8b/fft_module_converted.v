module tb_fft_module #(parameter DATA_WIDTH = 16, parameter FFT_POINTS = 1024);

  // Clock and reset signals
  reg clk;
  reg rst;
  reg start;

  // Input data
  reg [DATA_WIDTH-1:0] data_in;

  // Output data
  wire [DATA_WIDTH-1:0] data_out;

  // Done signal
  wire done;

  // Instantiate the DUT
  fft_module #(.DATA_WIDTH(DATA_WIDTH),.FFT_POINTS(FFT_POINTS)) UUT (
   .clk(clk),
   .rst(rst),
   .start(start),
   .data_in(data_in),
   .data_out(data_out),
   .done(done)
  );

  // Clock generation
  initial clk = 0;
  always #10 clk = ~clk;

  // Reset sequence
  initial begin
    rst = 1;
    #20 rst = 0;
  end

  // Start signal sequence
  initial begin
    start = 0;
    #100 start = 1;
    #200 start = 0;
  end

  // Data input sequence
  initial begin
    data_in = 12'h1234; // Example data
    #50 data_in = 12'h5678; // Another example data
  end

  // Properties
  always @(*) begin assert (@(posedge clk) ($rose(start) |=> data_out!= 0)); end

  always @(*) begin assert (@(posedge clk) ($rose(start) |=> done)); end

endmodule