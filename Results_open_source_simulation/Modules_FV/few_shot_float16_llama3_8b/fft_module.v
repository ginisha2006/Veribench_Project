module tb_fft_module #(parameter DATA_WIDTH = 16, parameter FFT_POINTS = 1024);

  // Inputs
  reg clk;
  reg rst;
  reg start;
  reg [DATA_WIDTH-1:0] data_in;

  // Outputs
  wire [DATA_WIDTH-1:0] data_out;
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

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if data_out is valid when done is high
  property p_valid_data_out;
    @(posedge clk) ((done) => ($valid(data_out)));
  endproperty
  assert property (p_valid_data_out);

  // Property: Check if data_out is invalid when done is low
  property p_invalid_data_out;
    @(posedge clk) (!done | (!$valid(data_out)));
  endproperty
  assert property (p_invalid_data_out);

  // Property: Check if data_out is updated correctly
  property p_correct_data_out;
    @(posedge clk) (data_out == data_in); // Replace with actual implementation-dependent property
  endproperty
  assert property (p_correct_data_out);

endmodule