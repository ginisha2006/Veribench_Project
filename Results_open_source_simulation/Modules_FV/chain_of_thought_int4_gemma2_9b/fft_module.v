module tb_fft_module(
  );

  parameter DATA_WIDTH = 16;
  parameter FFT_POINTS = 1024;

  reg clk;
  reg rst;
  reg start;
  reg [DATA_WIDTH-1:0] data_in;
  wire [DATA_WIDTH-1:0] data_out;
  wire done;

  fft_module dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .data_in(data_in),
    .data_out(data_out),
    .done(done)
  );

  always #5 clk = ~clk;

  property p_start_to_done;
    @(posedge clk)
      (start && !done) -> $past(done);
  endproperty

  assert property (p_start_to_done);

endmodule