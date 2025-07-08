module digital_filter #(
  parameter DATA_WIDTH = 16,
  parameter COEFF_WIDTH = 16,
  parameter NUM_TAPS = 32
) (
  input clk,
  input rst,
  input [DATA_WIDTH-1:0] data_in,
  output [DATA_WIDTH-1:0] data_out,
  input [NUM_TAPS-1:0][COEFF_WIDTH-1:0] coeff
);

  reg [DATA_WIDTH-1:0] memory [0:NUM_TAPS-1];
  wire [DATA_WIDTH-1:0] temp_sum;

  always @(posedge clk) begin
    if (rst) begin
      memory <= 0;
    end else begin
      for (integer i = NUM_TAPS-1; i > 0; i--) begin
        memory[i] <= memory[i-1];
      end
      memory[0] <= data_in;
    end
  end

  generate
    genvar i;
    for (i = 0; i < NUM_TAPS; i++) begin : tap_loop
      assign temp_sum += memory[i] * coeff[i];
    end
  endgenerate

  assign data_out = temp_sum;

endmodule