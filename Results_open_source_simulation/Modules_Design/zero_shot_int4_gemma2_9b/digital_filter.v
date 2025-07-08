module digital_filter(
  clk,
  rst,
  data_in,
  data_out,
  coeff
);

  parameter DATA_WIDTH = 16;
  parameter COEFF_WIDTH = 16;
  parameter NUM_TAPS = 32;

  input clk;
  input rst;
  input [DATA_WIDTH-1:0] data_in;
  output [DATA_WIDTH-1:0] data_out;
  input [NUM_TAPS-1:0][COEFF_WIDTH-1:0] coeff;

  reg [DATA_WIDTH-1:0] buffer [0:NUM_TAPS-1];
  wire [DATA_WIDTH-1:0] sum;

  always @(posedge clk) begin
    if (rst) begin
      buffer[0] <= 0;
    end else begin
      buffer[0] <= data_in;
      for (integer i = 1; i < NUM_TAPS; i++) begin
        buffer[i] <= buffer[i-1];
      end
    end
  end

  assign sum = 0;
  generate
    for (integer i = 0; i < NUM_TAPS; i++) begin : tap_loop
      assign sum += buffer[i] * coeff[i];
    end
  endgenerate

  assign data_out = sum;

endmodule