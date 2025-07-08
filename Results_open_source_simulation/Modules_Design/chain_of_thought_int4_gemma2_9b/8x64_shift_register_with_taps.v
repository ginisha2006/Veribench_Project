module shift_8x64_taps (
  clk,
  shift,
  sr_in,
  sr_tap_one,
  sr_tap_two,
  sr_tap_three,
  sr_out
);

  input clk;
  input shift;
  input [7:0] sr_in;
  output [7:0] sr_tap_one;
  output [7:0] sr_tap_two;
  output [7:0] sr_tap_three;
  output [7:0] sr_out;

  reg [7:0] shift_reg [0:63];

  always @(posedge clk) begin
    if (shift) begin
      shift_reg[0:63] <= shift_reg[1:63] << 1;
      shift_reg[63] <= sr_in;
    end
  end

  assign sr_tap_one = shift_reg[15:8];
  assign sr_tap_two = shift_reg[31:24];
  assign sr_tap_three = shift_reg[47:40];
  assign sr_out = shift_reg[63:56];

endmodule