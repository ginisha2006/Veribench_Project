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
  always @(*) begin assert (@(posedge clk) [$rose(pattern_detected) && $countones($past({bit_in, bit_in, bit_in, bit_in})[3:0]) == 2]); end

  // Property: Pattern not detected before 4 cycles
  always @(*) begin assert (@(posedge clk) [$fell(pattern_detected) |-> $stable({bit_in, bit_in, bit_in, bit_in}[3:0]!= 2'd11)]); end

endmodule