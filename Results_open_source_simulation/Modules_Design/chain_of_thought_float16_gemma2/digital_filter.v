module digital_filter (
  input clk,
  input rst,
  input [DATA_WIDTH-1:0] data_in,
  output [DATA_WIDTH-1:0] data_out,
  input [NUM_TAPS-1:0][COEFF_WIDTH-1:0] coeff
);

  reg [DATA_WIDTH-1:0] shift_reg [0:NUM_TAPS-1];
  wire [DATA_WIDTH-1:0] sum;

  always @(posedge clk) begin
    if (rst) begin
      shift_reg[0] <= 0;
      for (integer i = 1; i < NUM_TAPS; i++) begin
        shift_reg[i] <= 0;
      end
    end else begin
      for (integer i = NUM_TAPS-1; i > 0; i--) begin
        shift_reg[i] <= shift_reg[i-1];
      end
      shift_reg[0] <= data_in;
    end
  end

  assign sum = shift_reg[0] * coeff[0] + shift_reg[1] * coeff[1] + ... + shift_reg[NUM_TAPS-1] * coeff[NUM_TAPS-1];

  assign data_out = sum;

endmodule