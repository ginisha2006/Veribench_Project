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

  // Property: Check reset behavior
  property p_reset_behavior;
    @(posedge clk) disable iff (!rst)
      (rst && !start) |-> ##[1:$] (data_out == 0) && (done == 0);
  endproperty
  assert property (p_reset_behavior);

  // Property: Check start condition
  property p_start_condition;
    @(posedge clk) disable iff (!start)
      (start && !rst) |-> ##[1:$] (done === 1);
  endproperty
  assert property (p_start_condition);

  // Property: Check done signal after processing
  property p_done_signal;
    @(posedge clk) disable iff (!start || rst)
      (start && !rst) |=> ##[FFT_POINTS-1:FFT_POINTS] (done === 1);
  endproperty
  assert property (p_done_signal);

endmodule