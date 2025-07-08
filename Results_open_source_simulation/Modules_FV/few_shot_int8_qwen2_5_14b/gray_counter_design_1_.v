module tb_gray_count();

  // Inputs
  reg clk, enable, reset;

  // Outputs
  wire [7:0] gray_count;

  // Instantiate the DUT
  gray_count UUT (
    .clk(clk),
    .enable(enable),
    .reset(reset),
    .gray_count(gray_count)
  );

  // Clock generation for properties
  initial clk = 0;
  always #5 clk = ~clk;

  // Properties
  property p_reset_behavior;
    @(posedge reset) disable iff (!reset)
      ##1 gray_count == 8'b00000001;
  endproperty
  assert property (p_reset_behavior);

  property p_enable_behavior;
    @(posedge clk) disable iff (!enable)
      gray_count != gray_count[prev];
  endproperty
  assert property (p_enable_behavior);

  property p_gray_code_transition;
    @(posedge clk) disable iff (!enable || reset)
      gray_count[$countones(gray_count)] == gray_count[$countones(gray_count)-1] + 1;
  endproperty
  assert property (p_gray_code_transition);

  property p_no_overflow;
    @(posedge clk) disable iff (!enable || reset)
      gray_count != 8'b11111111;
  endproperty
  assert property (p_no_overflow);

endmodule