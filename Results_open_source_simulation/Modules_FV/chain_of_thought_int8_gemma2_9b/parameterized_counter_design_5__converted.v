module tb_param_counter;

  reg clk;
  reg rst;
  wire [$clog2(MAX_COUNT+1)-1:0] count;

  parameter MAX_COUNT = 255;

  assign clk = 1'b1;

  param_counter #( .MAX_COUNT(MAX_COUNT) ) dut (
    .clk(clk),
    .rst(rst),
    .count(count)
  );

  always @(*) begin assert (@(posedge clk) count == count + 1); end
  always @(*) begin assert (@(posedge clk) (rst && count == 0)); end
  always @(*) begin assert (@(posedge clk) (count == MAX_COUNT && count == count + 1)); end

endmodule