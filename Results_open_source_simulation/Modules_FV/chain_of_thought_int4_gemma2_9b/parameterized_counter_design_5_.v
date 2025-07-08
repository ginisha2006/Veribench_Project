module tb_param_counter;

  reg clk;
  reg rst;
  wire [$clog2(MAX_COUNT+1)-1:0] count;

  parameter MAX_COUNT = 255;

  assign clk = 1'b1;

  param_counter #(
    .MAX_COUNT(MAX_COUNT)
  ) dut (
    .clk(clk),
    .rst(rst),
    .count(count)
  );

  property p_count_increment;
    @(posedge clk) count == count + 1;
  endproperty

  property p_reset;
    @(posedge clk) rst == 1'b1 ? count == 0 : 1'b0;
  endproperty

  property p_max_count_wrap;
    @(posedge clk) count == 0 | count < MAX_COUNT;
  endproperty

  assert property (p_count_increment);
  assert property (p_reset);
  assert property (p_max_count_wrap);


endmodule