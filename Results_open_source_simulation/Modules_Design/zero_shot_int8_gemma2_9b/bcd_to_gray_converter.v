module bcd_to_gray(
  input [BCD_WIDTH-1:0] bcd,
  output [GRAY_WIDTH-1:0] gray
);

assign gray = {bcd[BCD_WIDTH-1]^bcd[BCD_WIDTH-2], bcd[BCD_WIDTH-2]^bcd[BCD_WIDTH-3], bcd[BCD_WIDTH-3]^bcd[BCD_WIDTH-4], bcd[BCD_WIDTH-4]};

endmodule