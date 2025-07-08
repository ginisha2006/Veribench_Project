module fft_module (
  input clk,
  input rst,
  input start,
  input [DATA_WIDTH-1:0] data_in,
  output [DATA_WIDTH-1:0] data_out,
  output done
);

  parameter DATA_WIDTH = 16;
  parameter FFT_POINTS = 1024;

endmodule