module tb_fsm_1100();

  // Inputs
  reg clk;
  reg rst;
  reg bit_in;

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
  property p_reset;
    @(posedge rst) disable iff (!rst)
      (rst) |-> ##[0:4] (pattern_detected === 0);
  endproperty
  assert property (p_reset);

  property p_pattern_detection;
    @(posedge clk) disable iff (rst)
      ((##1 bit_in === 1) && (##2 bit_in === 1) && (##3 bit_in === 0) && (##4 bit_in === 0))
         |=> (##1 pattern_detected === 1);
  endproperty
  assert property (p_pattern_detection);

  property p_no_false_positives;
    @(posedge clk) disable iff (rst)
      !((##1 bit_in === 1) && (##2 bit_in === 1) && (##3 bit_in === 0) && (##4 bit_in === 0))
         |-> (##1 pattern_detected !== 1);
  endproperty
  assert property (p_no_false_positives);

endmodule