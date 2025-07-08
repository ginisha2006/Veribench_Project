module mod_demod(
  clk,
  rst,
  data_in,
  modulated_signal,
  demodulated_data
);

  parameter DATA_WIDTH = 16;

  input clk;
  input rst;
  input [DATA_WIDTH-1:0] data_in;
  output [DATA_WIDTH-1:0] modulated_signal;
  output [DATA_WIDTH-1:0] demodulated_data;

endmodule