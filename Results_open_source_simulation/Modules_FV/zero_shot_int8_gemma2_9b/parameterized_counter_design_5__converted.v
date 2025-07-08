module tb_param_counter;

  reg clk;
  reg rst;
  wire [$clog2(256)-1:0] count;

  param_counter #(
    .MAX_COUNT(255)
  ) dut (
    .clk(clk),
    .rst(rst),
    .count(count)
  );

  always #5 clk = ~clk;

  always @(*) begin assert (@(posedge clk) count == count + 1); end
  always @(*) begin assert (@(posedge clk) count == 0 | count != 255); end
  always @(*) begin assert (@(posedge clk) rst == 1 -> count == 0); end

endmodule