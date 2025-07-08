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
  assert (@(posedge reset) disable iff (!reset)
      ##1 gray_count == 8'b00000001);

  assert (@(posedge clk) disable iff (!enable)
      gray_count != gray_count[prev]);

  assert (@(posedge clk) disable iff (!enable || reset)
      gray_count[$countones(gray_count)] == gray_count[$countones(gray_count)-1] + 1);

  assert (@(posedge clk) disable iff (!enable || reset)
      gray_count != 8'b11111111);

endmodule