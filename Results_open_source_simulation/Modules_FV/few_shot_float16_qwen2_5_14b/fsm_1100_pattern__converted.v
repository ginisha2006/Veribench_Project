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

  // Properties
  assert (@(posedge clk) disable iff (!rst)
      (rst |-> ##1 state == S0));

  assert (@(posedge clk) disable iff (rst)
      ((state == S0 && !bit_in) |=> state == S0) &&
      ((state == S0 && bit_in) |=> state == S1));

  assert (@(posedge clk) disable iff (rst)
      ((state == S1 && !bit_in) |=> state == S0) &&
      ((state == S1 && bit_in) |=> state == S2));

  assert (@(posedge clk) disable iff (rst)
      ((state == S2 && !bit_in) |=> state == S3) &&
      ((state == S2 && bit_in) |=> state == S2));

  assert (@(posedge clk) disable iff (rst)
      ((state == S3 && !bit_in) |=> state == S0) &&
      ((state == S3 && bit_in) |=> state == S1));

  assert (@(posedge clk) disable iff (rst)
      (state == S3 && !bit_in |-> pattern_detected));

endmodule