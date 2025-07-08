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
  assert (@(posedge reset)
    disable iff (!reset)
    (gray_count == 8'b00000001));

  assert (@(posedge clk)
    disable iff (!enable || reset)
    (gray_count != gray_count[prev])
    |-> (gray_count == gray_count[prev] ^ {gray_count[prev][6], gray_count[prev][6:1]}));

  assert (@(posedge clk)
    disable iff (!enable || reset)
    (gray_count inside {[8'd0 : 8'hFE]}));

endmodule