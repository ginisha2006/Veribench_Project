module tb_param_counter;

  reg clk;
  reg rst;
  wire [$clog2(MAX_COUNT+1)-1:0] count;

  parameter MAX_COUNT = 255;

  assign count = param_counter.count;

  property p_count_increment;
    @(posedge clk) count == count + 1;
  endproperty

  property p_reset;
    rst == 1  -> count == 0;
  endproperty

  property p_max_count_wrap;
    count == MAX_COUNT  -> count == 0;
  endproperty

  param_counter dut (
    .clk(clk),
    .rst(rst),
    .count(count)
  );

  always #5 clk = ~clk;

  assert property (p_count_increment);
  assert property (p_reset);
  assert property (p_max_count_wrap);

endmodule