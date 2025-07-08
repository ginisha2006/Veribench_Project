module tb_bcd_to_gray #(parameter BCD_WIDTH = 4, parameter GRAY_WIDTH = 4);

  // Inputs
  reg clk;
  reg [BCD_WIDTH-1:0] bcd;

  // Outputs
  wire [GRAY_WIDTH-1:0] gray;

  // Instantiate the DUT
  bcd_to_gray #(.BCD_WIDTH(BCD_WIDTH),.GRAY_WIDTH(GRAY_WIDTH)) UUT (
   .bcd(bcd),
   .gray(gray)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Check if conversion is correct
  property p_correct_conversion;
    @(posedge clk) (gray == (bcd ^ (bcd >> 1)));
  endproperty
  assert property (p_correct_conversion);

  // Property: Check if conversion is correct for all possible BCD values
  property p_all_possible_values;
    @(posedge clk) ((bcd < 2**(BCD_WIDTH)) => (gray == ({(BCD_WIDTH{bcd[BCD_WIDTH-1]}}, bcd[BCD_WIDTH-2:1]) ^ ({(BCD_WIDTH{bcd[BCD_WIDTH-1]}}, bcd[BCD_WIDTH-2:1]))));
  endproperty
  assume property (p_all_possible_values);

endmodule