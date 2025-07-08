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

  // Property: Check if gray value does not change when bcd value remains unchanged
  property p_no_change_on_same_input;
    @(posedge clk) ($stable(bcd) => $stable(gray));
  endproperty
  assert property (p_no_change_on_same_input);

endmodule