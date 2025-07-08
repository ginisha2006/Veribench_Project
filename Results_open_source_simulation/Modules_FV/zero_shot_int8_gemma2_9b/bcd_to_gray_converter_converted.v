module tb_bcd_to_gray;

  parameter BCD_WIDTH = 4;
  parameter GRAY_WIDTH = 4;

  reg [BCD_WIDTH-1:0] bcd;
  wire [GRAY_WIDTH-1:0] gray;

  bcd_to_gray dut (
    .bcd(bcd),
    .gray(gray)
  );

  initial begin
    bcd = 0;
  end

  always #5 clk = ~clk;

  always @(*) begin assert (@(posedge clk) $past(bcd) != bcd); end
  always @(*) begin assert (@(posedge clk) gray == bcd ^ (bcd >> 1)); end

endmodule