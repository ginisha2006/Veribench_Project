module digital_filter (
  input clk,
  input rst,
  input [DATA_WIDTH-1:0] data_in,
  output [DATA_WIDTH-1:0] data_out,
  input [NUM_TAPS-1:0][COEFF_WIDTH-1:0] coeff
);

  reg [DATA_WIDTH-1:0] memory [0:NUM_TAPS-1];
  wire [DATA_WIDTH-1:0] sum;

  always @(posedge clk) begin
    if (rst) begin
      memory <= 0;
    end else begin
      memory[0] <= data_in;
      for (integer i = 1; i < NUM_TAPS; i++) begin
        memory[i] <= memory[i-1];
      end
    end
  end

  assign sum = memory[0] * coeff[0] + memory[1] * coeff[1] + ... + memory[NUM_TAPS-1] * coeff[NUM_TAPS-1];

  assign data_out = sum;

endmodule