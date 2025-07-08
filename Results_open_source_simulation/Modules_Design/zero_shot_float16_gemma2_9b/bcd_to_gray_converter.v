module bcd_to_gray(
  input [BCD_WIDTH-1:0] bcd,
  output [GRAY_WIDTH-1:0] gray
);

  parameter BCD_WIDTH = 4;
  parameter GRAY_WIDTH = 4;

  assign gray[0] = bcd[0] ^ bcd[1];
  assign gray[1] = bcd[1] ^ bcd[2];
  assign gray[2] = bcd[2] ^ bcd[3];
  assign gray[3] = bcd[3];

endmodule