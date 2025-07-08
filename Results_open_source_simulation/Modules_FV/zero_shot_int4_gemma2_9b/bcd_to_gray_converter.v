module tb_bcd_to_gray;

  parameter BCD_WIDTH = 4;
  parameter GRAY_WIDTH = 4;

  reg [BCD_WIDTH-1:0] bcd;
  wire [GRAY_WIDTH-1:0] gray;

  bcd_to_gray dut (
    .bcd(bcd),
    .gray(gray)
  );

  property p_gray_conversion;
    @(posedge clk)
    $sformatf("bcd=%b", bcd);
    $sformatf("gray=%b", gray);
    gray == bcd ^ (bcd >> 1);
  endproperty

  assert property (p_gray_conversion);

  always #5 clk = ~clk;
  reg clk;

endmodule