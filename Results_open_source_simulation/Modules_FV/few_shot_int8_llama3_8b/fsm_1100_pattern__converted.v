module tb_fsm_1100();

  // Inputs
  reg clk, rst, bit_in;

  // Output
  reg pattern_detected;

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
  always @(*) begin assert (@(posedge clk) [$rose(pattern_detected) && $countones($past(clk, 4)) == 4]); end

  // Property: Pattern not detected before 4 cycles
  always @(*) begin assert (@(posedge clk) [$fell(pattern_detected) || $countones($past(clk, 4)) < 4]); end

  // Property: Correct transition from S0 to S1
  always @(*) begin assert (@(posedge clk) ((state == S0) && (next_state == S1) && bit_in)); end

  // Property: Correct transition from S1 to S2
  always @(*) begin assert (@(posedge clk) ((state == S1) && (next_state == S2) && bit_in)); end

  // Property: Correct transition from S2 to S3
  always @(*) begin assert (@(posedge clk) ((state == S2) && (next_state == S3) &&!bit_in)); end

  // Property: Correct transition from S3 to S1
  always @(*) begin assert (@(posedge clk) ((state == S3) && (next_state == S1) &&!bit_in)); end

endmodule