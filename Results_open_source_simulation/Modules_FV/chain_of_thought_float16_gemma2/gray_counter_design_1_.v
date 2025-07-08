module tb_gray_count;

  logic clk;
  logic enable;
  logic reset;
  logic [7:0] gray_count;

  gray_count dut (
    .clk(clk),
    .enable(enable),
    .reset(reset),
    .gray_count(gray_count)
  );

  always #5 clk = ~clk;

  property p_gray_code;
    @(posedge clk)
      $past(gray_count) != gray_count;
  endproperty

  property p_reset;
    @(posedge reset)
      gray_count == 8'b0;
  endproperty

  assert property (p_gray_code);
  assert property (p_reset);

endmodule