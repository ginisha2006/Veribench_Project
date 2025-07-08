module tb_fsm_1100();

  // Inputs
  reg clk, rst, bit_in;

  // Output
  wire pattern_detected;

  // Instantiate the DUT
  fsm_1100 UUT (
   .clk(clk),
   .rst(rst),
   .bit_in(bit_in),
   .pattern_detected(pattern_detected)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Property: Pattern detected after 4 cycles
  property p_pattern_detected;
    @(posedge clk) [$rose(pattern_detected) && $countones($past({bit_in, bit_in, bit_in, bit_in})[3:0]) == 2];
  endproperty
  assert property (p_pattern_detected);

  // Property: Pattern not detected before 4 cycles
  property p_no_pattern_detected_before;
    @(posedge clk) [$fell(pattern_detected) |-> $stable({bit_in, bit_in, bit_in, bit_in}[3:0]!= 2'd11)];
  endproperty
  assert property (p_no_pattern_detected_before);

endmodule