module tb_gray_count();

  // Inputs
  reg clk;
  reg enable;
  reg reset;

  // Output
  wire [7:0] gray_count;

  // Instantiate the DUT
  gray_count UUT (
    .clk(clk),
    .enable(enable),
    .reset(reset),
    .gray_count(gray_count)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Assertions
  property p_reset;
    @(posedge reset) gray_count == 8'h0;
  endproperty
  assert property (p_reset);

  property p_enable;
    @(posedge clk)
      | gray_count != 8'h0 && !reset
      || gray_count == 8'h0 && reset;
  endproperty
  assert property (p_enable);

  property p_gray_code;
    @(posedge clk)
      gray_count[i] != gray_count[i-1] && !reset
      && !enable;
  endproperty
  assert property (p_gray_code);


endmodule