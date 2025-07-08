module tb_gray_count();

  // Inputs
  reg clk, enable, reset;

  // Output
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
    @(posedge reset)
    disable iff (!reset)
    (gray_count == 8'b00000001);
  endproperty
  assert property (p_reset_behavior);

  property p_enable_behavior;
    @(posedge enable)
    disable iff (!enable)
    (gray_count != gray_count ##1);
  endproperty
  assert property (p_enable_behavior);

  property p_no_overflow_underflow;
    @(posedge clk)
    disable iff (!enable || reset)
    (!$isunknown(gray_count));
  endproperty
  assert property (p_no_overflow_underflow);

  property p_gray_code_transition;
    @(posedge clk)
    disable iff (!enable || reset)
    ((gray_count[$high(gray_count)] ^ gray_count[$low(gray_count)-1]) == 
     (gray_count[$high(gray_count)] ##1 ^ gray_count[$low(gray_count)-1] ##1));
  endproperty
  assert property (p_gray_code_transition);

endmodule