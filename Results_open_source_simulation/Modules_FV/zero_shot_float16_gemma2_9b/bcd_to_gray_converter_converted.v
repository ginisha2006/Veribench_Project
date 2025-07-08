module tb_bcd_to_gray;

  parameter BCD_WIDTH = 4;
  parameter GRAY_WIDTH = 4;

  reg [BCD_WIDTH-1:0] bcd;
  wire [GRAY_WIDTH-1:0] gray;

  bcd_to_gray dut (
    .bcd(bcd),
    .gray(gray)
  );

  assert (@(posedge clk)
    $past(bcd) != bcd && gray == bcd ^ (bcd >> 1));

endmodule