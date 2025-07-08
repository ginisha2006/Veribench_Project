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

  property p_count_increment;
    @(posedge clk) count == count + 1;
  endproperty

  property p_count_overflow;
    @(posedge clk) count == 0 |-> count != 255;
  endproperty

  property p_reset;
    @(posedge clk) rst == 1 -> count == 0;
  endproperty

  assert property (p_count_increment);
  assert property (p_count_overflow);
  assert property (p_reset);

endmodule