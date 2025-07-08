module bcd_to_gray(
  input [BCD_WIDTH-1:0] bcd,
  output [GRAY_WIDTH-1:0] gray
);

  assign gray = {bcd[3]^bcd[2], bcd[2]^bcd[1], bcd[1]^bcd[0], bcd[0]};

endmodule