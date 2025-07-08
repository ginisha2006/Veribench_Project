module tb_fft_module #(
    parameter DATA_WIDTH = 16,
    parameter FFT_POINTS = 1024
)();

  // Inputs
  reg clk, rst, start;
  reg [DATA_WIDTH-1:0] data_in;

  // Outputs
  wire [DATA_WIDTH-1:0] data_out;
  wire done;

  // Instantiate the DUT
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

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties

  // Property: Done should be high after start pulse and valid data_in
  property p_done_after_start;
    @(posedge clk) disable iff (!rst)
      (start && ##[1:$] !start) |-> ##[$:FFT_POINTS*10] done;
  endproperty
  assert property (p_done_after_start);

  // Property: Data out should be valid when done is high
  property p_data_valid_when_done;
    @(posedge clk) disable iff (!rst)
      (done && ##1 !done) |-> data_out != 0;
  endproperty
  assert property (p_data_valid_when_done);

  // Property: Reset should clear done signal
  property p_reset_clears_done;
    @(posedge clk) disable iff (!rst)
      (rst && ##1 !rst) |-> !done;
  endproperty
  assert property (p_reset_clears_done);

endmodule