module tb_bcd_to_gray #(
    parameter BCD_WIDTH = 4,
    parameter GRAY_WIDTH = 4
)();

  // Inputs
  reg [BCD_WIDTH-1:0] bcd;

  // Outputs
  wire [GRAY_WIDTH-1:0] gray;

  // Instantiate the DUT
  bcd_to_gray #(.BCD_WIDTH(BCD_WIDTH), .GRAY_WIDTH(GRAY_WIDTH)) UUT (
    .bcd(bcd),
    .gray(gray)
  );

  // Properties
  assert (@(posedge $rose(bcd))
    let expected_gray = bcd ^ (bcd >> 1);
    (gray === expected_gray));

endmodule