module shift_8x64_taps (
  clk,
  shift,
  sr_in[7:0],
  sr_tap_one[7:0],
  sr_tap_two[7:0],
  sr_tap_three[7:0],
  sr_out[7:0]
);

  reg [7:0] shift_reg [0:63];

  always @(posedge clk) begin
    if (shift) begin
      shift_reg[0:63] <= shift_reg[1:63] << 1;
      shift_reg[63] <= sr_in[7:0];
    end else begin
      shift_reg[0:63] <= shift_reg[0:63];
    end
  end

  assign sr_tap_one = shift_reg[15:0];
  assign sr_tap_two = shift_reg[31:0];
  assign sr_tap_three = shift_reg[47:0];
  assign sr_out = shift_reg[63:0];

endmodule