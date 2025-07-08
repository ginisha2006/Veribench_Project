module tb_param_counter;

  reg clk;
  reg rst;
  wire [$clog2(MAX_COUNT+1)-1:0] count;

  parameter MAX_COUNT = 255;

  assign count = param_counter.count;

  param_counter dut (
    .clk(clk),
    .rst(rst),
    .count(count)
  );

  always #5 clk = ~clk;

  always @(*) begin assert (@(posedge clk) count == count + 1); end
  always @(*) begin assert (rst == 1  -> count == 0); end
  always @(*) begin assert (count == MAX_COUNT  -> count == 0); end

endmodule